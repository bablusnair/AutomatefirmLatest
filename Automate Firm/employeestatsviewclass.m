//
//  employeestatsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeestatsviewclass.h"

@implementation employeestatsviewclass

-(void)awakeFromNib
{
    
//    NSMutableDictionary *employeedictdetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
//    
//    NSMutableDictionary *empstats = [employeedictdetails objectForKey:@"stats"];
//    
//    NSLog(@"%@",empstats);

    
    [self performSelector:@selector(showurl) withObject:Nil afterDelay:0.1];
    
}


- (IBAction)workingdayaction:(id)sender {
    [self.workingDay1 setImage:[UIImage imageNamed:@"blue_bujht.png"] forState:UIControlStateNormal];
    self.workingDay.textColor=[UIColor whiteColor] ;
    [self.overTime2 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
    self.overTime.textColor=[UIColor blackColor];
    self.firstGraphxlabel.text=@"Days";
}

- (IBAction)overtimeAction:(id)sender {
    [self.overTime2 setImage:[UIImage imageNamed:@"blue_bujht.png"] forState:UIControlStateNormal];
    self.overTime.textColor=[UIColor whiteColor] ;
    [self.workingDay1 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
    self.workingDay.textColor=[UIColor blackColor];
     self.firstGraphxlabel.text=@"Hours";
    
}
//@property (strong, nonatomic) IBOutlet UIButton *workingDay1;
//@property (strong, nonatomic) IBOutlet UIButton *overTime2;
//@property (strong, nonatomic) IBOutlet UIButton *netPay1;
//@property (strong, nonatomic) IBOutlet UIButton *grosspay1;
//@property (strong, nonatomic) IBOutlet UIButton *overTime3;

- (IBAction)netPayAction:(id)sender {
    
    UIButton *button=(UIButton *)sender;
    
    if(button.tag==1)
    {
        [self.netPay1 setImage:[UIImage imageNamed:@"blue_bujht.png"] forState:UIControlStateNormal];
        self.netPay.textColor=[UIColor whiteColor] ;
        [self.grosspay1 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.grosspay.textColor=[UIColor blackColor];
        [self.overTime3 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.overTime1.textColor=[UIColor blackColor];

    }
    else if (button.tag==2)
    {
        [self.grosspay1 setImage:[UIImage imageNamed:@"blue_bujht.png"] forState:UIControlStateNormal];
        self.grosspay.textColor=[UIColor whiteColor] ;
        [self.netPay1 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.netPay.textColor=[UIColor blackColor];
        [self.overTime3 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.overTime1.textColor=[UIColor blackColor];
    }
    else
    {
        [self.overTime3 setImage:[UIImage imageNamed:@"blue_bujht.png"] forState:UIControlStateNormal];
        self.overTime1.textColor=[UIColor whiteColor] ;
        [self.netPay1 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.netPay.textColor=[UIColor blackColor];
        [self.grosspay1 setImage:[UIImage imageNamed:@"white_but.png"] forState:UIControlStateNormal];
        self.grosspay.textColor=[UIColor blackColor];
    }
}

-(void)showurl
{
    
    NSURL *url=[NSURL URLWithString:@"http://chart.apis.google.com/chart?cht=bvg&chs=450x300&chd=t:20,35,10,10,5,10,35,30,55,45,35,20&chds=0,50&chxt=x,y&chxl=0:%7cJan%7cFeb%7cMar%7cApr%7cMay%7cJun%7cJul%7cAug%7cSep%7cOct%7cNov%7cDec&chxr=1,0,400&chco=66B2FF%7cFF0000"];
    UIImage *myimage = [UIImage imageWithData: [NSData dataWithContentsOfURL:url]];
    
    
    //  UIImage *myimage = [UIImage imageWithData: [NSData dataWithContentsOfURL: [NSURL URLWithString: @"http://chart.apis.google.com/chart?cht=bvg&chs=450x280&chd=t:20,35,10,10,5,20%7c30,55,25,50,25,10,%7c5,25,5,5,15,40&chxr=1,0,6000&chds=0,60&chco=0A8C8A,EBB671,DE091A&chbh=5,0,5&chxt=x,y&chxl=0:%7cJan%7cFeb%7cMar%7cApr%7cMay%7cJune&chdl=Vendor1%7cVendor2%7cVendor3&chg=0,8.3,0,0&chxs=5,000000,10"]]];
    
    self.myimgview.image=myimage;
    self.myimgview2.image=myimage;
    
    
}

@end
