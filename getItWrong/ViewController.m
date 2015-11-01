//
//  ViewController.m
//  getItWrong
//
//  Created by Luke Sadler on 29/10/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import <Parse.h>
#import <NPReachability.h>
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.navigationController setNavigationBarHidden:YES];
    
    globals = [GlobalVars sharedInstance];
    
    __block SCLAlertView * loading = [[SCLAlertView alloc]initWithNewWindow];
    [loading showWaiting:@"Loading...."
                subTitle:nil
        closeButtonTitle:nil
                duration:0.0];
    
    PFQuery *query = [PFQuery queryWithClassName:@"questions"];
    [[query findObjectsInBackground] continueWithSuccessBlock:^id(BFTask *task) {
        return [[PFObject unpinAllObjectsInBackgroundWithName:@"qs"] continueWithSuccessBlock:^id(BFTask *ignored) {
            
            if (task.error) {
                NSLog(@"ERROR %@",task.error);
                return task.error;
            }
           
            dispatch_async(dispatch_get_main_queue(), ^{
                [loading hideView];
                [button setEnabled:YES];
                [button setAlpha:1];
            });
            
            return [PFObject pinAllInBackground:task.result withName:@"qs"];
        }];
    }];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

-(void)loadquestions{

    PFQuery *query = [PFQuery queryWithClassName:@"questions"];
    [query fromLocalDatastore];
    [[query findObjectsInBackground] continueWithBlock:^id(BFTask *task) {
        if (task.error) {
            // Something went wrong.
            return task;
        }
        globals.questions = [task.result mutableCopy];
        
        return task;
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    [button setTransform:CGAffineTransformIdentity];
}

-(void)start:(id)sender{
    
    [self loadquestions];
    
    [self.view layoutIfNeeded]; // Called on parent view
    [button setNeedsUpdateConstraints];
    [button updateConstraintsIfNeeded];
    UIButton * start = (UIButton *)sender;
    
    [UIView animateWithDuration:1.5
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{

                         CALayer *layer = start.layer;
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         rotationAndPerspectiveTransform.m34 = 1.0 / -500;
                         rotationAndPerspectiveTransform = CATransform3DRotate(rotationAndPerspectiveTransform, 45.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         layer.transform = rotationAndPerspectiveTransform;
                         [self.view layoutIfNeeded]; // Called on parent view

                     }completion:^(BOOL complete){
                         [self performSegueWithIdentifier:@"start"
                                                   sender:nil];
                     }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
