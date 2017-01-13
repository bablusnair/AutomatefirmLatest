//
//  timeCardScrollTableCell.m
//  Automate Firm
//
//  Created by leonine on 05/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "timeCardScrollTableCell.h"

@implementation timeCardScrollTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    NSInteger row =[[[NSUserDefaults standardUserDefaults] objectForKey:@"rowpathalues"]integerValue];
    NSLog(@"%li",(long)row);
    
    if (row%2==0) {
        
        
    
        [self.TimecardCollection registerNib:[UINib nibWithNibName:@"secondRowCollectionViewCell" bundle:nil]
                  forCellWithReuseIdentifier:@"timecardScrollCell"];

    }
    else
    {
        
    
        
        [self.TimecardCollection registerNib:[UINib nibWithNibName:@"CollectionViewCellForTimeCard" bundle:nil]
                  forCellWithReuseIdentifier:@"timecardScrollCell"];

        
    }
    


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
