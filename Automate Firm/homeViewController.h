//
//  homeViewController.h
//  Automire Firm
//
//  Created by leonine on 14/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *staffing;
- (IBAction)staffingactionbutton:(id)sender;
- (IBAction)documentationactionbutton:(id)sender;
@property (nonatomic,assign)NSInteger identifyhomebuttonindex;

@property(nonatomic,retain)NSArray *myarray;
@property (strong, nonatomic) IBOutlet UIButton *projects;
@property (strong, nonatomic) IBOutlet UIButton *tasks;
@property (strong, nonatomic) IBOutlet UIButton *inventory;
@property (strong, nonatomic) IBOutlet UIButton *documentation;
-(IBAction)closeaddemployee:(id)sender;
- (IBAction)projectactionbutton:(id)sender;
- (IBAction)taskactionbutton:(id)sender;
- (IBAction)inventoryactionbutton:(id)sender;

@end
