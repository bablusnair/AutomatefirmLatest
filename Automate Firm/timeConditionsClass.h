//
//  timeConditionsClass.h
//  Automate Firm
//
//  Created by leonine on 1/19/16.
//  Copyright © 2016 leonine. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface timeConditionsClass : NSObject

//Timer

-(float)timerGotValueChanged:(NSString *)Time;
-(float)timerGetValueChanged:(NSString *)timerValue;
-(float)timerGetRemainingValue:(NSString *)time1 : (NSString *)time2;


//Time

-(id)timeInitialSettings;
-(id)timeMinimumValueSetting:(NSString *)minimumTime;

@end
