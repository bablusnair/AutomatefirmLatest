//
//  vacationLeave.h
//  bablusdemokpproject
//
//  Created by leonine on 7/23/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "uploadCollectionViewCell.h"
@interface vacationLeave : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *mycollectionView;
@property(nonatomic,retain)NSMutableArray *stamparray;
@property(nonatomic,retain)NSMutableArray *stamparray1;
@property(nonatomic,retain)IBOutlet UIButton *approvedradioButton;
@property(nonatomic,retain)IBOutlet UIButton *deniedradioButton;
-(IBAction)authorisationButtonAction:(id)sender;
-(IBAction)drop1ButtonAction:(id)sender;
-(IBAction)drop2ButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UITableView *mytablebiew1;
@property(nonatomic,retain)IBOutlet UITableView *mytablebiew2;
@property(nonatomic,retain)NSMutableArray *economyArray;
@property(nonatomic,retain)NSMutableArray *companyArray;
@property(nonatomic,retain)IBOutlet UITextField *startDateText;
@property(nonatomic,retain)IBOutlet UITextField *returnDateText;
@property(nonatomic,retain)IBOutlet UITextField *destinationText;
@property(nonatomic,retain)IBOutlet UITextField *ticketCost;
@property(nonatomic,retain)IBOutlet UITextField *approveRadio;
@property(nonatomic,retain)IBOutlet UITextField *denyRadio;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker1;
@property(nonatomic,retain)IBOutlet UIDatePicker *datePicker2;
@property(nonatomic,retain)IBOutlet UITextField *economyText;
@property(nonatomic,retain)IBOutlet UITextField *companyText;
@property(nonatomic,retain)IBOutlet UIView *datePicker1View;
@property(nonatomic,retain)IBOutlet UIView *datePicker2View;
-(IBAction)datePicker1Action:(id)sender;
-(IBAction)datePicker2Action:(id)sender;
-(IBAction)uploadDocument:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *uploadButton;
@property(nonatomic,retain)IBOutlet UICollectionView *uploadCollectionView;
@property(nonatomic,retain)NSMutableArray *uploadEvidenceArray;
@property(nonatomic,assign)int actionFlag;@property(nonatomic,assign)int row;
@property(nonatomic,retain)IBOutlet UITableView *earningsTC;
@property(nonatomic,retain)IBOutlet UITableView *deductionsTC;
@property(nonatomic,retain)IBOutlet UITextField *contactNumberText1;
@property(nonatomic,retain)IBOutlet UITextField *contactNumberText2;
-(IBAction)deleteEvidence:(id)sender;
@property(nonatomic,retain)NSIndexPath *inPath;
- (IBAction)newEmpSignAction:(id)sender ;


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
