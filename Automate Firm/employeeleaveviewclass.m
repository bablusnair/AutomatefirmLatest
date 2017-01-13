//
//  employeeleaveviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/10/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeeleaveviewclass.h"
#import "leaveCollectionViewCell.h"
@implementation employeeleaveviewclass
@synthesize numberArray,leaveArray,statusArray,startDateArray,enddateArray,durationArray,rejoiningArray,reasonArray;
-(void)awakeFromNib
{
    
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    self.leaveQutoaArray=[[NSMutableArray alloc]init];
    self.totalQuotaArray=[[NSMutableArray alloc]init];
    
    NSMutableArray *leaveDetailsArray = [employeedictdetails objectForKey:@"leave"];
    for (int i=0; i<leaveDetailsArray.count; i++) {
        NSMutableDictionary *leaveDict=[leaveDetailsArray objectAtIndex:i];
        [self.leaveQutoaArray addObject:[leaveDict objectForKey:@"leave_abbrv"]];
        [self.totalQuotaArray addObject:[leaveDict objectForKey:@"leave_max_quota_of_year"]];
    }
    

    
    self.numberArray=[[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10", nil];
    self.leaveArray=[[NSMutableArray alloc] initWithObjects:@"Sick Leave",@"Sick Leave",@"Annual Leave",@"SickLeave",@"Annual Leave",@"Sick Leave",@"Sick Leave",@"Annual Leave",@"SickLeave",@"Annual Leave", nil];
    self.statusArray=[[NSMutableArray alloc] initWithObjects:@"Pending",@"Approved",@"Denied",@"Pending",@"Approved",@"Pending",@"Approved",@"Denied",@"Pending",@"Approved", nil];
    self.enddateArray=[[NSMutableArray alloc] initWithObjects:@"12/05/2015",@"22/05/2015",@"",@"25/06/2015",@"06/07/2015",@"12/05/2015",@"22/05/2015",@"",@"25/06/2015",@"06/07/2015", nil];
    self.startDateArray=[[NSMutableArray alloc] initWithObjects:@"11/05/2015",@"21/05/2015",@"",@"14/06/2015",@"04/07/2015",@"11/05/2015",@"21/05/2015",@"",@"14/06/2015",@"04/07/2015", nil];
    self.durationArray=[[NSMutableArray alloc] initWithObjects:@"1",@"1",@"",@"1",@"2",@"1",@"1",@"",@"1",@"2", nil];
    self.rejoiningArray=[[NSMutableArray alloc] initWithObjects:@"2 Week(s)&2 Day(s)",@"1 Week(s)&2 Day(s)",@"",@"2 Week(s)&1 Day(s)",@"2 Week(s)&2 Day(s)",@"2 Week(s)&2 Day(s)",@"1 Week(s)&2 Day(s)",@"",@"2 Week(s)&1 Day(s)",@"2 Week(s)&2 Day(s)", nil];
    self.reasonArray=[[NSMutableArray alloc] initWithObjects:@"Fever",@"Family Emergency",@"Vacation to home town",@"Fever",@"Fever",@"Fever",@"Family Emergency",@"Vacation to home town",@"Fever",@"Fever", nil];
    
    
    [self.leaveCollectionView registerNib:[UINib nibWithNibName:@"leaveCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"leaveCell"];
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return numberArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    leavecellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"leavecell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.numberLabel.text=[self.numberArray objectAtIndex:indexPath.row];
    cell.leaveLabel.text=[self.leaveArray objectAtIndex:indexPath.row];
    cell.statusLabel.text=[self.statusArray objectAtIndex:indexPath.row];
    cell.startLabel.text=[self.startDateArray objectAtIndex:indexPath.row];
    cell.endLabel.text=[self.enddateArray objectAtIndex:indexPath.row];
    cell.durationLabel.text=[self.durationArray objectAtIndex:indexPath.row];
    cell.rejoiningLabel.text=[self.rejoiningArray objectAtIndex:indexPath.row];
    cell.reasonLabel.text=[self.reasonArray objectAtIndex:indexPath.row];
    if (indexPath.row%2==0) {
        cell.backImg.image=[UIImage imageNamed:@"blwue_rectangle.png"];
    }
    else
        cell.backImg.image=[UIImage imageNamed:@"whwite_rectangle.png"];
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.leaveQutoaArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    leaveCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"leaveCell" forIndexPath:indexPath];
    cell.leaveNameLabel.text=[self.leaveQutoaArray objectAtIndex:indexPath.row];
    cell.totalQuotaLabel.text=[self.totalQuotaArray objectAtIndex:indexPath.row];
    return cell;
}

//- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
//{
//      UICollectionView *slaveTable = nil;
//      UICollectionView *slaveTable1 = nil;
//      UICollectionView *slaveTable2 = nil;
//      UICollectionView *slaveTable3 = nil;
//      UICollectionView *slaveTable4 = nil;
//      UICollectionView *slaveTable5 = nil;
//    
//    if (self.mycollectionview == scrollView)              {
//        
//        slaveTable = self.firstquotacollectionview;
//        slaveTable1 = self.secondquotacollectionview;
//        slaveTable2 = self.thirdquotacollectionview;
//        slaveTable3 = self.fourthquotacollectionview;
//        slaveTable4 = self.fifthquotacollectionview;
//        slaveTable5 = self.sixthquotacollectionview;
//        
//    }
//    
//    else if (self.firstquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.secondquotacollectionview;
//        slaveTable2 = self.thirdquotacollectionview;
//        slaveTable3 = self.fourthquotacollectionview;
//        slaveTable4 = self.fifthquotacollectionview;
//        slaveTable5 = self.sixthquotacollectionview;
//        
//    }
//    
//    else if (self.secondquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.firstquotacollectionview;
//        slaveTable2 = self.thirdquotacollectionview;
//        slaveTable3 = self.fourthquotacollectionview;
//        slaveTable4 = self.fifthquotacollectionview;
//        
//    }
//    
//    else if (self.thirdquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.firstquotacollectionview;
//        slaveTable2 = self.secondquotacollectionview;
//        slaveTable3 = self.fourthquotacollectionview;
//        slaveTable4 = self.fifthquotacollectionview;
//        slaveTable5 = self.sixthquotacollectionview;
//        
//    }
//    
//    else if (self.fourthquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.firstquotacollectionview;
//        slaveTable2 = self.secondquotacollectionview;
//        slaveTable3 = self.thirdquotacollectionview;
//        slaveTable4 = self.fifthquotacollectionview;
//        slaveTable5 = self.sixthquotacollectionview;
//        
//    }
//    
//    else if (self.fifthquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.firstquotacollectionview;
//        slaveTable2 = self.secondquotacollectionview;
//        slaveTable3 = self.thirdquotacollectionview;
//        slaveTable4 = self.fourthquotacollectionview;
//        slaveTable5 = self.sixthquotacollectionview;
//        
//    }
//    
//    else if (self.sixthquotacollectionview == scrollView) {
//        
//        slaveTable = self.mycollectionview;
//        slaveTable1 = self.firstquotacollectionview;
//        slaveTable2 = self.secondquotacollectionview;
//        slaveTable3 = self.thirdquotacollectionview;
//        slaveTable4 = self.fourthquotacollectionview;
//        slaveTable5 = self.fifthquotacollectionview;
//        
//    }
//
//     [slaveTable setContentOffset:scrollView.contentOffset];
//     [slaveTable1 setContentOffset:scrollView.contentOffset];
//     [slaveTable2 setContentOffset:scrollView.contentOffset];
//     [slaveTable3 setContentOffset:scrollView.contentOffset];
//     [slaveTable4 setContentOffset:scrollView.contentOffset];
//     [slaveTable5 setContentOffset:scrollView.contentOffset];
//    
//}


@end
