//
//  officesetupcustomcell.h
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface officesetupcustomcell : UITableViewCell
@property(nonatomic,retain)IBOutlet UILabel *mainLabel;
@property(nonatomic,retain)IBOutlet UILabel *descriptionLabel;
@property(nonatomic,retain)IBOutlet UILabel *lastModifiedLabel;
@property (weak, nonatomic) IBOutlet UILabel *storeidlabel;
@property(nonatomic,retain)IBOutlet UIImageView *mainimage;
@end
