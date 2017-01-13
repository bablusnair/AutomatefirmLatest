//
//  documentationhomeviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 29/05/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "documentationhomeviewclass.h"
#import "paperworkViewClass.h"
#import "pjtgenateviewclass.h"
@implementation documentationhomeviewclass
@synthesize x;

- (void)drawRect:(CGRect)rect
{
    
    self.frame=CGRectMake(140, 22, self.frame.size.width, self.frame.size.height);
}

-(void)awakeFromNib
{
    
    x=0;
    self.y=0;
//    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentationFrontViewScreen" owner:self options:nil];
//    [self.myDocView addSubview:[nib objectAtIndex:0]];
}

- (IBAction)genatedocumentsbuttonaction:(id)sender
{
    for (UIView *view in self.myDocView.subviews) {
        
        if ([view isKindOfClass:[paperworkViewClass class]])
        {
            [view removeFromSuperview];
        }
    }

    
    if (x%2==0) {
        
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"pjtgeneratedocuments" owner:self options:Nil];
        [self.myDocView addSubview:[myviewarray objectAtIndex:0]];
        
        x++;
    }
    
    else
    {
        for (UIView *subView in self.subviews)
        {
            
            [[subView viewWithTag:12] removeFromSuperview];
        }
        x++;
        
    }
    
}
-(IBAction)paperWorkAction:(id)sender
{
    if (self.y%2==0) {
    
    for (UIView *view in self.myDocView.subviews) {
        
        if ([view isKindOfClass:[pjtgenateviewclass class]])
        {
            [view removeFromSuperview];
        }
    }

    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"paperWorkView" owner:self options:nil];
    [self.myDocView addSubview:[nib objectAtIndex:0]];
        self.y++;
    }
    else
    {
        for (UIView *subView in self.subviews)
        {
            
            [[subView viewWithTag:10] removeFromSuperview];
        }
        self.y++;
        
    }

}
@end
