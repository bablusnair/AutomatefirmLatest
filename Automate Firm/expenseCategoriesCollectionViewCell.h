//
//  expenseCategoriesCollectionViewCell.h
//  Automate Firm
//
//  Created by leonine on 11/24/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface expenseCategoriesCollectionViewCell : UICollectionViewCell<UITextFieldDelegate>
@property(nonatomic,retain)IBOutlet UITextField *expenseText;
@end
