//
//  fineDocumentsViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "fineDocumentsViewClass.h"
#import "documentInnerViewClass.h"
@implementation fineDocumentsViewClass

-(void)awakeFromNib
{
    
    accordion = [[DocumentTile alloc] initWithFrame:CGRectMake(22, 110, 600, 465)];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"accordianAction"];
    [self addSubview:accordion];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewLoad) name:@"leavePaperwork" object:Nil];
    
}
-(void)viewLoad
{
    self.leaveNameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"LeaveName"];
    //self.leaveTypeLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@""];
    self.descriptionLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"description"];
}
-(void)willRemoveSubview:(UIView *)subview
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"employee"]) {
        NSMutableArray *selectedEmployeeArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployee"];
        NSString *selectedEmployeeIcon=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployeeIcon"];
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                
                [myView specificEmployee:selectedEmployeeArray :selectedEmployeeIcon];
            }
        }
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"includedesignation"])
    {
        NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        NSLog(@"%@",self.subviews);
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                
                [myView collectionViewReload:selectedDeignationArray];
            }
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"designation"])
    {
        NSMutableArray *selectedDesignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                [myView assignDesignation:selectedDesignationArray];
            }
        }
    }
    else
    {
        
    }
    
}
-(IBAction)doneButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}

@end
