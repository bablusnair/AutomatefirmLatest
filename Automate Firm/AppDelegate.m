//
//  AppDelegate.m
//  Automate Firm
//
//  Created by leonine on 14/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import "AppDelegate.h"
//Step 1
#import <DropboxSDK/DropboxSDK.h>

#define APP_KEY  @"d1npf9a2hx66ano"
#define APP_SECRET  @"xrhv29os1g8mq2e"
@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize warningflag,designationFlag,conditionCount,selectedRow,ruleID,conditionID,flowAction,specificEmployeeFlag1,specificEmployeeFlag2,specificEmployeeFlag3,specificEmployeeFlag4,specificEmployeeFlag5,designationFlag1,designationFlag2,designationFlag3,designationFlag4,designationFlag5;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    warningflag=0;
    designationFlag=designationFlag5=designationFlag4=designationFlag3=designationFlag2=designationFlag1=0;
    specificEmployeeFlag1=specificEmployeeFlag2=specificEmployeeFlag3=specificEmployeeFlag4=specificEmployeeFlag5=0;
    conditionCount=0;
    selectedRow=0;
    self.scrollvalue=35;
    ruleID=@"0";
    conditionID=@"0";
    flowAction=@"1";
    self.advance_tileId=@"0";
     self.earningRuleId=@"0";
    self.deductionRuleId=@"0";

    self.loan_idstring=@"0";
    self.earningTypeString=@"1";
    self.earningConditionId=@"0";
    self.deductionConditionId=@"0";
   // self.deductionTypeString
    
    self.includedesignationflag=0;
    
    self.myselectedTag=0;
    
    self.dropboxFlag=0;
    
    self.petennityleavesignaturearray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.vact_emrc_sickleavearray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.maternityleavearray=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.otherleave_array=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.advanceformsign_array=[[NSMutableArray alloc]initWithObjects:@"",@"",@"",@"",@"", nil];
    
    self.conditionIDArray=[[NSMutableArray alloc]init];
    
    self.loantileid_array=[[NSMutableArray alloc]init];
    
     self.dropbox_array=[[NSMutableArray alloc]init];
    
    self.documentarray=[[NSMutableArray alloc]init];
    
    NSMutableArray *myarray = [[NSMutableArray alloc] init];
    self.appde_locgroupdictionary=[[NSMutableDictionary alloc]initWithObjectsAndKeys:myarray,@"0", nil];
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    self.advanceTileIdDict= [[NSMutableDictionary alloc] init];
    //self.earningsTileIdDict= [[NSMutableDictionary alloc] init];
   // self.deductionTileIdDict= [[NSMutableDictionary alloc] init];

    self.advanceAmtChangeFlag=0;
    self.appde_localdict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:dict,@"0",nil];
    self.loanupdate_dictionary = [[NSMutableDictionary alloc] init];
    DBSession *dbSession = [[DBSession alloc] initWithAppKey:APP_KEY appSecret:APP_SECRET root:kDBRootDropbox];
    [DBSession setSharedSession:dbSession];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
  //  NSLog(@"%@",documentsDirectory);
   // NSString * appBuildString = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
   // NSLog(@"%@",appBuildString);

  //  NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"Autoincrementedalue"])
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window {
    
    return UIInterfaceOrientationMaskAll;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)hudStart:(UIView *)myView;
{
    HUD = [[MBProgressHUD alloc] initWithView:myView];
    HUD.mode=MBProgressHUDModeIndeterminate;
    [myView addSubview:HUD];
    [HUD show:YES];
}

-(void)hudStop
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
         [HUD hide:YES];
    });

   
}

//Stpe3
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
   
    
    if ([[DBSession sharedSession] handleOpenURL:url]) {
        if ([[DBSession sharedSession] isLinked]) {
            NSLog(@"App linked successfully!");
            // At this point you can start making API calls
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"recall" object:Nil];
        }
        return YES;
    }
    // Add whatever other url handling code your app requires here
    return NO;
}
@end
