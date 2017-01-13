//
//  attendancesettingsviewclass.h
//  
//
//  Created by leonine on 12/10/15.
//
//

#import <UIKit/UIKit.h>
#import "connectionclass.h"
#import "headerprotocol.h"
#import "AppDelegate.h"
@interface attendancesettingsviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UITableViewDataSource,UITableViewDelegate,headerprotocol>
{
    AppDelegate *appObj;
}

@property (retain, nonatomic)connectionclass *myconnection;

@property(nonatomic,retain)IBOutlet UICollectionView *attendancecollectionview;
@property (weak, nonatomic) IBOutlet UIView *attendancesettingscontainsview;
@property (weak, nonatomic) IBOutlet UITableView *settingscontainstableview;

@property(nonatomic,retain)NSMutableArray *iconsarray;
@property(nonatomic,retain)NSMutableArray *iconnamesarray;
@property(nonatomic,retain)NSMutableArray *weekarray;
@property(nonatomic,retain)NSMutableArray *shiftarray;
@property(nonatomic,retain)NSMutableArray *timearray;
@property(nonatomic,retain)NSMutableArray *rounduparray;
@property(nonatomic,retain)NSMutableArray *leavesarray;
@property(nonatomic,retain)NSMutableArray *leavesIDArray;
@property(nonatomic,retain)NSMutableArray *leavesFlagArray;
@property(nonatomic,retain)NSMutableArray *holidayarray;
@property(nonatomic,retain)NSMutableArray *idpassingarray;//Time
@property(nonatomic,retain)NSMutableArray *shiftIDPassingArray;//Shift
@property(nonatomic,retain)NSMutableArray *WeekIdPassingAray;//week
@property(nonatomic,retain)NSMutableArray *holydayIdPassingAray;//Holiday


@property(nonatomic,retain)NSIndexPath *k;

//@property(nonatomic,retain)NSMutableArray *headingarray;


@property (assign, nonatomic)int selectedflag;


@property (weak, nonatomic) IBOutlet UIButton *createnewbutton;


-(IBAction)createnewbuttonaction:(id)sender;

//-(void)savedWeekArray:(id)savedWeekData;
//-(void)savedarray:(NSMutableArray *)saveddata;//Time passing function
-(void)savedShiftsArray:(NSMutableArray *)savedShiftData;//Shift passing function



@end
