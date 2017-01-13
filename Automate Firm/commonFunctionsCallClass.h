//
//  commonFunctionsCallClass.h
//  Automate Firm
//
//  Created by leonine on 9/29/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "documentViewClass.h"
@interface commonFunctionsCallClass : UIView

//Timer

-(float)timerGotValueChanged:(NSString *)Time;
-(float)timerGetValueChanged:(NSString *)timerValue;
-(float)timerGetRemainingValue:(NSString *)time1 : (NSString *)time2;


//Time

-(id)timeInitialSettings;
-(id)timeMinimumValueSetting:(NSString *)minimumTime;

//Pdf Spliting

-(void)splittingPDF:(NSString *)filePath;
-(void)convertingPDFtoImage:(NSMutableArray *)pdfArray;
@property(nonatomic,retain)NSMutableArray *imageArray;

@end
