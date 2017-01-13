
//  timeConditionsClass.m
//  Automate Firm
//
//  Created by leonine on 1/19/16.
//  Copyright © 2016 leonine. All rights reserved.

#import "timeConditionsClass.h"

@implementation timeConditionsClass
-(float)timerGotValueChanged:(NSString *)Time // To  set the value changed functionality of timer if it is 00 Hrs 00 Mins(Minimum or maximum time settings)
{
    NSArray *timeValues=[Time componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:1];
    NSString *minuteString=[timeValues objectAtIndex:3];
    int hour=[hourString intValue];
    int hours=hour*60*60;
    int minute=[minuteString intValue];
    int minute1=minute*60;
    //int minutes= minute1-10;
    float totalSeconds=(hours+minute1) - 300;
    return totalSeconds;
}

-(float)timerGetValueChanged:(NSString *)timerValue // To  set the value changed functionality of timer if it is 00 : 00(Minimum or maximum time settings)
{
    NSArray *timeValues=[timerValue componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:0];
    NSString *minuteString=[timeValues objectAtIndex:2];
    int hour=[hourString intValue];
    int hours=hour*60*60;
    int minute=[minuteString intValue];
    int minute1=minute*60;
    int minutes= minute1-10;
    float totalSeconds=hours+minutes;
    return  totalSeconds;
}



-(float)timerGetRemainingValue:(NSString *)time1 :(NSString *)time2 // timer shows the duration of two times
{
    NSArray *timeValues=[time1 componentsSeparatedByString:@" "];
    NSString *hourString=[timeValues objectAtIndex:1];
    NSString *minuteString=[timeValues objectAtIndex:3];
    NSString *date=[NSString stringWithFormat:@"%@:%@",hourString,minuteString];
    
    
    NSArray *timeValues1=[time2 componentsSeparatedByString:@" "];
    NSString *hourString1=[timeValues1 objectAtIndex:1];
    NSString *minuteString1=[timeValues1 objectAtIndex:3];
    NSString *dates=[NSString stringWithFormat:@"%@:%@",hourString1,minuteString1];
    
    
    NSDateFormatter *df=[[NSDateFormatter alloc] init];
    // Set the date format according to your needs
    [df setDateFormat:@"HH:mm"]; //for 12 hour format
    //[df setDateFormat:@"MM/dd/YYYY HH:mm "]  // for 24 hour format
    
    NSDate *date1 = [df dateFromString:date];
    NSDate *date2 = [df dateFromString:dates];
    int timeDiff=[date2 timeIntervalSinceDate:date1];
    int hours=timeDiff/3600;
    float remainder=timeDiff%3600;
    remainder=remainder/60;
    
    hours=hours*60*60;
    
    int minute=remainder*60;
    
    float totalSeconds=(hours+minute) - 300;
    return  totalSeconds;
}


//Time Initial Settings

-(id)timeInitialSettings  // Reset DatePicker
{
    NSDate *date1 = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [gregorian components: NSUIntegerMax fromDate: date1];
    [components setHour: 0];
    [components setMinute: 0];
    NSDate *startDate = [gregorian dateFromComponents: components];
    
    [components setHour: 23];
    [components setMinute: 0];
    NSDate *endDate = [gregorian dateFromComponents: components];

    NSMutableArray *TimeArray=[[NSMutableArray alloc]init];
    [TimeArray addObject:startDate];
    [TimeArray addObject:endDate];
    return TimeArray;
}

//Time To set the minimum value

-(id)timeMinimumValueSetting:(NSString *)minimumTime
{
    NSString *str=minimumTime;
    NSArray *timeValues1=[str componentsSeparatedByString:@" "];
    NSString *timeV=[timeValues1 objectAtIndex:0];
    NSArray *timeValues=[timeV componentsSeparatedByString:@":"];
    NSString *hourString=[timeValues objectAtIndex:0];
    NSString *minuteString=[timeValues objectAtIndex:1];
    
    int hour=[hourString intValue];
    
    if ([[timeValues1 objectAtIndex:1]isEqualToString:@"AM"])
    {
        
    }
    else
    {
        hour+=12;
    }
    
    int minute=[minuteString intValue] + 10 ;
    NSString *time=[NSString stringWithFormat:@"%d###%d",hour,minute];
    return time;
    
}


@end
