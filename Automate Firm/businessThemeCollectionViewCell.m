//
//  businessThemeCollectionViewCell.m
//  Automate Firm
//
//  Created by leonine on 7/27/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "businessThemeCollectionViewCell.h"

@implementation businessThemeCollectionViewCell
@synthesize statusFlag;
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.redButton.layer.borderWidth = 3.0;
    self.redButton.layer.borderColor = [UIColor greenColor].CGColor;
    statusFlag=0;
    
    UISwipeGestureRecognizer * swiperight=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swiperight:)];
    swiperight.direction=UISwipeGestureRecognizerDirectionRight;
    [self.formView addGestureRecognizer:swiperight];
    
    UISwipeGestureRecognizer * swipeleft=[[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(swipeleft:)];
    swipeleft.direction=UISwipeGestureRecognizerDirectionLeft;
    [self.formView addGestureRecognizer:swipeleft];
}

-(void)swipeleft:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (statusFlag==0) {
        [self.scrollView setContentOffset:CGPointMake(112, 0) animated:YES];
        statusFlag=1;
        
        [self.actionButton1 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        [self.actionButton2 setImage:[UIImage imageNamed:@"blu.png"] forState:UIControlStateNormal];
        [self.actionButton3 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        self.themeTypeLabel.text=@"Employee ID (Front)";
    }
    else if (statusFlag==1)
    {
        [self.scrollView setContentOffset:CGPointMake(224, 0) animated:YES];
        [self.actionButton1 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        [self.actionButton2 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        [self.actionButton3 setImage:[UIImage imageNamed:@"blu.png"] forState:UIControlStateNormal];
        statusFlag=2;
        self.themeTypeLabel.text=@"Employee ID (Back)";
    }
}
-(void)swiperight:(UISwipeGestureRecognizer*)gestureRecognizer
{
    if (statusFlag==1) {
        [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        statusFlag=0;
        
        [self.actionButton1 setImage:[UIImage imageNamed:@"blu.png"] forState:UIControlStateNormal];
        [self.actionButton2 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        [self.actionButton3 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        self.themeTypeLabel.text=@"Letter Head";
    }
    else if (statusFlag==2)
    {
        [self.scrollView setContentOffset:CGPointMake(112, 0) animated:YES];
        statusFlag=1;
        
        [self.actionButton1 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        [self.actionButton2 setImage:[UIImage imageNamed:@"blu.png"] forState:UIControlStateNormal];
        [self.actionButton3 setImage:[UIImage imageNamed:@"gry.png"] forState:UIControlStateNormal];
        self.themeTypeLabel.text=@"Employee ID (Front)";
    }
}
@end
