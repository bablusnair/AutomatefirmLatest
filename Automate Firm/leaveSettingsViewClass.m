//
//  leaveSettingsViewClass.m
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "leaveSettingsViewClass.h"

@implementation leaveSettingsViewClass
@synthesize x;
- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}
-(void)awakeFromNib
{
    self.x=0;
    self.monthTableView.hidden=TRUE;
    self.monthArray=[[NSMutableArray alloc]initWithObjects:@"January",@"February",@"March",@"April",@"May",@"June",@"July",@"August",@"September",@"October",@"November",@"December", nil];
    //to verify
    NSString *action=[[NSUserDefaults standardUserDefaults]objectForKey:@"radioButtonSelection"];
    if ([action isEqualToString:@"1"]) {
        self.paidLeaveLabel.text=@"Days/Months";
    }
    else
    {
        self.paidLeaveLabel.text=@"Days";
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.monthArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.monthArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.joiningMonthText.text=[self.monthArray objectAtIndex:indexPath.row];
    self.monthTableView.hidden=TRUE;
}
-(IBAction)advancedAction:(id)sender
{
    if (self.x%2==0) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"paymentView" owner:self options:nil];
        [self.paymentStructureView addSubview:[array objectAtIndex:0]];
        self.x++;
    }
    else
    {
        for (UIView *myview in self.paymentStructureView.subviews) {
            if (myview.tag==100) {
                [myview removeFromSuperview];
                
            }
        }
        self.x++;
    }
    
}
-(IBAction)carryForwardButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else if (button.tag==2)
    {
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else if (button.tag==3)
    {
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else if (button.tag==4)
    {
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else if (button.tag==5)
    {
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else if (button.tag==6)
    {
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
    else
    {
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.joiningMonthText) {
        self.monthTableView.hidden=false;
        self.monthTableView.frame=CGRectMake(447, 175, self.monthTableView.frame.size.width, self.monthTableView.frame.size.height);
        return  NO;
    }
    if (textField==self.carryText1) {
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText2) {
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText3) {
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText4) {
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText5) {
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText6) {
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    if (textField==self.carryText7) {
        [self.carryRadioButton7 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.carryRadioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton4 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton5 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton6 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.carryRadioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        return  NO;
    }
    else
        return YES;
}
@end
