//
//  performanceEvaluationViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "performanceEvaluationViewClass.h"
#import "popupTableViewCell.h"
#import "documentInnerViewClass.h"

@implementation performanceEvaluationViewClass
@synthesize buttonFlag,x,y,checkFlag1,checkFlag2;
-(void)awakeFromNib
{
    self.popupArray=[[NSMutableArray alloc] initWithObjects:@"Designations",@"Owners",@"Specific Individuals", nil];
    self.popUpView.hidden=true;
    x=y=buttonFlag=0;
    checkFlag1=checkFlag2=0;
    
    accordion = [[performanceEvaluationTile alloc] initWithFrame:CGRectMake(22, 230, 600, 300)];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"accordianAction"];
    [self addSubview:accordion];
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.popupArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"popupTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.popupLabel.text=[self.popupArray objectAtIndex:indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[self.popupTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"drop_box_blue.png"];
    cell.popupLabel.textColor=[UIColor whiteColor];
    
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults]setObject:@"designation" forKey:@"popupAction"];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"includeDesignation"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"grouppopupview" owner:self options:nil];
        [self addSubview:[nib objectAtIndex:0]];
    }
    
    if (indexPath.row==1) {
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    
    if (indexPath.row==2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"employee" forKey:@"popupAction"];
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"assignToSpecificEmployeeView" owner:self options:nil];
        [self addSubview:[nib objectAtIndex:0]];
        
    }
    x=y=0;
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[self.popupTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"drop_box_white.png"];
    cell.popupLabel.textColor=[UIColor blackColor];
}
-(IBAction)button1Action:(id)sender
{
    y=0;
    if (x==0) {
        buttonFlag=1;
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(172, 41, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        x=1;
    }
    else
    {
        x++;
        self.popUpView.hidden=true;
    }
    
    
}
-(IBAction)button2Action:(id)sender
{
    x=0;
    if (y==0) {
        buttonFlag=2;
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(402, 41, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        y++;
    }
    else
    {
        y++;
        self.popUpView.hidden=true;
    }
}
//-(void)assignDesignation:(NSMutableArray *)desigArray
//{
//    if (buttonFlag==1) {
//        [self.button1 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
//        self.button2.userInteractionEnabled=YES;
//        self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//        self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//        self.popUpView.hidden=true;
//    }
//    else if (buttonFlag==2)
//    {
//        [self.button2 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
//        self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//        self.popUpView.hidden=true;
//    }
//    
//    
//}



//-(void)specificEmployee:(NSMutableArray *)selectedEmployee :(NSString *)selectedEmployeeIcon
//{
//    if (selectedEmployee.count > 1) {
//        if (buttonFlag==1) {
//            [self.button1 setImage:[UIImage imageNamed:@"icon_paperwork_Blue.png"] forState:UIControlStateNormal];
//            self.button2.userInteractionEnabled=YES;
//            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.popUpView.hidden=true;
//        }
//        else if (buttonFlag==2)
//        {
//            [self.button2 setImage:[UIImage imageNamed:@"icon_paperwork_Blue.png"] forState:UIControlStateNormal];
//            
//            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.popUpView.hidden=true;
//        }
//        
//    }
//    else if (selectedEmployee.count == 1)
//    {
//        if (buttonFlag==1) {
//            [self.button1 setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
//            self.button2.userInteractionEnabled=YES;
//            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.popUpView.hidden=true;
//        }
//        else if (buttonFlag==2)
//        {
//            [self.button2 setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
//            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
//            self.popUpView.hidden=true;
//        }
//        
//        
//    }
//}


-(void)willRemoveSubview:(UIView *)subview
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"employee"]) {
        NSMutableArray *selectedEmployeeArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployee"];
        NSString *selectedEmployeeIcon=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployeeIcon"];
        
        if (selectedEmployeeArray.count > 1) {
            if (buttonFlag==1) {
                [self.button1 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
                self.button2.userInteractionEnabled=YES;
                self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.popUpView.hidden=true;
            }
            else if (buttonFlag==2)
            {
                [self.button2 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
                
                self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.popUpView.hidden=true;
            }
            
        }
        else if (selectedEmployeeArray.count == 1)
        {
            if (buttonFlag==1) {
                [self.button1 setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
                self.button2.userInteractionEnabled=YES;
                self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.popUpView.hidden=true;
            }
            else if (buttonFlag==2)
            {
                [self.button2 setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
                self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
                self.popUpView.hidden=true;
            }
            
            
        }
    }
//    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"includedesignation"])
//    {
//        NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
//        NSLog(@"%@",self.subviews);
//        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
//            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
//                
//                [myView collectionViewReload:selectedDeignationArray];
//            }
//        }
//    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"designation"])
    {
        NSMutableArray *selectedDesignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                [myView assignDesignation:selectedDesignationArray];
            }
        }
        
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
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

-(IBAction)checkButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (checkFlag1%2==0) {
            [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            checkFlag2=1;
            checkFlag1++;
        }
        else
        {
            [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            checkFlag1++;
        }
    }
    else if (button.tag==2)
    {
        if (checkFlag2%2==0) {
            [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            checkFlag2++;
        }
        else
        {
            if (checkFlag1%2==0) {
                [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
                checkFlag2++;
            }
        }
    }
}
@end
