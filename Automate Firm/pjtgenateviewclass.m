//
//  pjtgenateviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 13/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "pjtgenateviewclass.h"
#import "pjtgenatedcustumviewclass.h"
#import "documentationIndividualSelectionViewClass.h"
#import "leaveFormViewClass.h"
#import "advanceFormClass.h"
#import "expenseReimbursementFormClass.h"
#import "documentationFormCreationClass.h"
#import "fineApplicationFormClass.h"
#import "loanFormClass.h"
@implementation pjtgenateviewclass

- (void)drawRect:(CGRect)rect {
    
      self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)awakeFromNib
{
    
    self.x=0;
    self.y=0;
    
    self.popUpView.hidden=true;
}


-(void)willRemoveSubview:(UIView *)subview
{
    
}


-(IBAction)closepjtgeneratedviewall:(id)sender
{
    
    [self removeFromSuperview];
}






-(IBAction)presetButtonAction:(id)sender
{
    if (self.y%2==0) {
        for (UIView *view in self.mainView.subviews) {
            if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]|| [view isKindOfClass:[documentationFormCreationClass class]] || [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]] || [view isKindOfClass:[loanFormClass class]]) {
                [view removeFromSuperview];
            }
        }
        self.scrollView.scrollEnabled=YES;
        self.popUpView.hidden=false;
        self.y++;
    }
    else
    {
        self.popUpView.hidden=true;
        self.y++;
    }
   
}
-(IBAction)presetViewActions:(id)sender
{
    UIButton *button=(UIButton *)sender;
    self.y++;
    if (button.tag==1) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
            
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]] || [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]] || [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"leaveFormView" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    else if (button.tag==2) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
                
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]] || [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]]|| [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"advanceForm" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    else if (button.tag==3)
    {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
                
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]]|| [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]]|| [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"documentationFormCreationView" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    else if (button.tag==4)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
                
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]]|| [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]]|| [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"expenseReimbursementForm" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    else if (button.tag==5)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
                
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]]|| [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]]|| [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"fineApplicationForm" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    else if (button.tag==6)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.scrollView.scrollEnabled=NO;
            for (UIView *view in self.mainView.subviews) {
                
                if ([view isKindOfClass:[documentationIndividualSelectionViewClass class]] || [view isKindOfClass:[leaveFormViewClass class]] || [view isKindOfClass:[advanceFormClass class]]||[view isKindOfClass:[documentationFormCreationClass class]]|| [view isKindOfClass:[expenseReimbursementFormClass class]] || [view isKindOfClass:[fineApplicationFormClass class]]|| [view isKindOfClass:[loanFormClass class]]) {
                    [view removeFromSuperview];
                }
            }
            NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"loanForm" owner:self options:Nil];
            
            [self.mainView addSubview:[myviewarray objectAtIndex:0]];
        });
    }
    self.popUpView.hidden=true;
    self.y=0;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.popUpView.hidden=true;
    self.y++;
}
@end
