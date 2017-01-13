//
//  AppDelegate.h
//  Automate Firm
//
//  Created by leonine on 14/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    MBProgressHUD *HUD;
}

@property (strong, nonatomic) UIWindow *window;

@property(nonatomic,assign) int warningflag;
@property(nonatomic,assign) int designationFlag;

@property(nonatomic,assign) int employeeFlag;
@property(nonatomic,assign) int conditionCount;
@property(nonatomic,assign) int selectedRow;

@property(nonatomic,assign) int designationFlag1;
@property(nonatomic,assign) int designationFlag2;
@property(nonatomic,assign) int designationFlag3;
@property(nonatomic,assign) int designationFlag4;
@property(nonatomic,assign) int designationFlag5;
@property(nonatomic,assign) int specificEmployeeFlag1;
@property(nonatomic,assign) int specificEmployeeFlag2;
@property(nonatomic,assign) int specificEmployeeFlag3;
@property(nonatomic,assign) int specificEmployeeFlag4;
@property(nonatomic,assign) int specificEmployeeFlag5;

@property(nonatomic,retain)NSString *ruleID;
@property(nonatomic,retain)NSString *conditionID;
@property(nonatomic,retain)NSString *flowAction;

@property(nonatomic,retain)NSString *action;

@property(nonatomic,retain)NSMutableArray *conditionIDArray;

@property(nonatomic,retain)NSMutableArray *documentarray;

-(void)hudStart:(UIView *)myView;
-(void)hudStop;

@property(nonatomic,assign) int myselectedTag;
@property(nonatomic,assign) int headercount;

@property(nonatomic,retain)NSString *loan_idstring;

@property(nonatomic,retain)NSMutableArray *loantileid_array;

@property(nonatomic,retain)NSString *designation_tile;

@property(nonatomic,retain)NSMutableDictionary*appde_locgroupdictionary;
@property(nonatomic,retain)NSMutableDictionary*appde_localdict;
@property(nonatomic,assign) int includedesignationflag;

@property(nonatomic,retain)NSMutableDictionary *loanupdate_dictionary;

@property(nonatomic,assign) int scrollvalue;
@property(nonatomic,retain)NSMutableDictionary *advanceTileIdDict;
@property(nonatomic,retain)NSMutableDictionary *earningsTileIdDict;
@property(nonatomic,retain)NSMutableDictionary *deductionTileIdDict;
@property(nonatomic,retain)NSString *deductionRuleId;
@property(nonatomic,retain)NSString *deductionName;
@property(nonatomic,retain)NSString *deductionAbbrevtion;
@property(nonatomic,retain)NSString *deductionTypeString;
@property(nonatomic,retain)NSString *deductionTileIdString;
@property(nonatomic,retain)NSString *deductionDescription;
@property(nonatomic,retain)NSString *deductionConditionId;



@property(nonatomic,assign) int addnewCount;
@property(nonatomic,retain)NSString *advance_tileId;
@property(nonatomic,retain)NSString *advance_ruleId;

@property(nonatomic,retain)NSString *earningName;
@property(nonatomic,retain)NSString *earningAbbrevtion;
@property(nonatomic,retain)NSString *earningTypeString;
@property(nonatomic,retain)NSString *earningTileIdString;
@property(nonatomic,retain)NSString *earningConditionId;
@property(nonatomic,retain)NSString *earningDesc;


@property(nonatomic,retain)NSString *earningRuleId;



@property(nonatomic,assign) int tableRowId;
@property(nonatomic,assign) int deductionRowId;


@property(nonatomic,assign) int advanceAmtChangeFlag;


@property(nonatomic,retain)NSMutableArray *petennityleavesignaturearray;
@property(nonatomic,retain)NSMutableArray *vact_emrc_sickleavearray;
@property(nonatomic,retain)NSMutableArray *maternityleavearray;
@property(nonatomic,retain)NSMutableArray *otherleave_array;
@property(nonatomic,retain)NSMutableArray *advanceformsign_array;

@property(nonatomic,retain)NSIndexPath *signatureindex;
@property(nonatomic,retain)UIImage *sigimg;

@property(nonatomic,retain)NSMutableArray *dropbox_array;
@property(nonatomic,assign)int dropboxFlag;
@end

