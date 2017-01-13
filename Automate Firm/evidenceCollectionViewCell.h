//
//  evidenceCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 8/1/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface evidenceCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UIImageView *backImage;
@property(nonatomic,retain)IBOutlet UIButton *deleteButton;
@property(nonatomic,retain)IBOutlet UIImageView *signatureimg;
@property(nonatomic,retain)IBOutlet UIView *sigview;
@property(nonatomic,retain)IBOutlet UIImageView *boximg;
@end
