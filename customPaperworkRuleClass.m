//
//  customPaperworkRuleClass.m
//  Automate Firm
//
//  Created by leonine on 16/09/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "customPaperworkRuleClass.h"
#import "popupTableViewCell.h"

@implementation customPaperworkRuleClass
@synthesize p,q,r,s,t,buttonFlag;

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.popupArray=[[NSMutableArray alloc] initWithObjects:@"Designations",@"Owners",@"Specific Individuals", nil];
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
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    if (indexPath.row==1) {
        if (buttonFlag==1) {
            [self.flow1Button setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.flow2Button.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.flow2Button setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.flow3Button.userInteractionEnabled=YES;
            self.flowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.flow3Button setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.flow4Button.userInteractionEnabled=YES;
            self.flowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.flow4Button setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.flowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.flow5Button.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else
        {
            [self.flow5Button setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.flowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
    }
    if (indexPath.row==2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"employee" forKey:@"popupAction"];
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"assignToSpecificEmployeeView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
        
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[self.popupTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"drop_box_white.png"];
    cell.popupLabel.textColor=[UIColor blackColor];
}


-(void)assignDesignation:(NSMutableArray *)desigArray
{
    if (buttonFlag==1) {
        [self.flow1Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
        self.flow2Button.userInteractionEnabled=YES;
        self.popUpView.hidden=true;
    }
    else if (buttonFlag==2)
    {
        [self.flow2Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
        self.flow3Button.userInteractionEnabled=YES;
        self.flowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
        self.popUpView.hidden=true;
    }
    else if (buttonFlag==3)
    {
        [self.flow3Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
        self.flow4Button.userInteractionEnabled=YES;
        self.flowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
        self.popUpView.hidden=true;
    }
    else if(buttonFlag==4)
    {
        [self.flow4Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
        self.flow5Button.userInteractionEnabled=YES;
        self.flowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
        self.popUpView.hidden=true;
    }
    else
    {
        [self.flow5Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
        self.flowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
        self.popUpView.hidden=true;

    }
    
}



-(void)specificEmployee:(NSMutableArray *)selectedEmployee :(NSString *)selectedEmployeeIcon
{
    if (selectedEmployee.count > 1) {
        if (buttonFlag==1) {
            [self.flow1Button setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.flow2Button.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.flow2Button setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.flow3Button.userInteractionEnabled=YES;
            self.flowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.flow3Button setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.flow4Button.userInteractionEnabled=YES;
            self.flowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.flow4Button setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.flow5Button.userInteractionEnabled=YES;
            self.flowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.flow5Button setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.flowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    else if (selectedEmployee.count == 1)
    {
        if (buttonFlag==1) {
            [self.flow1Button setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.flow2Button.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.flow2Button setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.flow3Button.userInteractionEnabled=YES;
            self.flowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.flow3Button setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.flow4Button.userInteractionEnabled=YES;
            self.flowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.flow4Button setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.flow5Button.userInteractionEnabled=YES;
            self.flowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.flow5Button setImage:[UIImage imageNamed:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.flowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
}

-(IBAction)saveButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancelButton:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)flowActionButton:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        if (p%2==0) {
            buttonFlag=1;
            self.popUpView.hidden=false;
            [self.popupTableView reloadData];
            self.popUpView.frame=CGRectMake(-5, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
            p++;
        }
        else
        {
            p++;
            self.popUpView.hidden=true;
        }

    }
    else if (button.tag==2) {
        if (q%2==0) {
            buttonFlag=2;
            self.popUpView.hidden=false;
            [self.popupTableView reloadData];
            self.popUpView.frame=CGRectMake(95, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
            q++;
        }
        else
        {
            q++;
            self.popUpView.hidden=true;
        }
    }
    else if (button.tag==3) {
        if (r%2==0) {
            buttonFlag=3;
            self.popUpView.hidden=false;
            [self.popupTableView reloadData];
            self.popUpView.frame=CGRectMake(208, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
            r++;
        }
        else
        {
            r++;
            self.popUpView.hidden=true;
        }

    }
    else if (button.tag==4) {
        if (s%2==0) {
            buttonFlag=4;
            self.popUpView.hidden=false;
            [self.popupTableView reloadData];
            self.popUpView.frame=CGRectMake(325, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        }
        else
        {
            s++;
            self.popUpView.hidden=true;
        }

    }
    else if (button.tag==5) {
        if (t%2==0) {
            buttonFlag=5;
            self.popUpView.hidden=false;
            [self.popupTableView reloadData];
            self.popUpView.frame=CGRectMake(425, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        }
        else
        {
            t++;
            self.popUpView.hidden=true;
        }

    }
}
-(void)willRemoveSubview:(UIView *)subview
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"employee"]) {
        NSMutableArray *selectedEmployeeArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployee"];
        NSString *selectedEmployeeIcon=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployeeIcon"];
        [self specificEmployee:selectedEmployeeArray :selectedEmployeeIcon];
       
    }
    
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"designation"])
    {
        NSMutableArray *selectedDesignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        
        [self assignDesignation:selectedDesignationArray];
    }
    else
    {
        
    }
    
}

@end
