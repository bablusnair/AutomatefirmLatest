//
//  currencySettingsViewClass.h
//  Automate Firm
//
//  Created by leonine on 1/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface currencySettingsViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property(nonatomic,retain)IBOutlet UIScrollView *scrollView;
@property(nonatomic,retain)IBOutlet UITextField *activeField;//Textfield for keyboard scrolling


@property(nonatomic,retain)IBOutlet UICollectionView *currencyNotesCV;
@property(nonatomic,retain)IBOutlet UICollectionView *currencyCoinsCV;

@property(nonatomic,retain)NSMutableArray *notesArray;
@property(nonatomic,retain)NSMutableArray *coinsArray;
@property(nonatomic,retain)NSMutableArray *notesImageArray;
@property(nonatomic,retain)NSMutableArray *coinsImageArray;

@property(nonatomic,retain)NSIndexPath *index;
@property(nonatomic,assign)int pickerFlag;

@property(nonatomic,retain)IBOutlet UILabel *currencyLabel;


-(IBAction)DoneAction:(id)sender;
-(IBAction)cancelAction:(id)sender;

-(IBAction)deleteNoteCell:(id)sender;
-(IBAction)deleteCoinsCell:(id)sender;
-(IBAction)imagePickerAction:(id)sender;

-(IBAction)imagePickerAction1:(id)sender;
-(IBAction)denominationEndEditing:(id)sender;
-(IBAction)coinsDenominationEndEditing:(id)sender;
@end
