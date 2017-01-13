//
//  officelistviewclass.m
//  Automate Firm
//
//  Created by leonine on 1/7/17.
//  Copyright © 2017 leonine. All rights reserved.
//

#import "officelistviewclass.h"
#import "officeCell.h"

@interface officelistviewclass ()
@end
@implementation officelistviewclass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
   return 11;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    officeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MYCell" forIndexPath:indexPath];
    
    if (indexPath.row==10) {
        
        cell.officelogoimgview.image=[UIImage imageNamed:@"addvffv.png"];
    }
    else
    {
        cell.officelogoimgview.image=[UIImage imageNamed:@"imghhh.png"];
        
    }
   
    return cell;
}

@end
