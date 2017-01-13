
//  addnewemployee3Class.m
//  bablusdemokpproject
//
//  Created by leonine on 8/20/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "addnewemployee3Class.h"
#import "leavetableviewcellTableViewCell.h"
#import "EarningsTableViewCell1.h"
#import "deductionsTableViewCell.h"
#import "homeViewController.h"
#import "rulePopupTableViewCell.h"
#import "TeamsTableViewCell.h"
#import "ConditionTableViewCell.h"
@implementation addnewemployee3Class
@synthesize a,b,c,d,action;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    
    
    [self.myconnection listRuleAccordingtoDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"empID"]];
    
    
   
    
    self.earningsArray=[[NSMutableArray alloc]initWithObjects:@"Housing",@"Entertainment",@"Medical Insurance",@"Children's Education", nil];
    self.deductionsArray=[[NSMutableArray alloc]initWithObjects:@"Provident Fund",@"ESI",@"Professional Taxes",@"Income Tax", nil];
    self.empStatusArray=[[NSMutableArray alloc]initWithObjects:@"FullTime",@"HalfTime", nil];
    self.unselectedEarningArray=[[NSMutableArray alloc]init];
    self.unselectedDeductionArray=[[NSMutableArray alloc]init];
    self.selectedLeaveArray=[[NSMutableArray alloc]init];
    self.defaultLeaveArray=[[NSMutableArray alloc]init];
    self.selectedHolidayArray=[[NSMutableArray alloc] init];
    self.defaultHolidayArray=[[NSMutableArray alloc]init];
    self.leavesIDArray=[[NSMutableArray alloc]init];
    self.holidayIDArray=[[NSMutableArray alloc]init];
    self.ruleArray=[[NSMutableArray alloc]init];
    self.ruleIDArray=[[NSMutableArray alloc]init];
    self.ruleDescriptionArray=[[NSMutableArray alloc]init];
    self.shiftOptionArray=[[NSMutableArray alloc]init];
    self.leavesArray=[[NSMutableArray alloc]init];
    self.holidayArray=[[NSMutableArray alloc] init];
    
    self.ruleDict=[[NSMutableDictionary alloc]init];
    self.teamShiftArray=[[NSMutableArray alloc]init];
    self.payTypeArray=[[NSMutableArray alloc]init];
    self.loanArray=[[NSMutableArray alloc]init];
    self.loanIDArray=[[NSMutableArray alloc]init];
    self.selectedLoanArray=[[NSMutableArray alloc]init];
    self.defaultLoanArray=[[NSMutableArray alloc]init];
    
    self.reimbursemntArray=[[NSMutableArray alloc]init];
    self.reimbursemntIDArray=[[NSMutableArray alloc]init];
    self.selectedExpenseArray=[[NSMutableArray alloc]init];
    self.defaultExpenseArray=[[NSMutableArray alloc]init];
    
    self.selectedLeaveDict=[[NSMutableDictionary alloc]init];
    self.selectedLoanDict=[[NSMutableDictionary alloc]init];
    self.selectedExpenseDict=[[NSMutableDictionary alloc]init];
    
    self.x=a=b=c=d=0;
    self.y=0;
    action=1;
    self.selectedField=@"";
    self.empStatusTC.hidden=true;
    self.shiftType=@"Regular";
    
    
    NSMutableDictionary *serviceData=[[NSUserDefaults standardUserDefaults]objectForKey:@"serviceData"];
    
    [self AddNewEmployeeIntitalResponse:serviceData];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)fillDetails:(id)personalDict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",personalDict);
        NSMutableDictionary *detailsDict=[personalDict objectForKey:@"basic_info"];
        self.empID=[detailsDict objectForKey:@"emp_id"];
        self.empCode=[detailsDict objectForKey:@"emp_code"];
        self.monthlyBasicSalaryText.text=[detailsDict objectForKey:@"emp_month_salary"];
        self.empStatusTextField.text=[detailsDict objectForKey:@"emp_status"];
        
    });
}
-(IBAction)saveButtonAction:(id)sender
{
    if([self.shiftType isEqualToString:@"Regular"])
    {
        if ((self.weekText.text.length > 0) && (self.payText.text.length > 0) && (self.overtimeText.text.length > 0) && (self.shiftText.text.length > 0) && (self.teamText.text.length > 0))
        {
            
            [self saveAction];
        }
        else
        {
            [self showalerviewcontroller:@"Must Enter All Mandatory Fields"];
        }

    }
    else
    {
        if ((self.payText.text.length > 0) && (self.overtimeText.text.length > 0) && (self.shiftText.text.length > 0) && (self.teamText.text.length > 0))
        {
            [self saveAction];
        }
        else
        {
            [self showalerviewcontroller:@"Must Enter All Mandatory Fields"];
        }
    }
}

-(void)saveAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [app hudStart:self];
        
        NSMutableArray *selectedLeave=[self.selectedLeaveDict objectForKey:@"leaveSelected"];
        NSMutableDictionary *dummyLeaveDict=[self.selectedLeaveDict mutableCopy];
        [dummyLeaveDict removeObjectForKey:@"leaveSelected"];
        
        for (int i=0; i<selectedLeave.count; i++) {
            if ([self.selectedLeaveDict objectForKey:[selectedLeave objectAtIndex:i]]== nil) {
                [dummyLeaveDict setObject:@"" forKey:[selectedLeave objectAtIndex:i]];
            }
        }
        
        NSMutableArray *selectedLoan=[self.selectedLoanDict objectForKey:@"loanSelected"];
        NSMutableDictionary *dummyLoanDict=[self.selectedLoanDict mutableCopy];
        [dummyLoanDict removeObjectForKey:@"loanSelected"];
        
        for (int i=0; i<selectedLoan.count; i++) {
            if ([self.selectedLoanDict objectForKey:[selectedLoan objectAtIndex:i]]== nil) {
                [dummyLoanDict setObject:@"" forKey:[selectedLoan objectAtIndex:i]];
            }
        }
        
        NSMutableArray *selectedExpense=[self.selectedExpenseDict objectForKey:@"expenseSelected"];
        NSMutableDictionary *dummyExpenseDict=[self.selectedExpenseDict mutableCopy];
        [dummyExpenseDict removeObjectForKey:@"expenseSelected"];
        
        for (int i=0; i<selectedExpense.count; i++) {
            if ([self.selectedExpenseDict objectForKey:[selectedExpense objectAtIndex:i]]== nil) {
                [dummyExpenseDict setObject:@"" forKey:[selectedExpense objectAtIndex:i]];
            }
        }
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            NSMutableDictionary *employeeDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"],@"emp_id",self.empStatusTextField.text,@"emp_status",self.weekID,@"emp_weeek_rule",self.payID,@"emp_pay_rule",self.overtimeID,@"emp_overtime_rule",self.shiftID,@"emp_shift_rule",self.shiftType,@"shift_type",self.teamText.text,@"team",self.monthlyBasicSalaryText.text,@"emp_month_salary",dummyLeaveDict,@"leave",self.selectedHolidayArray,@"holidays",dummyLoanDict,@"loan",dummyExpenseDict,@"expense", nil];
            
            
            NSLog(@"%@",employeeDict);
            
            [self.myconnection addEmployeeSave3:employeeDict];
        }
        else //Update
        {
            NSMutableDictionary *employeeDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.empCode,@"emp_id",self.empStatusTextField.text,@"emp_status",self.weekID,@"emp_weeek_rule",self.payID,@"emp_pay_rule",self.overtimeID,@"emp_overtime_rule",self.shiftID,@"emp_shift_rule",self.shiftType,@"shift_type",self.teamText.text,@"team",self.monthlyBasicSalaryText.text,@"emp_month_salary",dummyLeaveDict,@"leave",self.selectedHolidayArray,@"holidays",dummyLoanDict,@"loan",dummyExpenseDict,@"expense", nil];
            
            
            NSLog(@"%@",employeeDict);
            
            [self.myconnection updateEmployee3:employeeDict];
        }
        
    });
}
-(IBAction)cancelButtonAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"cancel" forKey:@"action"];
    [self removeFromSuperview];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.leavesTC) {
        return self.leavesArray.count;;
    }
    else if (tableView==self.holidayTC)
    {
        return self.holidayArray.count;
    }
    else if (tableView==self.loanTC)
    {
        return  self.loanArray.count;
    }
    else if (tableView==self.expenseReimbursementTC)
    {
        return self.reimbursemntArray.count;
    }
    else if (tableView==self.earningsTC)
    {
        return self.earningsArray.count;
    }
    else if(tableView==self.deductionsTC)
    {
        return self.deductionsArray.count;
    }
    else if(tableView==self.empStatusTC)
        return self.empStatusArray.count;
    else if (tableView==self.shiftOptionTC)
    {
        return self.teamShiftArray.count;
    }
    else
    {
        return self.ruleArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leavesTC) {
        leavetableviewcellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leavetableviewcellTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.nameLabel.text=[self.leavesArray objectAtIndex:indexPath.row];
        cell.cellID=[self.leavesIDArray objectAtIndex:indexPath.row];
        if ([self.selectedLeaveArray containsObject:cell.cellID]) {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_tickmark.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
        }
        
        if ([self.defaultLeaveArray containsObject:cell.cellID]) {
            cell.backImage.image=[UIImage imageNamed:@"leave_box.png"];
        }
        else
        {
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        
        return cell;
    }
    else if (tableView==self.holidayTC)
    {
        leavetableviewcellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leavetableviewcellTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.nameLabel.text=[self.holidayArray objectAtIndex:indexPath.row];
        cell.cellID=[self.holidayIDArray objectAtIndex:indexPath.row];
        if ([self.selectedHolidayArray containsObject:cell.cellID]) {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_tickmark.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
        }
        
        if ([self.defaultHolidayArray containsObject:cell.cellID]) {
            cell.backImage.image=[UIImage imageNamed:@"leave_box.png"];
        }
        else
        {
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        return cell;
    }
    else if (tableView==self.loanTC)
    {
        leavetableviewcellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leavetableviewcellTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.nameLabel.text=[self.loanArray objectAtIndex:indexPath.row];
        cell.cellID=[self.loanIDArray objectAtIndex:indexPath.row];
        if ([self.selectedLoanArray containsObject:cell.cellID]) {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_tickmark.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
        }
        
        if ([self.defaultLoanArray containsObject:cell.cellID]) {
            cell.backImage.image=[UIImage imageNamed:@"leave_box.png"];
        }
        else
        {
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        return cell;
    }
    else if (tableView==self.expenseReimbursementTC)
    {
        leavetableviewcellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leavetableviewcellTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.nameLabel.text=[self.reimbursemntArray objectAtIndex:indexPath.row];
        cell.cellID=[self.reimbursemntIDArray objectAtIndex:indexPath.row];
        if ([self.selectedExpenseArray containsObject:cell.cellID]) {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_tickmark.png"] forState:UIControlStateNormal];
        }
        else
        {
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
        }
        
        if ([self.defaultExpenseArray containsObject:cell.cellID]) {
            cell.backImage.image=[UIImage imageNamed:@"leave_box.png"];
        }
        else
        {
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        return cell;
    }
    
    else if(tableView==self.earningsTC)
    {
        EarningsTableViewCell1 *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"EarningsTableViewCell1" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if ([self.unselectedEarningArray containsObject:indexPath]) {
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            cell.TypeText.userInteractionEnabled=NO;
            cell.amountText.userInteractionEnabled=NO;
            cell.TypeText.backgroundColor=[UIColor lightGrayColor];
            cell.amountText.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            cell.TypeText.userInteractionEnabled=YES;
            cell.amountText.userInteractionEnabled=YES;
            cell.TypeText.backgroundColor=[UIColor clearColor];
            cell.amountText.backgroundColor=[UIColor clearColor];
        }
        if (self.x==1) {
            switch (indexPath.row) {
                case 0:
                    cell.TypeText.userInteractionEnabled=YES;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            cell.TypeText.userInteractionEnabled=NO;
        }
        cell.TypeText.text=[self.earningsArray objectAtIndex:indexPath.row];

        return cell;
    }
    else if(tableView==self.deductionsTC)
    {
        deductionsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"deductionsTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if ([self.unselectedDeductionArray containsObject: indexPath]) {
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
            cell.TypeText.userInteractionEnabled=NO;
            cell.amountText.userInteractionEnabled=NO;
            cell.TypeText.backgroundColor=[UIColor lightGrayColor];
            cell.amountText.backgroundColor=[UIColor lightGrayColor];
        }
        else
        {
            [cell.checkBoxButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
            cell.TypeText.userInteractionEnabled=YES;
            cell.amountText.userInteractionEnabled=YES;
            cell.TypeText.backgroundColor=[UIColor clearColor];
            cell.amountText.backgroundColor=[UIColor clearColor];
        }
        if (self.y==1) {
            switch (indexPath.row) {
                case 0:
                    cell.TypeText.userInteractionEnabled=YES;
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            cell.TypeText.userInteractionEnabled=NO;

        }
        cell.TypeText.text=[self.deductionsArray objectAtIndex:indexPath.row];
        cell.TypeText.placeholder=@"Deductions";
        return cell;
    }
    else if(tableView==self.empStatusTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        cell.textLabel.text=[self.empStatusArray objectAtIndex:indexPath.row];
        cell.textLabel.font=[UIFont systemFontOfSize:12];
        return cell;
    }
    else if (tableView==self.shiftOptionTC)
    {
        TeamsTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"TeamsTableViewCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.shiftOptionLabel.text=[self.teamShiftArray objectAtIndex:indexPath.row];
        NSString *type=[[cell.shiftOptionLabel.text componentsSeparatedByString:@" "] objectAtIndex:0];
        if ([type isEqualToString:@"Day"]) {
            cell.iconImage.image=[UIImage imageNamed:@"Shift_swing-iconblack.png"];
        }
        else if ([type isEqualToString:@"Swing"])
        {
            cell.iconImage.image=[UIImage imageNamed:@"shift_day_iconblack.png"];
        }
        else if ([type isEqualToString:@"Night"])
        {
            cell.iconImage.image=[UIImage imageNamed:@"shift_night_iconblack.png"];
        }
        return cell;
    }
    else
    {
        if (action==1) {
            rulePopupTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
                NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"rulePopupTableViewCell" owner:self options:nil];
                cell=[array objectAtIndex:0];
            }
            cell.abbrvLabel.text=[self.ruleArray objectAtIndex:indexPath.row];
            cell.descriptionLabel.text=[self.ruleDescriptionArray objectAtIndex:indexPath.row];
            cell.shiftTypeLabel.text=[self.shiftOptionArray objectAtIndex:indexPath.row];
            cell.cellID=[self.ruleIDArray objectAtIndex: indexPath.row];
            if ([self.selctedRule containsString:cell.cellID]) {
                [cell.radioButton setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.radioButton setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            }
            if ([self.highlightedRule containsString:cell.cellID]) {
                cell.backImage.image=[UIImage imageNamed:@"selected_cell.png"];
            }
            else
            {
                cell.backImage.image=[UIImage imageNamed:@"grey_cell.png"];
            }
            
            return cell;
        }
        else
        {
            ConditionTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell==nil) {
                NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"ConditionTableViewCell" owner:self options:nil];
                cell=[nib objectAtIndex:0];
            }
            cell.abbrvLabel.text=[self.ruleArray objectAtIndex:indexPath.row];
            cell.cellID=[self.ruleIDArray objectAtIndex:indexPath.row];
            if ([self.selctedRule containsString:cell.cellID]) {
                [cell.radioButton setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            }
            else
            {
                [cell.radioButton setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
            }
            if ([self.highlightedRule containsString:cell.cellID]) {
                cell.backImage.image=[UIImage imageNamed:@"selected_cell.png"];
            }
            else
            {
                cell.backImage.image=[UIImage imageNamed:@"grey_cell.png"];
            }
            return  cell;
        }
        
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.popupTC) {
        if (action==1) {
            return 76.0;
        }
        else
        {
            return 38.0;
        }
    }
    else if((tableView==self.earningsTC) || (tableView==self.deductionsTC))
    {
        return 35.0;
    }
    else if (tableView==self.shiftOptionTC)
    {
        return 45.0;
    }
    else
    {
        return 30.0;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.leavesTC) {
        leavetableviewcellTableViewCell *cell=(leavetableviewcellTableViewCell *)[self.leavesTC cellForRowAtIndexPath:indexPath];
        if ([cell.checkButton.currentImage isEqual:[UIImage imageNamed:@"white_box_addnew.png"]]) {
            [self.selectedLeaveArray addObject:[self.leavesIDArray objectAtIndex:indexPath.row]];
            
            [[NSUserDefaults standardUserDefaults]setObject:[self.leavesIDArray objectAtIndex:indexPath.row] forKey:@"selectedID"];
            [self.selectedLeaveDict setObject:self.selectedLeaveArray forKey:@"leaveSelected"];
            
            [self.myconnection listLeaveConditions:[self.leavesIDArray objectAtIndex:indexPath.row] :[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"]];
            
        }
        else
        {
            
            [self.selectedLeaveArray removeObject:[self.leavesIDArray objectAtIndex:indexPath.row]];
            [self.selectedLeaveDict removeObjectForKey:[self.leavesIDArray objectAtIndex:indexPath.row]];
            [self.selectedLeaveDict setObject:self.selectedLeaveArray forKey:@"leaveSelected"];
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        [self.leavesTC reloadData];
    }
    else if (tableView==self.holidayTC)
    {
        leavetableviewcellTableViewCell *cell=(leavetableviewcellTableViewCell *)[self.holidayTC cellForRowAtIndexPath:indexPath];
        if ([cell.checkButton.currentImage isEqual:[UIImage imageNamed:@"white_box_addnew.png"]]) {
            
            [self.selectedHolidayArray addObject:[self.holidayIDArray objectAtIndex:indexPath.row]];
            
            
        }
        else
        {
            [self.selectedHolidayArray removeObject:[self.holidayIDArray objectAtIndex:indexPath.row]];
            
        }
        [self.holidayTC reloadData];
    }
    else if (tableView==self.expenseReimbursementTC)
    {
        leavetableviewcellTableViewCell *cell=(leavetableviewcellTableViewCell *)[self.expenseReimbursementTC cellForRowAtIndexPath:indexPath];
        if ([cell.checkButton.currentImage isEqual:[UIImage imageNamed:@"white_box_addnew.png"]]) {
            [self.selectedExpenseArray addObject:[self.reimbursemntIDArray objectAtIndex:indexPath.row]];
            
            [[NSUserDefaults standardUserDefaults]setObject:[self.reimbursemntIDArray objectAtIndex:indexPath.row] forKey:@"selectedID"];
            [self.selectedExpenseDict setObject:self.selectedExpenseArray forKey:@"expenseSelected"];
            
            [self.myconnection listExpenseCondition:[self.reimbursemntIDArray objectAtIndex:indexPath.row] :[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"]];
            
        }
        else
        {
            
            [self.selectedExpenseArray removeObject:[self.reimbursemntIDArray objectAtIndex:indexPath.row]];
            [self.selectedExpenseDict removeObjectForKey:[self.reimbursemntIDArray objectAtIndex:indexPath.row]];
            [self.selectedExpenseDict setObject:self.selectedExpenseArray forKey:@"expenseSelected"];
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        [self.expenseReimbursementTC reloadData];
    }
    else if (tableView==self.loanTC)
    {
        leavetableviewcellTableViewCell *cell=(leavetableviewcellTableViewCell *)[self.loanTC cellForRowAtIndexPath:indexPath];
        
        if ([cell.checkButton.currentImage isEqual:[UIImage imageNamed:@"white_box_addnew.png"]]) {
            [self.selectedLoanArray addObject:[self.loanIDArray objectAtIndex:indexPath.row]];
            
            [[NSUserDefaults standardUserDefaults]setObject:[self.loanIDArray objectAtIndex:indexPath.row] forKey:@"selectedID"];
            [self.selectedLoanDict setObject:self.selectedLoanArray forKey:@"loanSelected"];
            
            [self.myconnection listLoanCondition:[self.loanIDArray objectAtIndex:indexPath.row] :[[NSUserDefaults standardUserDefaults]objectForKey:@"empID"]];
            
        }
        else
        {
            
            [self.selectedLoanArray removeObject:[self.loanIDArray objectAtIndex:indexPath.row]];
            [self.selectedLoanDict removeObjectForKey:[self.loanIDArray objectAtIndex:indexPath.row]];
            [self.selectedLoanDict setObject:self.selectedLoanArray forKey:@"loanSelected"];
            [cell.checkButton setImage:[UIImage imageNamed:@"white_box_addnew.png"] forState:UIControlStateNormal];
            cell.backImage.image=[UIImage imageNamed:@"leave_box_grey.png"];
        }
        [self.loanTC reloadData];
        
        
    }
    if (tableView==self.empStatusTC) {
        self.empStatusTextField.text=[self.empStatusArray objectAtIndex:indexPath.row];
        self.empStatusTC.hidden=true;
    }
    if (tableView==self.popupTC) {
        if (action==1) {
            //Other popup
            
            if ([self.selectedField isEqualToString:@"Week Rules"]) {
                [self.ruleDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:@"weekSelected"];
                self.weekText.text=[self.ruleArray objectAtIndex:indexPath.row];
                self.weekID=[self.ruleIDArray objectAtIndex:indexPath.row];
                b++;
            }
            else if ([self.selectedField isEqualToString:@"Pay Rules"])
            {
                [self.ruleDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:@"paySelected"];
                self.payText.text=[self.ruleArray objectAtIndex:indexPath.row];
                self.payID=[self.ruleIDArray objectAtIndex:indexPath.row];
                if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"daily"]) {
                    self.salaryLabel.text=@"Daily Wages";
                }
                else if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"monthly"])
                {
                    self.salaryLabel.text=@"Monthly Basic Salary";
                }
                else if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"bi-weekly"])
                {
                    self.salaryLabel.text=@"Bi-Weekly Wages";
                }
                else if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"weekly"])
                {
                    self.salaryLabel.text=@"Weekly Wages";
                }
                else if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"semi-month"])
                {
                    self.salaryLabel.text=@"Semi-Monthly Wages";
                }
                else if ([[self.payTypeArray objectAtIndex:indexPath.row]isEqualToString:@"custom"])
                {
                    [self.myconnection individualPayruleView:[self.ruleIDArray objectAtIndex:indexPath.row] officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
                }
                c++;
            }
            
            else if ([self.selectedField isEqualToString:@"Overtime Rules"])
            {
                [self.ruleDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:@"overtimeSelected"];
                self.overtimeText.text=[self.ruleArray objectAtIndex:indexPath.row];
                self.overtimeID=[self.ruleIDArray objectAtIndex:indexPath.row];
                d++;
            }
            else if ([self.selectedField isEqualToString:@"Shift Rules"])
            {
                [self.ruleDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:@"shiftSelected"];
                self.shiftText.text=[self.ruleArray objectAtIndex:indexPath.row];
                self.shiftID=[self.ruleIDArray objectAtIndex:indexPath.row];
                if ([[self.shiftOptionArray objectAtIndex:indexPath.row]isEqualToString:@"(Rotational)"])
                {
                    self.shiftType=@"Rotational";
                    self.shiftResultTextLabel.text=@"Team";
                    [self shiftTeamOptionList:@"Team"];
                    self.weekText.text=@"";
                    self.weekText.userInteractionEnabled=NO;
                    self.weekText.backgroundColor=[UIColor lightGrayColor];
                }
                else
                {
                    self.shiftType=@"Regular";
                    self.shiftResultTextLabel.text=@"Shift Option";
                    [self shiftTeamOptionList:[self.ruleIDArray objectAtIndex:indexPath.row]];
                    self.weekText.userInteractionEnabled=YES;
                    self.weekText.backgroundColor=[UIColor clearColor];
                    
                }
                self.teamText.text=@"";
                self.teamText.userInteractionEnabled=YES;
                self.teamText.backgroundColor=[UIColor clearColor];
                a++;
            }
            [self ruleSelection:self.selectedField];
        }
        else
        {
            //Leave,loan,expense popup
            if([self.seletedRuleLabel.text isEqualToString:@"Leave"])
            {
                [self.selectedLeaveDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
            }
            else if ([self.seletedRuleLabel.text isEqualToString:@"Expense Reimbursement"])
            {
                [self.selectedExpenseDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
            }
            else if ([self.seletedRuleLabel.text isEqualToString:@"Loan"])
            {
                [self.selectedLoanDict setObject:[self.ruleIDArray objectAtIndex:indexPath.row] forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
            }
            
            
            
        }
        
        self.rulePopup.hidden=true;
    }
    if (tableView==self.shiftOptionTC) {
        self.teamText.text=[self.teamShiftArray objectAtIndex:indexPath.row];
        NSString *type=[[self.teamText.text componentsSeparatedByString:@" "] objectAtIndex:0];
            if (([type isEqualToString:@"Day"])||([type isEqualToString:@"Swing"])||([type isEqualToString:@"Night"])) {
            self.teamText.text=[[self.teamText.text componentsSeparatedByString:@" "] objectAtIndex:0];
        }
        self.shiftOptionTC.hidden=true;
    }
    
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.empStatusTextField) {
        self.empStatusTC.hidden=false;
        return NO;
    }
    if (textField==self.monthlyBasicSalaryText) {
        return YES;
    }
    else if (textField==self.shiftText)
    {
        if (a%2==0) {
            self.rulePopup.hidden=false;
            self.selectedField=@"Shift Rules";
            [self ruleSelection:@"Shift Rules"];
            a++;
        }
        else
        {
            self.rulePopup.hidden=true;
            a++;
        }
        
        return  NO;
    }
    else if (textField==self.weekText)
    {
        if (b%2==0) {
            self.rulePopup.hidden=false;
            self.selectedField=@"Week Rules";
            [self ruleSelection:@"Week Rules"];
            b++;
        }
        else
        {
            self.rulePopup.hidden=true;
            b++;
        }
        
        return  NO;
    }
    else if (textField==self.payText)
    {
        if (c%2==0) {
            self.rulePopup.hidden=false;
            self.selectedField=@"Pay Rules";
            [self ruleSelection:@"Pay Rules"];
            c++;
        }
        else
        {
            self.rulePopup.hidden=false;
            c++;
        }
        
        return  NO;
    }
    else if (textField==self.overtimeText)
    {
        if (d%2==0) {
            self.rulePopup.hidden=false;
            self.selectedField=@"Overtime Rules";
            [self ruleSelection:@"Overtime Rules"];
            d++;
        }
        else
        {
            self.rulePopup.hidden=false;
            d++;
        }
        
        return  NO;
    }
    else if (textField==self.teamText)
    {
        self.shiftOptionTC.hidden=false;
        return  NO;
    }
    
    else
        return YES;
}
-(IBAction)addnewEarningsAction:(id)sender
{
        self.x=1;
        NSInteger row = 0;
        NSInteger section = 0;
        [self.earningsArray insertObject:@"" atIndex:row];
        NSIndexPath *myindexpath = [NSIndexPath indexPathForRow:row inSection:section];
        [self.earningsTC beginUpdates];
        [self.earningsTC insertRowsAtIndexPaths:@[myindexpath] withRowAnimation:UITableViewRowAnimationTop];
        [self.earningsTC endUpdates];
}
-(IBAction)addNewDeductionsAction:(id)sender
{
    self.y=1;
    NSInteger row = 0;
    NSInteger section = 0;
    [self.deductionsArray insertObject:@"" atIndex:row];
    NSIndexPath *myindexpath=[NSIndexPath indexPathForRow:row inSection:section];
    [self.deductionsTC beginUpdates];
    [self.deductionsTC insertRowsAtIndexPaths:@[myindexpath] withRowAnimation:UITableViewRowAnimationTop];
    [self.deductionsTC endUpdates];
}
-(IBAction)checkBoxAction:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.earningsTC];
    NSIndexPath *inPath= [self.earningsTC indexPathForRowAtPoint:buttonPosition];
    EarningsTableViewCell1 *cell=(EarningsTableViewCell1 *)[self.earningsTC cellForRowAtIndexPath:inPath];
    if ([cell.checkBoxButton.currentImage isEqual:[UIImage imageNamed:@"checkbox1.png23.png"]]) {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        [self.unselectedEarningArray removeObject:inPath];
    }
    else
    {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        [self.unselectedEarningArray addObject:inPath];
    }
    [self.earningsTC reloadData];
}
-(IBAction)checkBoxAction1:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.deductionsTC];
    NSIndexPath *inPath= [self.deductionsTC indexPathForRowAtPoint:buttonPosition];
    deductionsTableViewCell *cell=(deductionsTableViewCell *)[self.deductionsTC cellForRowAtIndexPath:inPath];
    if ([cell.checkBoxButton.currentImage isEqual:[UIImage imageNamed:@"checkbox1.png23.png"]]) {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        [self.unselectedDeductionArray removeObject:inPath];
    }
    else
    {
        [cell.checkBoxButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        [self.unselectedDeductionArray addObject: inPath];
    }
    [self.deductionsTC reloadData];

}
- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}






-(void)ruleSelection:(NSString *)option
{
    [self.ruleArray removeAllObjects];
    [self.ruleIDArray removeAllObjects];
    [self.ruleDescriptionArray removeAllObjects];
    [self.shiftOptionArray removeAllObjects];
    [self.payTypeArray removeAllObjects];
    
    action=1;
    
    self.seletedRuleLabel.text=option;
    
        if ([option isEqualToString:@"Week Rules"]) {
            NSMutableArray *array=[self.ruleDict objectForKey:option];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dict=[array objectAtIndex:i];
                [self.ruleArray addObject:[dict objectForKey:@"abr"]];
                [self.ruleIDArray addObject:[dict objectForKey:@"week_rule_id"]];
                [self.ruleDescriptionArray addObject:[dict objectForKey:@"description"]];
                [self.shiftOptionArray addObject:@""];
                self.selctedRule=[self.ruleDict objectForKey:@"weekSelected"];
                self.highlightedRule=[self.ruleDict objectForKey:@"weekDefault"];
            }
        }
        if ([option isEqualToString:@"Pay Rules"]) {
            NSMutableArray *array=[self.ruleDict objectForKey:option];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dict=[array objectAtIndex:i];
                [self.ruleArray addObject:[dict objectForKey:@"abr"]];
                [self.ruleIDArray addObject:[dict objectForKey:@"id"]];
                [self.ruleDescriptionArray addObject:[dict objectForKey:@"description"]];
                [self.shiftOptionArray addObject:@""];
                self.selctedRule=[self.ruleDict objectForKey:@"paySelected"];
                self.highlightedRule=[self.ruleDict objectForKey:@"payDefault"];
                [self.payTypeArray addObject:[dict objectForKey:@"period_settings"]];
            }

        }
        if ([option isEqualToString:@"Overtime Rules"]) {
            NSMutableArray *array=[self.ruleDict objectForKey:option];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dict=[array objectAtIndex:i];
                [self.ruleArray addObject:[dict objectForKey:@"abr"]];
                [self.ruleIDArray addObject:[dict objectForKey:@"id"]];
                [self.ruleDescriptionArray addObject:[dict objectForKey:@"description"]];
                [self.shiftOptionArray addObject:@""];
            
                self.selctedRule=[self.ruleDict objectForKey:@"overtimeSelected"];
                self.highlightedRule=[self.ruleDict objectForKey:@"overtimeDefault"];
            }
        }
        if ([option isEqualToString:@"Shift Rules"]) {
            NSMutableArray *array=[self.ruleDict objectForKey:option];
            for (int i=0; i<array.count; i++) {
                NSMutableDictionary *dict=[array objectAtIndex:i];
                [self.ruleArray addObject:[dict objectForKey:@"shift_abbrv"]];
                [self.ruleIDArray addObject:[dict objectForKey:@"id"]];
                [self.ruleDescriptionArray addObject:[dict objectForKey:@"shift_description"]];
                [self.shiftOptionArray addObject:[NSString stringWithFormat:@"(%@)",[dict objectForKey:@"shift_type"]]];
                self.selctedRule=[self.ruleDict objectForKey:@"shiftSelected"];
                self.highlightedRule=[self.ruleDict objectForKey:@"shiftDefault"];
            }
        }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.popupTC reloadData];
        
    });
}
-(void)shiftTeamOptionList:(NSString *)type
{
    if ([type isEqualToString:@"Team"]) {
        [self.teamShiftArray removeAllObjects];
        for (int t=1;t<7;t++) {
            [self.teamShiftArray addObject:[NSString stringWithFormat:@"Team %d",t]];
        }
    }
    else
    {
        [self.myconnection displaySelectedShiftRule:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] :type];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.shiftOptionTC reloadData];
    });
}

//<<<-----------------------Response Part------------->>>

-(void)AddNewEmployeeIntitalResponse:(id)responseData1
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.ruleDict setObject:[responseData1 objectForKey:@"weekrules"] forKey:@"Week Rules"];
        [self.ruleDict setObject:[responseData1 objectForKey:@"payrules"] forKey:@"Pay Rules"];
        [self.ruleDict setObject:[responseData1 objectForKey:@"overtimerule"] forKey:@"Overtime Rules"];
        [self.ruleDict setObject:[responseData1 objectForKey:@"shiftrule"] forKey:@"Shift Rules"];
        
        
        [self.leavesArray removeAllObjects];
        [self.leavesIDArray removeAllObjects];
        [self.holidayIDArray removeAllObjects];
        [self.holidayArray removeAllObjects];
        [self.reimbursemntArray removeAllObjects];
        [self.reimbursemntIDArray removeAllObjects];
        
        NSMutableArray *leaveArray=[responseData1 objectForKey:@"leaves"];
        for ( int i=0; i<leaveArray.count; i++) {
            NSMutableDictionary *leaveDict=[leaveArray objectAtIndex:i];
            [self.leavesArray addObject:[leaveDict objectForKey:@"leave_abbrv"]];
            [self.leavesIDArray addObject:[leaveDict objectForKey:@"leave_id"]];
        }
        
        
        NSMutableArray *holidayArray=[responseData1 objectForKey:@"holidays"];
        for (int i=0; i<holidayArray.count; i++) {
            NSMutableDictionary *holidayDict=[holidayArray objectAtIndex:i];
            [self.holidayArray addObject:[holidayDict objectForKey:@"holyday_name"]];
            [self.holidayIDArray addObject:[holidayDict objectForKey:@"holi_id"]];
            
        }
        [self.leavesTC reloadData];
        [self.holidayTC reloadData];
        
        NSMutableArray *loanArray=[responseData1 objectForKey:@"loan"];
        for (int i=0; i<loanArray.count; i++) {
            NSMutableDictionary *loanDict=[loanArray objectAtIndex:i];
            [self.loanArray addObject:[loanDict objectForKey:@"abbreviation"]];
            [self.loanIDArray addObject:[loanDict objectForKey:@"loan_id"]];
        }
        
        NSMutableArray *expenseArray=[responseData1 objectForKey:@"expense_reimbursement"];
        for (int i=0; i<expenseArray.count; i++) {
            NSMutableDictionary *expenseDict=[expenseArray objectAtIndex:i];
            [self.reimbursemntArray addObject:[expenseDict objectForKey:@"expen_abbr"]];
            [self.reimbursemntIDArray addObject:[expenseDict objectForKey:@"expen_id"]];
        }
        
        [self.loanTC reloadData];
        [self.expenseReimbursementTC reloadData];
    });
}

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableDictionary *weekDict=[responseData objectForKey:@"week_rule"];
        id defaultWeekDict = [weekDict objectForKey:@"default"];
        if ([defaultWeekDict isKindOfClass:[NSDictionary class ]]) {
            
            [self.ruleDict setObject:[defaultWeekDict objectForKey:@"week_rule_id"] forKey:@"weekDefault"];
            
        }
        else
        {
            [self.ruleDict setObject:@"" forKey:@"weekDefault"];
        }
        
        
        id selectedWeekDict = [weekDict objectForKey:@"selected"];
        if ([selectedWeekDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[selectedWeekDict objectForKey:@"week_rule_id"] forKey:@"weekSelected"];
            self.weekID=[selectedWeekDict objectForKey:@"week_rule_id"];
            self.weekText.text=[selectedWeekDict objectForKey:@"abr"];
        }
        else
        {
            [self.ruleDict setObject:[self.ruleDict objectForKey:@"weekDefault"] forKey:@"weekSelected"];
            if ([defaultWeekDict isKindOfClass:[NSDictionary class]]) {
                self.weekText.text=[defaultWeekDict objectForKey:@"abr"];
                self.weekID=[defaultWeekDict objectForKey:@"week_rule_id"];
                
            }
        }
        
        
        NSMutableDictionary *payDict=[responseData objectForKey:@"pay_rule"];
        id defaultPayDict = [payDict objectForKey:@"default"];
        if ([defaultPayDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[defaultPayDict objectForKey:@"id"] forKey:@"payDefault"];
        }
        else
        {
            [self.ruleDict setObject:@"" forKey:@"payDefault"];
        }
        
        
        id selectedPayDict = [payDict objectForKey:@"selected"];
        if ([selectedPayDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[selectedPayDict objectForKey:@"id"] forKey:@"paySelected"];
            self.payText.text=[selectedPayDict objectForKey:@"abr"];
            self.payID=[selectedPayDict objectForKey:@"id"];
            
            if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"daily"]) {
                self.salaryLabel.text=@"Daily Wages";
            }
            else if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"monthly"])
            {
                self.salaryLabel.text=@"Monthly Basic Salary";
            }
            else if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"bi-weekly"])
            {
                self.salaryLabel.text=@"Bi-Weekly Wages";
            }
            else if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"weekly"])
            {
                self.salaryLabel.text=@"Weekly Wages";
            }
            else if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"semi-month"])
            {
                self.salaryLabel.text=@"Semi-Monthly Wages";
            }
            else if ([[selectedPayDict objectForKey:@"period_settings"]isEqualToString:@"custom"])
            {
                [self.myconnection individualPayruleView:[selectedPayDict objectForKey:@"id"] officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
            }
            
        }
        else
        {
            [self.ruleDict setObject:[self.ruleDict objectForKey:@"payDefault"] forKey:@"paySelected"];
            if ([defaultPayDict isKindOfClass:[NSDictionary class]]) {
                self.payText.text=[defaultPayDict objectForKey:@"abr"];
                self.payID=[defaultPayDict objectForKey:@"id"];
                
                if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"daily"]) {
                    self.salaryLabel.text=@"Daily Wages";
                }
                else if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"monthly"])
                {
                    self.salaryLabel.text=@"Monthly Basic Salary";
                }
                else if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"bi-weekly"])
                {
                    self.salaryLabel.text=@"Bi-Weekly Wages";
                }
                else if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"weekly"])
                {
                    self.salaryLabel.text=@"Weekly Wages";
                }
                else if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"semi-month"])
                {
                    self.salaryLabel.text=@"Semi-Monthly Wages";
                }
                else if ([[defaultPayDict objectForKey:@"period_settings"]isEqualToString:@"custom"])
                {
                    [self.myconnection individualPayruleView:[defaultPayDict objectForKey:@"id"] officeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
                }
            }
        }
        
        
        NSMutableDictionary *overtimeDict=[responseData objectForKey:@"over_time"];
        id defaultOvertimeDict = [overtimeDict objectForKey:@"default"];
        if ([defaultOvertimeDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[defaultOvertimeDict objectForKey:@"id"] forKey:@"overtimeDefault"];
        }
        else
        {
            [self.ruleDict setObject:@"" forKey:@"overtimeDefault"];
        }
        
        
        id selectedOvertimeDict = [overtimeDict objectForKey:@"selected"];
        if ([selectedOvertimeDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[selectedOvertimeDict objectForKey:@"id"] forKey:@"overtimeSelected"];
            self.overtimeText.text=[selectedOvertimeDict objectForKey:@"abr"];
            self.overtimeID=[selectedOvertimeDict objectForKey:@"id"];
        }
        else
        {
            [self.ruleDict setObject:[self.ruleDict objectForKey:@"overtimeDefault"] forKey:@"overtimeSelected"];
            if ([defaultOvertimeDict isKindOfClass:[NSDictionary class]]) {
                self.overtimeText.text=[defaultOvertimeDict objectForKey:@"abr"];
                self.overtimeID=[defaultOvertimeDict objectForKey:@"id"];
            }
        }
        
        NSMutableDictionary *shiftDict=[responseData objectForKey:@"shift"];
        id defaultShiftDict = [shiftDict objectForKey:@"default"];
        if ([defaultShiftDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[defaultShiftDict objectForKey:@"id"] forKey:@"shiftDefault"];
        }
        else
        {
            [self.ruleDict setObject:@"" forKey:@"shiftDefault"];
        }
        
        
        id selectedShiftDict = [shiftDict objectForKey:@"selected"];
        if ([selectedShiftDict isKindOfClass:[NSDictionary class]]) {
            
            [self.ruleDict setObject:[selectedShiftDict objectForKey:@"id"] forKey:@"shiftSelected"];
            self.shiftText.text=[selectedShiftDict objectForKey:@"shift_abbrv"];
            self.shiftID=[selectedShiftDict objectForKey:@"id"];
            self.teamText.userInteractionEnabled=YES;
            self.teamText.backgroundColor=[UIColor clearColor];
            if ([[selectedShiftDict objectForKey:@"shift_type"]isEqualToString:@"Regular"]) {
                self.shiftResultTextLabel.text=@"Shift Option";
                self.shiftType=@"Regular";
                [self shiftTeamOptionList:[selectedShiftDict objectForKey:@"id"]];
                self.weekText.userInteractionEnabled=YES;
                self.weekText.backgroundColor=[UIColor clearColor];
            }
            else
            {
                self.shiftType=@"Rotational";
                self.shiftResultTextLabel.text=@"Team";
                [self shiftTeamOptionList:@"Team"];
                self.weekText.text=@"";
                self.weekText.userInteractionEnabled=NO;
                self.weekText.backgroundColor=[UIColor lightGrayColor];
            }
        }
        else
        {
            [self.ruleDict setObject:[self.ruleDict objectForKey:@"shiftDefault"] forKey:@"shiftSelected"];
            if ([defaultShiftDict isKindOfClass:[NSDictionary class]]) {
                self.shiftText.text=[defaultShiftDict objectForKey:@"shift_abbrv"];
                self.shiftID=[defaultShiftDict objectForKey:@"id"];
                if (self.shiftText.text.length>0) {
                    self.teamText.userInteractionEnabled=YES;
                    self.teamText.backgroundColor=[UIColor clearColor];
                    
                    if ([[defaultShiftDict objectForKey:@"shift_type"]isEqualToString:@"Regular"]) {
                        self.shiftType=@"Regular";
                        self.shiftResultTextLabel.text=@"Shift Option";
                        [self shiftTeamOptionList:[defaultShiftDict objectForKey:@"id"]];
                        self.weekText.userInteractionEnabled=YES;
                        self.weekText.backgroundColor=[UIColor clearColor];
                    }
                    else
                    {
                        self.shiftType=@"Rotational";
                        self.shiftResultTextLabel.text=@"Team";
                        [self shiftTeamOptionList:@"Team"];
                        self.weekText.text=@"";
                        self.weekText.userInteractionEnabled=NO;
                        self.weekText.backgroundColor=[UIColor lightGrayColor];
                    }
                    
                }
            }
        }
        
        
        [self.selectedLeaveArray removeAllObjects];
        [self.defaultLeaveArray removeAllObjects];
        [self.defaultHolidayArray removeAllObjects];
        [self.selectedHolidayArray removeAllObjects];
        
        NSMutableArray *leaveArray=[responseData objectForKey:@"leave_selected"];
        NSMutableArray *leaveDefaultArray=[responseData objectForKey:@"leave_default"];
        if (leaveArray.count > 0) {
            for (int i=0; i<leaveArray.count; i++) {
                NSMutableDictionary *leaveDict=[leaveArray objectAtIndex:i];
                [self.selectedLeaveArray addObject:[leaveDict objectForKey:@"leave_id"]];
            }
        }
        else
        {
            for (int i=0; i<leaveDefaultArray.count; i++) {
                NSMutableDictionary *leaveDict=[leaveDefaultArray objectAtIndex:i];
                [self.selectedLeaveArray addObject:[leaveDict objectForKey:@"leave_id"]];
            }
        }
        [self.selectedLeaveDict setObject:self.selectedLeaveArray forKey:@"leaveSelected"];
        
        for (int i=0; i<leaveDefaultArray.count; i++) {
            NSMutableDictionary *leaveDict=[leaveDefaultArray objectAtIndex:i];
            [self.defaultLeaveArray addObject:[leaveDict objectForKey:@"leave_id"]];
        }
        
        
        NSMutableArray *holidayArray=[responseData objectForKey:@"holidays_selected"];
        NSMutableArray *defaultHolidayArray=[responseData objectForKey:@"holidays_default"];
        if (holidayArray.count > 0) {
            for (int i=0; i<holidayArray.count; i++) {
                NSMutableDictionary *holidayDict=[holidayArray objectAtIndex:i];
                [self.selectedHolidayArray addObject:[holidayDict objectForKey:@"holi_id"]];
            }
        }
        else
        {
            for (int i=0; i<defaultHolidayArray.count; i++) {
                NSMutableDictionary *holidayDict=[defaultHolidayArray objectAtIndex:i];
                [self.selectedHolidayArray addObject:[holidayDict objectForKey:@"holi_id"]];
            }
        }
        for (int i=0; i<defaultHolidayArray.count; i++) {
            NSMutableDictionary *holidayDict=[defaultHolidayArray objectAtIndex:i];
            [self.defaultHolidayArray addObject:[holidayDict objectForKey:@"holi_id"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.leavesTC reloadData];
            [self.holidayTC reloadData];
        });
        
        [self.selectedExpenseArray removeAllObjects];
        [self.defaultExpenseArray removeAllObjects];
        [self.defaultLoanArray removeAllObjects];
        [self.selectedLoanArray removeAllObjects];
        
        NSMutableArray *reimbursemntArray=[responseData objectForKey:@"reimbersment_selected"];
        NSMutableArray *defaultExpenseArray=[responseData objectForKey:@"reimbersment_default"];
        
        if (reimbursemntArray.count > 0) {
            for (int i=0; i<reimbursemntArray.count; i++) {
                NSMutableDictionary *selectedExpenseDict=[reimbursemntArray objectAtIndex:i];
                [self.selectedExpenseArray addObject:[selectedExpenseDict objectForKey:@"expen_id"]];
            }
        }
        else
        {
            for (int i=0; i<defaultExpenseArray.count; i++) {
                NSMutableDictionary *selectedExpenseDict=[defaultExpenseArray objectAtIndex:i];
                [self.selectedExpenseArray addObject:[selectedExpenseDict objectForKey:@"expen_id"]];
            }
        }
        for (int i=0; i<defaultExpenseArray.count; i++) {
            NSMutableDictionary *selectedExpenseDict=[defaultExpenseArray objectAtIndex:i];
            [self.defaultExpenseArray addObject:[selectedExpenseDict objectForKey:@"expen_id"]];
        }
        
        [self.selectedExpenseDict setObject:self.selectedExpenseArray forKey:@"expenseSelected"];
        
        
        NSMutableArray *loanArray=[responseData objectForKey:@"loan_selected"];
        NSMutableArray *defaultLoanArray=[responseData objectForKey:@"loan_default"];
        if (loanArray.count > 0) {
            for (int i=0; i<loanArray.count; i++) {
                NSMutableDictionary *loanDict=[loanArray objectAtIndex:i];
                [self.selectedLoanArray addObject:[loanDict objectForKey:@"loan_id"]];
            }
        }
        else
        {
            for (int i=0; i<defaultLoanArray.count; i++) {
                NSMutableDictionary *loanDict=[defaultLoanArray objectAtIndex:i];
                [self.selectedLoanArray addObject:[loanDict objectForKey:@"loan_id"]];
            }
        }
        
        [self.selectedLoanDict setObject:self.selectedLoanArray forKey:@"loanSelected"];
        for (int i=0; i<defaultLoanArray.count; i++) {
            NSMutableDictionary *loanDict=[defaultLoanArray objectAtIndex:i];
            [self.defaultLoanArray addObject:[loanDict objectForKey:@"loan_id"]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.expenseReimbursementTC reloadData];
            [self.loanTC reloadData];
        });
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"update"]) {
            NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
            self.detailsDict=[[NSMutableDictionary alloc]init];
            self.detailsDict=[NSKeyedUnarchiver unarchiveObjectWithData:newData];
            
            [self fillDetails:self.detailsDict];
        }
        
    });
}
-(void)updateruleviewresponse:(NSMutableArray *)updateruleArray{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.teamShiftArray removeAllObjects];
        NSMutableDictionary *shiftDict=[updateruleArray objectAtIndex:0];
        if (!([[shiftDict objectForKey:@"day_punch_start"]isEqualToString:@""])) {
            [self.teamShiftArray addObject:[NSString stringWithFormat:@"Day (%@ - %@)",[shiftDict objectForKey:@"day_shift_start"],[shiftDict objectForKey:@"day_shift_end"]]];
        }
        if (!([[shiftDict objectForKey:@"swing_punch_start"]isEqualToString:@""])) {
            [self.teamShiftArray addObject:[NSString stringWithFormat:@"Swing (%@ - %@)",[shiftDict objectForKey:@"swing_shift_start"],[shiftDict objectForKey:@"swing_shift_end"]]];
        }
        if (!([[shiftDict objectForKey:@"night_punch_start"]isEqualToString:@""])) {
            [self.teamShiftArray addObject:[NSString stringWithFormat:@"Night (%@ - %@)",[shiftDict objectForKey:@"night_shift_start"],[shiftDict objectForKey:@"night_shift_end"]]];
        }
    
        [self.shiftOptionTC reloadData];
    });
    
}

-(void)viewIndividualPayResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSMutableArray *paymentArray=[responseList objectForKey:@"payroll_details"];
        NSMutableDictionary *paymentDict=[paymentArray objectAtIndex:0];
        self.salaryLabel.text=[NSString stringWithFormat:@"Basic Salary for %@ days",[paymentDict objectForKey:@"period_gap"]];
    });
    
}

-(void)individualDisplayResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        action=2;
        [self.ruleIDArray removeAllObjects];
        [self.ruleArray removeAllObjects];
        self.highlightedRule=@"";
        self.selctedRule=@"";
        
        self.rulePopup.hidden=false;
        self.seletedRuleLabel.text=@"Leave";
        
        NSMutableArray *conditionArray=[responseData objectForKey:@"details"];
        for (int i=0; i<conditionArray.count; i++) {
            NSMutableDictionary *conditionDict=[conditionArray objectAtIndex:i];
            [self.ruleArray addObject:[NSString stringWithFormat:@"Condition %d",i+1]];
            [self.ruleIDArray addObject:[conditionDict objectForKey:@"id"]];
        }
        NSMutableArray *defaultArray=[responseData objectForKey:@"default"];
        if (defaultArray.count>0) {
            NSMutableDictionary *dict=[defaultArray objectAtIndex:0];
            self.highlightedRule=[dict objectForKey:@"tile_id"];
            
        }
        
        NSMutableArray *selectedArray=[responseData objectForKey:@"selected"];
        if (selectedArray.count>0) {
            NSMutableDictionary *dict=[selectedArray objectAtIndex:0];
            self.selctedRule=[dict objectForKey:@"c_id"];
            [self.selectedLeaveDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        else
        {
            self.selctedRule=self.highlightedRule;
            [self.selectedLeaveDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        
        [self.popupTC reloadData];
        
    });
}

-(void)allearningsResponse:(id)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        action=2;
        [self.ruleIDArray removeAllObjects];
        [self.ruleArray removeAllObjects];
        self.highlightedRule=@"";
        self.selctedRule=@"";
        
        self.rulePopup.hidden=false;
        self.seletedRuleLabel.text=@"Expense Reimbursement";
        
        NSMutableArray *conditionArray=[response objectForKey:@"details"];
        for (int i=0; i<conditionArray.count; i++) {
            NSMutableDictionary *conditionDict=[conditionArray objectAtIndex:i];
            [self.ruleArray addObject:[NSString stringWithFormat:@"Condition %d",i+1]];
            [self.ruleIDArray addObject:[conditionDict objectForKey:@"con_id"]];
        }
        NSMutableArray *defaultArray=[response objectForKey:@"default"];
        if (defaultArray.count>0) {
            NSMutableDictionary *dict=[defaultArray objectAtIndex:0];
            self.highlightedRule=[dict objectForKey:@"tile_id"];
            
        }
        
        NSMutableArray *selectedArray=[response objectForKey:@"selected"];
        if (selectedArray.count>0) {
            NSMutableDictionary *dict=[selectedArray objectAtIndex:0];
            self.selctedRule=[dict objectForKey:@"c_id"];
            [self.selectedExpenseDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        else
        {
            self.selctedRule=self.highlightedRule;
            [self.selectedExpenseDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        
        [self.popupTC reloadData];
        
    });
}
-(void)viewAllLoanResponse:(id)responseList
{
    dispatch_async(dispatch_get_main_queue(), ^{
        action=2;
        [self.ruleIDArray removeAllObjects];
        [self.ruleArray removeAllObjects];
        self.highlightedRule=@"";
        self.selctedRule=@"";
        
        self.rulePopup.hidden=false;
        self.seletedRuleLabel.text=@"Loan";
        
        NSMutableArray *conditionArray=[responseList objectForKey:@"details"];
        for (int i=0; i<conditionArray.count; i++) {
            NSMutableDictionary *conditionDict=[conditionArray objectAtIndex:i];
            [self.ruleArray addObject:[NSString stringWithFormat:@"Condition %d",i+1]];
            [self.ruleIDArray addObject:[conditionDict objectForKey:@"id"]];
        }
        NSMutableArray *defaultArray=[responseList objectForKey:@"default"];
        if (defaultArray.count>0) {
            NSMutableDictionary *dict=[defaultArray objectAtIndex:0];
            self.highlightedRule=[dict objectForKey:@"tile_id"];
            
        }
        
        NSMutableArray *selectedArray=[responseList objectForKey:@"selected"];
        if (selectedArray.count>0) {
            NSMutableDictionary *dict=[selectedArray objectAtIndex:0];
            self.selctedRule=[dict objectForKey:@"c_id"];
            [self.selectedLoanDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        else
        {
            self.selctedRule=self.highlightedRule;
            [self.selectedLoanDict setObject:self.self.selctedRule forKey:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedID"]];
        }
        
        [self.popupTC reloadData];
        
    });
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    
    UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@""
                                   message:[NSString stringWithFormat:@"%@",errorMessage]
                                   preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                   }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"empStatus"]isEqualToString:@"create"]) {
            [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        else
        {
            [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        }
        
    });
}
-(void)addNewEmployeeSaveResponse:(NSString *)saveResponse
{
    if ([saveResponse isEqualToString:@"1"]) {
        [self showalerviewcontroller:@"Successfully Saved"];
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults]setObject:@"save" forKey:@"action"];
            [self removeFromSuperview];
        });

    }
    else
    {
        [self showalerviewcontroller:@"Error in Saving"];
    }
}

@end
