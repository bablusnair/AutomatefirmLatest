//
//  custumclasscell.h
//  bablusdemokpproject
//
//  Created by Emvigo on 28/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface custumclasscell : UITableViewCell<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *degree;
@property (strong, nonatomic) IBOutlet UITextField *institution;
@property(nonatomic,retain)IBOutlet UITextField *yearlabel;
@end
