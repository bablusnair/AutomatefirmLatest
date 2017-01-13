//
//  demostaffingviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 24/03/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "demostaffingviewclass.h"
#import "attendancehomeviewclass.h"
#import "staffingemployeehomeviewclass.h"

@implementation demostaffingviewclass




- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.x=0;
    self.y=0;
   

    
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"StaffingEmployeesHomeview" owner:self options:Nil];
    
    [self.employeelistview addSubview:[myviewarray objectAtIndex:0]];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changingimage) name:@"timecardimage" object:Nil];
     self.x=0;
     self.k=0;
    
    NSArray*array=self.employeelistview.subviews;
    staffingemployeehomeviewclass *ob = (staffingemployeehomeviewclass *)[array objectAtIndex:0];
    self.searchfield.delegate=ob;
    
}

-(void)changingimage
{
    
    [self.timecardbutton setImage:[UIImage imageNamed:@"main_blue_box.png"] forState:UIControlStateNormal];
    self.timecardlabel.textColor=[UIColor whiteColor];
    self.timecardimgview.image=[UIImage imageNamed:@"timecard_white.png"];
      self.x=0;
}

-(IBAction)employeetimecardbuttonaction:(id)sender
{
    if (self.x%2==0) {
        
        
//        for (UIView *view in self.employeelistview.subviews) {
//            if ([view isKindOfClass:[staffingemployeehomeviewclass class]] || [view isKindOfClass:[attendancehomeviewclass class]]) {
//                
//                [view removeFromSuperview];
//            }
//        }
        
        
        [self.timecardbutton setImage:[UIImage imageNamed:@"main_grey_box.png"] forState:UIControlStateNormal];
        
        self.timecardlabel.textColor=[UIColor blackColor];
        
        self.timecardimgview.image=[UIImage imageNamed:@"timecard_blue.png"];
        
        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"timecardhomeview" owner:self options:Nil];
        
        [self.employeelistview addSubview:[myviewarray objectAtIndex:0]];
        
        self.x++;
        
    }

    else
    {
        
    for (UIView *subView in self.subviews)
    {
        

    [[subView viewWithTag:1] removeFromSuperview];
        
    
    }
        
    self.x++;
        
   [self.timecardbutton setImage:[UIImage imageNamed:@"main_blue_box.png"] forState:UIControlStateNormal];
    self.timecardlabel.textColor=[UIColor whiteColor];
    self.timecardimgview.image=[UIImage imageNamed:@"timecard_white.png"];
        
        
        
//        NSArray *myviewarray=[[NSBundle mainBundle] loadNibNamed:@"StaffingEmployeesHomeview" owner:self options:Nil];
//        
//        [self.employeelistview addSubview:[myviewarray objectAtIndex:0]];

    }
    
}

-(IBAction)filterbuttonaction:(id)sender
{
    self.searchfield.text=@"";
    self.searchicon.image=[UIImage imageNamed:@"se-ecffh.png"];
    
    if (self.k%2==0) {
        
         [[NSNotificationCenter defaultCenter] postNotificationName:@"filteron" object:Nil];
        self.k++;
    }
    else
    {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"filteroff" object:Nil];
        self.k++;
    }
    
}

-(IBAction)presentViewpopup:(id)sender
{
  
    if (self.y%2==0) {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presentpopupon" object:Nil];
        self.y++;
    }
    else
    {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"presentpopupoff" object:Nil];
        self.y++;
    }
    

}

-(void)setimageandsearchvalue:(NSString *)searchedvalue and:(NSString *)imagestring
{
    self.searchfield.text=searchedvalue;
    self.searchicon.image=[UIImage imageNamed:imagestring];
    self.y=0;
    
}

-(void)forfilterviewdoneaction
{
    
    self.k=0;
}


@end
