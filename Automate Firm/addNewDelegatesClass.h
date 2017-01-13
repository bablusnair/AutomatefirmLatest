//
//  addNewDelegateClass.h
//  
//
//  Created by leonine on 10/8/15.
//
//

#import <UIKit/UIKit.h>

@interface addNewDelegatesClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UITableView *moduleTableView;
@property(nonatomic,retain)NSMutableArray *moduleArray;
@property(nonatomic,retain)NSMutableArray *moduleIconArray;
@property(nonatomic,retain)NSMutableArray *moduleIconArray1;
-(IBAction)doneButtonAction:(id)sender;
-(IBAction)cancelButtonAction:(id)sender;
-(IBAction)applyToDesignationAction:(id)sender;
-(IBAction)applyTospecificEmployeeAction:(id)sender;
-(IBAction)radioButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *createOnlyButton;

-(IBAction)checkButtonAction:(id)sender;
@property(nonatomic,retain)IBOutlet UIButton *deleagteCheckButton;
@property(nonatomic,retain)IBOutlet UIButton *applyDesignationButton;
@property(nonatomic,retain)IBOutlet UIButton *assignEmployeeButton;
@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;

@property(nonatomic,retain)IBOutlet UITextView *createOnlyText;
@property(nonatomic,retain)IBOutlet UITextView *applyToDesignationText;
@property(nonatomic,retain)IBOutlet UITextView *assignEmployeeText;
@property(nonatomic,retain)IBOutlet UITextView *delegateText;
@property (weak, nonatomic) IBOutlet UIView *delegateView;
@property (weak, nonatomic) IBOutlet UIView *maindelegateView;
@property (weak, nonatomic) IBOutlet UIScrollView *delgateScroll;
@property (weak, nonatomic) IBOutlet UIView *docmntSubView;
@property (weak, nonatomic) IBOutlet UIView *shiftSubView;
@property (weak, nonatomic) IBOutlet UIView *empDetailSubview;
@property (weak, nonatomic) IBOutlet UIView *timeCardSubview;
- (IBAction)addDocSubVIew:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *empDetailViewBtn;
@property (weak, nonatomic) IBOutlet UIButton *empdetailLabelButn;

@end
