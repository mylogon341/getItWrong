//
//  QuestionViewController.m
//  getItWrong
//
//  Created by Luke Sadler on 29/10/2015.
//  Copyright © 2015 luke. All rights reserved.
//

#import "QuestionViewController.h"

@interface QuestionViewController ()

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    globals = [GlobalVars sharedInstance];

    self.clock.hours = 12;
    self.clock.minutes = 60;
    self.clock.seconds = 60;
    [self.clock setHourHandAlpha:0];
    [self.clock setSecondHandAlpha:0];
    
    myAudio = [MylogonAudio sharedInstance];
    [myAudio playBackgroundMusic:@"ticking.aiff"];
    
    time = 60;

    timer = [NSTimer scheduledTimerWithTimeInterval:1
                                     target:self
                                   selector:@selector(countDown)
                                   userInfo:nil
                                    repeats:YES];
    [self setQuestion];
    
}

-(void)countDown{
    time --;
    
    if (time < 0) {
        NSLog(@"TIMES UP\nSCORE:%d",score);
        [timer invalidate];
        timer = nil;
        globals.gameOverScore = score;
        [myAudio pauseBackgroundMusic];
        [self performSegueWithIdentifier:@"gameover" sender:nil];
        return;
    }
    
    if ([qObject[@"vibrate"] boolValue]) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        //Your main thread code goes in here
        self.clock.minutes = time;
        [self.clock updateTimeAnimated:YES];
    });
}

-(void)setQuestion{
    if (globals.questions.count == 0) {
        time = -1;
        return;
    }
    qObject = globals.questions[arc4random()%globals.questions.count];
    [globals.questions removeObject:qObject];
    [question setText:qObject[@"question"]];
    [self.view setBackgroundColor:[self getBGColour]];
    [self centerTextInTextView];
    
    if (arc4random()%50 % 2) {
        [lButton setTitle:qObject[@"button1"] forState:UIControlStateNormal];
        [rButton setTitle:qObject[@"button2"] forState:UIControlStateNormal];
    }else{
        [rButton setTitle:qObject[@"button1"] forState:UIControlStateNormal];
        [lButton setTitle:qObject[@"button2"] forState:UIControlStateNormal];
    }
}

-(void)lButtonPressed:(id)sender{
    
    if ([qObject[@"trickQuestion"] boolValue]) {
        score ++;
        [scoreLabel setText:[NSString stringWithFormat:@"Score: %d",score]];
        [self setQuestion];
        return;
    }
    
    if ([[(UIButton *)sender titleLabel].text isEqualToString:qObject[@"button2"]]) {
        score ++;
    }else{
        [myAudio playSoundEffect:@"buzz.mp3"];
        score = 0;
    }
    
    [scoreLabel setText:[NSString stringWithFormat:@"Score: %d",score]];
    [self setQuestion];
}

-(void)rButtonPressed:(id)sender{
    [self lButtonPressed:sender];
}

-(UIColor *)getBGColour{
    NSDictionary * dict = [globals JSONtoDict:qObject[@"backgroundColour"]];
    float red = [dict[@"red"] floatValue]/255.0;
    float green = [dict[@"green"] floatValue]/255.0;
    float blue = [dict[@"blue"] floatValue]/255.0;
    
    if ((red + green + blue)/3 > 0.5) {
        [question setTextColor:[UIColor blackColor]];
        [scoreLabel setTextColor:[UIColor blackColor]];
    }else{
        [question setTextColor:[UIColor whiteColor]];
        [scoreLabel setTextColor:[UIColor whiteColor]];
    }
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:1];
}

- (void)centerTextInTextView{
    
    CGFloat topCorrect = ([question bounds].size.height - [question contentSize].height * [question zoomScale])/2.0;
    topCorrect = ( topCorrect < 0.0 ? 0.0 : topCorrect );
    question.contentOffset = (CGPoint){ .x = 0, .y = -topCorrect };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
