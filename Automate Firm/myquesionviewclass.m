//
//  myquesionviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 18/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "myquesionviewclass.h"
#import "questioncollecionclasscellCollectionViewCell.h"
@implementation myquesionviewclass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)awakeFromNib {
    
    self.mycollectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(170.0,150.0);
    [self.mycollectionView setCollectionViewLayout:flowLayout];
   flowLayout.minimumInteritemSpacing = 10;
    flowLayout.minimumLineSpacing = 16;
    // Register the collection cell
    [ self.mycollectionView registerNib:[UINib nibWithNibName:@"questioncollecioncell" bundle:nil] forCellWithReuseIdentifier:@"questioncell"];
    self.imgarray=[[NSMutableArray alloc]initWithObjects:@"category.png", @"category.png", @"category.png", @"category.png", @"category.png",@"category.png", @"category.png", @"category.png", @"category.png",@"category.png", @"category.png", @"category.png",  nil];
}

/*- (void)setCollectionData:(NSArray *)data {
    self.mycollectionData1 = data;
    [ self.mycollectionView setContentOffset:CGPointZero animated:NO];
    [ self.mycollectionView reloadData];
}*/

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imgarray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    questioncollecionclasscellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"questioncell" forIndexPath:indexPath];
    cell.myimg.image=[UIImage imageNamed:[self.imgarray objectAtIndex:indexPath.row]];
    return cell;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UIView *myviews=self.superview.superview.superview.superview.superview;
    
    NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"questionscrollview" owner:self options:Nil];
    UIView *myviews2=[myviewarray objectAtIndex:0];
    [myviews addSubview:myviews2];
    
}

@end
