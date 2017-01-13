//
//  autocodingViewClass.m
//  Automate Firm
//
//  Created by leonine on 7/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "autocodingViewClass.h"

@implementation autocodingViewClass
-(void)awakeFromNib
{
    accordion = [[autocodingTileClass alloc] initWithFrame:CGRectMake(10, 60, 625, 445)];
    [self addSubview:accordion];
    self.doneButton.enabled=NO;
}
-(IBAction)done:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancel:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(void)enable
{
    self.doneButton.enabled=YES;
}
-(void)disable
{
    self.doneButton.enabled=NO;
}
@end
