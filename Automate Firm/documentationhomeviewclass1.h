//
//  documentationhomeviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 29/05/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface documentationhomeviewclass : UIView
- (IBAction)genatedocumentsbuttonaction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *myDocView;
@property(nonatomic,assign)int x;
-(IBAction)paperWorkAction:(id)sender;
@property(nonatomic,assign)int y;
@end
