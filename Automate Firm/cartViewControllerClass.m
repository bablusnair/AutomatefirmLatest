//
//  cartViewControllerClass.m
//  Automate Firm
//
//  Created by leonine on 25/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "cartViewControllerClass.h"
#import "cartCollectionViewCell.h"
#import "cartMainOffficeCollectionViewCell.h"
#import "cartTableCellTableViewCell.h"
#import "cartproductTableViewCell.h"


@interface cartViewControllerClass ()

@end

@implementation cartViewControllerClass

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.cartCollection registerNib:[UINib nibWithNibName:@"cartCollectionViewCell" bundle:nil]
               forCellWithReuseIdentifier:@"cartCell"];
    [self.mainOfficeCollection registerNib:[UINib nibWithNibName:@"cartMainOffficeCollectionViewCell" bundle:nil]
          forCellWithReuseIdentifier:@"mainCell"];
    self.mainOfficeAray=[[NSMutableArray alloc]initWithObjects:@"head Office",@"head Office1",@"head Office2",@"head Office3", nil];
    self.productLabelAray=[[NSMutableArray alloc]initWithObjects:@"Splash Screen",@"Biometric Attendance Machine",@"Barcode Scanner",@"Card Printer",@"Splash Screen", nil];
    self.productImageAray=[[NSMutableArray alloc]initWithObjects:@"splash.png",@"biometric.png",@"cartbarcode.png",@"card_printer.png",@"splash.png", nil];
    self.cellFlag=0;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView==self.cartCollection) {
        return  12;
    }
    else{
    return 4;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView==self.cartCollection) {
        cartCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cartCell" forIndexPath:indexPath];
        if (self.cellFlag==0) {
            cell.outLetlabel.text=@"abc";
        }
        if (self.cellFlag==1) {
            cell.outLetlabel.text=@"def";
        }
        if (self.cellFlag==2) {
            cell.outLetlabel.text=@"ghi";
        }
        if (self.cellFlag==3) {
            cell.outLetlabel.text=@"jkl";
        }
        return cell;

    }
    else{
        cartMainOffficeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
        cell.mainOficelabel.text=self.mainOfficeAray[indexPath.row];
        return cell;

    }
 }

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.productTable) {
        return self.productImageAray.count;
    }
    else{
    return 8;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.productTable) {
        cartproductTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"simpleCell"];
        if (cell==nil) {
            
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cartproductTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
            
        }
        cell.productLabel.text=self.productLabelAray[indexPath.row];
        cell.producIiconImage.image=[UIImage imageNamed:self.productImageAray[indexPath.row]];
        return  cell;
    }
    else{
    cartTableCellTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"simpleCell"];
    if (cell==nil) {
        
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"cartTableCellTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
        
    }
    return cell;
    }
}

- (IBAction)previousPageAction:(id)sender {
    
    NSArray *visibleItems = [self.mainOfficeCollection indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    if (!(currentItem.row==0)) {
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 1 inSection:currentItem.section];
        [self.mainOfficeCollection scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.cellFlag=self.cellFlag-1;
        [self.cartCollection reloadData];

    }
    
}
- (IBAction)nextPageAction:(id)sender {
    NSArray *visibleItems = [self.mainOfficeCollection indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item + 1 inSection:currentItem.section];
    if (!(nextItem.row==4)) {
        [self.mainOfficeCollection scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        self.cellFlag=self.cellFlag+1;
        [self.cartCollection reloadData];

    }
    self.previousBtn.hidden=false;
}
- (IBAction)closeAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
