//
//  notesCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 1/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface notesCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UIImageView *iconImage;
@property(nonatomic,retain)IBOutlet UITextField *notesText;
@end
