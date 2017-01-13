//
//  timecardindividualpopupviewclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 19/05/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "timecardindividualpopupviewclass.h"
#import "timecardpopupcustomcell.h"
@implementation timecardindividualpopupviewclass

@synthesize x;

-(void)awakeFromNib
{
    self.frame=CGRectMake(80, 150, self.frame.size.width, self.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-400, -450, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
  [self.morningbutton setImage:[UIImage imageNamed:@"blue box.png"] forState:UIControlStateNormal];
    
  
    self.subview.hidden=TRUE;
   
    
    x=0;
    
    [self.mycollcetionview registerNib:[UINib nibWithNibName:@"timecardpopupcustomcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];

    
}
-(IBAction)closebuttonaction:(id)sender
{
    
    [self removeFromSuperview];
    
}
-(IBAction)changeshiftbuttonactions:(id)sender
{
    
    UIButton *mybutton = (UIButton *)sender;
    
    
    if (mybutton.tag==1) {
        
        [self.morningbutton setImage:[UIImage imageNamed:@"blue box.png"] forState:UIControlStateNormal];
        [self.swingbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
        [self.nightbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
    }
    else if (mybutton.tag==2)
    {
        
        
        [self.morningbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
        [self.swingbutton setImage:[UIImage imageNamed:@"blue box.png"] forState:UIControlStateNormal];
        [self.nightbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        
        [self.morningbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
        [self.swingbutton setImage:[UIImage imageNamed:@"dark blue box.png"] forState:UIControlStateNormal];
        [self.nightbutton setImage:[UIImage imageNamed:@"blue box.png"] forState:UIControlStateNormal];
        
        
    }
    
    
}

-(IBAction)editbuttonaction:(id)sender
{
    
   // self.frame=CGRectMake(80, 150, self.frame.size.width, self.frame.size.height+45);
 
  
    
    if (x%2==0) {
        
    //    self.myimgview.frame=CGRectMake(self.myimgview.frame.origin.x, self.myimgview.frame.origin.y, self.myimgview.frame.size.width,195);
        
         [self.editbutton setImage:[UIImage imageNamed:@"selectedfortimecard.png"] forState:UIControlStateNormal];
        
        self.subview.hidden=FALSE;
        
        self.frame=CGRectMake(80, 150, self.frame.size.width,350);
        x++;
    }
    else
    {
        
        
       // self.myimgview.frame=CGRectMake(self.myimgview.frame.origin.x, self.myimgview.frame.origin.y, self.myimgview.frame.size.width,195);
        
        [self.editbutton setImage:[UIImage imageNamed:@"edit_box.png"] forState:UIControlStateNormal];
        
         self.subview.hidden=TRUE;
        
        self.frame=CGRectMake(80, 150, self.frame.size.width,233);
        x++;
    }
    
    
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    timecardpopupcustomcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
      cell.myimgview.image=[UIImage imageNamed:@"img_greyout.png"];
    
    if (indexPath.row==0) {
        
         cell.myimgview.image=[UIImage imageNamed:@"img_color.png"];
    }
    if (indexPath.row==2) {
        
        cell.myimgview.image=[UIImage imageNamed:@"img_color.png"];
    }
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    timecardpopupcustomcell *cell = (timecardpopupcustomcell *)[self.mycollcetionview cellForItemAtIndexPath:indexPath];
    
   
    
    if ([cell.myimgview.image isEqual:[UIImage imageNamed:@"img_color.png"]]) {
        
         cell.myimgview.image=[UIImage imageNamed:@"img_greyout.png"];
        
    }
    else
    {
         cell.myimgview.image=[UIImage imageNamed:@"img_color.png"];
        
    }
    
    
}

@end
