//
//  GameOVerViewController.m
//  getItWrong
//
//  Created by Luke Sadler on 01/11/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import "GameOVerViewController.h"

@interface GameOVerViewController ()

@end

@implementation GameOVerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    globals = [GlobalVars sharedInstance];
    
    
    [scoreLabel setText:[NSString stringWithFormat:@"You scored: %d",globals.gameOverScore]];
    // Do any additional setup after loading the view.
}

-(void)playAgainPressed:(id)sender{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
