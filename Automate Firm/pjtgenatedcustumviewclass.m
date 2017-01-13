//
//  pjtgenatedcustumviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 13/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "pjtgenatedcustumviewclass.h"
#import "pjtgeneratecolleioncellclass.h"
@implementation pjtgenatedcustumviewclass
@synthesize selectedarray,k;

- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(185, 160, self.frame.size.width, self.frame.size.height);

}

-(void)awakeFromNib
{
    [ self.mycollectinview registerNib:[UINib nibWithNibName:@"pjtgeneratecollectioncell" bundle:nil] forCellWithReuseIdentifier:@"pjtgencell"];
    self.stamparray=[[NSMutableArray alloc] initWithObjects:@"important-290x100_1.jpg",@"RejectedStamp.jpg",@"urgent-stamp-md.png",@"receivednew.jpeg",@"Merlin2525-Paid-Business-Stamp-1.png",@"overdue.png",@"final_notice_stamp.png",@"expired.png",@"newconfident.jpeg",@"copy2.jpg",@"cancelled.png",@"approved-stamp-round-red.png",@"confidential5.png",@"copy2.jpg",@"cancelled.png",@"approved-stamp-round-red.png",nil];
    
    self.stampnamearray=[[NSMutableArray alloc] initWithObjects:@"Important",@"Rejected",@"Urgent",@"Recevied",@"Copy",@"Over due",@"Final Notice",@"Expired",@"Confidential",@"Copy",@"Cancelled",@"Approved",@"Confidential",@"Copy",@"Cancelled",@"Approved",nil];
    self.selectedarray=[[NSMutableArray alloc]init];

}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.stamparray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    pjtgeneratecolleioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pjtgencell" forIndexPath:indexPath];
    
    
    if([self.selectedarray containsObject:indexPath]) {
        
        [cell.radiobutton setImage:[UIImage imageNamed:@"Selectgeraete.png"] forState:UIControlStateNormal];
        
        
    }
    else {
        
        [cell.radiobutton setImage:[UIImage imageNamed:@"Select_Notgerate.png"] forState:UIControlStateNormal];
    }
    

    cell.myimgview.image=[UIImage imageNamed:[self.stamparray objectAtIndex:indexPath.row]];
    
    cell.mylabelname.text=[self.stampnamearray objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    pjtgeneratecolleioncellclass *cell= (pjtgeneratecolleioncellclass *) [self.mycollectinview cellForItemAtIndexPath:k];
    [cell.radiobutton setImage:[UIImage imageNamed:@"Select_Notgerate.png"] forState:UIControlStateNormal];
    
    [self.selectedarray removeAllObjects];
    
    pjtgeneratecolleioncellclass *cell1= (pjtgeneratecolleioncellclass *) [self.mycollectinview cellForItemAtIndexPath:indexPath];
    
    if ([cell1.radiobutton.currentImage isEqual:[UIImage imageNamed:@"Select_Notgerate.png"]]) {
        
        [cell1.radiobutton setImage:[UIImage imageNamed:@"Selectgeraete.png"] forState:UIControlStateNormal];
        [self.selectedarray addObject:indexPath];
        
        
    }
    else {
        
        [cell1.radiobutton setImage:[UIImage imageNamed:@"Select_Notgerate.png"] forState:UIControlStateNormal];
        [self.selectedarray removeObject:indexPath];
        
    }
    k=indexPath;
    [self.mycollectinview deselectItemAtIndexPath:indexPath animated:YES];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell1.selectedBackgroundView = v;
    

}
-(IBAction)closeButton:(id)sender
{
    [self removeFromSuperview];
     
}

@end
