//
//  registrationPopupClass.h
//  Automate Firm
//
//  Created by leonine on 11/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
@interface registrationPopupClass : UIView<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,headerprotocol>
@property(nonatomic,retain)connectionclass *myconnection;

@property (weak, nonatomic) IBOutlet UITableView *languagTable;
@property(nonatomic,retain)NSMutableArray *languagenamesarray;
@property (weak, nonatomic) IBOutlet UITextField *languageText;
@property (weak, nonatomic) IBOutlet UITextField *paswrText;
@property (weak, nonatomic) IBOutlet UITextField *retypePaswrdText;
@end
