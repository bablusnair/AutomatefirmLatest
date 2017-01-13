//
//  advanceInnerViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface advanceInnerViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    AppDelegate *app;
}
-(IBAction)includeDesignationAction:(id)sender;
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionview;
@property(nonatomic,retain)IBOutlet UIView *popUpView;
@property(nonatomic,retain)IBOutlet UITableView *popupTableView;
@property(nonatomic,retain)NSMutableArray *popupArray;

@property(nonatomic,retain)NSMutableArray *grouparray;
@property(nonatomic,retain)NSIndexPath *indexpath;
-(void)collectionViewReload:(NSMutableArray *)desigArray;
-(void)assignDesignation:(NSMutableArray *)desigArray;
-(void)specificEmployee:(NSMutableArray *)selectedEmployee : (NSData *)selectedEmployeeIcon;
-(IBAction)saveButtonAction:(id)sender;


-(IBAction)button1Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button1;

-(IBAction)button2Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button2;

-(IBAction)button3Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button3;

-(IBAction)button4Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button4;

-(IBAction)button5Action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *button5;

@property(nonatomic,retain)IBOutlet UIImageView *arrowImage1;
@property(nonatomic,retain)IBOutlet UIImageView *arrowImage2;
@property(nonatomic,retain)IBOutlet UIImageView *arrowImage3;
@property(nonatomic,retain)IBOutlet UIImageView *arrowImage4;

@property(nonatomic,retain)IBOutlet UITextField *descriptionText;

@property(nonatomic,assign)int buttonFlag;

@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
@property(nonatomic,assign)int z;
@property(nonatomic,assign)int p;
@property(nonatomic,assign)int q;

@property(nonatomic,retain)NSMutableDictionary *finalDict;

@end
