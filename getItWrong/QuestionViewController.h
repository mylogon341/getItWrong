//
//  QuestionViewController.h
//  getItWrong
//
//  Created by Luke Sadler on 29/10/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVars.h"
#import <Parse.h>
#import <BEMAnalogClockView.h>
#import <AudioToolbox/AudioToolbox.h>
#import "MylogonAudio.h"

@interface QuestionViewController : UIViewController <BEMAnalogClockDelegate>
{
    MylogonAudio * myAudio;
    
    GlobalVars * globals;
    
    IBOutlet UITextView * question;
    IBOutlet UIButton * lButton;
    IBOutlet UIButton * rButton;
    IBOutlet UILabel * scoreLabel;
    
    PFObject * qObject;
    NSTimer * timer;
    int score;
    int time;
}

-(IBAction)lButtonPressed:(id)sender;
-(IBAction)rButtonPressed:(id)sender;

@property(nonatomic,weak) IBOutlet BEMAnalogClockView * clock;
@end
