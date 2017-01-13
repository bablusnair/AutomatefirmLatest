//
//  timecardindividualpopupviewclass.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 19/05/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface timecardindividualpopupviewclass : UIView<UICollectionViewDelegate,UICollectionViewDataSource>
-(IBAction)closebuttonaction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *morningbutton;
@property(nonatomic,retain)IBOutlet UIButton *swingbutton;
@property(nonatomic,retain)IBOutlet UIButton *nightbutton;
-(IBAction)changeshiftbuttonactions:(id)sender;

@property(nonatomic,retain)IBOutlet UIImageView *myimgview;


-(IBAction)editbuttonaction:(id)sender;

@property(nonatomic,retain)IBOutlet UIButton *presentbutton;
@property(nonatomic,retain)IBOutlet UIButton *absentbutton;

@property(nonatomic,retain)IBOutlet UILabel *presentlabel;
@property(nonatomic,retain)IBOutlet UILabel *absentlabel;

@property(nonatomic,assign)int x;
@property(nonatomic,retain)IBOutlet UIButton *editbutton;

@property(nonatomic,retain)IBOutlet UICollectionView *mycollcetionview;

@property(nonatomic,retain)IBOutlet UIView *subview;
@end
