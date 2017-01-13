//
//  taskquestionnairviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 18/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface taskquestionnairviewclass : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSArray *myarray;
@property (weak, nonatomic)IBOutlet UITableView *tableView;
@property (retain, nonatomic)UIImageView *imageViewForImage;
-(IBAction)addnewplusbuttonaction:(id)sender;
@end
