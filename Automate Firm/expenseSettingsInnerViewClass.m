//
//  expenseSettingsInnerViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "expenseSettingsInnerViewClass.h"
#import "categoryCollectionViewCell.h"
#import "groupcollceioncellclass.h"
#import "expenseTile.h"
@implementation expenseSettingsInnerViewClass
@synthesize x,flagValue,s1;
-(void)awakeFromNib
{
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(expenseArrayReloading) name:@"ExpenseArrayReloade" object:Nil];
    
    [self.categoryCollectionView registerNib:[UINib nibWithNibName:@"categoryCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cateogoryCell"];
    self.categoryArray=[[NSMutableArray alloc]init];
    self.limitArray=[[NSMutableArray alloc]init];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.grouparray=[[NSMutableArray alloc]init];
    self.dropArray=[[NSMutableArray alloc] initWithObjects:@"N/A",@"Cover full",@"Specific Amt.", nil];
    self.dropTableView.hidden=true;
    flagValue=0;
    s1=0;
    
    UISwipeGestureRecognizer *leftSwip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip1.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton addGestureRecognizer:leftSwip1];
    
    
    
    UISwipeGestureRecognizer *rightSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton addGestureRecognizer:rightSwipe1];
    
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
    if (collectionView==self.categoryCollectionView) {
        return self.categoryArray.count;
    }
    else
        return [self.grouparray count];
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.categoryCollectionView) {
        static NSString *cellIdentifier = @"cateogoryCell";
        categoryCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (x%2==0) {
            cell.backImage.image=[UIImage imageNamed:@"category & limit 2.png"];
            x++;
        }
        else
        {
            cell.backImage.image=[UIImage imageNamed:@"category & limit.png"];
            x++;
            
        }
        if (self.categoryArray.count > 0) {
            cell.categoryLabel.text=[self.categoryArray objectAtIndex:indexPath.row];
            cell.limitText.text=[self.limitArray objectAtIndex:indexPath.row];
            cell.limitText.delegate=self;
        }
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"simplecell";
        groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (self.grouparray.count>0) {
            cell.grouplabel.text=[self.grouparray objectAtIndex:indexPath.row];
            
        }
        return cell;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dropArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc]init];
    cell.textLabel.text=[self.dropArray objectAtIndex: indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:12];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    app.warningflag=1;
    if (indexPath.row==0)
    {
        self.flagValue=0;
        categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[self.categoryCollectionView cellForItemAtIndexPath:self.inPath];
        cell.limitText.text=[self.dropArray objectAtIndex:indexPath.row];
        [self.limitArray replaceObjectAtIndex:self.inPath.row withObject:cell.limitText.text];
        self.dropTableView.hidden=true;
    }
    else if (indexPath.row==1)
    {
        self.flagValue=0;
        categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[self.categoryCollectionView cellForItemAtIndexPath:self.inPath];
        cell.limitText.text=[self.dropArray objectAtIndex:indexPath.row];
        [self.limitArray replaceObjectAtIndex:self.inPath.row withObject:cell.limitText.text];
        self.dropTableView.hidden=true;
    }
    else if (indexPath.row==2)
    {
        self.flagValue=1;
        categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[self.categoryCollectionView cellForItemAtIndexPath:self.inPath];
        cell.limitText.text=@"";
        [cell.limitText becomeFirstResponder];
        self.dropTableView.hidden=true;
        expenseSettingsInnerViewClass *view=(expenseSettingsInnerViewClass *)self.superview.superview.superview;
        NSLog(@"%@",[view.subviews lastObject]);
//        expenseTile *tile=(expenseTile *)[view.subviews lastObject];
//        tile.frame=CGRectMake(tile.frame.origin.x, 30, tile.frame.size.width, tile.frame.size.height);
//        [view.scrollView setContentOffset:CGPointMake(0, 150) animated:YES];
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[[textField superview]superview];
    self.inPath=[self.categoryCollectionView indexPathForCell:cell];
    if (self.inPath.row == 0) {
        self.dropTableView.frame=CGRectMake(105, 76, self.dropTableView.frame.size.width, self.dropTableView.frame.size.height);
    }
    else if (self.inPath.row==1)
    {
        self.dropTableView.frame=CGRectMake(194, 76, self.dropTableView.frame.size.width, self.dropTableView.frame.size.height);
    }
    else if (self.inPath.row==2)
    {
        self.dropTableView.frame=CGRectMake(283, 76, self.dropTableView.frame.size.width, self.dropTableView.frame.size.height);
    }
    else if (self.inPath.row==3)
    {
        self.dropTableView.frame=CGRectMake(370, 76, self.dropTableView.frame.size.width, self.dropTableView.frame.size.height);
    }
    else if (self.inPath.row > 3)
    {
        self.dropTableView.frame=CGRectMake(459, 76, self.dropTableView.frame.size.width, self.dropTableView.frame.size.height);
    }
    if (flagValue==1) {
        
        return  YES;
    }
    else
    {
        self.dropTableView.hidden=false;
        return  NO;
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[[textField superview]superview];
    self.inPath=[self.categoryCollectionView indexPathForCell:cell];
    float amount=[cell.limitText.text floatValue];
    NSString *value=[NSString stringWithFormat:@"%.1f",amount];
    cell.limitText.text=value;
    [self.limitArray replaceObjectAtIndex:self.inPath.row withObject:value];
    self.flagValue=0;
    
//    expenseSettingsInnerViewClass *view=(expenseSettingsInnerViewClass *)self.superview.superview.superview;
//    //[view.scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
//    expenseTile *tile=(expenseTile *)[view.subviews lastObject];
//    tile.frame=CGRectMake(tile.frame.origin.x, 150, tile.frame.size.width, tile.frame.size.height);
    return  YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    categoryCollectionViewCell *cell=(categoryCollectionViewCell *)[[textField superview]superview];
    self.inPath=[self.categoryCollectionView indexPathForCell:cell];
    if (textField==cell.limitText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length < 6) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@".0123456789"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
            return YES;
        }
        return  NO;
    }
    else
    {
        return YES;
    }
    return false;

}

-(void)expenseArrayReloading
{
    
    [self.grouparray removeAllObjects];
    [self.mycollectionview reloadData];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionAction"]isEqualToString:@"save"]) {
        
        NSMutableArray *myArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"ExpenseArray"];
        [self.categoryArray removeAllObjects];
        [self.limitArray removeAllObjects];
        [self.categoryArray addObjectsFromArray:myArray];
        for (int i=0; i<self.categoryArray.count; i++) {
            [self.limitArray addObject:@"N/A"];
        }
        [self.categoryCollectionView reloadData];
    }
    else
    {
        [self.myconnection viewExpenseConditionView:app.ruleID :app.conditionID];
    }
    
}

-(IBAction)doneButtonAction:(id)sender
{
    app.designationFlag=0;
    app.warningflag=0;
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"expenseAction"]isEqualToString:@"update"]) {
        [self updateAction];
    }
    else
    {
        [self saveAction];
    }
    
    
//    expenseTile *ob = (expenseTile *)self.superview.superview;
//    
//    [ob addaccordianview];
}
-(void)saveAction
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionAction"]isEqualToString:@"save"]) {
        
        
        [self saveToService];
        
        [app.conditionIDArray addObject:@"0"];
        expenseTile *ob = (expenseTile *)self.superview.superview;
        [ob addaccordianview];
    }
    else
    {
//        NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]init];
//        
//        NSMutableDictionary *expenseDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.ruleID,@"expen_id",app.conditionID,@"condition_id",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id", nil];
//        
//        [expenseDict setObject:expenseDetailsDict forKey:@"expense_details"];
//        
//        NSMutableArray *valueArray=[[NSMutableArray alloc]init];
//        for (int i=0; i<self.categoryArray.count; i++) {
//            NSMutableDictionary *conditionDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryArray objectAtIndex:i],@"expen_category",[self.limitArray objectAtIndex:i],@"expen_limit", nil];
//            [valueArray addObject:conditionDict];
//        }
//        [expenseDict setObject:valueArray forKey:@"condition_details"];
//        [self.myconnection saveExpenseCondition:expenseDict];
        [self saveToService];
    }
    
}
-(void)updateAction
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"conditionAction"]isEqualToString:@"save"])
    {
        [self saveToService];
        
//        NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]init];
//        
//        NSMutableDictionary *expenseDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.ruleID,@"expen_id",app.conditionID,@"condition_id",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id", nil];
//        
//        [expenseDict setObject:expenseDetailsDict forKey:@"expense_details"];
//        
//        NSMutableArray *valueArray=[[NSMutableArray alloc]init];
//        for (int i=0; i<self.categoryArray.count; i++) {
//            NSMutableDictionary *conditionDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryArray objectAtIndex:i],@"expen_category",[self.limitArray objectAtIndex:i],@"expen_limit", nil];
//            [valueArray addObject:conditionDict];
//        }
//        [expenseDict setObject:valueArray forKey:@"condition_details"];
//        [self.myconnection saveExpenseCondition:expenseDict];
//        
//        
//        [app.conditionIDArray addObject:@"0"];
//        expenseTile *ob = (expenseTile *)self.superview.superview;
//        [ob addaccordianview];
    }
    else
    {
        
        [self saveToService];
//        NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]init];
//        
//        NSMutableDictionary *expenseDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.ruleID,@"expen_id",app.conditionID,@"condition_id",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id", nil];
//        
//        [expenseDict setObject:expenseDetailsDict forKey:@"expense_details"];
//        
//        NSMutableArray *valueArray=[[NSMutableArray alloc]init];
//        for (int i=0; i<self.categoryArray.count; i++) {
//            NSMutableDictionary *conditionDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryArray objectAtIndex:i],@"expen_category",[self.limitArray objectAtIndex:i],@"expen_limit", nil];
//            [valueArray addObject:conditionDict];
//        }
//        [expenseDict setObject:valueArray forKey:@"condition_details"];
//        [self.myconnection saveExpenseCondition:expenseDict];
    }
}
-(void)saveToService
{
    NSMutableDictionary *expenseDict=[[NSMutableDictionary alloc]init];
    
    NSMutableDictionary *expenseDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.ruleID,@"expen_id",app.conditionID,@"condition_id",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id", nil];
    
    [expenseDict setObject:expenseDetailsDict forKey:@"expense_details"];
    
    NSMutableArray *valueArray=[[NSMutableArray alloc]init];
    for (int i=0; i<self.categoryArray.count; i++) {
        NSMutableDictionary *conditionDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.categoryArray objectAtIndex:i],@"expen_category",[self.limitArray objectAtIndex:i],@"expen_limit", nil];
        [valueArray addObject:conditionDict];
    }
    [expenseDict setObject:valueArray forKey:@"condition_details"];
    
    NSString *designationList=@"";
    if (self.grouparray.count > 0) {
        designationList=[self.grouparray componentsJoinedByString:@"###"];
    }
    else
    {
        designationList=@"";
    }
    
    [expenseDict setObject:designationList forKey:@"selectedDesignation"];
    
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
        [expenseDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"designation_list"];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    }
    
    else
    {
        [expenseDict setObject:@"" forKey:@"designation_list"];
    }
    
    [self.myconnection saveExpenseCondition:expenseDict];
}
-(IBAction)includeDesignationButtonAction:(id)sender
{
    self.saveButton.enabled=NO;
    app.warningflag=1;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    self.saveButton.enabled=YES;
    self.mycollectionview.hidden=false;
    [self.grouparray removeAllObjects];
    [self.grouparray addObjectsFromArray:desigArray];
    [[NSUserDefaults standardUserDefaults]setObject:self.grouparray forKey:@"ExpenseDesigArray"];
    [self.mycollectionview reloadData];
}
-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    self.indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:self.indexpath.row];
    [self.mycollectionview reloadData];
}

-(IBAction)switchButtonAction:(id)sender
{
    if (self.s1%2==0) {
        [self.switchButton setImage:[UIImage imageNamed:@"button_2.png"] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=NO;
        }
        self.s1++;
        [self.scrollView setAlpha:0.6];
    }
    else
    {
        [self.switchButton setImage:[UIImage imageNamed:@"button_1.png"] forState:UIControlStateNormal];
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=YES;
        }
        self.s1++;
        [self.scrollView setAlpha:1.0];
    }
}
-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_1.png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    self.s1++;
    [self.scrollView setAlpha:1.0];
}
-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    //AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    //myappde.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2.png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    //[self setBackgroundColor:[UIColor lightGrayColor]];
    self.s1++;
    [self.scrollView setAlpha:0.6];
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


//<<------------------Service Response----------------------->>

-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.categoryArray removeAllObjects];
        [self.limitArray removeAllObjects];
        if ([responseData count] > 0) {
            for (int i=0; i<[responseData count]; i++) {
                NSMutableDictionary *expenseDict=[responseData objectAtIndex:i];
                [self.categoryArray addObject:[expenseDict objectForKey:@"cat_name"]];
                if ([expenseDict objectForKey:@"cat_value"]!=(id)[NSNull null])
                {
                    [self.limitArray addObject:[expenseDict objectForKey:@"cat_value"]];
                }
                else
                {
                    [self.limitArray addObject:@"N/A"];

                }
            }
            [self.categoryCollectionView reloadData];
            
            NSMutableDictionary *groupDict=[responseData objectAtIndex:0];
            [self.grouparray addObjectsFromArray:[[groupDict objectForKey:@"selected_designation"]componentsSeparatedByString:@"###"]];
            [self.mycollectionview reloadData];
        }
        
    });
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    expenseTile *ob = (expenseTile *)self.superview.superview;
    
    [ob closeTile];
}
@end
