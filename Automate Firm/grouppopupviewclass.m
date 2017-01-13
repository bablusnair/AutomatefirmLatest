//
//  grouppopupviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 17/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "grouppopupviewclass.h"
#import "storeViewCollectionViewCell.h"
#import "designationCollectionViewsCell.h"
#import "editingdesignationcellview.h"
#import "secondeditdesignationcellview.h"

@implementation grouppopupviewclass
@synthesize selectedarray;

- (void)drawRect:(CGRect)rect {
    
    
    self.frame=CGRectMake(10, -20, self.frame.size.width, self.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-500, -300, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
     
}

-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;

    
    
    self.filteredFlag=0;
    
    [ self.storesCollectionView registerNib:[UINib nibWithNibName:@"storeViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"myCell"];
    
        
    [ self.designationCollectionView registerNib:[UINib nibWithNibName:@"designationCollectionViewsCell" bundle:nil] forCellWithReuseIdentifier:@"designationCell"];
    
    
    self.finalDict=[[NSMutableDictionary alloc]init];
    self.designationDict=[[NSMutableDictionary alloc]init];
    self.finalSelectedDict=[[NSMutableDictionary alloc]init];
    
    
    self.selectedarray=[[NSMutableArray alloc]init];
    self.designationArray=[[NSMutableArray alloc]init];
    self.designationIDArray=[[NSMutableArray alloc]init];
    self.filteredDesignationArray=[[NSMutableArray alloc]init];
    self.storesArray=[[NSMutableArray alloc] init];
    self.storesIDArray=[[NSMutableArray alloc]init];
    self.highlightArray=[[NSMutableArray alloc]init];
    self.selectedDesignationArray=[[NSMutableArray alloc]init];
    self.selectedArrays=[[NSMutableArray alloc]init];
   
    
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"week"]) {
        
        
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"weekAction"] isEqualToString:@"update"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"week" :[[NSUserDefaults standardUserDefaults]objectForKey:@"weekRuleId"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"weekAction"];
            
            
        }
        
       else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"weekAction"] isEqualToString:@"create"])
        {
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"week" :@"0" ];
           
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"weekAction"];
            
        }
        
        else
        {
            [self localView];
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"time"])
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Timeaction"] isEqualToString:@"update"])
        {
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"time" :[[NSUserDefaults standardUserDefaults]objectForKey:@"timeruleid"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Timeaction"];
            
            
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"Timeaction"] isEqualToString:@"create"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"time" :@"0" ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"Timeaction"];
            
        }
        
        else
        {
            [self localView];
        }

    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"shift"])
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shiftAction"] isEqualToString:@"update"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"shift" :[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftruleid"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shiftAction"];
            
            
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"shiftAction"] isEqualToString:@"create"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"shift" :@"0" ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"shiftAction"];
            
        }
        
        else
        {
            [self localView];
        }

    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"leave"])
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"leaveAction"] isEqualToString:@"update"])
        {
            
            //[self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"leave" :[[NSUserDefaults standardUserDefaults]objectForKey:@"shiftruleid"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"leaveAction"];
            
            
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"leaveAction"] isEqualToString:@"create"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"leave" :@"0" ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"leaveAction"];
            
        }
        
        else
        {
            [self localService];
        }

    }
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"pay"])
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payAction"] isEqualToString:@"update"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"payroll" :[[NSUserDefaults standardUserDefaults]objectForKey:@"payRuleId"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"payAction"];
            
            
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"payAction"] isEqualToString:@"create"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"payroll" :@"0" ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"payAction"];
            
        }
        
        else
        {

            [self localView];
        }
        
    }
    
    
    else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"ruleType"] isEqualToString:@"overtime"])
    {
        if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"overtimeAction"] isEqualToString:@"update"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"overtime" : [[NSUserDefaults standardUserDefaults]objectForKey:@"overtimeID"] ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"overtimeAction"];
            
            
        }
        
        else if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"overtimeAction"] isEqualToString:@"create"])
        {
            
            [self.myconnection includeDesignation:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] :@"overtime" :@"0" ];
            
            [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"overtimeAction"];
            
        }
        
        else
        {
            
            [self localView];
        }
        
    }
    
    
     //[[NSUserDefaults standardUserDefaults]setObject:@"Create" forKey:@"payAction"];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    if (collectionView==self.storesCollectionView) {
        return [self.storesArray count];
    }
    else
    {
        if (self.filteredFlag==0) {
            return [self.designationArray count];
        }
        else
            return self.filteredDesignationArray.count;
    }
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.storesCollectionView)
    {
        static NSString *cellIdentifier = @"myCell";
        storeViewCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if ([self.selectedArrays containsObject:indexPath]) {
            cell.storeLabel.textColor=[UIColor blueColor];
        }
        else
        {
            cell.storeLabel.textColor=[UIColor blackColor];
        }
        cell.storeLabel.text=[self.storesArray objectAtIndex:indexPath.row];
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"designationCell";
        designationCollectionViewsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
        if (self.filteredFlag==0) {
            cell.desigLabel.text=[self.designationArray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.desigLabel.text=[self.filteredDesignationArray objectAtIndex:indexPath.row];
        }
        cell.cellID=[self.designationDict objectForKey:cell.desigLabel.text];
        if([self.selectedarray containsObject:cell.cellID]) {
            
            [cell.checkButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
            
        }
        
        else {
            
            [cell.checkButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
            
        }
        
        if ([self.highlightArray containsObject:cell.cellID]) {
            cell.iconImage.image=[UIImage imageNamed:@"img.png"];
        }
        else
        {
            cell.iconImage.image=[UIImage imageNamed:@"designation_normal.png"];
        }
        
        return cell;
    }
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.designationCollectionView)
    {
        designationCollectionViewsCell *cell1= (designationCollectionViewsCell *) [self.designationCollectionView cellForItemAtIndexPath:indexPath];
        
        NSMutableDictionary *mydict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.selectedStore]];
        NSMutableArray *selectArray=[[NSMutableArray alloc]initWithArray:[mydict objectForKey:@"selected"]];
        
        if ([cell1.checkButton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
            
            [cell1.checkButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
             
            [self.selectedarray addObject:[self.designationDict objectForKey:cell1.desigLabel.text]];
            
            
            NSMutableDictionary *addDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[self.designationDict objectForKey:cell1.desigLabel.text],@"id",cell1.desigLabel.text,@"designation_title", nil];
            
            [selectArray addObject:addDict];
            [mydict setObject:selectArray forKey:@"selected"];
            
            
        }
        
        else
        {
            
            [cell1.checkButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
            
            [self.selectedarray removeObject:[self.designationDict objectForKey:cell1.desigLabel.text]];
//            NSMutableArray *selectArray=[mydict objectForKey:@"selected"];
            for (int i=0; i<selectArray.count; i++) {
                NSMutableDictionary *mydict=[selectArray objectAtIndex:i];
                if ([[mydict objectForKey:@"id"]isEqualToString:[self.designationDict objectForKey:cell1.desigLabel.text]]) {
                    [selectArray removeObjectAtIndex:i];
                }
            }
            [mydict setObject:selectArray forKey:@"selected"];
            
        }
        NSMutableDictionary *finalDictTemp=[[NSMutableDictionary alloc]init];
        finalDictTemp=[self.finalDict mutableCopy];
        [finalDictTemp setObject:mydict forKey:self.selectedStore];
        
        self.finalDict=[[NSMutableDictionary alloc]initWithDictionary:finalDictTemp];
        //[self.finalDict setObject:mydict forKey:self.selectedStore];

    }
    else
    {
        [self.officeButton setImage:[UIImage imageNamed:@"top_office_normal.png"] forState:UIControlStateNormal];
        [self.designationCollectionView setContentOffset:CGPointMake(0,0) animated:YES];
        storeViewCollectionViewCell *cell=(storeViewCollectionViewCell *)[self.storesCollectionView cellForItemAtIndexPath:indexPath];
        self.selectedStore=cell.storeLabel.text;
        [self individualView:cell.storeLabel.text];
        [self.selectedArrays removeAllObjects];
        [self.selectedArrays addObject:indexPath];
        self.officename.textColor=[UIColor blackColor];
        [self.storesCollectionView reloadData];
    }
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.storesCollectionView) {
        storeViewCollectionViewCell *cell=(storeViewCollectionViewCell *)[self.storesCollectionView cellForItemAtIndexPath:indexPath];
        cell.storeLabel.textColor=[UIColor blackColor];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.searchText) {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.origin.x,90) animated:YES];        self.filteredFlag=1;
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.searchText.text stringByReplacingCharactersInRange:range withString:string]];
        self.filteredDesignationArray = [[self.designationArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
        [self.designationCollectionView reloadData];
        if ([string isEqualToString:@""] && textField.text.length==1)
        {
            self.filteredFlag=0;//
            [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.origin.x,0) animated:YES];
            
            [self.designationCollectionView reloadData];
        }
        return  YES;
    }
    else
    {
        return  NO;
    }
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.origin.x,0) animated:YES];
    return  YES;
}

-(IBAction)donebuttonaction:(id)sender
{
    
    NSMutableArray *desig=[[NSMutableArray alloc]initWithObjects:self.officename.text, nil];
    [desig addObjectsFromArray:self.storesArray];
    
    NSMutableArray *workingPremiseIDArray=[[NSMutableArray alloc] initWithObjects:self.officeID, nil];
    [workingPremiseIDArray addObjectsFromArray:self.storesIDArray];
    
    for (int i=0; i<desig.count; i++) {
        NSMutableDictionary *localDict=[self.finalDict objectForKey:[desig objectAtIndex:i]];
        NSMutableArray *localArray=[localDict objectForKey:@"selected"];
        
        NSMutableDictionary *selectedDict=[[NSMutableDictionary alloc]init];
        [selectedDict setObject:localArray forKey:@"selected"];
        [selectedDict setObject:[workingPremiseIDArray objectAtIndex:i] forKey:@"id"];
        
        [self.finalSelectedDict setObject:selectedDict forKey:[desig objectAtIndex:i]];
        
        
        for (int j=0; j<localArray.count; j++) {
            NSMutableDictionary *localDict1=[localArray objectAtIndex:j];
            NSString *myString=[NSString stringWithFormat:@"%@:%@",[desig objectAtIndex:i],[localDict1 objectForKey:@"designation_title"]];
            [self.selectedDesignationArray addObject:myString];
        }
    }
    
    
    
    NSMutableDictionary *desigDict=[[NSMutableDictionary alloc]init];
    [desigDict setObject:[self.finalSelectedDict objectForKey:[desig objectAtIndex:0]] forKey:@"office"];
    
    NSMutableArray *storesSelected=[[NSMutableArray alloc]init];
    for (int i=1; i<desig.count; i++) {
        
        [storesSelected addObject:[self.finalSelectedDict objectForKey:[desig objectAtIndex:i]]];
    }
    [desigDict setObject:storesSelected forKey:@"stores"];
    
    [[NSUserDefaults standardUserDefaults]setObject:self.selectedDesignationArray forKey:@"selectedDesig"];
    [[NSUserDefaults standardUserDefaults]setObject:desigDict forKey:@"selectedDesignation"];
    [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"officeDetails"];
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"]);
    [self removeFromSuperview];
   
}




-(void)showalerviewcontroller
{
    
    
    NSLog(@" No internet connection ");
    
}
-(IBAction)officeButtonAction:(id)sender
{
    [self.selectedArrays removeAllObjects];
    [self.officeButton setImage:[UIImage imageNamed:@"officeSelected.png"] forState:UIControlStateNormal];
    self.officename.textColor=[UIColor blueColor];
    [self.designationCollectionView setContentOffset:CGPointMake(0,0) animated:YES];
    [self individualView:self.officename.text];
    
    [self.storesCollectionView reloadData];
}
-(void)serviceGotResponse:(id)responseData
{
    [self.finalDict removeAllObjects];
    [self.designationArray removeAllObjects];
    [self.designationIDArray removeAllObjects];
    [self.highlightArray removeAllObjects];
    [self.storesArray removeAllObjects];
    [self.storesIDArray removeAllObjects];
    [self.selectedarray removeAllObjects];
    
   dispatch_async(dispatch_get_main_queue(), ^{ 
    
    NSMutableDictionary *tempDict=[[NSMutableDictionary alloc] initWithDictionary:responseData];
    [tempDict removeObjectForKey:@"store_details"];
    self.finalDict=tempDict;
    
    NSMutableArray *stores=[self.finalDict objectForKey:@"store"];
    for (int i=0; i<stores.count; i++) {
        NSMutableDictionary *storesDict=[stores objectAtIndex:i];
        [self.storesArray addObject:[storesDict objectForKey:@"store_name"]];
        [self.storesIDArray addObject:[storesDict objectForKey:@"store_id"]];
    }
    NSMutableArray *officeArray=[self.finalDict objectForKey:@"office"];
    NSMutableDictionary *offDict=[officeArray objectAtIndex:0];
    self.officename.text=[offDict objectForKey:@"office_name"];
    self.officename.textColor=[UIColor blueColor];
    self.officeID=[offDict objectForKey:@"id"];
    self.selectedStore=self.officename.text;
    
    
    NSMutableDictionary *storesDetails=[responseData objectForKey:@"store_details"];
    for (int i=0; i<self.storesArray.count; i++) {
        NSMutableDictionary *selectedStoreDict=[storesDetails objectForKey:[self.storesArray objectAtIndex:i]];
        [self.finalDict setObject:selectedStoreDict forKey:[self.storesArray objectAtIndex:i]];
    }
    
    
    NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.officename.text]];
    
    
    NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"designation_list"];
    for (int i=0; i<desigsArray.count; i++) {
        NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
        [self.designationArray addObject:[desigDict objectForKey:@"designation_title"]];
        [self.designationIDArray addObject:[desigDict objectForKey:@"id"]];
        [self.designationDict setObject:[desigDict objectForKey:@"id"] forKey:[desigDict objectForKey:@"designation_title"]];
    }
    
    
    NSMutableArray *highlight=[officeDetailsDict objectForKey:@"highlighted"];
    for (int i=0; i<highlight.count; i++) {
        NSMutableDictionary *highlightDict=[highlight objectAtIndex:i];
        [self.highlightArray addObject:[highlightDict objectForKey:@"id"]];
    }
    
    
    
    NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected"];
    for (int i=0; i<selected.count; i++) {
        NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
        [self.selectedarray addObject:[selectedDesigDict objectForKey:@"id"]];
    }
    
    
    
        [self.designationCollectionView reloadData];
        [self.storesCollectionView reloadData];
    });
    
    
    
    
    
    
    
    
}
//-(void)service
//{
//    NSMutableDictionary *officeDict=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *storeDict1=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *storeDict2=[[NSMutableDictionary alloc]init];
//    NSMutableDictionary *storeDict3=[[NSMutableDictionary alloc]init];
//    
//    
//    [self.finalDict removeAllObjects];
//    
//   //Office
//    NSMutableDictionary *officeDict1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Automate Firm",@"office_name",@"1",@"office_id", nil];
//    [self.finalDict setObject:officeDict1 forKey:@"office"];
//    
//    //Stores
//    
//    NSMutableDictionary *store1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"TVPM",@"store_name",@"2",@"store_id", nil];
//    NSMutableDictionary *store2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"ERKLM",@"store_name",@"3",@"store_id", nil];
//    NSMutableDictionary *store3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"KLM",@"store_name",@"3",@"store_id", nil];
//    
//    NSMutableArray *storeArray1=[[NSMutableArray alloc] initWithObjects:store1,store2
//                                 ,store3, nil];
//    
//    [self.finalDict setObject:storeArray1 forKey:@"stores"];
//    
//    
//    
//    
//   
//    [officeDict setObject:@"1" forKey:@"id"];
//    
//    NSMutableDictionary *desig1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Software Developer",@"desig_name",@"1",@"desig_id", nil];
//    NSMutableDictionary *desig2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"HR Manager",@"desig_name",@"2",@"desig_id", nil];
//    NSMutableDictionary *desig3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Senior Software Engineer",@"desig_name",@"3",@"desig_id", nil];
//    NSMutableDictionary *desig4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Senior HR Manager",@"desig_name",@"4",@"desig_id", nil];
//    NSMutableDictionary *desig5=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Accountant",@"desig_name",@"5",@"desig_id", nil];
//    NSMutableDictionary *desig6=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Supervisor",@"desig_name",@"6",@"desig_id", nil];
//    NSMutableDictionary *desig7=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"General Manager",@"desig_name",@"7",@"desig_id", nil];
//    NSMutableDictionary *desig8=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Administrator",@"desig_name",@"8",@"desig_id", nil];
//    NSMutableDictionary *desig9=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Salesman",@"desig_name",@"9",@"desig_id", nil];
//    NSMutableDictionary *desig10=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Sales Executive",@"desig_name",@"10",@"desig_id", nil];
//    NSMutableDictionary *desig11=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Business Developer",@"desig_name",@"11",@"desig_id", nil];
//    NSMutableDictionary *desig12=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"BPO",@"desig_name",@"12",@"desig_id", nil];
//    
//    NSMutableDictionary *desig13=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Software Tester",@"desig_name",@"13",@"desig_id", nil];
//    NSMutableDictionary *desig14=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Project Manager",@"desig_name",@"14",@"desig_id", nil];
//    NSMutableDictionary *desig15=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Team Leader",@"desig_name",@"15",@"desig_id", nil];
//    NSMutableDictionary *desig16=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Security",@"desig_name",@"16",@"desig_id", nil];
//    NSMutableDictionary *desig17=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Ground Staff",@"desig_name",@"17",@"desig_id", nil];
//    NSMutableDictionary *desig18=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Designer",@"desig_name",@"18",@"desig_id", nil];
//    NSMutableDictionary *desig19=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Customer-Client Servicer",@"desig_name",@"19",@"desig_id", nil];
//    NSMutableDictionary *desig20=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Team Head",@"desig_name",@"20",@"desig_id", nil];
//    
//    NSMutableArray *desigArray=[[NSMutableArray alloc]initWithObjects:desig1,desig2,desig3,desig4,desig5,desig6,desig7,desig8,desig9,desig10,desig11,desig12,desig13,desig14,desig15,desig16,desig17,desig18,desig19,desig20, nil];
//    
//    [officeDict setObject:desigArray forKey:@"designation"];
//    
//    NSMutableDictionary *highlighted1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Software Developer",@"desig_name",@"1",@"desig_id", nil];
//    NSMutableDictionary *highlighted2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"HR Manager",@"desig_name",@"2",@"desig_id", nil];
//    NSMutableDictionary *highlighted3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Senior Software Engineer",@"desig_name",@"3",@"desig_id", nil];
//    NSMutableDictionary *highlighted4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Senior HR Manager",@"desig_name",@"4",@"desig_id", nil];
//    NSMutableDictionary *highlighted5=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Accountant",@"desig_name",@"5",@"desig_id", nil];
//    NSMutableDictionary *highlighted6=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Supervisor",@"desig_name",@"6",@"desig_id", nil];
//    
//    NSMutableArray *highlightedArray=[[NSMutableArray alloc] initWithObjects:highlighted1,highlighted2,highlighted3,highlighted4,highlighted5,highlighted6, nil];
//    
//    [officeDict setObject:highlightedArray forKey:@"highlighted"];
//    
//    
//    
//    NSMutableDictionary *selected1=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Software Developer",@"desig_name",@"1",@"desig_id", nil];
//    NSMutableDictionary *selected2=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Senior HR Manager",@"desig_name",@"4",@"desig_id", nil];
//    NSMutableDictionary *selected3=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"General Manager",@"desig_name",@"7",@"desig_id", nil];
//    NSMutableDictionary *selected4=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Business Developer",@"desig_name",@"11",@"desig_id", nil];
//    NSMutableDictionary *selected5=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Team Leader",@"desig_name",@"15",@"desig_id", nil];
//    NSMutableDictionary *selected6=[[NSMutableDictionary alloc] initWithObjectsAndKeys:@"Designer",@"desig_name",@"18",@"desig_id", nil];
//    
//    NSMutableArray *selectedDesigArray=[[NSMutableArray alloc] initWithObjects:selected1,selected2,selected3,selected4,selected5,selected6, nil];
//    
//    [officeDict setObject:selectedDesigArray forKey:@"selected"];
//    [self.finalDict setObject:officeDict forKey:@"Automate Firm"];
//    
//    
//    [storeDict1 setObject:@"2" forKey:@"id"];
//    
//    NSMutableArray *desigArray2=[[NSMutableArray alloc] initWithObjects:desig1,desig2,desig3,desig4,desig5,desig6,desig7,desig8,desig9,desig10,desig11,desig12, nil];
//    [storeDict1 setObject:desigArray2 forKey:@"designation"];
//    
//    
//    NSMutableArray *highlightedArray1=[[NSMutableArray alloc] initWithObjects:desig1,desig10,desig2,desig3,desig6,desig8,desig9, nil];
//    [storeDict1 setObject:highlightedArray1 forKey:@"highlighted"];
//    
//    
//    NSMutableArray *selectedDesigArray1=[[NSMutableArray alloc]initWithObjects:desig1,desig2,desig4,desig5, nil];
//    
//    [storeDict1 setObject:selectedDesigArray1 forKey:@"selected"];
//    
//    [self.finalDict setObject:storeDict1 forKey:@"TVPM"];
//    
//    
//    [storeDict2 setObject:@"3" forKey:@"id"];
//    NSMutableArray *desigArray3=[[NSMutableArray alloc]initWithObjects:desig1,desig10,desig11,desig12,desig13,desig14,desig15,desig16,desig17,desig18,desig19,desig20, nil];
//    
//    [storeDict2 setObject:desigArray3 forKey:@"designation"];
//    
//    NSMutableArray *highlightedArray2=[[NSMutableArray alloc] initWithObjects:desig1,desig11,desig14,desig15,desig18,desig19, nil];
//    [storeDict2 setObject:highlightedArray2 forKey:@"highlighted"];
//    
//    NSMutableArray *selectedDesigArray2=[[NSMutableArray alloc] initWithObjects:desig1,desig10,desig11,desig12,desig13,desig14,desig15, nil];
//    
//    [storeDict2 setObject:selectedDesigArray2 forKey:@"selected"];
//    
//    [self.finalDict setObject:storeDict2 forKey:@"ERKLM"];
//    
//    
//    [storeDict3 setObject:@"4" forKey:@"id"];
//    [storeDict3 setObject:desigArray3 forKey:@"designation"];
//    [storeDict3 setObject:highlightedArray2 forKey:@"highlighted"];
//    [storeDict3 setObject:selectedDesigArray2 forKey:@"selected"];
//    [self.finalDict setObject:storeDict3 forKey:@"KLM"];
//    
////<------------------------------------------------------------------------------------------------------------>
//    
//    
//    [self.designationArray removeAllObjects];
//    [self.designationIDArray removeAllObjects];
//    [self.highlightArray removeAllObjects];
//    [self.storesArray removeAllObjects];
//    [self.storesIDArray removeAllObjects];
//    [self.selectedarray removeAllObjects];
//    
//    
//    NSMutableArray *stores=[self.finalDict objectForKey:@"stores"];
//    for (int i=0; i<stores.count; i++) {
//        NSMutableDictionary *storesDict=[stores objectAtIndex:i];
//        [self.storesArray addObject:[storesDict objectForKey:@"store_name"]];
//        [self.storesIDArray addObject:[storesDict objectForKey:@"store_id"]];
//    }
//    
//    
//    NSMutableDictionary *offDict=[self.finalDict objectForKey:@"office"];
//    self.officename.text=[offDict objectForKey:@"office_name"];
//    self.selectedStore=self.officename.text;
//
//    NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.officename.text]];
//    
//    
//    NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"designation"];
//    for (int i=0; i<desigsArray.count; i++) {
//        NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
//        [self.designationArray addObject:[desigDict objectForKey:@"desig_name"]];
//        [self.designationIDArray addObject:[desigDict objectForKey:@"desig_id"]];
//        [self.designationDict setObject:[desigDict objectForKey:@"desig_id"] forKey:[desigDict objectForKey:@"desig_name"]];
//    }
//
//    
//    NSMutableArray *highlight=[officeDetailsDict objectForKey:@"highlighted"];
//    for (int i=0; i<highlight.count; i++) {
//        NSMutableDictionary *highlightDict=[highlight objectAtIndex:i];
//        [self.highlightArray addObject:[highlightDict objectForKey:@"desig_id"]];
//    }
//    
//    
//
//    NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected"];
//    for (int i=0; i<selected.count; i++) {
//        NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
//        [self.selectedarray addObject:[selectedDesigDict objectForKey:@"desig_id"]];
//    }
//
//    
//    [self.designationCollectionView reloadData];
//    [self.storesCollectionView reloadData];
//    
//    
//}

-(void)individualView:(NSString *)selectedPremise
{
    self.selectedStore=selectedPremise;
    NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:selectedPremise]];
    
    [self.designationDict removeAllObjects];
    [self.designationArray removeAllObjects];
    [self.designationIDArray removeAllObjects];
    [self.highlightArray removeAllObjects];
    [self.selectedarray removeAllObjects];
    
    NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"designation_list"];
    for (int i=0; i<desigsArray.count; i++) {
        NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
        [self.designationArray addObject:[desigDict objectForKey:@"designation_title"]];
        [self.designationIDArray addObject:[desigDict objectForKey:@"id"]];
        [self.designationDict setObject:[desigDict objectForKey:@"id"] forKey:[desigDict objectForKey:@"designation_title"]];
    }
    
    
    NSMutableArray *highlight=[officeDetailsDict objectForKey:@"highlighted"];
    for (int i=0; i<highlight.count; i++) {
        NSMutableDictionary *highlightDict=[highlight objectAtIndex:i];
        [self.highlightArray addObject:[highlightDict objectForKey:@"id"]];
    }
    
    
    
    NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected"];
    for (int i=0; i<selected.count; i++) {
        NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
        [self.selectedarray addObject:[selectedDesigDict objectForKey:@"id"]];
    }
    
    
    [self.designationCollectionView reloadData];
}

-(void)localView
{
    self.finalDict=[[NSUserDefaults standardUserDefaults]objectForKey:@"officeDetails"];
    
    [self.designationArray removeAllObjects];
    [self.designationIDArray removeAllObjects];
    [self.highlightArray removeAllObjects];
    [self.storesArray removeAllObjects];
    [self.storesIDArray removeAllObjects];
    [self.selectedarray removeAllObjects];
    
    
    NSMutableArray *stores=[self.finalDict objectForKey:@"store"];
    for (int i=0; i<stores.count; i++) {
        NSMutableDictionary *storesDict=[stores objectAtIndex:i];
        [self.storesArray addObject:[storesDict objectForKey:@"store_name"]];
        [self.storesIDArray addObject:[storesDict objectForKey:@"store_id"]];
    }
    
    
    NSMutableArray *offArray=[self.finalDict objectForKey:@"office"];
    NSMutableDictionary *offDict=[offArray objectAtIndex:0];
    self.officename.text=[offDict objectForKey:@"office_name"];
    self.officename.textColor=[UIColor blueColor];

    self.officeID=[offDict objectForKey:@"id"];
    self.selectedStore=self.officename.text;
    
    NSMutableDictionary *officeDetailsDict=[[NSMutableDictionary alloc] initWithDictionary:[self.finalDict objectForKey:self.officename.text]];
    
    
    NSMutableArray *desigsArray=[officeDetailsDict objectForKey:@"designation_list"];
    for (int i=0; i<desigsArray.count; i++) {
        NSMutableDictionary *desigDict=[desigsArray objectAtIndex:i];
        [self.designationArray addObject:[desigDict objectForKey:@"designation_title"]];
        [self.designationIDArray addObject:[desigDict objectForKey:@"id"]];
        [self.designationDict setObject:[desigDict objectForKey:@"id"] forKey:[desigDict objectForKey:@"designation_title"]];
    }
    
    
    NSMutableArray *highlight=[officeDetailsDict objectForKey:@"highlighted"];
    for (int i=0; i<highlight.count; i++) {
        NSMutableDictionary *highlightDict=[highlight objectAtIndex:i];
        [self.highlightArray addObject:[highlightDict objectForKey:@"id"]];
    }
    
    
    
    NSMutableArray *selected=[officeDetailsDict objectForKey:@"selected"];
    for (int i=0; i<selected.count; i++) {
        NSMutableDictionary *selectedDesigDict=[selected objectAtIndex:i];
        [self.selectedarray addObject:[selectedDesigDict objectForKey:@"id"]];
    }
    
    
    [self.designationCollectionView reloadData];
    [self.storesCollectionView reloadData];
    
}


-(void)localService
{
    
}


@end
