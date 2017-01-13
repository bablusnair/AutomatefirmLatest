//
//  evidencesignatureviewclass.h
//  Automate Firm
//
//  Created by leonine on 9/1/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface evidencesignatureviewclass : UIView
-(IBAction)donebuttonaction:(id)sender;
@property (nonatomic, assign) CGPoint lastContactPoint1, lastContactPoint2, currentPoint;
@property (nonatomic, assign) CGRect imageFrame;
@property (nonatomic, assign) BOOL fingerMoved;
@property (strong, nonatomic) IBOutlet UIImageView *mySignatureImage;

-(IBAction)clearsignature:(id)sender;
@property (strong, nonatomic) UIColor *myselectedcolor;
-(IBAction)selectedcolorbuttonaction:(id)sender;

@end
