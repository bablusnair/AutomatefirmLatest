//
//  advancesettingsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "advancesettingsviewclass.h"
#import "advanceGroupClass.h"
#import "advanceTileClass.h"
@implementation advancesettingsviewclass
- (void)awakeFromNib
{
    myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    accordion = [[advanceTileClass alloc] initWithFrame:CGRectMake(10, 125, 625, 445)];

    [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"accordianAction"];
    [self addSubview:accordion];
    myappde.advance_ruleId=[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"];
    [self.myconnection viewAdvanceRuleTileDetails:[[NSUserDefaults standardUserDefaults]objectForKey:@"advance_ruleId"]];
    
//    [app.conditionIDArray removeAllObjects];
//    [app.conditionIDArray addObjectsFromArray:self.leaveTileIDArray];
//    AccordionView *myobj = (AccordionView *)[self.subviews lastObject];
//    [myobj CreationoftileforUpdation:condtionArray.count];

//    [self addSubview:accordion];
//    
//    UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
//    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
//    label.text=@"Group Name 1";
//    [label setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
//    label.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
//    [header addSubview:label];
//    [header setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
//    
//    NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"advanceconditionsview" owner:self options:nil];
//    [accordion addHeader:header withView:[array objectAtIndex:0]];
    
    
//    UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
//    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
//    label1.text=@"Group Name 2";
//    [label1 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
//    label1.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
//    [header1 addSubview:label1];
//    [header1 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
//    
//    NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"advanceconditionsview" owner:self options:nil];
//    [accordion addHeader:header1 withView:[array objectAtIndex:0]];
//    
//    
//    UIButton *header2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
//    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
//    label2.text=@"Group Name 3";
//    [label2 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
//    label2.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
//    [header2 addSubview:label2];
//    
//    [header2 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
//    
//    NSArray *array1=[[NSBundle mainBundle]loadNibNamed:@"advanceconditionsview" owner:self options:nil];
//    
//    [accordion addHeader:header2 withView:[array1 objectAtIndex:0]];
//    
//    UIButton *header3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
//    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
//    label3.text=@"Group Name 4";
//    [label3 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
//    label3.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
//    [header3 addSubview:label3];
//    
//    [header3 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
//    
//    NSArray *array2=[[NSBundle mainBundle]loadNibNamed:@"advanceconditionsview" owner:self options:nil];
//    
//    [accordion addHeader:header3 withView:[array2 objectAtIndex:0]];
//    
//    UIButton *header4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
//    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
//    label4.text=@"Group Name 5";
//    [label4 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
//    label4.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
//    [header4 addSubview:label4];
//    
//    [header4 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
//    
//    NSArray *array3=[[NSBundle mainBundle]loadNibNamed:@"advanceconditionsview" owner:self options:nil];
//    
//    [accordion addHeader:header4 withView:[array3 objectAtIndex:0]];
    
}
-(IBAction)donebuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancelbuttonaction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableCollectionView" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}

-(void)willRemoveSubview:(UIView *)subview
{
    NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
    NSLog(@"%@",self.subviews);
    for (advanceGroupClass *myView in accordion.scrollView.subviews) {
        if ([myView isKindOfClass:[advanceGroupClass class]]) {
            
            [myView collectionViewReload:selectedDeignationArray];
        }
    }
}
-(void)viewAllAdvanceResponse:(id)responseList
{
    for (int i=0; i<[responseList count]; i++) {
        [myappde.advanceTileIdDict setObject:[[responseList objectAtIndex:i ]objectForKey:@"con_id"] forKey:[NSString stringWithFormat:@"%d",i]];
    }
    advanceTileClass *myobj = (advanceTileClass *)[self.subviews lastObject];
    [myobj CreationoftileforUpdation:[responseList count]];

}
- (IBAction)addNewTile:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"advanceAction"];
  
    advanceTileClass *myobj = (advanceTileClass *)[self.subviews lastObject];
    if ([myappde.advanceTileIdDict count]==myappde.addnewCount) {
        
         [myobj addNewTileForUpdation:myappde.advanceTileIdDict.count];
    }

}

@end
