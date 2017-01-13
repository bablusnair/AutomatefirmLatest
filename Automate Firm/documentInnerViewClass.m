//
//  documentInnerViewClass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 29/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "documentInnerViewClass.h"
#import "groupcollceioncellclass.h"
#import "popupTableViewCell.h"
#import "DocumentTile.h"
#import "settingsViewController.h"


@implementation documentInnerViewClass
@synthesize buttonFlag,x,y,z,p,q;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.grouparray=[[NSMutableArray alloc]init];
    self.popupArray=[[NSMutableArray alloc] initWithObjects:@"Designations",@"Owners",@"Specific Individuals", nil];
    self.dropHighlightArray=[[NSMutableArray alloc]init];
    
    self.finalDict=[[NSMutableDictionary alloc]init];
    self.popupStorageDict=[[NSMutableDictionary alloc]init];
    
    self.popUpView.hidden=true;
    self.button2.userInteractionEnabled=NO;
    self.button3.userInteractionEnabled=NO;
    self.button4.userInteractionEnabled=NO;
    buttonFlag=0;
    x=0;
    y=0;
    z=0;
    p=q=0;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewLoad) name:@"PaperworkProtocol" object:Nil];
    
}

-(void)viewLoad
{
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.grouparray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simplecell";
    groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.grouparray.count>0) {
        cell.grouplabel.text=[self.grouparray objectAtIndex:indexPath.row];
        
    }
    return cell;
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
    if ([self.dropHighlightArray containsObject:indexPath]) {
        [cell.backImage setImage:[UIImage imageNamed:@"bottom_left buttton_selected.png"]];
    }
    else
    {
        [cell.backImage setImage:[UIImage imageNamed:@"drop_box_white.png"]];
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
            [self.button1 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            x=0;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            y=0;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.button3 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            z=0;
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            self.button5.userInteractionEnabled=YES;
            [self.button4 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            p=0;
            self.popUpView.hidden=true;
        }
        else
        {
            [self.button5 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        NSMutableDictionary *ownerDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"owner",@"type",app.flowAction,@"progress_id", nil ];
        [self.finalDict setObject:ownerDict forKey:app.flowAction];
        
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
-(IBAction)button1Action:(id)sender
{
    if (x%2==0) {
        [self settingsLocalStorageValue:@"1"];
        buttonFlag=1;
        app.flowAction=@"1";
        self.popUpView.hidden=false;
        
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(-5, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        x++;
    }
    else
    {
        x++;
        self.popUpView.hidden=true;
    }
    
    
}
-(IBAction)button2Action:(id)sender
{
    if (y%2==0) {
        buttonFlag=2;
        app.flowAction=@"2";
        self.popUpView.hidden=false;
        
        [self settingsLocalStorageValue:@"2"];
        
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(95, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        y++;
    }
    else
    {
        y++;
        self.popUpView.hidden=true;
    }
}
-(IBAction)button3Action:(id)sender
{
    if (z%2==0) {
        buttonFlag=3;
        app.flowAction=@"3";
        self.popUpView.hidden=false;
        
        [self settingsLocalStorageValue:@"3"];
        
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(208, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        z++;
    }
    else
    {
        z++;
        self.popUpView.hidden=true;
    }
    
}
-(IBAction)button4Action:(id)sender
{
    if (p%2==0) {
        buttonFlag=4;
        app.flowAction=@"4";
        self.popUpView.hidden=false;
        
        [self settingsLocalStorageValue:@"4"];
        
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(325, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
    }
    else
    {
        p++;
        self.popUpView.hidden=true;
    }
    
}
-(IBAction)button5Action:(id)sender
{
    if (q%2==0) {
        buttonFlag=5;
        app.flowAction=@"5";
        self.popUpView.hidden=false;
        
        [self settingsLocalStorageValue:@"5"];
        
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(425, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
    }
    else
    {
        q++;
        self.popUpView.hidden=true;
    }
    
}
-(void)settingsLocalStorageValue:(NSString *)key
{
    NSMutableDictionary *protocolDict=[[NSMutableDictionary alloc]initWithDictionary:self.finalDict];
    if ([[protocolDict allKeys]containsObject:key]) {
        
        if ([[[protocolDict objectForKey:key]objectForKey:@"type"]isEqualToString:@"designation"]) {
            
            [self.dropHighlightArray removeAllObjects];
            NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[key intValue]-1 inSection:0];
            [self.dropHighlightArray addObject:myindexPath];
            
            //NSMutableDictionary *detailsDict=[[NSMutableDictionary alloc] initWithDictionary:[[protocolDict objectForKey:key]objectForKey:@"selected_designation"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:[self.popupStorageDict objectForKey:key] forKey:@"officeDetails"];
            
        }
        else if ([[[protocolDict objectForKey:key]objectForKey:@"type"]isEqualToString:@"owner"])
        {
            [self.dropHighlightArray removeAllObjects];
            NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[key intValue]-1 inSection:0];
            [self.dropHighlightArray addObject:myindexPath];

        }
        else if ([[[protocolDict objectForKey:key]objectForKey:@"type"]isEqualToString:@"employee"])
        {
            [self.dropHighlightArray removeAllObjects];
            NSIndexPath *myindexPath = [NSIndexPath indexPathForRow:[key intValue]-1 inSection:0];
            [self.dropHighlightArray addObject:myindexPath];
            
            //NSMutableDictionary *detailsDict=[[NSMutableDictionary alloc] initWithDictionary:[[protocolDict objectForKey:key]objectForKey:@"selected_employee"]];
            
            [[NSUserDefaults standardUserDefaults]setObject:[self.popupStorageDict objectForKey:app.flowAction] forKey:@"employeeDict"];

        }
        
    }
}
-(IBAction)includeDesignationAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"includedesignation" forKey:@"popupAction"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeEmployeePopup" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selected_employees"] count] > 0) {
        [self.finalDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selected_employees"] forKey:@"employees"];
    }
    else
    {
        [self.finalDict setObject:@"" forKey:@"employees"];
    }
    

    
    self.mycollectionview.hidden=false;
    [self.grouparray addObjectsFromArray:desigArray];
    [self.mycollectionview reloadData];
    
    
    
}
-(void)assignDesignation:(NSMutableArray *)desigArray
{
    if (desigArray.count > 0) {
        if (buttonFlag==1) {
            x=0;
            [self.button1 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            y=0;
            [self.button2 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            z=0;
            [self.button3 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            p=0;
            [self.button4 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=YES;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            q=0;
            [self.button5 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        NSMutableDictionary *designationDict=[[NSMutableDictionary alloc]init];
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] count] > 0) {
            [designationDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesignation"] forKey:@"selected_designation"];
        }
        else
        {
            [designationDict setObject:@"" forKey:@"selected_designation"];
        }
    
        
        
        [designationDict  setObject:@"designation" forKey:@"type"];
        [designationDict setObject:app.flowAction forKey:@"progress_id"];
        [self.finalDict setObject:designationDict forKey:app.flowAction];
        [self.popupStorageDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"officeDetails"] forKey:app.flowAction];
        
        
    }
    
    
    
}



-(void)specificEmployee:(NSMutableArray *)selectedEmployee :(NSData *)selectedEmployeeIcon
{
    if (selectedEmployee.count > 1) {
        if (buttonFlag==1) {
            x=0;
            [self.button1 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            y=0;
            [self.button2 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            z=0;
            [self.button3 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            p=0;
            [self.button4 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=YES;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            q=0;
            [self.button5 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    else if (selectedEmployee.count == 1)
    {
        if (buttonFlag==1) {
            x=0;
            [self.button1 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button1.layer.cornerRadius = self.button1.frame.size.width / 2;
            self.button1.clipsToBounds = YES;
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            y=0;
            [self.button2 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            z=0;
            [self.button3 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            p=0;
            [self.button4 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=YES;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            q=0;
            [self.button5 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    NSMutableDictionary *designationDict=[[NSMutableDictionary alloc]init];
    
    [designationDict setObject:selectedEmployee forKey:@"selected_employee"];
    [designationDict setObject:@"employee" forKey:@"type"];
    [designationDict setObject:app.flowAction forKey:@"progress_id"];
    [self.finalDict setObject:designationDict forKey:app.flowAction];
    [self.popupStorageDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeDict"] forKey:app.flowAction];
}
-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    self.indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:self.indexpath.row];
    [self.mycollectionview reloadData];
}
-(IBAction)saveButtonAction:(id)sender
{
    app.designationFlag=0;
    app.warningflag=0;
    app.specificEmployeeFlag1=0;
    app.specificEmployeeFlag2=0;
    app.specificEmployeeFlag3=0;
    app.specificEmployeeFlag4=0;
    app.specificEmployeeFlag5=0;
    app.designationFlag1=0;
    app.designationFlag2=0;
    app.designationFlag3=0;
    app.designationFlag4=0;
    app.designationFlag5=0;
    
    
    [self.finalDict setObject:app.conditionID forKey:@"protocol_id"];
    NSMutableDictionary *protocolDetailsDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.finalDict,@"protocol_details",app.ruleID,@"rule_id",self.descriptionText.text,@"description",@"leave",@"rule_type", nil];
    
    
    if([[[NSUserDefaults standardUserDefaults]objectForKey:@"paperworkAction"]isEqualToString:@"create"])
    {
        
        [self.myconnection saveIndividualLeaveProtocol:protocolDetailsDict];
        

    }
    else
    {
        [self.myconnection saveIndividualLeaveProtocol:protocolDetailsDict];

    }
        
    
}


//<<<<<<<<<------------------------------Response Part----------------------------->>>>>>>>>>
-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",Response);
        
        NSArray *responseArray=[Response componentsSeparatedByString:@"###"];
        if ([[responseArray objectAtIndex:1]isEqualToString:@"1"]) {
            
            [app.conditionIDArray replaceObjectAtIndex:app.selectedRow withObject:[responseArray objectAtIndex:1]];
            
            
            if([[[NSUserDefaults standardUserDefaults]objectForKey:@"paperworkAction"]isEqualToString:@"create"])
            {
                DocumentTile *ob = (DocumentTile *)self.superview.superview;
                [app.conditionIDArray addObject:@"0"];
                [ob addaccordianview];
            }
            else
            {
                DocumentTile *ob = (DocumentTile *)self.superview.superview;
                [ob closeTile];
            }
        }
        else
        {
            [self showalerviewcontroller:@"Failed to Save Protocol"];
        }
        
        
        
        
        
    });
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
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
