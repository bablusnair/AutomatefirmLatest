//
//  firstTableViewCellClass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/6/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface firstTableViewCellClass : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UILabel *numberLabel;
@property (strong, nonatomic) IBOutlet UITextField *categoryText;

@property (strong, nonatomic) IBOutlet UITextField *Description;
@property (strong, nonatomic) IBOutlet UIButton *statusButton1;
@property (strong, nonatomic) IBOutlet UIImageView *cellImage;

@property(nonatomic,retain)IBOutlet UITextField *limitText;
@property(nonatomic,retain)IBOutlet UITextField *rqstAmount;
@property(nonatomic,retain)IBOutlet UITextField *approvedAmount;

@property (strong, nonatomic) IBOutlet UIImageView *evidenceImageView;

@property(nonatomic,retain)IBOutlet UITextField *remarkText;


@end
