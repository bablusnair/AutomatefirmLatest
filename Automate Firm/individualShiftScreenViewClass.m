//
//  individualShiftScreenViewClass.m
//  Automate Firm
//
//  Created by leonine on 04/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "individualShiftScreenViewClass.h"
#import "cellForShifttableView.h"
#import "cellForShiftCalender.h"
#import "CellForShiftScrollingCell.h"
#import "shiftemployeeNameTableViewCell.h"

@implementation individualShiftScreenViewClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    [self.calenderCollection registerNib:[UINib nibWithNibName:@"cellForShiftCalender" bundle:nil]
            forCellWithReuseIdentifier:@"calenderCell"];
    //cellForShifttableView *cell = (cellForShifttableView *)[tableView dequeueReusableCellWithIdentifier:@"shiftTableCell"];
    self.scrollTableAray=[[NSMutableArray alloc]initWithObjects:@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png",@"nill.png",@"dayicon_1_orange.png",@"sunicon_2__Green.png",@"nighticon_3_blue.png", nil];
    self.daysArray=[[NSMutableArray alloc]initWithObjects:@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN",@"MON",@"TUE",@"WED",@"THU",@"FRI",@"SAT",@"SUN",@"FRI",@"SAT",@"SUN", nil];

    self.date=1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  35;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.nameTableView) {
        shiftemployeeNameTableViewCell *cell=(shiftemployeeNameTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"nameTableCell"];
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"shiftemployeeNameTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        if (indexPath.row%2) {
            cell.tableRowImag.image=[UIImage imageNamed:@"gray_bk.png"];
        }
        else
        {
            cell.tableRowImag.image=[UIImage imageNamed:@"tableBorder-(1).png"];

        }
        
        return cell;
        
        }
    else
    {
    cellForShifttableView *cell = (cellForShifttableView *)[tableView dequeueReusableCellWithIdentifier:@"shiftTableCell"];
    if (cell == nil)
    {
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%ld",indexPath.row] forKey:@"row"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"cellForShifttableView" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.scrollCollection.dataSource=self;
    cell.scrollCollection.delegate=self;
    return cell;
    }
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 60;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView==self.calenderCollection) {
        
    
    cellForShiftCalender *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"calenderCell" forIndexPath:indexPath];
        cell.dateLabel.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.dayLabel.text=self.daysArray[indexPath.row];
    return cell;
        
    }
    else{
        
        CellForShiftScrollingCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"scrollCell" forIndexPath:indexPath];
        cell.dayImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",self.scrollTableAray[indexPath.row]]];
        NSInteger row =[[[NSUserDefaults standardUserDefaults] objectForKey:@"row"]integerValue];
        if (row%2) {
            
            cell.brderImage.image=[UIImage imageNamed:@"gray_bk.png"];
        }
        else
        {
            cell.brderImage.image=[UIImage imageNamed:@"tableBorder-(1).png"];
            
        }
        return  cell;
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.nameTableView) {
        self.shiftDetailsTableView.contentOffset = scrollView.contentOffset;
    } else {
        self.nameTableView.contentOffset = scrollView.contentOffset;
    }
}

- (IBAction)teamSelectionAction:(id)sender {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"shiftTeamView" owner:self options:Nil];
        UIView *myview=[myviewarray objectAtIndex:0];
        myview.frame=CGRectMake(0,37, self.frame.size.width,581);
        [self addSubview:myview];
    });
    
}

- (IBAction)teamdetailsViewAction:(id)sender {
    dispatch_async(dispatch_get_main_queue(), ^{
//        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"teamShiftAllocationScreen" owner:self options:Nil];
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"teamAllocationScreen2View" owner:self options:Nil];
        UIView *myview=[myviewarray objectAtIndex:0];
       // myview.frame=CGRectMake(0,37, self.frame.size.width,581);
        [self addSubview:myview];
    });

}
@end
