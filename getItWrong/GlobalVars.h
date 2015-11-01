//
//  GlobalVars.h
//  Parse Test
//
//  Created by Luke Sadler on 16/05/2015.
//  Copyright (c) 2015 luke. All rights reserved.
//

@interface GlobalVars : NSObject
{
    NSMutableArray * _questions;
    int _gameOverScore;
}

+ (GlobalVars *)sharedInstance;

@property (nonatomic,strong) NSMutableArray * questions;
@property (nonatomic) int gameOverScore;

-(NSString *)returnJSONString:(NSMutableArray *)array;
-(NSString *)dictReturnJSONString:(NSMutableDictionary *)dict;
-(NSDictionary *)JSONtoDict:(NSString*)string;

-(BOOL)isToday:(NSDate *)oldDate;

@end