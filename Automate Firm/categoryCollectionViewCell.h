//
//  categoryCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface categoryCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UILabel *categoryLabel;
@property(nonatomic,retain)IBOutlet UITextField *limitText;
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@end
