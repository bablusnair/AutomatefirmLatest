//
//  staffinghomeview.h
//  bablusdemokpproject
//
//  Created by Emvigo on 16/02/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface staffinghomeview : UIView
- (IBAction)addemployeeactionbutton:(id)sender;
-(IBAction)identityCardAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *mainview;
@property(nonatomic,assign)int i;
@property(nonatomic,assign)int j;


@end
