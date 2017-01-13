       //
//  expenseReimbursementSettingsViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "expenseReimbursementSettingsViewClass.h"
#import "expenseCategoriesCollectionViewCell.h"
#import "expenseTile.h"
#import "expenseSettingsInnerViewClass.h"
#import "settingsViewController.h"
#import "borrowingSettingsViewClass.h"
@implementation expenseReimbursementSettingsViewClass
@synthesize expenseArray,addNewFlag;
-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    accordion = [[expenseTile alloc] initWithFrame:CGRectMake(10, 240, 625, 330)];
    [self addSubview:accordion];

    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"expenseAction"]isEqualToString:@"update"])
    {
        self.addTileButton.hidden=false;
        self.addNewButton.enabled=TRUE;
        [self.myconnection individualExpenseRuleView:[[NSUserDefaults standardUserDefaults]objectForKey:@"expense_ID"]];
    }
    else
    {
        self.addNewButton.enabled=NO;
        self.addTileButton.hidden=true;

    }
    
    //[[NSUserDefaults standardUserDefaults]setObject:@"loan" forKey:@"accordianAction"];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [app.conditionIDArray removeAllObjects];
    app.selectedRow=0;
    app.ruleID=app.conditionID=@"0";
    [app.conditionIDArray addObject:@"0"];
    app.conditionCount=0;
    
    
    [self.expenseCollectionView registerNib:[UINib nibWithNibName:@"expenseCategoriesCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"expenseCell"];
    expenseArray=[[NSMutableArray alloc]initWithObjects:@"", nil];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"ExpenseArray"];
    self.expenseTypeArray=[[NSMutableArray alloc] initWithObjects:@"Occasional",@"Monthly", nil];
    self.expenseTypeTC.hidden=true;
    self.addNewFlag=0;
    
    self.descriptionText.text=@"";
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return expenseArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"expenseCell";
    expenseCategoriesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (expenseArray.count > 0) {
        cell.expenseText.text=[self.expenseArray objectAtIndex:indexPath.row];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.expenseTypeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.expenseTypeArray objectAtIndex:indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.expenseTypeText.text=[self.expenseTypeArray objectAtIndex:indexPath.row];
    self.expenseTypeTC.hidden=true;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.expenseTypeText) {
        self.expenseTypeTC.hidden=false;
        return  NO;
    }
    else
        return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.expenseNameText) {
        self.expenseNameText.text=[self.expenseNameText.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    }
    else if (textField==self.abbrvText)
    {
        self.abbrvText.text=[self.abbrvText.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    }
    else if (textField==self.descriptionText)
    {
        self.descriptionText.text=[self.descriptionText.text stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceCharacterSet]];
    }
    return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.expenseNameText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=44) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
            return  NO;
    }
    else if (textField==self.abbrvText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789 "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
            return  NO;

    }
    else if (textField==self.descriptionText)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=94) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789./@!$%&*()?, "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
            return  NO;
    }
    else
    {
        return YES;
    }
}
-(IBAction)addNewExpense:(id)sender
{
    if (!([expenseArray.lastObject isEqualToString:@""])) {
        [self.expenseArray addObject:@""];
        
        self.addNewButton.enabled=NO;
        
        NSArray *visibleItems = [self.expenseCollectionView indexPathsForVisibleItems];
        [self.expenseCollectionView reloadData];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.expenseArray.count - 1 inSection:currentItem.section];
        [self.expenseCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
    }
    
}
-(IBAction)textfieldShouldBeginEditing:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.expenseCollectionView];
    self.inPath= [self.expenseCollectionView indexPathForItemAtPoint:buttonPosition];
  //  expenseCategoriesCollectionViewCell *cell=(expenseCategoriesCollectionViewCell *)[self.expenseCollectionView cellForItemAtIndexPath:self.inPath];
    [self.scrollView setContentOffset:CGPointMake(0, 40) animated:YES];

    addNewFlag=0;
    
}
-(IBAction)textfieldShouldEndEditing:(id)sender
{
    expenseCategoriesCollectionViewCell *cell=(expenseCategoriesCollectionViewCell *)[self.expenseCollectionView cellForItemAtIndexPath:self.inPath];
    cell.expenseText.text=[cell.expenseText.text stringByTrimmingCharactersInSet:
                                [NSCharacterSet whitespaceCharacterSet]];
    if (cell.expenseText.text.length > 0)
    {
        if ([self.expenseArray containsObject:cell.expenseText.text])
        {
            if (self.expenseArray.count > 1) {
                [self.expenseArray removeObjectAtIndex:self.inPath.row];
                [self.expenseCollectionView reloadData];
                if (!([[self.expenseArray lastObject]isEqualToString:@""]))
                {
                    self.addNewButton.enabled=YES;
                }
                [[NSUserDefaults standardUserDefaults]setObject:self.expenseArray forKey:@"ExpenseArray"];
                [self showalerviewcontroller:@"Expense Category Already Exist"];
            }
        }
        else
        {
            if (addNewFlag==1) {
                self.addNewButton.enabled=NO;
            }
            else
            {
                self.addNewButton.enabled=YES;
            }
            [self.expenseArray replaceObjectAtIndex:self.inPath.row withObject:cell.expenseText.text];
                [[NSUserDefaults standardUserDefaults]setObject:self.expenseArray forKey:@"ExpenseArray"];
            [self changeExpenseCategoryAction:@"N"];
        }
            
        [self.expenseCollectionView reloadData];
    
    }
    else
    {
        if (self.expenseArray.count > 1) {
            self.addNewButton.enabled=false;
//            if (self.inPath.row==self.expenseArray.count - 1) {
//                self.addNewButton.enabled=YES;
//            }
            [self.expenseArray removeObjectAtIndex:self.inPath.row];
            [self.expenseCollectionView reloadData];
            if (!([[self.expenseArray lastObject]isEqualToString:@""]))
            {
                self.addNewButton.enabled=YES;
            }
        }
        [[NSUserDefaults standardUserDefaults]setObject:self.expenseArray forKey:@"ExpenseArray"];
        [self changeExpenseCategoryAction:@"N"];
        }
    [self.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    
}
-(void)enable
{
    self.addNewButton.enabled=YES;
    self.expenseCollectionView.userInteractionEnabled=YES;
    self.saveButton.enabled=YES;
    self.cancelButton.enabled=YES;
}
-(void)disable
{
    self.addNewButton.enabled=NO;
    self.expenseCollectionView.userInteractionEnabled=NO;
    self.saveButton.enabled=NO;
    self.cancelButton.enabled=NO;
}
-(void)willRemoveSubview:(UIView *)subview
{
    NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSLog(@"%@",self.subviews);
    for (expenseSettingsInnerViewClass *myView in accordion.scrollView.subviews) {
        if ([myView isKindOfClass:[expenseSettingsInnerViewClass class]]) {
            
            [myView collectionViewReload:selectedDeignationArray];
        }
    }
}
-(IBAction)saveAction:(id)sender
{
    app.designationFlag=0;
    app.warningflag=0;
    [app.conditionIDArray removeObject:@"0"];
    if (app.conditionIDArray.count>0) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
        [self finalSaveAction:@"Y"];
    }
    else
    {
        [self showalerviewcontroller:@"Must Enter Atleast One Condition"];
        [app.conditionIDArray addObject:@"0"];
    }
    
    
    //[self removeFromSuperview];
}
-(IBAction)cancelAction:(id)sender
{
    app.designationFlag=0;
    app.warningflag=0;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"expenseAction"]isEqualToString:@"update"]) {
        [app.conditionIDArray removeObject:@"0"];
        if (app.conditionIDArray.count>0) {
            [self finalSaveAction:@"Y"];
        }
        else
        {
            [self alertActionforCancel:@"Expense Rule Doesn't contains any condition. Enter Continue to Delete the Expense Rule"];
        }
    }
    else
        [self removeFromSuperview];
}
-(IBAction)deleteCell:(id)sender
{
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.expenseCollectionView];
    self.inPath= [self.expenseCollectionView indexPathForItemAtPoint:buttonPosition];
    if (self.expenseArray.count > 1) {
        if ([[self.expenseArray objectAtIndex:self.inPath.row]isEqualToString:@""]) {
            self.addNewButton.enabled=YES;
        }
        [self.expenseArray removeObjectAtIndex:self.inPath.row];
        
        [self.expenseCollectionView reloadData];
        [[NSUserDefaults standardUserDefaults]setObject:self.expenseArray forKey:@"ExpenseArray"];
        [self changeExpenseCategoryAction:@"N"];
    }
    
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",self.superview.superview.superview.superview);
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
-(void)alertActionforCancel:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Continue" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   [self.myconnection deleteExpenseRule:app.ruleID];
                                                   [self removeFromSuperview];
                                                   
                                               }];
    [alert addAction:ok];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   [app.conditionIDArray addObject:@"0"];
                                               }];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",self.superview.superview.superview.superview);
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
-(IBAction)AddTileAction:(id)sender
{
    if ([app.conditionIDArray.lastObject isEqualToString:@"0"]) {
        [self showalerviewcontroller:@"Can't make an empty Condition"];
    }
    else
    {
        expenseTile *myobj = (expenseTile *)[self.subviews lastObject];
        [myobj addNewTileForUpdation:app.conditionIDArray.count];
    }
}

-(void)changeExpenseCategoryAction:(NSString *)expen_view_status
{
    if ((self.expenseNameText.text.length > 0)&&(self.abbrvText.text.length > 0)) {
        //service
        NSString *expenseCategory=[self.expenseArray componentsJoinedByString:@"###"];
        NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:expenseCategory,@"expenseCategory",app.ruleID,@"expen_id",self.expenseNameText.text,@"expen_name",self.abbrvText.text,@"expen_abbr",self.expenseTypeText.text,@"expen_type",self.descriptionText.text,@"expen_desc",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",expen_view_status,@"expen_view_status", nil];
        NSLog(@"%@",expenseDict);
        [self.myconnection createNewExpenseCategory:expenseDict];
        
    }
    else
    {
        [self.expenseArray replaceObjectAtIndex:self.inPath.row withObject:@""];
        self.addNewButton.enabled=NO;
        [self.expenseCollectionView reloadData];
        [self showalerviewcontroller:@"First Enter Expense Name and Abbreviation"];
    }
}
-(void)finalSaveAction:(NSString *)expen_view_status
{
    if ((self.expenseNameText.text.length > 0)&&(self.abbrvText.text.length > 0)) {
        //service
        NSString *expenseCategory=[self.expenseArray componentsJoinedByString:@"###"];
        NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:expenseCategory,@"expenseCategory",app.ruleID,@"expen_id",self.expenseNameText.text,@"expen_name",self.abbrvText.text,@"expen_abbr",self.expenseTypeText.text,@"expen_type",self.descriptionText.text,@"expen_desc",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",expen_view_status,@"expen_view_status", nil];
        NSLog(@"%@",expenseDict);
        [self.myconnection finalExpenseCreation:expenseDict];
        
    }
    else
    {
        [self.expenseArray replaceObjectAtIndex:self.inPath.row withObject:@""];
        self.addNewButton.enabled=NO;
        [self.expenseCollectionView reloadData];
        [self showalerviewcontroller:@"First Enter Expense Name and Abbreviation"];
    }
}

- (void) keyboardDidShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height-40, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        // AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
        
        // NSLog(@"%@",myappde.designation_tile);
        
        
    }
    
}
- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    //loanTileClass *ob = (loanTileClass *)self.superview.superview;
    //[ob.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
}


//<<----------------------------------Service Part---------------------------------------->>

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [app.conditionIDArray removeAllObjects];
        
        NSMutableArray *expenseDetailsArray=[responseData objectForKey:@"imbursment_rule"];
        NSMutableDictionary *expenseDict=[expenseDetailsArray objectAtIndex:0];
        app.ruleID=[expenseDict objectForKey:@"expen_id"];
        self.expenseNameText.text=[expenseDict objectForKey:@"expen_name"];
        self.abbrvText.text=[expenseDict objectForKey:@"expen_abbr"];
        self.expenseTypeText.text=[expenseDict objectForKey:@"expen_type"];
        self.descriptionText.text=[expenseDict objectForKey:@"expen_desc"];
        [self.expenseArray removeAllObjects];
        [self.expenseArray addObjectsFromArray:[[expenseDict objectForKey:@"expense_category"]componentsSeparatedByString:@"###"]];
        [[NSUserDefaults standardUserDefaults]setObject:self.expenseArray forKey:@"ExpenseArray"];
        [self.expenseCollectionView reloadData];
        
        NSMutableArray *conditionsArray=[responseData objectForKey:@"imbursment_rule_condtions"];
        
        expenseTile *myobj = (expenseTile *)[self.subviews lastObject];
        [myobj CreationoftileforUpdation:conditionsArray.count];
        
        
        for (int i=0; i<conditionsArray.count; i++) {
            NSMutableDictionary *conditionDict=[conditionsArray objectAtIndex:i];
            [app.conditionIDArray addObject:[conditionDict objectForKey:@"id"]];
        }
        
        
        
        
        
    });
    
}
-(void)initiallyruleviewresponse:(NSMutableArray *)viewrulearray
{
    dispatch_async(dispatch_get_main_queue(), ^{
        borrowingSettingsViewClass *ob = (borrowingSettingsViewClass *)self.superview.superview;
        
        [ob initiallyruleviewresponse:viewrulearray];
        
        [self removeFromSuperview];
    });
}
@end
