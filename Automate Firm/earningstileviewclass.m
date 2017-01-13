//
//  earningstileviewclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 05/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "earningstileviewclass.h"
#import "earningsAccordianview.h"
#import "groupcollceioncellclass.h"
#import "earningsview.h"
#import "settingsViewController.h"
@implementation earningstileviewclass
@synthesize rateFlag,hoursWorkedFlag,issuePaymentFlag,p,q,r,s,x,y;

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [self.desigcollection registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
     self.paymentintervelarray=[[NSMutableArray alloc] initWithObjects:@"          Annual",@"   Semi-annually",@"        Quarterly",@"        Monthly",@"   Semi- Monthly",@"        Bi-weekly",@"        Weekly", nil];
    self.issuePaymentArray1=[[NSMutableArray alloc]initWithObjects:@"Annual",@"Semi-Ann",@"Quarterly",@"Monthly",@"Semi-Mon",@"Bi-Weekly",@"Weekly", nil];
    self.dummyIssuePaymentArray=[[NSMutableArray alloc]init];
    self.issuePaymentArray=[[NSMutableArray alloc]init];


    self.selected=0;
    for (int i=self.selected; i<self.paymentintervelarray.count; i++) {
        [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
        NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        [self.dummyIssuePaymentArray addObject:trimmedString];
    }
    
     self.paidbyarray=[[NSMutableArray alloc] initWithObjects:@"Firm",@"3rd Party", nil];
     self.agearray=[[NSMutableArray alloc] initWithObjects:@"   >=",@"   <=", nil];
    
    self.hoursWorkedArray=[[NSMutableArray alloc]initWithObjects:@"Overtime",@"Standard",@"Total", nil];
    self.dummyHoursWorkedArray=[[NSMutableArray alloc] initWithObjects:@"OT",@"Stand.",@"total", nil];
    
    self.issueRateArray=[[NSMutableArray alloc]initWithObjects:@"Standard",@"Specific", nil];
    
    self.paymentMsgArray=[[NSMutableArray alloc]initWithObjects:@"Issued on the most recent fiscal year ending.",@"Issued on the mid and end of the fiscal year.",@"Issued over 4 quarter endings of the fiscal year.",@"Issued on the end of each month.",@"Issued twice a month, the 15th and last day of every month.",@"Issued in the end of every two weeks (as per the respective employee’s week rule)",@"Issued in the end of every week (as per the respective employee’s week rule)", nil];
    
    self.nextPaymentArray=[[NSMutableArray alloc] initWithObjects:@"DD/MM/YYYY",@"DD/MM/YYYY & DD/MM/YYYY",@" DD/MM/YYYY, DD/MM/YYYY, DD/MM/YYYY & DD/MM/YYYY",@" DD/MM/YYYY",@" DD/MM/YYYY & DD/sYYYY",@"DD/MM/YYYY",@"DD/MM/YYYY", nil];
    self.monthArray=[[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.designationAray=[[NSMutableArray alloc]init];

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
    
   
    app.designationFlag=0;
    app.warningflag=0;
    rateFlag=0;hoursWorkedFlag=0;issuePaymentFlag=0;
    p=q=r=s=x=y=0;
    self.switchString=@"1";
    self.radioFlag1=@"1";
    self.paymentintrvalTableString=@"1";
    self.paidbyTableString=@"1";
    self.agetextTableString=@"1";
    self.issuepaymentTableString=@"1";
    self.issuepaymentTableString1=@"";
    self.houersworkedTableString=@"1";
    self.houersworkedTableString1=@"2";
    self.issuerateTableString=@"1";
    self.issueFlagString=@"0";
    self.replaceStringFlag=@"0";
    self.earningflag=@"0";
    self.accumalateFlag=@"0";
    self.paidholiflag=@"0";
    self.paidleaveflag=@"0";
    self.maxLimitText.text=@"";
    self.fixedAmountText.text=@"";
    self.ageValueText.text=@"";
    self.payOnText.text=@"";
    self.issueHoursText.text=@"";
    self.issueRateText.text=@"";
    self.issueRateText1.text=@"";
    self.issueHoursText.text=@"";
    self.issuePercentageText.text=@"";
    self.fixedAmountText.text=@"";
    self.payondateString=@"";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewLoad:) name:@"loadView" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetFunction) name:@"resetfunction" object:Nil];
}

-(void)viewLoad:(int)paasvalue;
{
    
    if (!([app.earningsTileIdDict objectForKey:app.earningTileIdString]==Nil)) {
        //earningsview *obj = (earningsview *)self.superview.superview.superview;
        
        app.earningConditionId=[app.earningsTileIdDict objectForKey:app.earningTileIdString];
        //[[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"earningsAction"];
        //[self.myconnection individualTileViewDetails:[app.earningsTileIdDict objectForKey:app.earningTileIdString]];
        [self.myconnection individualTileViewDetails:app.earningRuleId condId:[app.earningsTileIdDict objectForKey:app.earningTileIdString]];
    }
    else{
        [self resetFunction];
    }
    paasvalue=app.tableRowId;
    
    int value=[[[NSUserDefaults standardUserDefaults]objectForKey:@"dropAction"] intValue];
    app.tableRowId=value;
    switch (value) {
        case 1:
        {
            self.maximumlimitview.hidden=FALSE;
            self.amountview.hidden=TRUE;
            self.issuefirstview.hidden=true;
            self.issuesecondview.hidden=TRUE;
            self.issuethirdview.hidden=TRUE;
            self.considerView.hidden=true;
            self.amountPerHourView.hidden=true;
            self.descriptionlabel.hidden=true;
            self.descriptionlabel.frame=CGRectMake(self.descriptionlabel.frame.origin.x, 230, self.descriptionlabel.frame.size.width, self.descriptionlabel.frame.size.height);
            self.maximumlimitview.frame=CGRectMake(256,46, self.maximumlimitview.frame.size.width, self.maximumlimitview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
        }
        break;
        case 2:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=FALSE;
            self.issuefirstview.hidden=true;
            self.issuesecondview.hidden=TRUE;
            self.issuethirdview.hidden=TRUE;
            self.considerView.hidden=true;
            self.amountPerHourView.hidden=true;
            self.descriptionlabel.hidden=false;
            self.descriptionlabel.frame=CGRectMake(self.descriptionlabel.frame.origin.x, 230, self.descriptionlabel.frame.size.width, self.descriptionlabel.frame.size.height);
            self.amountview.frame=CGRectMake(256,46, self.amountview.frame.size.width, self.amountview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
        }
            break;
        case 3:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=TRUE;
            self.issuefirstview.hidden=FALSE;
            self.issuesecondview.hidden=TRUE;
            self.issuethirdview.hidden=TRUE;
            self.considerView.hidden=false;
            self.amountPerHourView.hidden=true;
            self.descriptionlabel.hidden=false;
            self.descriptionlabel.frame=CGRectMake(self.descriptionlabel.frame.origin.x, 230, self.descriptionlabel.frame.size.width, self.descriptionlabel.frame.size.height);
            self.issuefirstview.frame=CGRectMake(256,46, self.issuefirstview.frame.size.width, self.issuefirstview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
            self.issue1PaymentText.text=@"Annual";
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
        case 4:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=TRUE;
            self.issuefirstview.hidden=true;
            self.issuesecondview.hidden=FALSE;
            self.issuethirdview.hidden=TRUE;
            self.considerView.hidden=true;
            self.amountPerHourView.hidden=false;
            self.descriptionlabel.hidden=false;
            self.descriptionlabel.frame=CGRectMake(self.descriptionlabel.frame.origin.x, 280, self.descriptionlabel.frame.size.width, self.descriptionlabel.frame.size.height);
            self.issuesecondview.frame=CGRectMake(256,46, self.issuesecondview.frame.size.width, self.issuesecondview.frame.size.height);
            [self continueRadioButtonAction];
            self.paymentinterveltext.text=@"Annual";
        }
            break;
        case 5:
        {
            self.maximumlimitview.hidden=true;
            self.amountview.hidden=TRUE;
            self.issuefirstview.hidden=true;
            self.issuesecondview.hidden=true;
            self.issuethirdview.hidden=FALSE;
            self.considerView.hidden=true;
            self.amountPerHourView.hidden=true;
            self.descriptionlabel.hidden=false;
            self.descriptionlabel.frame=CGRectMake(self.descriptionlabel.frame.origin.x, 230, self.descriptionlabel.frame.size.width, self.descriptionlabel.frame.size.height);
            self.issuethirdview.frame=CGRectMake(256,46, self.issuethirdview.frame.size.width, self.issuethirdview.frame.size.height);
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
//Discard FUNCTION
-(void)resetFunction
{
    
    self.paymentinterveltext.text=@"Annual";
    self.issue1PaymentText.text=@"Annual";
    self.issue2PaymentText.text=@"Annual";
    self.paidbytext.text=@"Firm";
    self.hoursWorkedText.text=@"Stand.";
    self.issueRateText1.text=@"Stand.";
    self.hoursWorkedText1.text=@"total";
    self.payOnText.text=@"";
    self.eligibilityText.text=@"";
    self.ageValueText.text=@"";
    self.issueRateText.text=@"";
    self.maxLimitText.text=@"";

    p=q=r=s=x=y=0;
    self.radioFlag1=@"1";
    self.paymentintrvalTableString=@"1";
    self.paidbyTableString=@"1";
    self.agetextTableString=@"1";
    self.issuepaymentTableString=@"1";
    self.issuepaymentTableString1=@"";
    self.houersworkedTableString=@"1";
    self.houersworkedTableString1=@"2";
    self.issuerateTableString=@"1";
    self.issueFlagString=@"0";
    self.replaceStringFlag=@"0";
    self.earningflag=@"0";
    self.accumalateFlag=@"0";
    self.paidholiflag=@"0";
    self.paidleaveflag=@"0";
    [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
//    [self continueRadioButtonAction];
//    [self paidHolidaysCheckBoxAction];
//    [self paidLeavesCheckBoxAction];
    
    

}
//save Tile
-(IBAction)saveButtonAction:(id)sender
{
            NSString *eligibleMonth=[[self.eligibilityText.text componentsSeparatedByString:@" Day(s)"]objectAtIndex:0];
    NSMutableDictionary *desigDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"];
    NSString *sendDesig=[self.designationAray componentsJoinedByString:@"###"];

  
    self.tileDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.paymentintrvalTableString,@"payment_interval",self.paidbyTableString,@"paid_by",self.maxLimitText.text,@"max_limit",self.fixedAmountText.text,@"earnings_amount",eligibleMonth,@"eligible_months",self.agetextTableString,@"age_condition",self.ageValueText.text,@"age",self.payondateString,@"earnings_pay_on",self.issueHoursText1.text,@"earnings_amt_hour_worked_hours",self.issuerateTableString,@"earnings_hourly_issue",self.houersworkedTableString,@"earnings_hourly_working_hour",self.issueRateText.text,@"earnings_hourly_rate",self.issueRateText1.text,@"earnings_amt_hour_rate",self.issueHoursText.text,@"earnings_amt_hour_issue",self.earningflag,@"earnings_taxed",self.accumalateFlag,@"earnings_accumulate",self.radioFlag1,@"earnings_payment_radio",self.paidholiflag,@"earnings_hourly_paid_holidays",self.paidleaveflag,@"earnings_hourly_paid_leaves",self.issueFlagString,@"earnings_amt_hour_issue_check",self.houersworkedTableString1,@"earnings_amt_hour_worked_option",self.replaceStringFlag,@"earnings_amt_hour_replace",self.issuePercentageText.text,@"earnings_base_issue",self.issuepaymentTableString,@"earnings_hourly_issue",self.issuepaymentTableString1,@"earnings_basic_gross_pay",sendDesig,@"designationstring",self.switchString,@"checkbox_enable", nil];
        NSLog(@"%@",self.tileDetailsDict);
    
    if ([app.earningRuleId isEqualToString:@"0"] && ([app.earningsTileIdDict objectForKey:app.earningTileIdString]==nil)) {
        self.firstDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.earningName,@"earnings_name",app.earningAbbrevtion,@"earnings_abbrb",app.earningTypeString,@"earnings_type",app.earningDesc,@"description",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",@"0###0",@"condition_id", nil];
        
        if ((app.earningName.length>0)&&(app.earningAbbrevtion.length>0)) {
            
            [self.myconnection createcreateNewEarningRule:self.firstDetailsDict tileDetails:self.tileDetailsDict includeDesignation:desigDict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] idurl:@"create"];
            
            app.warningflag=0;
            app.designationFlag=0;

            
            
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
    else
    {
        NSString *idStr;
        if ([app.earningsTileIdDict objectForKey:app.earningTileIdString]==nil) {
            idStr=[NSString stringWithFormat:@"%@###0",app.earningRuleId];
            
        }
        else{
            idStr=[NSString stringWithFormat:@"%@###%@",app.earningRuleId,[app.earningsTileIdDict objectForKey:app.earningTileIdString]];
            
        }
        self.firstDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:app.earningName,@"earnings_name",app.earningAbbrevtion,@"earnings_abbrb",app.earningTypeString,@"earnings_type",app.earningDesc,@"description",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"],@"office_id",idStr,@"condition_id", nil];
        
        
        [self.myconnection createcreateNewEarningRule:self.firstDetailsDict tileDetails:self.tileDetailsDict includeDesignation:desigDict officeId:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] idurl:@"update"];
        
        app.warningflag=0;
        app.designationFlag=0;


    }
    

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==self.paymentinterveltableview) {
        return [self.paymentintervelarray count];
    }
    else if (tableView==self.paidbytableview)
    {
        return [self.paidbyarray count];
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
    
    else if (tableView==self.paidbytableview)
    {
        
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.textLabel.font=[UIFont systemFontOfSize:12.0];
        cell.textLabel.text=[self.paidbyarray objectAtIndex:indexPath.row];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.designationAray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simplecell";
    groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.designationAray.count>0) {
        cell.grouplabel.text=[self.designationAray objectAtIndex:indexPath.row];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.paymentinterveltableview)
    {
        self.paymentintrvalTableString=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        self.issuepaymentTableString=self.paymentintrvalTableString;

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
        
        self.issue1PaymentText.text=[self.dummyIssuePaymentArray  objectAtIndex:0];
        self.issue2PaymentText.text=[self.dummyIssuePaymentArray objectAtIndex:0];
        [self.issuePaymentTableView reloadData];
        if ((indexPath.row==0) || (indexPath.row==1) || (indexPath.row==2)) {
            self.paymentIntervalLabel.text=@"fiscal year.";
            self.descriptionlabel.hidden=false;
        }
        else
        {
            self.paymentIntervalLabel.text=@"month.";
            self.descriptionlabel.hidden=true;
        }
        if (indexPath.row > 4) {
            self.nextPaymentLabel.hidden=true;
            self.nextPaymentLabel1.hidden=true;
        }
        else
        {
            self.nextPaymentLabel.hidden=false;
            self.nextPaymentLabel1.hidden=false;
        }
    }
    else if (tableView==self.paidbytableview)
    {
        self.paidbyTableString=[NSString stringWithFormat:@"%ld",indexPath.row+1];

        self.paidbytext.text=[self.paidbyarray objectAtIndex:indexPath.row];
        self.paidbytableview.hidden=TRUE;
    }
    else if(tableView==self.agetableview)
    {
        self.agetextTableString=[NSString stringWithFormat:@"%ld",indexPath.row+1];

        self.agetext.text=[self.agearray objectAtIndex:indexPath.row];
        self.agetableview.hidden=TRUE;
    }
    else if (tableView==self.issuePaymentTableView)
    {
        if (issuePaymentFlag==0) {
            self.issuepaymentTableString=[NSString stringWithFormat:@"%ld",self.selected+indexPath.row+1];

            self.issue1PaymentText.text=[self.dummyIssuePaymentArray objectAtIndex:indexPath.row];
        //self.issue1PaymentText.text=[self.paymentintervelarray objectAtIndex:newIndexPath.row];

        }
        else
        {
            self.issuepaymentTableString1=[NSString stringWithFormat:@"%ld",self.selected+indexPath.row+1];

            self.issue2PaymentText.text=[self.dummyIssuePaymentArray objectAtIndex:indexPath.row];
            //self.issue1PaymentText.text=[self.paymentintervelarray objectAtIndex:newIndexPath.row];

        }
        
        self.issuePaymentTableView.hidden=TRUE;
    }
    else if (tableView==self.hoursWorkedTC)
    {

        if (hoursWorkedFlag==0) {
            self.houersworkedTableString=[NSString stringWithFormat:@"%d",indexPath.row+1];

            self.hoursWorkedText.text=[self.dummyHoursWorkedArray objectAtIndex:indexPath.row];
            if (indexPath.row==0) {
                self.considerView.hidden=true;
            }
            else
            {
                self.considerView.hidden=false;
            }
        }
        else
        {
            self.houersworkedTableString1=[NSString stringWithFormat:@"%d",indexPath.row+1];

            self.hoursWorkedText1.text=[self.dummyHoursWorkedArray objectAtIndex:indexPath.row];
        }
        
        self.hoursWorkedTC.hidden=true;
    }
    else if (tableView==self.issueRateTC)
    {
        self.issuerateTableString=[NSString stringWithFormat:@"%d",self.selected+1];

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
    else if(textField==self.paidbytext)
    {
        [self hideAllDropDown];
        self.paidbytableview.hidden=FALSE;

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
    else if (textField==self.issue1PaymentText)
    {
        [self hideAllDropDown];
        issuePaymentFlag=0;
        self.issuePaymentTableView.hidden=false;
        self.issuePaymentTableView.frame=CGRectMake(256, 81, self.issuePaymentTableView.frame.size.width, self.issuePaymentTableView.frame.size.height);
        return  NO;
    }
    else if (textField==self.hoursWorkedText)
    {
        [self hideAllDropDown];
        hoursWorkedFlag=0;
        self.hoursWorkedTC.hidden=false;
        self.hoursWorkedTC.frame=CGRectMake(354, 81, self.hoursWorkedTC.frame.size.width, self.hoursWorkedTC.frame.size.height);
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
        self.issuePaymentTableView.frame=CGRectMake(374, 81, self.issuePaymentTableView.frame.size.width, self.issuePaymentTableView.frame.size.height);
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
    else if (textField==self.paidHolidayText)
    {
        [self paidHolidaysCheckBoxAction];
        return  NO;
    }
    else if (textField==self.paidLeavesText)
    {
        [self paidLeavesCheckBoxAction];
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
    else if(textField==self.issueRateText)
    {
        self.issueRateText.text=[NSString stringWithFormat:@"%.1f",[self.issueRateText.text floatValue]];
    }
    else if (textField==self.issueRateText1)
    {
        self.issueRateText1.text=[NSString stringWithFormat:@"%.1f",[self.issueRateText1.text floatValue]];
        self.rateDropButton.hidden=false;
    }
    else if (textField==self.eligibilityText)
    {
        if (![self.eligibilityText.text isEqualToString:@""]) {
            if (!(self.eligibilityText.text.length > 3)) {
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
    if ((textField==self.maxLimitText)|| (textField==self.fixedAmountText) || (textField==self.issueRateText) || (textField==self.issueRateText1)) {
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
         self.radioFlag1=@"1";
        [self continueRadioButtonAction];
       

        
    }
    else
    {
        self.radioFlag1=@"2";

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
    else if (mybutton.tag==3)
    {
        [self paidHolidaysCheckBoxAction];
    }
    else if (mybutton.tag==4)
    {
        [self paidLeavesCheckBoxAction];
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
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
    
    self.payOnText.text=@"";
    
   self.radioFlag1=@"1";
//    self.radioFlag2=@"2";

    self.radio1stView.hidden=false;
    self.radio1stView.frame=CGRectMake(331, 200, self.radio1stView.frame.size.width, self.radio1stView.frame.size.height);
    self.radio2ndView.hidden=true;
    self.replaceView.hidden=true;
}
-(void)ontimeRadioButtonAction
{
    self.radioFlag1=@"2";

    [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
    [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal];
//    self.radioFlag1=@"2";

    self.radio1stView.hidden=true;
    self.radio2ndView.hidden=false;
    self.radio2ndView.frame=CGRectMake(331, 200, self.radio2ndView.frame.size.width, self.radio2ndView.frame.size.height);
    NSString *dropValue=[[NSUserDefaults standardUserDefaults]objectForKey:@"dropAction"];
    if ([dropValue integerValue]==4) {
        self.replaceView.hidden=false;
        //self.replaceHourText.text=self.issueHoursText.text;
        self.replaceView.frame=CGRectMake(331, 238, self.replaceView.frame.size.width, self.replaceView.frame.size.height);
    }
}


-(void)earningsCheckBoxAction
{
    if (p%2==0) {
        [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.earningflag=@"1";
        p++;
    }
    else
    {
        [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.earningflag=@"0";

        p++;
    }
}
-(void)accumulateCheckBoxAction
{
    if (q%2==0) {
        [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.accumalateFlag=@"1";

        q++;
    }
    else
    {
        [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.accumalateFlag=@"0";

        q++;
    }
}
-(void)paidHolidaysCheckBoxAction
{
    if (r%2==0) {
        [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.paidholiflag=@"1";

        r++;
    }
    else
    {
        [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.paidholiflag=@"0";

        r++;
    }
}
-(void)paidLeavesCheckBoxAction
{
    if (s%2==0) {
        [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.paidleaveflag=@"1";

        s++;
    }
    else
    {
        [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.paidleaveflag=@"0";

        s++;
    }
}
-(void)replaceCheckBoxAction
{
    if (x%2==0) {
        [self.checkButton5 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.replaceStringFlag=@"1";

        x++;
    }
    else
    {
        [self.checkButton5 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.replaceStringFlag=@"0";

        x++;
    }
}
-(void)issueCheckBoxAction
{
    if (y%2==0) {
        [self.issueCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        self.issueFlagString=@"1";
        y++;
    }
    else
    {
        [self.issueCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        self.issueFlagString=@"0";

        y++;
    }
}
-(IBAction)valueChangedActon:(id)sender
{
    app.warningflag=1;
}

- (IBAction)includeDesignationAction:(id)sender {
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    self.desigcollection.hidden=false;
    [self.designationAray removeAllObjects];
    [self.designationAray addObjectsFromArray:desigArray];
    [self.desigcollection reloadData];
}
-(void)hideAllDropDown
{
    self.paymentinterveltableview.hidden=true;
    self.paidbytableview.hidden=true;
    self.agetableview.hidden=true;
    self.issuePaymentTableView.hidden=true;
    self.hoursWorkedTC.hidden=true;
    self.issueRateTC.hidden=true;
    self.pickerView.hidden=true;
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

//.......Creating Response......
-(void)createEarningResponse:(id)reponse
{
    //app.tableRowId issue
    
    [app.earningsTileIdDict setObject:[reponse objectForKey:@"condition_id" ] forKey:app.earningTileIdString];
    app.earningRuleId=[NSString stringWithFormat:@"%@",[reponse objectForKey:@"rule_id"]];
    NSLog(@"%@",app.earningsTileIdDict);

    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesignation"];
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"earningsAction"]isEqualToString:@"create"])
    {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        earningsAccordianview *ob = (earningsAccordianview *)self.superview.superview;
        [ob addaccordianview];
            });
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
        
        earningsAccordianview *ob = (earningsAccordianview *)self.superview.superview;
        [ob closeTile];
            });
    }
}


//......conditionDetails View...................

-(void)conditionDetailsResponse:(id)responseData
{    dispatch_async(dispatch_get_main_queue(), ^{

  //  self.paymentinterveltext.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"payment_interval"];
   // self.paidbytext.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"paid_by"];
   // self.agetext.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"age_condition"];
   // self.issue1PaymentText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_issue"];
   // self.hoursWorkedText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_working_hour"];
    //self.issue2PaymentText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_basic_gross_pay"];
    //int value = [typeStr intValue];
    

    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"payment_interval"]intValue]) {
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
    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_issue"]intValue]) {
        case 1:
            self.issue1PaymentText.text=@"Annual";
            
            break;
        case 2:
            self.issue1PaymentText.text=@"Semi-annually";
            
            
            break;
            
        case 3:
            self.issue1PaymentText.text=@"Quarterly";
            
            
            break;
            
        case 4:
            self.issue1PaymentText.text=@"Monthly";
            
            break;
            
        case 5:
            self.issue1PaymentText.text=@"Semi- Monthly";
            
            break;
            
        case 6:
            self.issue1PaymentText.text=@"Bi-weekly";
            
            break;
        case 7:
            self.issue1PaymentText.text=@"Weekly";
            
            break;
            
            
        default:
            break;
    }
    

    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_basic_gross_pay"]intValue]) {
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

    
    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_working_hour"]intValue]) {
        case 1:
            self.hoursWorkedText.text=[self.dummyHoursWorkedArray objectAtIndex:0];

            break;
        case 2:
            self.hoursWorkedText.text=[self.dummyHoursWorkedArray objectAtIndex:1];
            break;
        case 3:
            self.hoursWorkedText.text=[self.dummyHoursWorkedArray objectAtIndex:2];
            break;

        default:
            break;
    }
    
    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"paid_by"]intValue]) {
        case 1:
            self.paidbytext.text=[self.paidbyarray objectAtIndex:0];
            
            break;
        case 2:
            self.paidbytext.text=[self.paidbyarray objectAtIndex:1];
            break;
            
        default:
            break;
    }
    switch ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"age_condition"]intValue]) {
        case 1:
             self.agetext.text=[self.agearray objectAtIndex:0];
            
            break;
        case 2:
             self.agetext.text=[self.agearray objectAtIndex:1];
            break;
            
        default:
            break;
    }
    if ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_issue_check"]isEqualToString:@"1"]) {
        [self.issueCheckButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];

    }
    else{
        [self.issueCheckButton setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
    }
    if ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_paid_holidays"]isEqualToString:@"1"]) {
        [self.checkButton3 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];

    }
    else{
        [self.checkButton3 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];

    }
    if ([[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_paid_leaves"]isEqualToString:@"1"]) {
        [self.checkButton4 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        
    }
    else{
        [self.checkButton4 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        
    }
   
    self.issueFlagString=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_issue_check"];
    self.paidholiflag=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_paid_holidays"];
    self.paidleaveflag=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_paid_leaves"];
    self.radioFlag1=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_payment_radio"];
    self.accumalateFlag=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_accumulate"];
    self.earningflag=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_taxed"];
    
    if ([self.radioFlag1 isEqualToString:@"1"]) {
        [self continueRadioButtonAction];
    }
    else{
        self.payondateString=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_pay_on"];
        
        NSDateFormatter *dateformat = [[NSDateFormatter alloc]init];
        [dateformat setDateFormat:@"dd-MM-yyyy"];
        NSDate *myDate = [dateformat dateFromString:self.payondateString];
        [dateformat setDateFormat:@"dd-MMM-YYYY"];
        self.payOnText.text = [dateformat stringFromDate:myDate];

        [self ontimeRadioButtonAction];
        
    }
    if ([self.accumalateFlag isEqualToString:@"1"]) {
        [self.checkButton2 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    }
    else{
        [self.checkButton2 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];

        
    }
    if ([self.earningflag isEqualToString:@"1"]) {
        [self.checkButton1 setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
    }
    else{
        [self.checkButton1 setImage:[UIImage imageNamed:@"checkbox1.png23.png"] forState:UIControlStateNormal];
        
        
    }
    
    self.eligibilityText.text=[NSString stringWithFormat:@"%@ Day(s)",[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"eligible_months"]];
    self.ageValueText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"age"];
    self.hoursWorkedText1.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_worked_option"];
    self.issueHoursText1.text=[NSString stringWithFormat:@"%@ H",[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_worked_hours"]];
    self.issueRateText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_rate"];
    self.issueRateText1.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_rate"];
    self.issueHoursText.text=[NSString stringWithFormat:@"%@ Hours",[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_issue"]];
    self.fixedAmountText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amount"];
    self.maxLimitText.text=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"max_limit"];
    NSString *symbolString=@"%";

    self.issuePercentageText.text=[NSString stringWithFormat:@"%@ %@ ",[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_base_issue"],symbolString];
    
    self.replaceStringFlag=[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_amt_hour_replace"];
        app.tableRowId=0;
    
    int value=[[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_hourly_issue"]intValue];
    int value1=[[[[responseData objectForKey:@"earnings_condtion_details"]objectAtIndex:0]objectForKey:@"earnings_basic_gross_pay"]intValue];
    [self.issuePaymentArray removeAllObjects];
    [self.dummyIssuePaymentArray removeAllObjects];
    
    //[self.designationAray removeAllObjects];
    
   
    
    if ([app.earningTypeString isEqualToString:@"3"]) {
        for (int i=value-1; i<self.paymentintervelarray.count; i++) {
            [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
            NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [self.dummyIssuePaymentArray addObject:trimmedString];
            
        }
        
    }
    if ([app.earningTypeString isEqualToString:@"5"])
    {
        for (int i=value1-1; i<self.paymentintervelarray.count; i++) {
            [self.issuePaymentArray addObject:[self.paymentintervelarray objectAtIndex:i]];
            NSString *trimmedString = [[self.issuePaymentArray1 objectAtIndex:i] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [self.dummyIssuePaymentArray addObject:trimmedString];
            
        }
    }
    
    [self.issuePaymentTableView reloadData];
    [self.designationAray removeAllObjects];
    for (int of=0; of<[[responseData objectForKey:@"office_designation"]count]; of++) {
        
        NSMutableDictionary *localDict1=[[responseData objectForKey:@"office_designation"] objectAtIndex:of];
        
        NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"office_name"],[localDict1 objectForKey:@"designation_title"]];
        
        [self.designationAray addObject:myString];
        
    }
    
    for (int st=0; st<[[responseData objectForKey:@"store_designation"]count]; st++) {
        
        NSMutableDictionary *localDict1=[[responseData objectForKey:@"store_designation"] objectAtIndex:st];
        
        NSString *myString=[NSString stringWithFormat:@"%@:%@",[localDict1 objectForKey:@"store_name"],[localDict1 objectForKey:@"designation_title"]];
        
        [self.designationAray addObject:myString];
        
    }
    
    [self.desigcollection reloadData];
    
    });
    //viewload function cal
    //[self viewLoad:app.tableRowId];

    
    
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning..."
                               message:[NSString stringWithFormat:@"%@",errorMessage]
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
