//
//  coinsCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 1/15/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface coinsCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UITextField *coinsText;
@property(nonatomic,retain)IBOutlet UIImageView *iconImage;
@end
