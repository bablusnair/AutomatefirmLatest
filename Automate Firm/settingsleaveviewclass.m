//
//  settingsleaveviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "settingsleaveviewclass.h"

@implementation settingsleaveviewclass


- (void)awakeFromNib
{
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(22, 130, 600, 400)];
    
    
    [self addSubview:accordion];
    
    UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 150, 20)];
    label.text=@"Group Name 1";
    [label setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
    label.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
    [header addSubview:label];
    [header setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
    
    NSArray *array0=[[NSBundle mainBundle]loadNibNamed:@"settingsleaveconditionview" owner:self options:nil];
    [accordion addHeader:header withView:[array0 objectAtIndex:0]];
    
    
    UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    label1.text=@"Group Name 2";
    [label1 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
    label1.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
    [header1 addSubview:label1];
    [header1 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
    
    NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"settingsleaveconditionview" owner:self options:nil];
    [accordion addHeader:header1 withView:[array objectAtIndex:0]];
    
    
    UIButton *header2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    label2.text=@"Group Name 3";
    [label2 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
    label2.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
    [header2 addSubview:label2];
    
    [header2 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
    
    NSArray *array1=[[NSBundle mainBundle]loadNibNamed:@"settingsleaveconditionview" owner:self options:nil];
    
    [accordion addHeader:header2 withView:[array1 objectAtIndex:0]];
    
    UIButton *header3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
    UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    label3.text=@"Group Name 4";
    [label3 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
    label3.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
    [header3 addSubview:label3];
    
    [header3 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
    
    NSArray *array2=[[NSBundle mainBundle]loadNibNamed:@"settingsleaveconditionview" owner:self options:nil];
    
    [accordion addHeader:header3 withView:[array2 objectAtIndex:0]];
    
    UIButton *header4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    label4.text=@"Group Name 5";
    [label4 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
    label4.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
    [header4 addSubview:label4];
    
    [header4 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
    
    NSArray *array3=[[NSBundle mainBundle]loadNibNamed:@"settingsleaveconditionview" owner:self options:nil];
    
    [accordion addHeader:header4 withView:[array3 objectAtIndex:0]];
    
}
-(IBAction)donebuttonaction:(id)sender
{
    
    [self removeFromSuperview];
}
-(IBAction)radioButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];
        
    }
    else if (button.tag==2)
    {
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"radioButtonSelection"];
    }
    else
    {
        [self.radioButton3 setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButton2 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButton1 setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];

    }
}
@end
