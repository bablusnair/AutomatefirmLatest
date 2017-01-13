//
//  addnewdesignations.m
//  Automate Firm
//
//  Created by leonine on 17/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "addnewdesignations.h"
#import "adddesignationtablecellclass.h"
@implementation addnewdesignations


- (void)drawRect:(CGRect)rect {
    
    
    self.frame=CGRectMake(30, 50, self.frame.size.width, self.frame.size.height);
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
    
    
    [ self.designationcollectionview registerNib:[UINib nibWithNibName:@"adddesignationtablecell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    self.designationnamearray=[[NSMutableArray alloc] initWithObjects:@"Designation 1",@"Designation 2",@"Designation 3",@"Designation 4",@"Designation 5",@"Designation 6",@"Designation 7",@"Designation 8",@"Designation 9",@"Designation 10",@"Designation 11",@"Designation 12",@"Designation 13",@"Designation 14",@"Designation 15",@"Designation 16",@"Designation 1",@"Designation 2",@"Designation 3",@"Designation 4",@"Designation 5",@"Designation 6",@"Designation 7",@"Designation 8",@"Designation 9",@"Designation 10",@"Designation 11",@"Designation 12",@"Designation 13",@"Designation 14",@"Designation 15",@"Designation 16", Nil];
    
    self.selectedarray=[[NSMutableArray alloc] init];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return [self.designationnamearray count];
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    adddesignationtablecellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    
    if([self.selectedarray containsObject:indexPath]) {
        
        [cell.checkbutton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
     
    }
    
    
    else {
        
        [cell.checkbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
       
    }
    
    cell.designationname.text=[self.designationnamearray objectAtIndex:indexPath.row];
   
    return cell;
    
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    adddesignationtablecellclass *cell1 = (adddesignationtablecellclass *)[self.designationcollectionview cellForItemAtIndexPath:indexPath];
    
    
    if ([cell1.checkbutton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        [self.selectedarray addObject:indexPath];

        
    }
    
    else {
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        [self.selectedarray removeObject:indexPath];
       
        
    }
    
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell1.selectedBackgroundView = v;
    
}

-(IBAction)donebuttonaction:(id)sender
{
    [self removeFromSuperview];
    
}

@end
