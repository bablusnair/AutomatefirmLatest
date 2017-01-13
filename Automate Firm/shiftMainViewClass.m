//
//  shiftMainViewClass.m
//  Automate Firm
//
//  Created by leonine on 03/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "shiftMainViewClass.h"
#import "shiftCellCollectionViewCell.h"
#import "shiftTableViewCell.h"

@implementation shiftMainViewClass

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void)awakeFromNib
{
    self.cellImageArray=[[NSMutableArray alloc]initWithObjects:@"shiftboxDay_1.png",@"shiftboxDay2.png",@"shiftboxNight3.png", nil];
    [self.shiftCellCollection registerNib:[UINib nibWithNibName:@"shiftCellCollectionViewCell" bundle:nil]
            forCellWithReuseIdentifier:@"shiftCell"];

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    shiftCellCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shiftCell" forIndexPath:indexPath];
    if (indexPath.row%2==0) {
        cell.shiftImage.image=[UIImage imageNamed:@"strip_greenbar.png"];
    }
    else{
        cell.shiftImage.image=[UIImage imageNamed:@"strip_redbar.png"];

    }
    cell.cellTableview.dataSource=self;
    cell.cellTableview.delegate=self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    dispatch_async(dispatch_get_main_queue(), ^{
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"shiftIndividualScreenView" owner:self options:Nil];
        UIView *myview=[myviewarray objectAtIndex:0];
         myview.frame=CGRectMake(0,48, self.frame.size.width,618);
        [self addSubview:myview];
    });

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   // static NSString *simpleTableIdentifier = @"SimpleTableCell";
    shiftTableViewCell *cell = (shiftTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"shiftTableCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"shiftTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.cellImage.image=[UIImage imageNamed:self.cellImageArray[indexPath.row]];
    return cell;
//
//    
}
@end
