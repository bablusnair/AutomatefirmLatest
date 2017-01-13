//
//  advanceDocumentsViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 28/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "advanceDocumentsViewClass.h"
#import "advanceInnerViewClass.h"
@implementation advanceDocumentsViewClass

-(void)awakeFromNib
{
    [super awakeFromNib];
    accordion = [[advanceDocumentTile alloc] initWithFrame:CGRectMake(22, 110, 602, 465)];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"accordianAction"];
    //[self addSubview:accordion];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewLoad) name:@"leavePaperwork" object:Nil];
    
}
-(void)viewLoad
{
    self.leaveNameLabel.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"LeaveName"];
}
-(void)willRemoveSubview:(UIView *)subview
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"employee"]) {
        NSMutableArray *selectedEmployeeArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployee"];
        NSData *imageData=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployeeIcon"];
        for (advanceInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[advanceInnerViewClass class]]) {
                
                [myView specificEmployee:selectedEmployeeArray :imageData];
            }
        }
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"includedesignation"])
    {
        NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        NSLog(@"%@",self.subviews);
        for (advanceInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[advanceInnerViewClass class]]) {
                
                [myView collectionViewReload:selectedDeignationArray];
            }
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"designation"])
    {
        NSMutableArray *selectedDesignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        for (advanceInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[advanceInnerViewClass class]]) {
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
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.declarationText.text isEqualToString:@"Declaration Message"]) {
        self.declarationText.text=@"";
    }
    self.declarationText.textColor=[UIColor blackColor];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (!(self.declarationText.text.length > 0 )) {
        self.declarationText.text=@"Declaration Message";
        self.declarationText.textColor=[UIColor lightGrayColor];
    }
    return YES;
}


@end
