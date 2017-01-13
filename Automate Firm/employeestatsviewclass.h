//
//  employeestatsviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface employeestatsviewclass : UIView
- (IBAction)workingdayaction:(id)sender;
- (IBAction)overtimeAction:(id)sender;


- (IBAction)netPayAction:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *workingDay;
@property (strong, nonatomic) IBOutlet UILabel *overTime;
@property (strong, nonatomic) IBOutlet UILabel *netPay;
@property (strong, nonatomic) IBOutlet UILabel *grosspay;
@property (strong, nonatomic) IBOutlet UILabel *overTime1;

@property (strong, nonatomic) IBOutlet UIButton *workingDay1;
@property (strong, nonatomic) IBOutlet UIButton *overTime2;
@property (strong, nonatomic) IBOutlet UIButton *netPay1;
@property (strong, nonatomic) IBOutlet UIButton *grosspay1;
@property (strong, nonatomic) IBOutlet UIButton *overTime3;
@property (strong, nonatomic) IBOutlet UILabel *firstGraphxlabel;
@property (strong, nonatomic) IBOutlet UILabel *secondGraphxlabel;
@property (strong, nonatomic) IBOutlet UIImageView *myimgview;
@property (strong, nonatomic) IBOutlet UIImageView *myimgview2;
@end
