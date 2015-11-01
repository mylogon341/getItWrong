//
//  ViewController.h
//  getItWrong
//
//  Created by Luke Sadler on 29/10/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVars.h"
#import <SCLAlertView.h>

@interface ViewController : UIViewController
{
    GlobalVars * globals;
    IBOutlet UIButton * button;
}
-(IBAction)start:(id)sender;

@end

