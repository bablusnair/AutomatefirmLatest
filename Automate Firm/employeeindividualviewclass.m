//
//  employeeindividualviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/8/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeeindividualviewclass.h"

@implementation employeeindividualviewclass
@synthesize tileTitle,rowSize,z;

- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
}

- (void)awakeFromNib
{
  
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"employeeIndividualid"]);
    [self.myconnection employeeindividualServicedata:[[NSUserDefaults standardUserDefaults] objectForKey:@"employeeIndividualid"]];
    
    

    
}
-(void)addAccordian
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        accordion = [[IndividualAccordionView alloc] initWithFrame:CGRectMake(19, 78, 817, 587)];
        
        [self addSubview:accordion];
        //self backgroundColor = [UIColor colorWithRed:0.925 green:0.941 blue:0.945 alpha:1.000];
        
        // Only height is taken into account, so other parameters are just dummy
        UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        UIImageView *desigImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        desigImage.image=[UIImage imageNamed:@"designation.png"];
        [header addSubview:desigImage];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 150, 20)];
        label.text=self.designationString;
        [label setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header addSubview:label];
        [header setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        header.tag=1;
        NSArray *array0=[[NSBundle mainBundle]loadNibNamed:@"employeeAccount" owner:self options:nil];
        [accordion addHeader:header withView:[array0 objectAtIndex:0]];
        
        
        
        UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        UIImageView *detailsImage=[[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 20, 20)];
        detailsImage.image=[UIImage imageNamed:@"doc_icon_new.png"];
        [header1 addSubview:detailsImage];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 150, 20)];
        label1.text=@"Details";
        [label1 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label1.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header1 addSubview:label1];
        [header1 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        header1.tag=2;
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"employeedetailsView" owner:self options:nil];
        [accordion addHeader:header1 withView:[array objectAtIndex:0]];
        
        
        
        
        UIButton *header2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        UIImageView *leaveImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        leaveImage.image=[UIImage imageNamed:@"leavesicon_blue2.png"];
        //leaveImage.image=[UIImage imageNamed:@"leave_active_new.png"];
        [header2 addSubview:leaveImage];
        UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 150, 20)];
        label2.text=@"Leaves";
        [label2 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label2.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header2 addSubview:label2];
        
        [header2 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        header2.tag=3;
        NSArray *array1=[[NSBundle mainBundle]loadNibNamed:@"employeeleaveview" owner:self options:nil];
        
        [accordion addHeader:header2 withView:[array1 objectAtIndex:0]];
        
        
        
        
        UIButton *header3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        UIImageView *documentImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 3, 20, 22)];
        documentImage.image=[UIImage imageNamed:@"folder_icon_1.png"];
        [header3 addSubview:documentImage];
        UILabel *label3=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 150, 20)];
        label3.text=@"Documents";
        [label3 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label3.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header3 addSubview:label3];
        
        [header3 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        header3.tag=4;
        NSArray *array2=[[NSBundle mainBundle]loadNibNamed:@"employeeDocumentViews" owner:self options:nil];
        
        [accordion addHeader:header3 withView:[array2 objectAtIndex:0]];
        
        //    UIButton *header4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        //    UILabel *label4=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
        //    label4.text=@"Tasks";
        //    [label4 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        //    label4.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        //    [header4 addSubview:label4];
        //
        //    [header4 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        //
        //    NSArray *array3=[[NSBundle mainBundle]loadNibNamed:@"employeetasksview" owner:self options:nil];
        
        //[accordion addHeader:header4 withView:[array3 objectAtIndex:0]];
        
        UIButton *header5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        UIImageView *statsImage=[[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        statsImage.image=[UIImage imageNamed:@"stats_icon.png"];
        [header5 addSubview:statsImage];
        UILabel *label5=[[UILabel alloc]initWithFrame:CGRectMake(35, 5, 150, 20)];
        label5.text=@"Stats";
        [label5 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label5.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header5 addSubview:label5];
        
        [header5 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        header5.tag=6;
        NSArray *array4=[[NSBundle mainBundle]loadNibNamed:@"employeestatsView" owner:self options:nil];
        
        [accordion addHeader:header5 withView:[array4 objectAtIndex:0]];
        
        [accordion setNeedsLayout];
        
        
        // Set this if you want to allow multiple selection
        
        [accordion setAllowsMultipleSelection:YES];
        
        // Set this to NO if you want to have at least one open section at all times
        [accordion setAllowsEmptySelection:YES];
    });
    
}


-(IBAction)editbuttonaction:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"empStatus"];
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"employeeview" owner:self options:nil];
        
        [self addSubview:[array objectAtIndex:0]];
    });
}

-(IBAction)closebuttonaction:(id)sender
{
    
    [self removeFromSuperview];
    
}

-(void)employeeindividualGotreponsedata:(NSMutableDictionary *)idresponsedict
{
    dispatch_async(dispatch_get_main_queue(), ^{
        self.designationString=[[idresponsedict objectForKey:@"basic_info"]objectForKey:@"designation_title"];
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:idresponsedict];
        
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"employeewholeDetails"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [self addAccordian];
    });
}


@end
