//
//  attendancehomeviewclass.m
//  Automate Firm
//
//  Created by leonine on 28/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import "attendancehomeviewclass.h"
#import "employeeattendancetablecellclass.h"
#import "timecardcollcellview.h"
#import "timecardtableviewclass.h"
#import "timecardovertimecellview.h"
#import "timeCardScrollTableCell.h"
#import "CollectionViewCellForTimeCard.h"
#import "secondRowCollectionViewCell.h"
@implementation attendancehomeviewclass

- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"timecardcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.numarray=[[NSMutableArray alloc]init];
    for (int i=1; i<32; i++) {
        
        
        if (i<10) {
            
            [self.numarray addObject:[NSString stringWithFormat:@"0%i",i]];
        }
        else
        {
        
        [self.numarray addObject:[NSString stringWithFormat:@"%i",i]];
            
        }
        
    }
    
    
    
    self.daysarray=[[NSMutableArray alloc]initWithObjects:@"    MONDAY",@"    TUESDAY",@" WEDNESDAY",@"   THURSDAY",@"       FRIDAY",@"    SATURDAY",@"     SUNDAY",@"    MONDAY",@"    TUESDAY",@" WEDNESDAY",@"   THURSDAY",@"       FRIDAY",@"    SATURDAY",@"     SUNDAY",@"    MONDAY",@"    TUESDAY",@" WEDNESDAY",@"   THURSDAY",@"       FRIDAY",@"    SATURDAY",@"     SUNDAY",@"    MONDAY",@"    TUESDAY",@" WEDNESDAY",@"   THURSDAY",@"       FRIDAY",@"    SATURDAY",@"     SUNDAY",@"    MONDAY",@"    TUESDAY",@"  WEDNESDAY", nil];
    
    self.overtimeflag=0;
    
     self.setflag=0;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.mytableview1) {
        
        return 40;
    }
    
    else
    {
        
        return 40;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.mytableview1) {
        
        
        static NSString *simpleTableIdentifier = @"simplecell";
        employeeattendancetablecellclass *cell = (employeeattendancetablecellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"employeetimecardnamecell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        if (indexPath.row%2) {
            
            cell.firstimgview.image=[UIImage imageNamed:@"john_louis_box.png"];
            cell.secondimgview.image=[UIImage imageNamed:@"15hours_box.png"];

        }
        else
        {
            
            cell.firstimgview.image=[UIImage imageNamed:@"john_louis_box_white.png"];
            cell.secondimgview.image=[UIImage imageNamed:@"15hours_box_white.png"];
        }
        
        return cell;

    }
    
    else
    {
        static NSString *simpleTableIdentifier = @"simplecell";
        timeCardScrollTableCell *cell = (timeCardScrollTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        if (cell == nil)
        {
           // if (indexPath.row%2) {
             //   self.rowFlag=1;
            
            [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%ld",(long)indexPath.row] forKey:@"rowpathalues"];
            

            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timeCardScrollTableCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
                cell.TimecardCollection.dataSource=self;
                cell.TimecardCollection.delegate=self;
            
            NSLog(@"%li",(long)indexPath.row);
            
            
            
            //}
//            else{
//                self.rowFlag=2;
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timeCrdSecondCell" owner:self options:nil];
//                cell = [nib objectAtIndex:0];
//                cell.timecardCollection2.dataSource=self;
//                cell.timecardCollection2.dataSource=self;
//            }q    
        }
       
        return  cell;
    }
}






//
//        if (self.overtimeflag==0)
//        {
//            static NSString *simpleTableIdentifier = @"simplecell2";
//            timecardtableviewclass *cell = (timecardtableviewclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//            
//            if (cell == nil)
//            {
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timecardtablecellview" owner:self options:nil];
//                cell = [nib objectAtIndex:0];
//                
//            }
//            if (indexPath.row%2) {
//                
//                
//                
//                
//                [cell.mondayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"img_2_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//            }
//            else
//            {
//                
//                // [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//            }
//            
//            
//            if (indexPath.row==4) {
//                
//                
//                //     [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview setImage:[UIImage imageNamed:@"leave11.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                //  for only design purpose
//                
//                
//                // cell.tues1.text=@"";
//                //   cell.tues2.text=@"";
//                cell.wes1.text=@"";
//                cell.wes2.text=@"";
//                //               cell.thr1.text=@"";
//                //               cell.thr2.text=@"";
//                
//                
//            }
//            
//            else  if (indexPath.row==8) {
//                
//                
//                
//                
//                [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview setImage:[UIImage imageNamed:@"absent12.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                cell.tues1.text=@"";
//                cell.tues2.text=@"";
//                
//                // cell.wes1.text=@"";
//                // cell.wes2.text=@"";
//                // cell.thr1.text=@"";
//                // cell.thr2.text=@"";
//                
//                
//            }
//            
//            else if (indexPath.row==6) {
//                
//                
//                [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview setImage:[UIImage imageNamed:@"holiday.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                cell.thr1.text=@"";
//                cell.thr2.text=@"";
//                
//                
//                
//            }
//            else
//            {
//                
//                //  for only design purpose
//                
//                cell.tues1.text=@"09:00";
//                cell.tues2.text=@"15:00";
//                cell.wes1.text=@"09:00";
//                cell.wes2.text=@"15:00";
//                cell.thr1.text=@"09:00";
//                cell.thr2.text=@"15:00";
//                
//                
//            }
//            
//            return cell;
//        }
//        else
//        {
//            
//            
//            static NSString *simpleTableIdentifier = @"simplecell";
//            timecardovertimecellview *cell = (timecardovertimecellview *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
//            
//            if (cell == nil)
//            {
//                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timecardovertimecellview" owner:self options:nil];
//                cell = [nib objectAtIndex:0];
//                
//            }
//            
//            
//            if (indexPath.row%2) {
//                
//                
//                
//                
//                [cell.mondayimgview1 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview2 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview3 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview4 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview5 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview6 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview7 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                
//                
//                
//                
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1e_white.png"] forState:UIControlStateNormal];
//                
//                
//                
//            }
//            else
//            {
//                
//                // [cell.mondayimgview setImage:[UIImage imageNamed:@"revimg_1_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                [cell.mondayimgview1 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview2 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview3 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview4 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview5 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview6 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview7 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                
//                [cell.mondayimgview8 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview9 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview10 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview11 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview12 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview13 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview14 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                
//                
//                
//                
//                [cell.mondayimgview15 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview16 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview17 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview18 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview19 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview20 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview21 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.mondayimgview22 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.tuesdayimgview23 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.wednesdayimgview24 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.thursdayimgview25 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview26 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview27 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview28 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.fridayimgview29 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.saturdayimgview30 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//                [cell.sundayimgview31 setImage:[UIImage imageNamed:@"revimg_1ed_grey.png"] forState:UIControlStateNormal];
//              }
//

            
//            
//            return cell;
//            
//            
//            
//        }
//
//            
//    }
//        
//        
//
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    

    UIView *myview =[[UIView alloc] init];
    myview.backgroundColor=[UIColor clearColor];
    timecardtableviewclass *cell1 = [self.mytableview2 cellForRowAtIndexPath:indexPath];
    cell1.selectedBackgroundView=myview;
    
    
    employeeattendancetablecellclass *cell = [self.mytableview1 cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView=myview;
    
    
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.numarray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (collectionView==self.mycollectionview) {
        
    
    
    timecardcollcellview *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    
  
        cell.dayslabel.text=[self.daysarray objectAtIndex:indexPath.row];
        cell.numberlabel.text=[self.numarray objectAtIndex:indexPath.row];
    
    
            if (indexPath.row%2) {
    
                cell.dayimgview.image=[UIImage imageNamed:@"tuesday_box.png"];
    
            }
            else
            {
                cell.dayimgview.image=[UIImage imageNamed:@"monday_box.png"];
            }

        return  cell;
    }
    
    else{
        
        //if (self.rowFlag==1) {
//
        
        CollectionViewCellForTimeCard *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"timecardScrollCell" forIndexPath:indexPath];
            
     
        return cell;

  //  }
//        else
//        {
//            CollectionViewCellForTimeCard *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"timecardSecCell" forIndexPath:indexPath];
//            return cell;
//
//        }
    }
//    if (indexPath.row==0) {
//        NSString *string = [NSString stringWithFormat:@"   %@/%@",[self.numarray objectAtIndex:indexPath.row],[self.daysarray objectAtIndex:indexPath.row]];
//        cell.dayslabel.text=string;
//    }
//    if (indexPath.row==1) {
//        NSString *string = [NSString stringWithFormat:@"  %@/%@",[self.numarray objectAtIndex:indexPath.row],[self.daysarray objectAtIndex:indexPath.row]];
//        cell.dayslabel.text=string;
//    }
//    if (indexPath.row==4) {
//        NSString *string = [NSString stringWithFormat:@"    %@/%@",[self.numarray objectAtIndex:indexPath.row],[self.daysarray objectAtIndex:indexPath.row]];
//        cell.dayslabel.text=string;
//    }
//    if (indexPath.row==6) {
//        NSString *string = [NSString stringWithFormat:@"   %@/%@",[self.numarray objectAtIndex:indexPath.row],[self.daysarray objectAtIndex:indexPath.row]];
//        cell.dayslabel.text=string;
//    }

    
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    UITableView *slaveTable = nil;
    
    if (self.mytableview1 == scrollView) {
        
        slaveTable = self.mytableview2;
        
    }
    else if (self.mytableview2 == scrollView) {
        
        slaveTable = self.mytableview1;
        
    }
    
    [slaveTable setContentOffset:scrollView.contentOffset];
    
}

-(IBAction)closebuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"timecardimage" object:Nil];
    [self removeFromSuperview];
}


-(IBAction)timecardovertime:(id)sender
{
    
    if (self.setflag%2==0) {
        
        self.overtimeflag=1;
        [self.mytableview2 reloadData];
        self.totalworkinglabel.text=@"Total Overtime";
          self.setflag++;

    }
    else
    {
        self.overtimeflag=0;
        [self.mytableview2 reloadData];
        self.totalworkinglabel.text=@"Total Working";
          self.setflag++;
    }
    
}

-(IBAction)timecardeditfuction:(id)sender
{
    
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"timecardindividualpopupview" owner:self options:nil];
    [self addSubview:[nib objectAtIndex:0]];

    
}


@end
