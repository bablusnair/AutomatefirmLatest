//
//  settingsApplyDelegationClass.m
//  
//
//  Created by leonine on 10/10/15.
//
//

#import "settingsApplyDelegationClass.h"
#import "designationCollectionViewCell.h"
@implementation settingsApplyDelegationClass

-(void)awakeFromNib
{
    self.frame=CGRectMake(0, 10, self.frame.size.width, self.frame.size.height);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-400, -300, 1400, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    [ self.designationCollectionView registerNib:[UINib nibWithNibName:@"designationCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"designationCell"];
    
    self.selectedarray=[[NSMutableArray alloc] init];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return 20;
    
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"designationCell";
    designationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if([self.selectedarray containsObject:indexPath]) {
        
        [cell.checkButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        
        
        
    }
    else {
        [cell.checkButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
    }
    return cell;
}

- (IBAction)resentpjtcheckbutton:(id)sender
{
    designationCollectionViewCell *cell = (designationCollectionViewCell*)[[sender superview] superview];
    
    if ([cell.checkButton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
        [cell.checkButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        
        
    }
    else {
        
        [cell.checkButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        
        
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    designationCollectionViewCell *cell1= (designationCollectionViewCell *) [self.designationCollectionView cellForItemAtIndexPath:indexPath];
    
    if ([cell1.checkButton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
        [cell1.checkButton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        [self.selectedarray addObject:indexPath];
        
        
    }
    else {
        
        [cell1.checkButton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        [self.selectedarray removeObject:indexPath];
        
    }
    
    [self.designationCollectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell1.selectedBackgroundView = v;
    
    
    
}
-(IBAction)doneButtonAction:(id)sender
{
    [self removeFromSuperview];
}
@end
