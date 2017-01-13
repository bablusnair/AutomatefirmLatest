//
//  pjtgenateviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 13/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface pjtgenateviewclass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
//- (IBAction)showbuttonaction:(id)sender;
- (IBAction)closeforstampview:(id)sender;
-(IBAction)closepjtgeneratedviewall:(id)sender;
-(IBAction)closeButton:(id)sender;


@property(nonatomic,assign)int x;
@property(nonatomic,assign)int y;


@property(nonatomic,retain)IBOutlet UIView *mainView;
@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UIView *popUpView;
-(IBAction)presetButtonAction:(id)sender;
-(IBAction)presetViewActions:(id)sender;
-(IBAction)closePresetView:(id)sender;
@end
