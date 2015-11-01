//
//  GlobalVars.m
//  Parse Test
//
//  Created by Luke Sadler on 16/05/2015.
//  Copyright (c) 2015 luke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GlobalVars.h"
static const unsigned componentFlags = (NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfYear |  NSCalendarUnitDay | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal);

@implementation GlobalVars

@synthesize questions = _questions;
@synthesize gameOverScore = _gameOverScore;

+ (GlobalVars *)sharedInstance {
    static dispatch_once_t onceToken;
    static GlobalVars *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[GlobalVars alloc] init];
    });
    return instance;
}
- (id)init {
    self = [super init];
    if (self) {
        _questions = [[NSMutableArray alloc]init];
        _gameOverScore = 0;
    }
    return self;
}

-(NSString *)returnJSONString:(NSMutableArray *)array{
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

-(NSString *)dictReturnJSONString:(NSMutableDictionary *)dict{
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

-(NSDictionary *)JSONtoDict:(NSString*)string{
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    return [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
}

- (BOOL)isToday:(NSDate *)oldDate{
    
    if (!oldDate) {
        return NO;
    }
    NSDateComponents *components1 = [[NSCalendar currentCalendar] components:componentFlags fromDate:oldDate];
    NSDateComponents *components2 = [[NSCalendar currentCalendar] components:componentFlags fromDate:[NSDate date]];
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

@end