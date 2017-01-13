//
//  settingsApplyDelegationClass.h
//  
//
//  Created by leonine on 10/10/15.
//
//

#import <UIKit/UIKit.h>

@interface settingsApplyDelegationClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *designationCollectionView;
@property(nonatomic,retain)NSMutableArray *selectedarray;
- (IBAction)resentpjtcheckbutton:(id)sender;
- (IBAction)doneButtonAction:(id)sender;
@end
