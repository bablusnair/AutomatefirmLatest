//
//  autocodingViewClass.h
//  Automate Firm
//
//  Created by leonine on 7/13/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "autocodingTileClass.h"
#import "connectionclass.h"
@interface autocodingViewClass : UIView
{
    autocodingTileClass *accordion;
}
@property(nonatomic,retain)connectionclass *myconnection;
-(IBAction)done:(id)sender;
-(IBAction)cancel:(id)sender;
-(void)enable;
-(void)disable;
@property(nonatomic,retain)IBOutlet UIButton *doneButton;
@end
