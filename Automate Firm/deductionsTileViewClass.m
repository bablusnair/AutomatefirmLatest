
//
//  deductionsTileViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 09/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "deductionsTileViewClass.h"
#import "deductionsTileClass.h"
#import "groupcollceioncellclass.h"
#import "settingsViewController.h"
@implementation deductionsTileViewClass
@synthesize rateFlag,hoursWorkedFlag,issuePaymentFlag,p,q,r,s,x,y;
-(void)awakeFromNib
{
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.paymentintervelarray=[[NSMutableArray alloc] initWithObjects:@"          Annual",@"   Semi-annually",@"        Quarterly",@"        Monthly",@"   Semi- Monthly",@"        Bi-weekly",@"        Weekly", nil];
    self.issuePaymentArray1=[[NSMutableArray alloc]initWithObjects:@"Annual",@"Semi-Ann",@"Quarterly",@"Monthly",@"Semi-Mon",@"Bi-Weekly",@"Weekly", nil];
    self.dummyIssuePaymentArray=[[NSMutableArray alloc]init];
    self.issuePaymentArray=[[NSMutableArray alloc]init];
    self.designationArray=[[NSMutableArray alloc]init];
    [self.desigcollection registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];

    self.selected=0;
    for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
        [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
        NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.dummyIssuePaymentArray addObject:trimmedString];
    }
    
    self.agearray=[[NSMutableArray alloc] initWithObjects:@"   >=",@"   <=", nil];
    
    self.hoursWorkedArray=[[NSMutableArray alloc]initWithObjects:@"Overtime",@"Standard",@"Total", nil];
    self.dummyHoursWorkedArray=[[NSMutableArray alloc] initWithObjects:@"OT",@"Stand.",@"total", nil];
    
    self.issueRateArray=[[NSMutableArray alloc]initWithObjects:@"Standard",@"Specific", nil];
    
    self.paymentMsgArray=[[NSMutableArray alloc]initWithObjects:@"Deducted on the most recent fiscal year ending.",@"Deducted on the mid and end of the fiscal year.",@"Deducted over 4 quarter endings of the fiscal year.",@"Deducted on the end of each month.",@"Deducted twice a month, the 15th and last day of every month.",@"Deducted in the end of every two weeks (as per the respective employee’s week rule)",@"Deducted in the end of every week (as per the respective employee’s week rule)", nil];
    
    self.nextPaymentArray=[[NSMutableArray alloc] initWithObjects:@"DD/MM/YYYY",@"DD/MM/YYYY & DD/MM/YYYY",@" DD/MM/YYYY, DD/MM/YYYY, DD/MM/YYYY & DD/MM/YYYY",@" DD/MM/YYYY",@" DD/MM/YYYY & DD/MM/YYYY",@"DD/MM/YYYY",@"DD/MM/YYYY", nil];
    
    self.monthArray=[[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.yearArray=[[NSMutableArray alloc]init];
    self.dayArray=[[NSMutableArray alloc] initWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31", nil];
    
    NSDate *date=[NSDate date];
    NSDateFormatter *df=[[NSDateFormatter alloc]init];
    [df setDateFormat:@"dd-Mmm-yyyy"];
    NSString *currentDate=[df stringFromDate:date];
    NSArray *components=[currentDate componentsSeparatedByString:@"-"];
    self.yearString=[components objectAtIndex:2];
    self.monthString=@"Jan";
    self.dayString=@"31";
    for (int i=[[components objectAtIndex:2] integerValue]; i<[[components objectAtIndex:2] integerValue]+25; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    self.paymentIntervalString=@"1";
    self.basicString=@"";
    self.deductOnlyCheckString=@"3";
    self.ageString=@"1";
    self.paymentinterveltext.text=@"";
    self.maxLimitText.text=@"";
    self.fixedAmountText.text=@"";
    self.eligibilityText.text=@"";
    self.ageValueText.text=@"";
    self.agetext.text=@"";
    self.payOnText.text=@"";
    self.payondateString=@"";
    self.issueHoursText.text=@"";
    self.issueRateText1.text=@"";
    self.hoursWorkedText1.text=@"";
    self.issueHoursText1.text=@"";
    self.issuePercentageText.text=@"";
    self.issue2PaymentText.text=@"";
    self.radioString=@"1";
    self.deductionCheckString=@"0";
    self.accumalteCheckString=@"0";
    self.switchString=@"1";
    self.deductOnlyTableString=@"0";
    self.sendDesig=@"";
    app.warningflag=0;
    app.designationFlag=0;
    rateFlag=0;hoursWorkedFlag=0;issuePaymentFlag=0;
    p=q=r=s=x=y=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDeductionCondition) name:@"deductionsSettings" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetFunction) name:@"resetdeduction" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}
-(void)viewDeductionCondition
{
    
    
    if (!([app.deductionTileIdDict objectForKey:app.deductionTileIdString]==Nil)) {
//        earningsview *obj = (earningsview *)self.superview.superview.superview;
//        obj.plusButton.userInteractionEnabled=TRUE;
//        obj.plusButton.hidden=FALSE;
        app.deductionConditionId=[app.deductionTileIdDict objectForKey:app.deductionTileIdString];
       // [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"deductionsAction"];
        [self.myconnection individualDeductionTileConditionDetails:[app.deductionTileIdDict objectForKey:app.deductionTileIdString] ruleId:[[NSUserDefaults standardUserDefaults]objectForKey:@"deductionRuleID"]];
        
    }
    else{
        [self resetFunction];
    }
    
    
    
    
    
   // NSString *dropValue=[[NSUserDefaults standardUserDefaults]objectForKey:@"dropAction"];
    
  //  switch ([dropValue intValue]) {
    switch (app.deductionRowId) {

        case 1:
        {
            self.maximumlimitview.hidden=FALSE;
            self.amountview.hidden=TRUE;
            self.issuesecondview.hidden=TRUE;
            self.issuethirdview.hidden=TRUE;
            self.amountPerHourView.hidden=true;
            self.descriptionLabel.hidden=true;
            self.descriptionLabel.frame=CGRectMake(self.descriptionLabel.frame.origin.x, 230, self.descriptionLabel.frame.size.width, self.descriptionLabel.frame.size.height);
            self.maximumlimitview.frame=CGRectMake(166,46, self.maximumlimitview.frame.size.width, self.maximumlimitview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
//            self.issue2PaymentText.text=@"Annual";
//            self.selected=0;
//            for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
//                [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
//                NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                [self.dummyIssuePaymentArray addObject:trimmedString];
//            }
//             [self.issuePaymentTableView reloadData];
        }
            break;
        case 2:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=FALSE;
            self.issuesecondview.hidden=TRUE;
            self.issuethirdview.hidden=TRUE;
            self.amountPerHourView.hidden=true;
            self.descriptionLabel.hidden=false;
            self.descriptionLabel.frame=CGRectMake(self.descriptionLabel.frame.origin.x, 230, self.descriptionLabel.frame.size.width, self.descriptionLabel.frame.size.height);
            self.amountview.frame=CGRectMake(166,46, self.amountview.frame.size.width, self.amountview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
//            self.issue2PaymentText.text=@"Annual";
//            self.selected=0;
//            for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
//                [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
//                NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                [self.dummyIssuePaymentArray addObject:trimmedString];
//            }
//             [self.issuePaymentTableView reloadData];
        }
            break;
        case 3:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=TRUE;
            self.issuesecondview.hidden=FALSE;
            self.issuethirdview.hidden=TRUE;
            self.amountPerHourView.hidden=false;
            self.descriptionLabel.hidden=false;
            self.descriptionLabel.frame=CGRectMake(self.descriptionLabel.frame.origin.x, 280, self.descriptionLabel.frame.size.width, self.descriptionLabel.frame.size.height);
            self.issuesecondview.frame=CGRectMake(166,46, self.issuesecondview.frame.size.width, self.issuesecondview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
//            self.issue2PaymentText.text=@"Annual";
//            self.selected=0;
//            for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
//                [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
//                NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
//                [self.dummyIssuePaymentArray addObject:trimmedString];
//                
//            }
//             [self.issuePaymentTableView reloadData];
        }
            break;
        case 4:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=TRUE;
            self.issuesecondview.hidden=true;
            self.issuethirdview.hidden=FALSE;
            self.amountPerHourView.hidden=true;
            self.descriptionLabel.hidden=false;
            self.descriptionLabel.frame=CGRectMake(self.descriptionLabel.frame.origin.x, 230, self.descriptionLabel.frame.size.width, self.descriptionLabel.frame.size.height);
            self.issuethirdview.frame=CGRectMake(166,46, self.issuethirdview.frame.size.width, self.issuethirdview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
            self.issue2PaymentText.text=@"Annual";
            [self.issuePaymentArray removeAllObjects];
            [self.dummyIssuePaymentArray removeAllObjects];
            self.selected=0;
            for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
                [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
                NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
                [self.dummyIssuePaymentArray addObject:trimmedString];
            }
            [self.issuePaymentTableView reloadData];
        }
            break;
        default:
            break;
    }
    
    
    
}

// Reset Function
-(void)resetFunction
{
    
    self.paymentinterveltext.text=@"Annual";
    //self.issue1PaymentText.text=@"Annual";
  //  self.issue2PaymentText.text=@"Annual";
//    self.paidbytext.text=@"Firm";
  //  self.hoursWorkedText.text=@"Stand.";
    self.issueRateText1.text=@"Stand.";
    self.hoursWorkedText1.text=@"total";
    self.payOnText.text=@"";
    self.eligibilityText.text=@"";
    self.ageValueText.text=@"";
    //self.issueRateText.text=@"";
    self.maxLimitText.text=@"";
    
    p=q=r=s=x=y=0;
    self.paymentIntervalString=@"1";
    self.basicString=@"";
    self.deductOnlyCheckString=@"3";
    self.ageString=@"1";
    self.paymentinterveltext.text=@"";
    self.maxLimitText.text=@"";
    self.fixedAmountText.text=@"";
    self.eligibilityText.text=@"";
    self.ageValueText.text=@"";
    self.agetext.text=@"";
    self.payOnText.text=@"";
    self.issueHoursText.text=@"";
    self.issueRateText1.text=@"";
    self.hoursWorkedText1.text=@"";
    self.issueHoursText1.text=@"";
    self.issuePercentageText.text=@"";
    self.issue2PaymentText.text=@"";
    self.radioString=@"1";
    self.deductionCheckString=@"0";
    self.accumalteCheckString=@"0";
    self.switchString=@"1";
    self.deductOnlyTableString=@"0";
    self.sendDesig=@"";
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.issueCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];

    
    
}



- (IBAction)includeDesignationAction:(id)sender {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    self.desigcollection.hidden=false;
    [self.designationArray removeAllObjects];
    [self.designationArray addObjectsFromArray:desigArray];
    [self.desigcollection reloadData];
}

-(IBAction)saveButtonAction:(id)sender
{
   
    NSMutableDictionary *desigDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"];
    self.sendDesig=[self.designationArray componentsJoinedByString:@"###"];

    NSString *ageString=[[NSString stringWithFormat:@"%@###%@",self.ageString,self.ageValueText.text]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *eligibleString=[[[self.eligibilityText.text componentsSeparatedByString:@" Day(s)"] objectAtIndex:0]stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSMutableDictionary *tileDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.paymentIntervalString,@"d_interval",self.maxLimitText.text,@"max_limit",self.fixedAmountText.text,@"d_amount",eligibleString,@"d_applicable",ageString,@"age",self.payondateString,@"pay_on",self.radioString,@"payment_cycle",self.deductionCheckString,@"d_taxed",self.accumalteCheckString,@"accumulate_payment",self.switchString,@"checkbox_enable",[[self.issueHoursText.text componentsSeparatedByString:@" Hours"] objectAtIndex:0],@"deduct",self.issueRateText1.text,@"d_rate",self.deductOnlyCheckString,@"d_only_checkbox",self.deductOnlyTableString,@"d_only",self.issueHoursText1.text,@"d_hours",[[self.issuePercentageText.text componentsSeparatedByString:@" %"] objectAtIndex:0],@"d_percent",self.basicString,@"d_basic",self.sendDesig,@"designationstring", nil];

    
    if ([app.deductionRuleId isEqualToString:@"0"] && ([app.deductionTileIdDict objectForKey:app.deductionTileIdString]==nil)) {
        NSMutableDictionary *firstDetails=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.deductionName,@"d_name",app.deductionAbbrevtion,@"abbreviation",[NSString stringWithFormat:@"%d",app.deductionRowId],@"d_type",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id",app.deductionDescription,@"description",@"0###0",@"condition_id", nil];
        if ((app.deductionName.length>0)&&(app.deductionAbbrevtion.length>0)) {
            
            [self.myconnection createDeductionRule:firstDetails tileDetails:tileDict includeDesignation:desigDict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] tileId:@"0"];
            app.designationFlag=0;
            app.warningflag=0;
//            deductionsTileClass *ob = (deductionsTileClass *)self.superview.superview;
//            
//            [ob addaccordianview];
            
        }
        else{
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Warning..."
                                       message:[NSString stringWithFormat:@"Must Enter All Mandatory fields"]
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                       }];
            [alert addAction:ok];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(settingsViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            
        }
        
    }
    else{
        NSString *idStr;
        if ([app.deductionTileIdDict objectForKey:app.deductionTileIdString]==nil) {
            idStr=[NSString stringWithFormat:@"0###%@",app.deductionRuleId];

        }
        else{
            idStr=[NSString stringWithFormat:@"%@###%@",[app.deductionTileIdDict objectForKey:app.deductionTileIdString],app.deductionRuleId];

        }
        NSMutableDictionary *firstDetails=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.deductionName,@"d_name",app.deductionAbbrevtion,@"abbreviation",[NSString stringWithFormat:@"%d",app.deductionRowId],@"d_type",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"o_id",app.deductionDescription,@"description",idStr,@"condition_id", nil];
        if ((app.deductionName.length>0)&&(app.deductionAbbrevtion.length>0)) {

        [self.myconnection updateDeductionRule:firstDetails tileDetails:tileDict includeDesignation:desigDict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] tileId:[app.deductionTileIdDict objectForKey:app.deductionTileIdString]];
            app.warningflag=0;
            app.designationFlag=0;
//            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"earningsAction"]isEqualToString:@"create"])
//            {
//               
//                deductionsTileClass *ob = (deductionsTileClass *)self.superview.superview;
//                [ob addaccordianview];
//            }
//            else{
//                deductionsTileClass *ob = (deductionsTileClass *)self.superview.superview;
//                [ob closeTile];
//            }
        }
    }
    
    
    
   
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.designationArray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simplecell";
    groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.designationArray.count>0) {
        cell.grouplabel.text=[self.designationArray objectAtIndex:indexPath.row];
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==self.paymentinterveltableview) {
        return [self.paymentintervelarray count];
    }
    
    else if(tableView==self.agetableview)
    {
        return [self.agearray count];
    }
    else if(tableView==self.issuePaymentTableView)
    {
        return  self.issuePaymentArray.count;
    }
    else if(tableView==self.hoursWorkedTC)
    {
        return  self.hoursWorkedArray.count;
    }
    else //self.issueRateTC
    {
        return  self.issueRateArray.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.paymentinterveltableview) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.paymentintervelarray objectAtIndex:indexPath.row];
        return cell;
        
    }
    
    else if(tableView==self.agetableview)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.agearray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if(tableView==self.issuePaymentTableView)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.issuePaymentArray objectAtIndex:indexPath.row];
        return cell;
    }
    else if(tableView==self.hoursWorkedTC)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.hoursWorkedArray objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.issueRateArray objectAtIndex:indexPath.row];
        return cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.paymentinterveltableview)
    {
        self.paymentIntervalString=[NSString stringWithFormat:@"%d",indexPath.row+1];

        self.paymentinterveltext.text=[self.paymentintervelarray objectAtIndex:indexPath.row];
        self.paymentinterveltableview.hidden=TRUE;
        self.paymentMessageLabel.text=[self.paymentMsgArray objectAtIndex:indexPath.row];
        self.nextPaymentLabel.text=[self.nextPaymentArray objectAtIndex:indexPath.row];
        
        self.selected=indexPath.row;
        [self.issuePaymentArray removeAllObjects];
        [self.dummyIssuePaymentArray removeAllObjects];
        for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
            [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
            NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [self.dummyIssuePaymentArray addObject:trimmedString];
        }
        self.issue2PaymentText.text=[self.dummyIssuePaymentArray objectAtIndex:0];
        [self.issuePaymentTableView reloadData];
        if ((indexPath.row==0) || (indexPath.row==1) || (indexPath.row==2)) {
            self.paymentIntervalLabel.text=@"fiscal year.";
            self.descriptionLabel.hidden=false;
        }
        else
        {
            self.paymentIntervalLabel.text=@"month.";
            self.descriptionLabel.hidden=true;
        }
        if (indexPath.row > 4) {
            self.deductionLabel.hidden=true;
            self.nextPaymentLabel.hidden=true;
        }
        else
        {
            self.deductionLabel.hidden=false;
            self.nextPaymentLabel.hidden=false;
        }
    }
    
    else if(tableView==self.agetableview)
    {
        self.ageString=[NSString stringWithFormat:@"%d",indexPath.row+1];

        self.agetext.text=[self.agearray objectAtIndex:indexPath.row];
        self.agetableview.hidden=TRUE;
    }
    else if (tableView==self.issuePaymentTableView)
    {
        self.basicString=[NSString stringWithFormat:@"%d",self.selected+indexPath.row+1];

        self.issue2PaymentText.text=[self.dummyIssuePaymentArray objectAtIndex:indexPath.row];
        self.issuePaymentTableView.hidden=TRUE;
    }
    else if (tableView==self.hoursWorkedTC)
    {
        self.deductOnlyTableString=[NSString stringWithFormat:@"%d",indexPath.row+1];
        self.hoursWorkedText1.text=[self.dummyHoursWorkedArray objectAtIndex:indexPath.row];
        self.hoursWorkedTC.hidden=true;
    }
    else if (tableView==self.issueRateTC)
    {
        if (indexPath.row==0) {
            self.issueRateText1.text=@"Stand.";
            rateFlag=0;
        }
        else
        {
            self.issueRateText1.text=@"";
            rateFlag=1;
            self.rateDropButton.hidden=true;
            [self.issueRateText1 becomeFirstResponder];
        }
        self.issueRateTC.hidden=true;
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component==0) {
        return 1;
    }
    else if (component==1) {
        return self.monthArray.count;
    }
    else
    {
        return self.yearArray.count;
    }
}
- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (component==0) {
        NSString *day=self.dayString;
        return day;
    }
    if (component==1) {
        NSString *month=[self.monthArray objectAtIndex:row];
        return  month;
    }
    else
    {
        NSString *year=[self.yearArray objectAtIndex:row];
        return  year;
    }
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:
(NSInteger)row inComponent:(NSInteger)component{
    if (component==1) {
        self.monthString=[self.monthArray objectAtIndex:row];
        if (row==1) {
            if ([self.yearString integerValue]%4==0) {
                self.dayString= [NSString stringWithFormat:@"%d",[[self.dayArray objectAtIndex:row] integerValue]+1];
            }
            else
            {
                self.dayString=[self.dayArray objectAtIndex:row];
            }
        }
        else
        {
            self.dayString=[self.dayArray objectAtIndex:row];
        }
        [self.payPickerView reloadAllComponents];
        
        
    }
    else
    {
        self.yearString=[self.yearArray objectAtIndex:row];
        if ([self.yearString integerValue]%4==0) {
            if ([self.monthString isEqualToString:@"Feb"]) {
                self.dayString=@"29";
            }
        }
        else
        {
            if ([self.monthString isEqualToString:@"Feb"]) {
                self.dayString=@"28";
            }
        }
        [self.payPickerView reloadAllComponents];
    }
    
}
-(IBAction)donePickerAction:(id)sender
{
    self.payOnText.text=[NSString stringWithFormat:@"%@-%@-%@",self.dayString,self.monthString,self.yearString];
    
    NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
    [dateformat setDateFormat:@"dd-MMM-yyyy"];
    NSDate *myDate = [dateformat dateFromString:self.payOnText.text];
    [dateformat setDateFormat:@"dd-MM-YYYY"];
    self.payondateString = [dateformat stringFromDate:myDate];
    
    self.pickerView.hidden=true;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.paymentinterveltext) {
        [self hideAllDropDown];
        self.paymentinterveltableview.hidden=FALSE;
        return NO;
    }
    else if(textField==self.agetext)
    {
        [self hideAllDropDown];
        self.agetableview.hidden=FALSE;
        return NO;
    }
    else if (textField==self.payOnText)
    {
        [self hideAllDropDown];
        self.pickerView.hidden=false;
        return  NO;
    }
    else if (textField==self.issueRateText1)
    {
        [self hideAllDropDown];
        self.issueRateTC.hidden=false;
        if (rateFlag==0) {
            return  NO;
        }
        else
        {
            rateFlag=0;
            return  YES;
        }
        
    }
    else if (textField==self.hoursWorkedText1)
    {
        [self hideAllDropDown];
        hoursWorkedFlag=1;
        self.hoursWorkedTC.hidden=false;
        self.hoursWorkedTC.frame=CGRectMake(71, 248, self.hoursWorkedTC.frame.size.width, self.hoursWorkedTC.frame.size.height);
        return  NO;
    }
    else if (textField==self.issue2PaymentText)
    {
        [self hideAllDropDown];
        issuePaymentFlag=1;
        self.issuePaymentTableView.hidden=false;
        self.issuePaymentTableView.frame=CGRectMake(284, 81, self.issuePaymentTableView.frame.size.width, self.issuePaymentTableView.frame.size.height);
        return  NO;
        
    }
    else if (textField==self.earningsCheckText)
    {
        [self earningsCheckBoxAction];
        return  NO;
    }
    else if (textField==self.radioText1)
    {
        [self continueRadioButtonAction];
        return  NO;
    }
    else if (textField==self.radioText2)
    {
        [self ontimeRadioButtonAction];
        return  NO;
    }
    else if (textField==self.accumulateCheckText)
    {
        [self accumulateCheckBoxAction];
        return  NO;
    }
    
    else if (textField==self.replaceCheckText)
    {
        [self replaceCheckBoxAction];
        return  NO;
    }
    else if (textField==self.issueCheckText)
    {
        [self issueCheckBoxAction];
        return  NO;
    }
    else
    {
        
        return YES;
    }
    
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.maxLimitText) {
        self.maxLimitText.text=[NSString stringWithFormat:@"%.1f",[self.maxLimitText.text floatValue]];
    }
    else if (textField==self.fixedAmountText)
    {
        self.fixedAmountText.text=[NSString stringWithFormat:@"%.1f",[self.fixedAmountText.text floatValue]];
    }
    else if (textField==self.issueRateText1)
    {
        self.issueRateText1.text=[NSString stringWithFormat:@"%.1f",[self.issueRateText1.text floatValue]];
        self.rateDropButton.hidden=false;
    }
    else if (textField==self.eligibilityText)
    {
        if (![self.eligibilityText.text isEqualToString:@""]) {
            if (!(self.eligibilityText.text.length > 2)) {
                NSString *text=self.eligibilityText.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Day(s)",text];
                self.eligibilityText.text=finalText;
            }
        }
    }
    else if (textField==self.issueHoursText)
    {
        if (![self.issueHoursText.text isEqualToString:@""]) {
            if (!(self.issueHoursText.text.length > 3)) {
                NSString *text=self.issueHoursText.text;
                self.replaceHourText.text=text;
                NSString *finalText=[NSString stringWithFormat:@"%@ Hours",text];
                self.issueHoursText.text=finalText;
                
            }
        }
        else
        {
            self.replaceHourText.text=@"";
        }
    }
    else if (textField==self.issueHoursText1)
    {
        if (![self.issueHoursText1.text isEqualToString:@""]) {
            if (!(self.issueHoursText1.text.length > 3)) {
                NSString *text=self.issueHoursText1.text;
                NSString *finalText=[NSString stringWithFormat:@"%@ H",text];
                self.issueHoursText1.text=finalText;
            }
        }
    }
    
    else if (textField==self.issuePercentageText)
    {
        if(([self.issuePercentageText.text integerValue] > 0) && ([self.issuePercentageText.text integerValue] < 101))
        {
            self.issuePercentageText.textColor=[UIColor blackColor];
            self.saveButton.enabled=true;
        }
        else
        {
            self.issuePercentageText.textColor=[UIColor redColor];
            self.saveButton.enabled=false;
        }
        if (!(self.issuePercentageText.text.length > 3)) {
            NSString *symbolString=@"%";
            NSString *finalText=[NSString stringWithFormat:@"%@ %@ ",self.issuePercentageText.text,symbolString];
            self.issuePercentageText.text=finalText;
        }
    }
    return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ((textField==self.maxLimitText)|| (textField==self.fixedAmountText) || (textField==self.issueRateText1)) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789."];
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
    if ((textField==self.eligibilityText) || (textField==self.ageValueText)) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=1) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
    else if ((textField==self.issueHoursText)||(textField==self.issueHoursText1) || (textField==self.issuePercentageText))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=2) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
-(IBAction)radioButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self continueRadioButtonAction];
    }
    else
    {
        [self ontimeRadioButtonAction];
    }
}
-(IBAction)checkButtonAction:(id)sender
{
    UIButton *mybutton=(UIButton *)sender;
    if (mybutton.tag==1) {
        [self earningsCheckBoxAction];
    }
    else if (mybutton.tag==2)
    {
        [self accumulateCheckBoxAction];
    }
    else if (mybutton.tag==5) {
        [self replaceCheckBoxAction];
    }
    
}
-(IBAction)issueCheckButtonAction:(id)sender
{
    [self issueCheckBoxAction];
}


-(void)continueRadioButtonAction
{
    self.radioString=@"1";
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    self.radio1stView.hidden=false;
    self.radio1stView.frame=CGRectMake(331, 200, self.radio1stView.frame.size.width, self.radio1stView.frame.size.height);
    self.radio2ndView.hidden=true;
    self.replaceView.hidden=true;
}
-(void)ontimeRadioButtonAction
{
    self.radioString=@"2";
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    self.radio1stView.hidden=true;
    self.radio2ndView.hidden=false;
    self.radio2ndView.frame=CGRectMake(331, 200, self.radio2ndView.frame.size.width, self.radio2ndView.frame.size.height);
    NSString *dropValue=[[NSUserDefaults standardUserDefaults]objectForKey:@"dropAction"];
    if ([dropValue integerValue]==3) {
        self.replaceView.hidden=false;
       // self.replaceHourText.text=self.issueHoursText.text;
        self.replaceView.frame=CGRectMake(331, 238, self.replaceView.frame.size.width, self.replaceView.frame.size.height);
    }
}


-(void)earningsCheckBoxAction
{
    if (p%2==0) {
        self.deductionCheckString=@"1";
        [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        p++;
    }
    else
    {        self.deductionCheckString=@"0";

        [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        p++;
    }
}
-(void)accumulateCheckBoxAction
{
    if (q%2==0) {
        self.accumalteCheckString=@"1";

        [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        q++;
    }
    else
    {
        self.accumalteCheckString=@"0";

        [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        q++;
    }
}

-(void)replaceCheckBoxAction
{
    if (x%2==0) {
        [self.checkButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        x++;
    }
    else
    {
        [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        x++;
    }
}
-(void)issueCheckBoxAction
{
    if (y%2==0) {
        self.deductOnlyCheckString=@"1";
        [self.issueCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        y++;
    }
    else
    {
        self.deductOnlyCheckString=@"0";

        [self.issueCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        y++;
    }
}
-(IBAction)valueChangedActon:(id)sender
{
    app.warningflag=1;
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

-(void)hideAllDropDown
{
    self.paymentinterveltableview.hidden=true;
    self.agetableview.hidden=true;
    self.issuePaymentTableView.hidden=true;
    self.hoursWorkedTC.hidden=true;
    self.issueRateTC.hidden=true;
}
//.......Create Response....,

-(void)createDeductResponse:(id)response
{
    [app.deductionTileIdDict setObject:[[response componentsSeparatedByString:@"###"]objectAtIndex:1]  forKey:app.deductionTileIdString];
    app.deductionRuleId=[[response componentsSeparatedByString:@"###"]objectAtIndex:2];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"deductionsAction"]isEqualToString:@"create"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        deductionsTileClass *ob = (deductionsTileClass *)self.superview.superview;
        [ob addaccordianview];
            });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
       
        deductionsTileClass *ob = (deductionsTileClass *)self.superview.superview;
        [ob closeTile];
            });
    }

}

//Individaul rule View Response
-(void)alldeductionResponse:(id)response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([response count]>0) {
            
//            NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
//            [dateformat setDateFormat:@"dd-MM-yyyy"];
//            NSDate *myDate = [dateformat dateFromString:self.payondateString];
//            [dateformat setDateFormat:@"dd-MMM-YYYY"];
//            self.payOnText.text = [dateformat stringFromDate:myDate];
            
            
            self.paymentinterveltext.text=[[response objectAtIndex:0]objectForKey:@"d_interval"];
            self.maxLimitText.text=[[response objectAtIndex:0]objectForKey:@"max_limit"];
            self.fixedAmountText.text=[[response objectAtIndex:0]objectForKey:@"d_amount"];
            self.payOnText.text=[[response objectAtIndex:0]objectForKey:@"pay_on"];
            
            self.payondateString=[[response objectAtIndex:0]objectForKey:@"pay_on"];
            
            NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
            [dateformat setDateFormat:@"dd-MM-yyyy"];
            NSDate *myDate = [dateformat dateFromString:self.payondateString];
            [dateformat setDateFormat:@"dd-MMM-YYYY"];
            self.payOnText.text = [dateformat stringFromDate:myDate];
            
            
            self.issueHoursText1.text=[NSString stringWithFormat:@"%@ Hours",[[response objectAtIndex:0]objectForKey:@"deduct"]];
            self.issueRateText1.text=[[response objectAtIndex:0]objectForKey:@"d_rate"];
      //  self.hoursWorkedText1.text=[[response objectAtIndex:0]objectForKey:@"d_only"];
            NSString *symbolString=@"%";
        
            self.issuePercentageText.text=[NSString stringWithFormat:@"%@ %@ ",[[response objectAtIndex:0]objectForKey:@"d_percent"],symbolString];
            self.ageValueText.text=[[[[response objectAtIndex:0]objectForKey:@"age"]componentsSeparatedByString:@"###"]objectAtIndex:1];
      //  self.issue2PaymentText.text=[[response objectAtIndex:0]objectForKey:@"d_basic"];
            self.eligibilityText.text=[NSString stringWithFormat:@"%@ Day(s)",[[response objectAtIndex:0]objectForKey:@"d_applicable"]];
              [self.designationArray removeAllObjects];
       
            if (!([[[response objectAtIndex:0]objectForKey:@"designationstring"] isEqualToString:@""])) {
                [self.designationArray addObjectsFromArray:[[[response objectAtIndex:0]objectForKey:@"designationstring"]componentsSeparatedByString:@"###"]];
            }
        
        [self.desigcollection reloadData];
        self.paymentIntervalString=[[response objectAtIndex:0]objectForKey:@"d_interval"];
        
        self.radioString=[[response objectAtIndex:0]objectForKey:@"payment_cycle"];
        switch ([[[response objectAtIndex:0]objectForKey:@"payment_cycle"] intValue]) {
            case 1:
                [self continueRadioButtonAction];
                break;
            case 2:
                [self ontimeRadioButtonAction];
                break;
    
                
            default:
                break;
        }
        switch ([[[response objectAtIndex:0]objectForKey:@"d_taxed"] intValue]) {
            case 1:
                [self earningsCheckBoxAction];
                break;
//            case 1:
//                [self ontimeRadioButtonAction];
//                break;
//                
                
            default:
                break;
        }
        switch ([[[response objectAtIndex:0]objectForKey:@"accumulate_payment"] intValue]) {
            case 1:
                [self accumulateCheckBoxAction];
                break;
                //            case 1:
                //                [self ontimeRadioButtonAction];
                //                break;
                //
                
            default:
                break;
        }
        
        
        
            switch ([[[response objectAtIndex:0]objectForKey:@"d_interval"]intValue]) {
                case 1:
                    self.paymentinterveltext.text=@"          Annual";
                
                    break;
                case 2:
                    self.paymentinterveltext.text=@"   Semi-annually";
                
                
                    break;
                
                case 3:
                    self.paymentinterveltext.text=@"        Quarterly";
                
                
                    break;
                
                case 4:
                    self.paymentinterveltext.text=@"        Monthly";
                
                    break;
                
                case 5:
                    self.paymentinterveltext.text=@"   Semi- Monthly";
                
                    break;
                
                case 6:
                    self.paymentinterveltext.text=@"        Bi-weekly";
                
                    break;
                case 7:
                    self.paymentinterveltext.text=@"        Weekly";
                
                    break;
                
                
                default:
                    break;
            }
            self.basicString=[[response objectAtIndex:0]objectForKey:@"d_basic"];
            switch ([[[response objectAtIndex:0]objectForKey:@"d_basic"]intValue]) {
                case 1:
                    self.issue2PaymentText.text=@"Annual";
                
                    break;
                case 2:
                    self.issue2PaymentText.text=@"Semi-annually";
                
                
                    break;
                
                case 3:
                    self.issue2PaymentText.text=@"Quarterly";
                
                
                    break;
                
                case 4:
                    self.issue2PaymentText.text=@"Monthly";
                
                    break;
                
                case 5:
                    self.issue2PaymentText.text=@"Semi- Monthly";
                
                    break;
                
                case 6:
                    self.issue2PaymentText.text=@"Bi-weekly";
                
                    break;
                case 7:
                    self.issue2PaymentText.text=@"Weekly";
                
                    break;
                
                
                default:
                    break;
            }
        
            self.deductOnlyTableString=[[response objectAtIndex:0]objectForKey:@"d_only"];
            switch ([[[response objectAtIndex:0]objectForKey:@"d_only"]intValue]) {
                case 1:
                    self.hoursWorkedText1.text=[self.dummyHoursWorkedArray objectAtIndex:0];
                
                    break;
                case 2:
                    self.hoursWorkedText1.text=[self.dummyHoursWorkedArray objectAtIndex:1];
                    break;
                case 3:
                    self.hoursWorkedText1.text=[self.dummyHoursWorkedArray objectAtIndex:2];
                    break;
                
                default:
                    break;
            }
            self.ageString=[[[[response objectAtIndex:0]objectForKey:@"age"]componentsSeparatedByString:@"###"]objectAtIndex:0];
            switch ([[[[[response objectAtIndex:0]objectForKey:@"age"]componentsSeparatedByString:@"###"]objectAtIndex:0]intValue]) {
                case 1:
                    self.agetext.text=[self.agearray objectAtIndex:0];
                
                    break;
                case 2:
                    self.agetext.text=[self.agearray objectAtIndex:1];
                    break;
                
                default:
                    break;
            }

//
        
        }
    });
    
    
    
}


//>>>>>>>Alert Show..........
-(void)showalerviewcontroller:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //  [app hudStop];
                                                  
                                                   
                                                   
                                                   
                                                   
                                               }];
    
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}


@end
