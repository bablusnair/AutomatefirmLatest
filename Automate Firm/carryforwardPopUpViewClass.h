//
//  carryforwardPopUpViewClass.h
//  Automate Firm
//
//  Created by leonine on 11/6/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "carryForwardOptionsTile.h"

@interface carryforwardPopUpViewClass : UIView
{
    carryForwardOptionsTile *accordion;
}
-(IBAction)closeButtonAction:(id)sender;
@end
