//
//  GameOVerViewController.h
//  getItWrong
//
//  Created by Luke Sadler on 01/11/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalVars.h"

@interface GameOVerViewController : UIViewController
{
    IBOutlet UILabel *scoreLabel;
    GlobalVars * globals;
}
-(IBAction)playAgainPressed:(id)sender;
@end
