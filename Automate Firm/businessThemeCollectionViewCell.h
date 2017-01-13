//
//  businessThemeCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 7/27/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface businessThemeCollectionViewCell : UICollectionViewCell<UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *formView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UIButton *redButton;
@property(nonatomic,retain)IBOutlet UIButton *blueButton;
@property(nonatomic,retain)IBOutlet UIButton *greyButton;
@property(nonatomic,retain)IBOutlet UIButton *greenButton;
@property(nonatomic,retain)IBOutlet UIButton *brownButton;
@property(nonatomic,retain)IBOutlet UIImageView *formImage;
@property(nonatomic,retain)IBOutlet UIImageView *idFrontImage;
@property(nonatomic,retain)IBOutlet UIImageView *idBackImage;

@property(nonatomic,retain)IBOutlet UILabel *themeNameLabel;
@property(nonatomic,retain)IBOutlet UILabel *themeTypeLabel;

@property(nonnull,retain)IBOutlet UIButton *actionButton1;
@property(nonnull,retain)IBOutlet UIButton *actionButton2;
@property(nonnull,retain)IBOutlet UIButton *actionButton3;
@property(nonnull,retain)IBOutlet UIButton *checkButton;


@property(nonatomic,assign)int statusFlag;






@end
