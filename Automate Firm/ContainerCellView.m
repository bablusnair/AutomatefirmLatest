//
//  ContainerCellView.m
//  sometesting
//
//  Created by Emvigo on 21/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "ContainerCellView.h"
#import "ArticleCollectionViewCell.h"


@implementation ContainerCellView
@synthesize mycollectionData1,mycollectionView;

- (void)awakeFromNib {
  
    self.mycollectionView.backgroundColor = [UIColor whiteColor];
UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
 flowLayout.itemSize = CGSizeMake(140.0,143.0);
[self.mycollectionView setCollectionViewLayout:flowLayout];
  
    // Register the collection cell
  [ self.mycollectionView registerNib:[UINib nibWithNibName:@"mycollectionview" bundle:nil] forCellWithReuseIdentifier:@"ArticleCollectionViewCell"];
    self.imgarray=[[NSMutableArray alloc]initWithObjects:@"img 1.png", @"img 2.png", @"img 3.png", @"img 4.png", @"img 5.png",@"img 1.png", @"img 2.png", @"img 3.png", @"img 4.png",@"img 2.png", @"img 3.png", @"img 4.png",  nil];
}
- (void)setCollectionData:(NSArray *)data {
    self.mycollectionData1 = data;
    [ self.mycollectionView setContentOffset:CGPointZero animated:NO];
    [ self.mycollectionView reloadData];
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.mycollectionData1 count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ArticleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCollectionViewCell" forIndexPath:indexPath];
    NSDictionary *cellData = [self.mycollectionData1 objectAtIndex:[indexPath row]];
    cell.mylabel.text = [cellData objectForKey:@"emp_name"];
    [cell.presentbutton setImage:[UIImage imageNamed:@"present_icon (1).png"] forState:UIControlStateNormal];
    
    
   cell.myimg.layer.borderWidth = 1.0;
   cell.myimg.layer.borderColor = [UIColor grayColor].CGColor;
    
    if ([[cellData objectForKey:@"emp_encode_image"]isEqualToString:@""]){
        
        
        cell.myimg.image=[UIImage imageNamed:@"img 1.png"];
        
    }
    else
    {
        
      
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[cellData objectForKey:@"emp_encode_image"] options:0];
        
        cell.myimg.image=[UIImage imageWithData:decodedData];
    
    }

    
    cell.mylabel2.text=[cellData objectForKey:@"designation_title"];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSDictionary *cellData = [self.mycollectionData1 objectAtIndex:[indexPath row]];
    NSLog(@"%@",[cellData objectForKey:@"emp_id"]);

    
    [[NSUserDefaults standardUserDefaults] setObject:[cellData objectForKey:@"emp_id"] forKey:@"employeeIndividualid"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"employeeIndividualid"]);
    
    UIView *myviews=self.superview.superview.superview.superview.superview.superview.superview;
    NSLog(@"%@",myviews);
    NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"employeeindividualview" owner:self options:Nil];
    UIView *myviews2=[myviewarray objectAtIndex:0];
    [myviews addSubview:myviews2];
    
    
}


@end
