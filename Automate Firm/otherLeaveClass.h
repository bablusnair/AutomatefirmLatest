//
//  otherLeaveClass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/31/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface otherLeaveClass : UIView<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)IBOutlet UILabel *leaveLabel;
@property(nonatomic,retain)IBOutlet UIButton *startRadioButton;
@property(nonatomic,retain)IBOutlet UIButton *endradioButton;
-(IBAction)halfdayButtonAction:(id)sender;
-(IBAction)halfdayButtonAction1:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;
-(IBAction)uploadDocument:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *startDate;
@property(nonatomic,retain)IBOutlet UITextField *endDate;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker1;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker2;
@property(nonatomic,retain)IBOutlet UITextField *halfDay1;
@property(nonatomic,retain)IBOutlet UITextField *halfDay2;
@property(nonatomic,retain)IBOutlet UIView *datePicker1View;
@property(nonatomic,retain)IBOutlet UIView *datePicker2View;
-(IBAction)datePicker1Action:(id)sender;
-(IBAction)datePicker2Action:(id)sender;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property(nonatomic,retain)IBOutlet UITableView *earningsTC;
@property(nonatomic,retain)IBOutlet UITableView *deductionsTC;
@property(nonatomic,retain)IBOutlet UITextField *contactTextField;


-(void)formColorSetting;
@property(nonatomic,retain)IBOutlet UIImageView *image1;
@property(nonatomic,retain)IBOutlet UIImageView *image2;
@property(nonatomic,retain)IBOutlet UIImageView *image3;
@property(nonatomic,retain)IBOutlet UIImageView *image4;
@property(nonatomic,retain)IBOutlet UIImageView *image5;
@property(nonatomic,retain)IBOutlet UIImageView *image6;
@property(nonatomic,retain)IBOutlet UIImageView *image7;
@property(nonatomic,retain)IBOutlet UIImageView *image8;
@property(nonatomic,retain)IBOutlet UIImageView *image9;
@property(nonatomic,retain)NSString *colour;


@end
