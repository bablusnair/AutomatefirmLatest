//
//  settingsApplyDelegationClass.h
//  
//
//  Created by leonine on 10/10/15.
//
//

#import <UIKit/UIKit.h>

@interface settingsApplyDelegationsClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,retain)IBOutlet UICollectionView *designationCollectionView;
@property(nonatomic,retain)NSMutableArray *selectedarray;

- (IBAction)doneButtonAction:(id)sender;
@end
