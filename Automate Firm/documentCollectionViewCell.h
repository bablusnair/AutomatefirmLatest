//
//  documentCollectionViewCell.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 27/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface documentCollectionViewCell : UICollectionViewCell
@property(nonatomic,retain)IBOutlet UITextField *documentText;
@property(nonatomic,retain)IBOutlet UIButton *readButton;
@property(nonatomic,retain)IBOutlet UIButton *writeButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButon;
@end
