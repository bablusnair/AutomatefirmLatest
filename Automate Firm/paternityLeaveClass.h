//
//  paternityLeaveClass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/22/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface paternityLeaveClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)IBOutlet UIButton *approvedradioButton;
@property(nonatomic,retain)IBOutlet UIButton *deniedradioButton;
-(IBAction)authorisationButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *childrensTC;
@property(nonatomic,retain)IBOutlet UILabel *childrensLabel;
@property(nonatomic,retain)NSMutableArray *chldrensArray;
-(IBAction)childrensDropDown:(id)sender;
-(IBAction)uploadDocument:(id)sender;
@property(nonatomic,retain)IBOutlet UITextField *startDateText;
@property(nonatomic,retain)IBOutlet UITextField *returnDateText;
@property(nonatomic,retain)IBOutlet UITextField *EDDText;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker1;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker2;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker3;

@property(nonatomic,retain)IBOutlet UIView *datePicker1View;
@property(nonatomic,retain)IBOutlet UIView *datePicker2View;
@property(nonatomic,retain)IBOutlet UIView *datePicker3View;
-(IBAction)datePicker1Action:(id)sender;
-(IBAction)datePicker2Action:(id)sender;
-(IBAction)datePicker3Action:(id)sender;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property(nonatomic,retain)IBOutlet UITextField *approveRadio;
@property(nonatomic,retain)IBOutlet UITextField *denyRadio;
@property(nonatomic,retain)IBOutlet UITableView *earningsTC;
@property(nonatomic,retain)IBOutlet UITableView *deductionsTC;



-(void)formColorSetting;
@property(nonatomic,retain)IBOutlet UIImageView *image1;
@property(nonatomic,retain)IBOutlet UIImageView *image2;
@property(nonatomic,retain)IBOutlet UIImageView *image3;
@property(nonatomic,retain)IBOutlet UIImageView *image4;
@property(nonatomic,retain)IBOutlet UIImageView *image5;
@property(nonatomic,retain)IBOutlet UIImageView *image6;
@property(nonatomic,retain)IBOutlet UIImageView *image7;
@property(nonatomic,retain)IBOutlet UIImageView *image8;
@property(nonatomic,retain)NSString *colour;
@end
