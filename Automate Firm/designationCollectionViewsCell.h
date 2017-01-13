//
//  designationCollectionViewCell.h
//  
//
//  Created by leonine on 10/10/15.
//
//

#import <UIKit/UIKit.h>

@interface designationCollectionViewsCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UIButton *checkButton;
@property(nonatomic,retain)IBOutlet UILabel *desigLabel;
@property(nonatomic,retain)IBOutlet UIImageView *iconImage;
@property(nonatomic,retain)NSString *cellID;
@end
