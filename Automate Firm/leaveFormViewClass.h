//
//  leaveFormViewClass.h
//  Automate Firm
//
//  Created by leonine on 6/16/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface leaveFormViewClass : UIView<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UITextFieldDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)IBOutlet UITableView *firstTableView;
@property(nonatomic,retain)IBOutlet UITableView *secondTableView;
@property(nonatomic,retain)NSMutableArray *firstArray;
-(IBAction)tileButtonClicked:(id)sender;
@property(nonatomic,assign)int x;
@property(nonatomic,retain)IBOutlet UIScrollView *myscrollView;
@property(nonatomic,retain)IBOutlet UIView *firstView;
@property(nonatomic,retain)IBOutlet UIView *contentview;
-(IBAction)forwardbuttonaction:(id)sender;
-(IBAction)prioritybutton1action:(id)sender;
-(IBAction)prioritybutton2action:(id)sender;
-(IBAction)prioritybutton3action:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton1;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton2;
@property(nonatomic,retain)IBOutlet UIButton *priorityButton3;
-(IBAction)signatureAction:(id)sender;
-(IBAction)stampButtonAction:(id)sender;



//Leave
@property(nonatomic,retain)IBOutlet UICollectionView *leaveTypeCV;
@property(nonatomic,retain)IBOutlet UICollectionView *evidenceCollectionView;
@property(nonatomic,retain)IBOutlet UIScrollView *evidenceScrollView;
@property(nonatomic,retain)NSMutableArray *evidenceArray;
-(IBAction)evidenceMoveAction:(id)sender;
-(IBAction)uploadEvidence:(id)sender;
@property(nonatomic,assign)int formNumber;
@property(nonatomic,retain)IBOutlet UIView *myview;
@property(nonatomic,retain) NSMutableArray *othersArray;
@property(nonatomic,retain)IBOutlet UITextField *visaExpiry;
-(void)vacationSickEmergencyLeaveAction;
-(void)paternityLeaveAction;
-(void)maternityLeaveAction;
-(void)otherLeaveAction;
-(IBAction)authorityFlowAction:(id)sender;

-(IBAction)leaveRedemAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIScrollView *leaveRedemScroll;

-(IBAction)employeeSelectionAction:(id)sender;
@property(nonatomic,assign)int actionFlag;
@property(nonatomic,assign)int row;
@property(nonatomic,retain)NSIndexPath *inPath;
-(IBAction)evidenceDeleteAction:(id)sender;
@property(nonatomic,retain)NSTimer *timer;
@property BOOL blinkStatus;

@property(nonatomic,retain)IBOutlet UIButton *rightButton;
@property(nonatomic,retain)IBOutlet UIButton *leftButton;
@property(nonatomic,retain)IBOutlet UIView *leftButtonView;
@property(nonatomic,retain)IBOutlet UIView *rightButtonView;

-(void)initializeTimer;
-(void)invalidateTimer;
@property(nonatomic,assign)int selectedRow;

-(IBAction)signbuttonaction:(id)sender;
-(void)formColorSetting;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@property(nonatomic,retain)IBOutlet UIImageView *image1;
@property(nonatomic,retain)IBOutlet UIImageView *image2;
@property(nonatomic,retain)IBOutlet UIImageView *image3;
@property(nonatomic,retain)IBOutlet UIImageView *image4;
@property(nonatomic,retain)IBOutlet UIImageView *image5;

- (IBAction)newEmpSignAction:(id)sender;



@end
