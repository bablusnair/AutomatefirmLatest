//
//  businessThemeClass.m
//  Automate Firm
//
//  Created by leonine on 7/27/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "businessThemeClass.h"
#import "businessThemeCollectionViewCell.h"

@implementation businessThemeClass

-(void)awakeFromNib
{
    [self.themeCollectionView registerNib:[UINib nibWithNibName:@"businessThemeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"themeView"];
    
    self.formArray=[[NSMutableArray alloc]initWithObjects:@"form5.png", nil];
    self.idFrontArray=[[NSMutableArray alloc]initWithObjects:@"red_frnt.png", nil];
    self.idBackArray=[[NSMutableArray alloc]initWithObjects:@"red_bk.png", nil];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  self.formArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    businessThemeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"themeView" forIndexPath:indexPath];
    //if ([self.selectedIndex isEqual:indexPath ]) {
        [cell.checkButton setImage:[UIImage imageNamed:@"check_box.png32.png"] forState:UIControlStateNormal];
        for (UIView *view in cell.contentView.subviews) {
            view.userInteractionEnabled=YES;
        }
   // }
//    else
//    {
//        
//        [cell.checkButton setImage:[UIImage imageNamed:@"checkbox.png23.png"] forState:UIControlStateNormal];
//        for (UIView *view in cell.contentView.subviews) {
//            if ([view isKindOfClass:[UIButton class]]) {
//                if (view.tag==50) {
//                    [view setUserInteractionEnabled:YES];
//                }
//                else
//                {
//                    [view setUserInteractionEnabled:NO];
//                }
//            }
//            else
//            {
//                view.userInteractionEnabled=NO;
//            }
//        }
//    }
    cell.formImage.image=[UIImage imageNamed:[self.formArray objectAtIndex:indexPath.row]];
    cell.idFrontImage.image=[UIImage imageNamed:[self.idFrontArray objectAtIndex:indexPath.row]];
    cell.idBackImage.image=[UIImage imageNamed:[self.idBackArray objectAtIndex:indexPath.row]];
    return cell;
}
-(IBAction)colorChangeAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    businessThemeCollectionViewCell *cell=(businessThemeCollectionViewCell *)[[sender superview]superview];
    NSIndexPath *inPath=[self.themeCollectionView indexPathForCell:cell];
    
    if (button.tag==1) {
        cell.redButton.layer.borderWidth = 3.0;
        cell.redButton.layer.borderColor = [UIColor greenColor].CGColor;
        cell.greyButton.layer.borderWidth = 0.0;
        cell.greyButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.greenButton.layer.borderWidth = 0.0;
        cell.greenButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.blueButton.layer.borderWidth = 0.0;
        cell.blueButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.brownButton.layer.borderWidth = 0.0;
        cell.brownButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.formImage.image=[UIImage imageNamed:@"form5.png"];
        cell.idFrontImage.image=[UIImage imageNamed:@"red_frnt.png"];
        cell.idBackImage.image=[UIImage imageNamed:@"red_bk.png"];
        cell.themeNameLabel.text=@"AF Pride";
    }
    else if (button.tag==2)
    {
        cell.greenButton.layer.borderWidth = 3.0;
        cell.greenButton.layer.borderColor = [UIColor greenColor].CGColor;
        cell.redButton.layer.borderWidth = 0.0;
        cell.redButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.greyButton.layer.borderWidth = 0.0;
        cell.greyButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.blueButton.layer.borderWidth = 0.0;
        cell.blueButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.brownButton.layer.borderWidth = 0.0;
        cell.brownButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.formImage.image=[UIImage imageNamed:@"form4.png"];
        cell.idFrontImage.image=[UIImage imageNamed:@"green_frnt.png"];
        cell.idBackImage.image=[UIImage imageNamed:@"green_bk.png"];
        cell.themeNameLabel.text=@"AF Leaf";

    }
    else if (button.tag==3)
    {
        cell.greenButton.layer.borderWidth = 0.0;
        cell.greenButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.redButton.layer.borderWidth = 0.0;
        cell.redButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.blueButton.layer.borderWidth = 0.0;
        cell.blueButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.brownButton.layer.borderWidth = 0.0;
        cell.brownButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.greyButton.layer.borderWidth = 3.0;
        cell.greyButton.layer.borderColor = [UIColor greenColor].CGColor;
        cell.formImage.image=[UIImage imageNamed:@"form2.png"];
        cell.idFrontImage.image=[UIImage imageNamed:@"gray_frnt.png"];
        cell.idBackImage.image=[UIImage imageNamed:@"gray_bk.png"];
        cell.themeNameLabel.text=@"AF Code";

    }
    else if (button.tag==4)
    {
        cell.greenButton.layer.borderWidth = 0.0;
        cell.greenButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.redButton.layer.borderWidth = 0.0;
        cell.redButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.brownButton.layer.borderWidth = 0.0;
        cell.brownButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.greyButton.layer.borderWidth = 0.0;
        cell.greyButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.blueButton.layer.borderWidth = 3.0;
        cell.blueButton.layer.borderColor = [UIColor greenColor].CGColor;
        cell.formImage.image=[UIImage imageNamed:@"form1.png"];
        cell.idFrontImage.image=[UIImage imageNamed:@"id_front.png"];
        cell.idBackImage.image=[UIImage imageNamed:@"blue_bk.png"];
        cell.themeNameLabel.text=@"AF Mist";
    }
    else if (button.tag==5)
    {
        cell.brownButton.layer.borderWidth = 3.0;
        cell.brownButton.layer.borderColor = [UIColor greenColor].CGColor;
        cell.greenButton.layer.borderWidth = 0.0;
        cell.greenButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.redButton.layer.borderWidth = 0.0;
        cell.redButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.greyButton.layer.borderWidth = 0.0;
        cell.greyButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.blueButton.layer.borderWidth = 0.0;
        cell.blueButton.layer.borderColor = [UIColor clearColor].CGColor;
        cell.formImage.image=[UIImage imageNamed:@"form3.png"];
        cell.idFrontImage.image=[UIImage imageNamed:@"bl_frnt.png"];
        cell.idBackImage.image=[UIImage imageNamed:@"bl_bk.png"];
        cell.themeNameLabel.text=@"AF Clay";
    }
}

-(IBAction)checkBoxAction:(id)sender
{
//    businessThemeCollectionViewCell *cell=(businessThemeCollectionViewCell *)[[sender superview]superview];
//    NSIndexPath *inPath=[self.themeCollectionView indexPathForCell:cell];
//    self.selectedIndex=inPath;
//    [self.themeCollectionView reloadData];
}

-(IBAction)done:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancel:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableGeneralSettings" object:Nil];
    [self removeFromSuperview];                          
}
@end
