//
//  autocodeTileViewClass.m
//  Automate Firm
//
//  Created by leonine on 7/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "autocodeTileViewClass.h"
#import "settingcell.h"
#import "autocodeTableViewCell.h"
#import "settingsViewController.h"
@implementation autocodeTileViewClass

-(void)awakeFromNib
{
    [self.officesetupcollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [self.myconnection autocodeListing:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
    
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.app.warningflag=0;
    
    self.iconsarray=[[NSMutableArray alloc]initWithObjects:@"top_office_normal.png",@"top_office_normal.png",@"top_office_normal.png",  nil];
    self.iconnamesarray=[[NSMutableArray alloc]initWithObjects:@"Office 1",@"Office 2",@"Office 3", nil];
    
    self.workingPremiseArray=[[NSMutableArray alloc]init];
    self.workingPremiseIDArray=[[NSMutableArray alloc]init];
    self.workingPremiseCodeArray=[[NSMutableArray alloc]init];
    self.departmentArray=[[NSMutableArray alloc]init];
    self.departmentIDArray=[[NSMutableArray alloc]init];
    self.departmentCodeArray=[[NSMutableArray alloc]init];
    self.categoryArray=[[NSMutableArray alloc]init];
    self.categoryIDArray=[[NSMutableArray alloc]init];
    self.categoryCodeArray=[[NSMutableArray alloc]init];
    self.allWorkingPremiseArray=[[NSMutableArray alloc]init];
    
    self.autocodeID=@"0";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(autocodingView) name:@"autocodingView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
     
    
                                               object:nil];
    
    
    
    
    UISwipeGestureRecognizer *leftSwip1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToLeftWithGestureRecognizer:)];
    
    leftSwip1.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.switchButton addGestureRecognizer:leftSwip1];
    
    
    
    UISwipeGestureRecognizer *rightSwipe1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(slideToRightWithGestureRecognizer:)];
    
    rightSwipe1.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.switchButton addGestureRecognizer:rightSwipe1];
    
}
-(IBAction)switchButtonAction:(id)sender
{
    if (self.s1%2==0) {
        
        [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        
        
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=NO;
        }
        self.clearButton.enabled=NO;
        self.clearLabel.enabled=NO;
        self.s1++;
        [self.scrollView setAlpha:0.6];//off
        self.switchButtonstring=@"2";
        
    }
    else
    {
        [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
        
        
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=YES;
        }
        self.clearButton.enabled=YES;
        self.clearLabel.enabled=YES;
        self.s1++;
        [self.scrollView setAlpha:1.0];
        
        self.switchButtonstring=@"1";
    }
    [self.workingPremiseTC reloadData];
    [self.departmentTC reloadData];
    [self.categoryTC reloadData];
    self.app.warningflag=1;
}
-(void)slideToRightWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    
    self.app.warningflag=1;
    [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=YES;
    }
    self.clearButton.enabled=YES;
    self.clearLabel.enabled=YES;
    self.switchButtonstring=@"1";
    self.s1++;
    [self.scrollView setAlpha:1.0];
    [self.workingPremiseTC reloadData];
    [self.departmentTC reloadData];
    [self.categoryTC reloadData];
}
-(void)slideToLeftWithGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer{
    self.app.warningflag=1;

    [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
    
    for (UIView *myview in self.scrollView.subviews) {
        myview.userInteractionEnabled=NO;
    }
    self.clearButton.enabled=NO;
    self.clearLabel.enabled=NO;
    self.switchButtonstring=@"2";
    [self setBackgroundColor:[UIColor lightGrayColor]];
    self.s1++;
    [self.scrollView setAlpha:0.6];
    [self.workingPremiseTC reloadData];
    [self.departmentTC reloadData];
    [self.categoryTC reloadData];
    
}

-(void)autocodingView
{
    [self.myconnection autocodeListing:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.iconnamesarray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    cell.backgroundColor=[UIColor whiteColor];
    cell.myimg.image=[UIImage imageNamed:@"top_office_active.png"];
    cell.mylabel.text=[self.iconnamesarray objectAtIndex:indexPath.row];
    cell.mylabel.textColor=[UIColor blueColor];
        UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.officesetupcollectionview.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flow.minimumLineSpacing = 27;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.workingPremiseTC) {
        return self.workingPremiseArray.count;
    }
    else if(tableView==self.departmentTC)
    {
        return self.departmentArray.count;
    }
    else
        return self.categoryArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.workingPremiseTC) {
        autocodeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"autocodeTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.tag=1;
        cell.nameLabel.text=[self.workingPremiseArray objectAtIndex:indexPath.row];
        if ([self.switchButtonstring isEqualToString:@"1"]) {
            cell.codeText.text=[self.workingPremiseCodeArray objectAtIndex:indexPath.row];
        }
        
        cell.codeText.delegate=self;
        return  cell;
    }
    else if(tableView==self.departmentTC)
    {
        autocodeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"autocodeTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.tag=2;
        cell.nameLabel.text=[self.departmentArray objectAtIndex:indexPath.row];
        if ([self.switchButtonstring isEqualToString:@"1"]) {
            cell.codeText.text=[self.departmentCodeArray objectAtIndex:indexPath.row];
        }
        cell.codeText.delegate=self;
        return  cell;
    }
    else
    {
        autocodeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"autocodeTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.tag=3;
        cell.nameLabel.text=[self.categoryArray objectAtIndex:indexPath.row];
        if ([self.switchButtonstring isEqualToString:@"1"]) {
            cell.codeText.text=[self.categoryCodeArray objectAtIndex:indexPath.row];
        }
        cell.codeText.delegate=self;
        return  cell;
    }
    
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
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.workingPremiseArray removeAllObjects];
        [self.workingPremiseIDArray removeAllObjects];
        [self.workingPremiseCodeArray removeAllObjects];
        [self.departmentArray removeAllObjects];
        [self.departmentIDArray removeAllObjects];
        [self.departmentCodeArray removeAllObjects];
        [self.categoryArray removeAllObjects];
        [self.categoryIDArray removeAllObjects];
        [self.categoryCodeArray removeAllObjects];
        [self.allWorkingPremiseArray removeAllObjects];
    
        NSMutableArray *workingPremise=[responseData objectForKey:@"working_premise"];
        for (int i=0; i<workingPremise.count; i++) {
            NSMutableDictionary *workPremiseDict=[workingPremise objectAtIndex:i];
            if (i==0) {
                [self.workingPremiseArray addObject:[workPremiseDict objectForKey:@"office_name"]];
                [self.workingPremiseIDArray addObject:[workPremiseDict objectForKey:@"id"]];
            }
            else
            {
                [self.workingPremiseArray addObject:[workPremiseDict objectForKey:@"store_name"]];
                [self.workingPremiseIDArray addObject:[workPremiseDict objectForKey:@"store_id"]];
            }
            [self.workingPremiseCodeArray addObject:[[workPremiseDict objectForKey:@"code"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
    
        NSMutableArray *department=[responseData objectForKey:@"department_details"];
        for (int i=0; i<department.count; i++) {
            NSMutableDictionary *departmentDict=[department objectAtIndex:i];
            [self.departmentArray addObject:[departmentDict objectForKey:@"department_name"]];
            [self.departmentIDArray addObject:[departmentDict objectForKey:@"dept_id"]];
            [self.departmentCodeArray addObject:[[departmentDict objectForKey:@"code"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
    
        NSMutableArray *category=[responseData objectForKey:@"category_details"];
        for (int i=0; i<category.count; i++) {
            NSMutableDictionary *categoryDict=[category objectAtIndex:i];
            [self.categoryArray addObject:[categoryDict objectForKey:@"cat_name"]];
            [self.categoryIDArray addObject:[categoryDict objectForKey:@"cat_id"]];
            [self.categoryCodeArray addObject:[[categoryDict objectForKey:@"code"]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]];
        }
        
        NSMutableArray *allPremiseArray=[responseData objectForKey:@"all_working_premise"];
        for (int i=0; i<allPremiseArray.count; i++) {
            NSMutableDictionary *premiseDict=[allPremiseArray objectAtIndex:i];
            [self.allWorkingPremiseArray addObject:[premiseDict objectForKey:@"code"]];
        }
        
        NSMutableDictionary *switchDict=[[responseData objectForKey:@"checkbox_value"] objectAtIndex:0];
        self.switchButtonstring=[switchDict objectForKey:@"checkbox_enable"];
        self.autocodeID=[switchDict objectForKey:@"id"];
        if ([self.switchButtonstring isEqualToString:@"2"]) {
            [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
            
            
            for (UIView *myview in self.scrollView.subviews) {
                myview.userInteractionEnabled=NO;
            }
            self.clearButton.enabled=NO;
            self.clearLabel.enabled=NO;
            self.s1++;
            [self.scrollView setAlpha:0.6];//off
            self.switchButtonstring=@"2";
        }
        else
        {
            [self.switchButton setImage:[UIImage imageNamed:@"button_2 (1).png"] forState:UIControlStateNormal];
            
            
            for (UIView *myview in self.scrollView.subviews) {
                myview.userInteractionEnabled=YES;
            }
            self.clearButton.enabled=YES;
            self.clearLabel.enabled=YES;
            self.s1++;
            [self.scrollView setAlpha:1.0];
            
            self.switchButtonstring=@"1";
        }
        
        [self.workingPremiseTC reloadData];
        [self.departmentTC reloadData];
        [self.categoryTC reloadData];
    });
    
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    autocodeTableViewCell *cell=(autocodeTableViewCell *)[[textField superview]superview];
    if (cell.tag==1) {
        self.inPath=[self.workingPremiseTC indexPathForCell:cell];
    }
    else if (cell.tag==2)
    {
        self.inPath=[self.departmentTC indexPathForCell:cell];
    }
    else
    {
        self.inPath=[self.categoryTC indexPathForCell:cell];
    }
    self.activeField=cell.codeText;
    self.app.warningflag=1;
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    autocodeTableViewCell *cell=(autocodeTableViewCell *)[[textField superview]superview];
    if (cell.tag==1) {
        NSIndexPath *inPath=[self.workingPremiseTC indexPathForCell:cell];
        if (cell.codeText.text.length > 0) {
            NSMutableArray *premiseArray=[[NSMutableArray alloc]initWithArray:self.workingPremiseCodeArray];
            NSMutableArray *allWorkingPremiseArray = [[NSMutableArray alloc]initWithArray:self.allWorkingPremiseArray];
            if ([premiseArray containsObject:cell.codeText.text]) {
                [allWorkingPremiseArray removeObject:[premiseArray objectAtIndex:inPath.row]];
                [premiseArray removeObjectAtIndex:inPath.row];
            }
            
            
            
            
            
            if (([allWorkingPremiseArray containsObject:cell.codeText.text])||([premiseArray containsObject:cell.codeText.text]))// && (cell.codeText.text.length > 0))
            {
                [self alertShow:@"Working Premise code already exists"];
            }
            else
            {
                [self.workingPremiseCodeArray replaceObjectAtIndex:inPath.row withObject:cell.codeText.text];
            }
        }
        [self.workingPremiseTC reloadData];
        
        
    }
    if (cell.tag==2) {
        NSIndexPath *inPath=[self.departmentTC indexPathForCell:cell];
        
        if (cell.codeText.text.length > 0)
        {
            NSMutableArray *departmentArray=[[NSMutableArray alloc]initWithArray:self.departmentCodeArray];
            [departmentArray removeObjectAtIndex:inPath.row];
            if ([departmentArray containsObject:cell.codeText.text])// && (cell.codeText.text.length > 0))
            {
                [self alertShow:@"Department code already exists"];
            }
            else
            {
                [self.departmentCodeArray replaceObjectAtIndex:inPath.row withObject:cell.codeText.text];
            }
        }
        [self.departmentTC reloadData];
    }
    if (cell.tag==3) {
        NSIndexPath *inPath=[self.categoryTC indexPathForCell:cell];
        
        if (cell.codeText.text.length > 0) {
            
            NSMutableArray *catArray=[[NSMutableArray alloc]initWithArray:self.categoryCodeArray];
            [catArray removeObjectAtIndex:inPath.row];
            if ([catArray containsObject:cell.codeText.text])
            {
                [self alertShow:@"Category code already exists"];
            }
            else
            {
                [self.categoryCodeArray replaceObjectAtIndex:inPath.row withObject:cell.codeText.text];
                
            }
        }
        [self.categoryTC reloadData];
        
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.workingPremiseTC reloadData];
        [self.departmentTC reloadData];
        [self.categoryTC reloadData];
    });
    
    return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    autocodeTableViewCell *cell=(autocodeTableViewCell *)[[textField superview]superview];
    if (textField==cell.codeText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=2) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else{
                return NO;
            }
            return YES;
        }
    }
    else
    {
        return YES;
    }
    return false;
}
-(IBAction)saveAction:(id)sender
{
    self.app.warningflag=0;
    NSMutableDictionary *autocodeDict=[[NSMutableDictionary alloc]init];
    [autocodeDict setObject:self.switchButtonstring forKey:@"switch"];
    [autocodeDict setObject:self.autocodeID forKey:@"autocoding_id"];
    [autocodeDict setObject:self.workingPremiseIDArray forKey:@"work_premise_id"];
    [autocodeDict setObject:self.workingPremiseArray forKey:@"work_premise_name"];
    [autocodeDict setObject:self.workingPremiseCodeArray forKey:@"work_premise_code"];
    
    [autocodeDict setObject:self.departmentIDArray forKey:@"dept_id"];
    [autocodeDict setObject:self.departmentArray forKey:@"dept_name"];
    [autocodeDict setObject:self.departmentCodeArray forKey:@"dept_code"];
    
    [autocodeDict setObject:self.categoryIDArray forKey:@"cat_id"];
    [autocodeDict setObject:self.categoryArray forKey:@"cat_name"];
    [autocodeDict setObject:self.categoryCodeArray forKey:@"cat_code"];
    
    [autocodeDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] forKey:@"o_id"];
    
    [self.myconnection createAutocode:autocodeDict];
}

-(IBAction)clearAction:(id)sender
{
    self.clearView.hidden=false;
}
-(IBAction)clear:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if(button.tag==1)
    {
        //for (int i=0; i<self.workingPremiseCodeArray.count; i++) {
            [self autogenerate];
        //}
        for (int i=0; i<self.departmentCodeArray.count; i++) {
            [self.departmentCodeArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",i+1]];
        }
        for (int i=0; i<self.categoryCodeArray.count; i++) {
            [self.categoryCodeArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",i+1]];
        }
        [self.workingPremiseTC reloadData];
        [self.categoryTC reloadData];
        [self.departmentTC reloadData];
        self.clearView.hidden=true;
        
        [self.switchButton setImage:[UIImage imageNamed:@"button_1 (1).png"] forState:UIControlStateNormal];
        
        
        for (UIView *myview in self.scrollView.subviews) {
            myview.userInteractionEnabled=NO;
        }
        self.clearButton.enabled=NO;
        self.clearLabel.enabled=NO;
        self.s1++;
        [self.scrollView setAlpha:0.6];//off
        self.switchButtonstring=@"2";
        
        [self saveAction:self];
    }
    else
    {
        self.clearView.hidden=true;
    }
    
}
-(void)autogenerate
{
    int code=1;
    for (int i=0; i<self.workingPremiseCodeArray.count; i++) {
        [self.allWorkingPremiseArray removeObject:[self.workingPremiseCodeArray objectAtIndex:i]];
    }
    
    for (int i=0; i<self.workingPremiseArray.count; i++) {
        while (code<100000) {
            if ([self.allWorkingPremiseArray containsObject:[NSString stringWithFormat:@"%d",code]])
            {
                code++;
            }
            else
            {
                [self.workingPremiseCodeArray replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%d",code]];
                code++;
                break;
            }
        }
    }
    
}
-(void)createResponse:(id)Response
{
    if ([[Response objectForKey:@"status"] isEqualToString:@"200"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self alertShow:@"Successfully Saved"];
//            [self.workingPremiseTC reloadData];
//            [self.departmentTC reloadData];
//            [self.categoryTC reloadData];
            
            autocodingTileClass *ob = (autocodingTileClass *)self.superview.superview;
            [ob closeTile];
            
        });
        
    }
    else if ([Response isEqualToString:@"office already exist1"])
    {
        [self alertShow:@"Autocode for Office is Already Used"];
    }
    else if([Response isEqualToString:@"store already exist1"])
    {
        [self alertShow:@"Autocode for Store is Already Used"];
    }
}
-(void)alertShow:(NSString *)alertMsg
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",alertMsg]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   [self.workingPremiseTC reloadData];
                                                   [self.categoryTC reloadData];
                                                   [self.departmentTC reloadData];
                                               }];
    
    
    [alert addAction:ok];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
@end
