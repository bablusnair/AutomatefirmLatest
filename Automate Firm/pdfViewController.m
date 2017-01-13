//
//  pdfViewController.m
//  Automate Firm
//
//  Created by leonine on 12/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "pdfViewController.h"
#import "pdfCollectionViewCell.h"

@interface pdfViewController ()

@end

@implementation pdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.pdfLoadCollection registerNib:[UINib nibWithNibName:@"pdfCollectionViewCell" bundle:nil]
               forCellWithReuseIdentifier:@"pdfCell"];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    pdfCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"pdfCell" forIndexPath:indexPath];
    cell.pageNuber.text=[NSString stringWithFormat:@"%ld",indexPath.row+1];
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint initialPinchPoint = CGPointMake(self.pdfLoadCollection.center.x + self.pdfLoadCollection.contentOffset.x,
                                    self.pdfLoadCollection.center.y + self.pdfLoadCollection.contentOffset.y);
    NSIndexPath *tappedCellPath = [self.pdfLoadCollection indexPathForItemAtPoint:initialPinchPoint];
    if (!(tappedCellPath.row==0)) {
        self.previousButton.hidden=false;
    }
    else{
        self.previousButton.hidden=true;
 
    }
    if (!(tappedCellPath.row==7)) {
        self.nextButton.hidden=false;
    }
    else{
        self.nextButton.hidden=true;
        
    }
}
- (IBAction)previousPageAction:(id)sender {
    
    NSArray *visibleItems = [self.pdfLoadCollection indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    if (!(currentItem.row==0)) {
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item - 1 inSection:currentItem.section];
        [self.pdfLoadCollection scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
   }
- (IBAction)nextPageAction:(id)sender {
    NSArray *visibleItems = [self.pdfLoadCollection indexPathsForVisibleItems];
    NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
    NSIndexPath *nextItem = [NSIndexPath indexPathForItem:currentItem.item + 1 inSection:currentItem.section];
    if (!(nextItem.row==8)) {
        [self.pdfLoadCollection scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    }
    self.previousButton.hidden=false;
}

- (IBAction)pdfViewCloseAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
