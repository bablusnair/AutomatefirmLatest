//
//  SerachListingEmployeeView.h
//  Automate Firm
//
//  Created by leonine on 11/18/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SerachListingEmployeeView : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *nameLabel;
@property(nonatomic,retain)IBOutlet UILabel *desigLabel;
@property(nonatomic,retain)IBOutlet UILabel *empIDLabel;
@property(nonatomic,retain)IBOutlet UILabel *unitLabel;
@property(nonatomic,retain)IBOutlet UIImageView *myImage;
@property(nonatomic,retain)NSString *empID;
@end
