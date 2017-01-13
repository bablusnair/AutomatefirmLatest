//
//  delegateViewClass.m
//  
//
//  Created by leonine on 10/8/15.
//
//

#import "delegateViewClass.h"
#import "delegateCollectionViewCell.h"
#import "rulesTableViewCell.h"
@implementation delegateViewClass

-(void)awakeFromNib
{
     [ self.delegateCollectionView registerNib:[UINib nibWithNibName:@"delegateCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"delegateCell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    delegateCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"delegateCell" forIndexPath:indexPath];
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    rulesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"rulesTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    return cell;
}
-(IBAction)addNewDelegateAction:(id)sender
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addNewDelegateView" owner:self options:Nil];
    [self addSubview:[nib objectAtIndex:0]];
}
@end
