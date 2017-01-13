//
//  printercellclass.h
//  Automate Firm
//
//  Created by leonine on 13/01/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface printercellclass : UICollectionViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UITextField *namefield;
@property(nonatomic,retain)IBOutlet UITextField *mailfield;
@property(nonatomic,retain)IBOutlet UITextField *ratefield;
@property(nonatomic,retain)IBOutlet UIButton *closebutton;
@end
