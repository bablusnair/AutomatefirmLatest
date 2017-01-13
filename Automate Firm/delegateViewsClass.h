//
//  delegateViewClass.h
//  
//
//  Created by leonine on 10/8/15.
//
//

#import <UIKit/UIKit.h>

@interface delegateViewsClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *delegateiconscollectionview;

@property(nonatomic,retain)IBOutlet UICollectionView *delegateCollectionView;
@property(nonatomic,retain)IBOutlet UITableView *rulesTavleView;
-(IBAction)addNewDelegateAction:(id)sender;
@property(nonatomic,retain)NSIndexPath *inPath;
@property(nonatomic,retain)IBOutlet UIView *settingswholeview;
@property(nonatomic,retain)NSMutableArray *authorizationNameArray;
@property (assign,nonatomic) int x;
@property (assign,nonatomic) int y;
@property(nonatomic,retain)NSMutableArray *iconsarray;
@property(nonatomic,retain)NSMutableArray *iconnamesarray;
@property(nonatomic,retain)IBOutlet UIView *designationSearchView;
@property(nonatomic,retain)IBOutlet UITableView *designationSearchTableView;
@property(nonatomic,retain)IBOutlet UITableView *workingPremisesTC;
@property(nonatomic,retain)NSMutableArray *officetypearray;
@property(nonatomic,retain)NSMutableArray *officetypeimagearray;
@property(nonatomic,retain)IBOutlet UITextField *workingPremisestext;

@property(nonatomic,retain)NSMutableArray *sampleArray1;
@property(nonatomic,retain)NSMutableArray *sampleArray2;
@property(nonatomic,retain)NSMutableArray *sampleArray3;
@property(nonatomic,retain)NSMutableArray *sampleArray4;
@property(nonatomic,retain)NSMutableArray *sampleArray5;
@property(nonatomic,retain)NSMutableArray *sampleArray6;
@property(nonatomic,retain)NSMutableArray *designationArray;
@property(nonatomic,retain)NSMutableArray *filteredArray;
@property(nonatomic,retain)NSMutableDictionary *desigDict;
@property(nonatomic,retain)IBOutlet UITextField *designationSearchText;
@end
