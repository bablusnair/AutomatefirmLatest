//
//  teamallocation2Class.m
//  Automate Firm
//
//  Created by leonine on 18/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "teamallocation2Class.h"
#import "allocationTableCell.h"

@implementation teamallocation2Class

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return  6;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    allocationTableCell *cell = (allocationTableCell *)[tableView dequeueReusableCellWithIdentifier:@"TableCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"allocationTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
   
    return cell;
}
@end
