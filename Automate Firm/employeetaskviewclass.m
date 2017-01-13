//
//  employeetaskviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeetaskviewclass.h"

@implementation employeetaskviewclass
-(void)awakeFromNib
{
    
    
//    NSMutableDictionary *employeedictdetails = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
//    
//    NSMutableDictionary *emptasks = [employeedictdetails objectForKey:@"tasks"];
//    
//    NSLog(@"%@",emptasks);
    

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    employeetaskcellclass *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"employeetaskcell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    if((indexPath.row==0)&&(indexPath.row==3))
        cell.myImg.image=[UIImage imageNamed:@"red1.png"];
    else if(indexPath.row==1)
        cell.myImg.image=[UIImage imageNamed:@"green1.png"];
    else
    {
        cell.myImg.image=[UIImage imageNamed:@"yellow1.png"];
    }
    return cell;
}

- (IBAction)btn1:(id)sender {
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.btnstar1 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar2 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar3 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar4 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar5 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==2) {
        [self.btnstar2 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar1 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar3 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar4 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar5 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==3) {
        [self.btnstar3 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar2 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar1 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar4 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
        [self.btnstar5 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
    }
    else if (button.tag==4) {
        [self.btnstar4 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar2 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar3 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar1 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar5 setImage:[UIImage imageNamed:@"star_empty.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnstar5 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar2 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar3 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar4 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
        [self.btnstar1 setImage:[UIImage imageNamed:@"star_fill.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)btn2:(id)sender {
}

- (IBAction)btn3:(id)sender {
}
@end
