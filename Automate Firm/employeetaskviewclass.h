//
//  employeetaskviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "employeetaskcellclass.h"
@interface employeetaskviewclass : UIView<UITableViewDataSource,UITableViewDelegate>
- (IBAction)btn1:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnstar1;
@property (strong, nonatomic) IBOutlet UIButton *btnstar2;
@property (strong, nonatomic) IBOutlet UIButton *btnstar3;
@property (strong, nonatomic) IBOutlet UIButton *btnstar4;
@property (strong, nonatomic) IBOutlet UIButton *btnstar5;


@end
