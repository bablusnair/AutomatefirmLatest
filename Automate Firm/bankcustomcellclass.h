//
//  bankcustomcellclass.h
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface bankcustomcellclass : UICollectionViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *checkbutton;
@property (strong, nonatomic) IBOutlet UITextField *wpstextfield;
@property (strong, nonatomic) IBOutlet UILabel *bankname;
@property (strong, nonatomic) IBOutlet UILabel *branchname;
@property (weak, nonatomic) IBOutlet UILabel *selectedbankcellid;
@end
