//
//  departmentTableViewCell.h
//  Automate Firm
//
//  Created by leonine on 1/14/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface departmentTableViewCell : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UITextField *deptNameText;
@property(nonatomic,retain)IBOutlet UIButton *closeButton;
@end
