//
//  ViewController.m
//  Automate Firm
//
//  Created by leonine on 11/08/15.
//  Copyright (c) 2015 leonine. All rights reserved.
//

#import "MainViewController.h"
#import "notificationTableViewCell.h"
#import "homeViewController.h"
@interface MainViewController ()

@end

@implementation MainViewController
@synthesize currentbuttontag;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
     self.x=0;
    
    
    self.iconimagearray=[[NSMutableArray alloc] initWithObjects:@"icon_leave.png",@"icon_pef.png",@"icon_advance.png",@"icon_loan.png",@"icon_travel_expense.png",@"icon_dress code.png",@"icon_promotion letter.png",@"icon_retirement.png",@"icon_termination.png", nil];
    
    
    self.colorArray=[[NSMutableArray alloc]initWithObjects:@"Blue",@"Red",@"Green",@"Black",@"Orange", nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(IBAction)staffing:(id)sender
{
    UIButton *mybutton=(UIButton *)sender;
    self.currentbuttontag=mybutton.tag;
    [self performSegueWithIdentifier:@"staffing" sender:Nil];
}
- (IBAction)documentation:(id)sender
{
    UIButton *mybutton=(UIButton *)sender;
    self.currentbuttontag=mybutton.tag;
    [self performSegueWithIdentifier:@"documentation" sender:Nil];
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    homeViewController *ob=[segue destinationViewController];
    if ([segue.identifier isEqualToString:@"staffing"])
    {
        ob.identifyhomebuttonindex=self.currentbuttontag;
    }
    else if ([segue.identifier isEqualToString:@"project"])
    {
        ob.identifyhomebuttonindex=self.currentbuttontag;
    }
    else if ([segue.identifier isEqualToString:@"tasks"])
    {
        ob.identifyhomebuttonindex=self.currentbuttontag;
    }
    else if ([segue.identifier isEqualToString:@"inventory"])
    {
        ob.identifyhomebuttonindex=self.currentbuttontag;
    }
    else if ([segue.identifier isEqualToString:@"documentation"])
    {
        ob.identifyhomebuttonindex=self.currentbuttontag;
    }
    
}

-(IBAction)back:(UIStoryboardSegue *)segue
{
    
    
    
}

-(IBAction)notificationButtonaction:(id)sender
{
    
    if (self.x%2==0) {
        
         [self.myscrollview setContentOffset:CGPointMake(-350, 0) animated:YES];
         self.x++;
    }
    else
    {
         [self.myscrollview setContentOffset:CGPointMake(0, 0) animated:YES];
         self.x++;
    }
    

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    if (tableView==self.colorTC) {
        return  self.colorArray.count;
    }
    else
        return [self.iconimagearray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.colorTC)
    {
        UITableViewCell *cell=[[UITableViewCell alloc]init];
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.colorArray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else
    {
        notificationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"notificationTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        
        cell.myimgview.image=[UIImage imageNamed:[self.iconimagearray objectAtIndex:indexPath.row]];
        
        if(indexPath.row==1)
        {
            cell.backgrdimgview.image=[UIImage imageNamed:@"selecteded.png"];
        }
        else if(indexPath.row==2)
        {
            cell.backgrdimgview.image=[UIImage imageNamed:@"selecteded.png"];
        }
        
        else if(indexPath.row==3)
        {
            cell.backgrdimgview.image=[UIImage imageNamed:@"selecteded.png"];
        }
        else
        {
            cell.backgrdimgview.image=[UIImage imageNamed:@"background.png"];
        }
        
        
        // cell.backgrdimgview.image=[UIImage imageNamed:@"background.png"];
        return cell;
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.colorTC) {
        [[NSUserDefaults standardUserDefaults]setObject:[self.colorArray objectAtIndex:indexPath.row] forKey:@"color"];
        //[[NSUserDefaults standardUserDefaults]synchronize];
        self.colorText.text=[self.colorArray objectAtIndex:indexPath.row];
        self.colorTC.hidden=true;
    }
    else
    {
        notificationTableViewCell *cell = (notificationTableViewCell *)[self.mytableview cellForRowAtIndexPath:indexPath];
        
        
        
        UIView *myview = [[UIView alloc] init];
        myview.backgroundColor=[UIColor clearColor];
        cell.backgroundView=myview;
        
        cell.backgrdimgview.image=[UIImage imageNamed:@"selecteded.png"];

    }
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.colorText)
    {
        self.colorTC.hidden=false;
        return NO;
    }
    else
    {
        return  YES;
    }
}

-(IBAction)Mainnotificationbuttonaction:(id)sender
{
    
    UIButton *mybutton = (UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        self.headinglabel.text=@"Reports";
        
          [self.reportbutton setImage:[UIImage imageNamed:@"sel_yellow.png"] forState:UIControlStateNormal];
          [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
          [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
          [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
          [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
          [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
          [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
        
            [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
        
        
         [self.iconimagearray removeAllObjects];
         [self.iconimagearray addObject:@"icon_advance.png"];
         [self.iconimagearray addObject:@"icon_travel_expense.png"];
         [self.iconimagearray addObject:@"icon_dress code.png"];
         [self.iconimagearray addObject:@"icon_leave.png"];
        
        [self.mytableview reloadData];
        
        
    }
   else  if (mybutton.tag==2) {
        
        
        self.headinglabel.text=@"Paperworks";
        
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"sel_blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];

       
       [self.mytableview reloadData];
       


       
    }
    
   else  if (mybutton.tag==3) {
       
       self.headinglabel.text=@"Projects";
       
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"sel_green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       
       [self.mytableview reloadData];

       
       
   }
    
   else  if (mybutton.tag==4) {
       
       self.headinglabel.text=@"Staffing";
       
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"sel_deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       
       
       [self.mytableview reloadData];

       
       
       
   }
   else  if (mybutton.tag==5) {
       
       
       self.headinglabel.text=@"Task";
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"sel_yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       
       
       [self.mytableview reloadData];
       

       
       
       
   }
   else  if (mybutton.tag==6) {
       
       
       self.headinglabel.text=@"Inventary";
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"sel_orange.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
    
       
       
       [self.mytableview reloadData];
       

       
       
       
   }
    
   else  if (mybutton.tag==7) {
       
       
       self.headinglabel.text=@"Marketing";
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"sel_purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       [self.iconimagearray addObject:@"icon_dress code.png"];
       [self.iconimagearray addObject:@"icon_leave.png"];
       
       
       [self.mytableview reloadData];
       

       
       
       
       
   }
   else  if (mybutton.tag==8) {
       
       
       self.headinglabel.text=@"Surveillance";
       
       [self.reportbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.paperworkbutton setImage:[UIImage imageNamed:@"blue.png"] forState:UIControlStateNormal];
       [self.projectbutton setImage:[UIImage imageNamed:@"green.png"] forState:UIControlStateNormal];
       [self.staffingbutton setImage:[UIImage imageNamed:@"deep_yellow.png"] forState:UIControlStateNormal];
       [self.taskbutton setImage:[UIImage imageNamed:@"yellow.png"] forState:UIControlStateNormal];
       [self.inventarybutton setImage:[UIImage imageNamed:@"orangre.png"] forState:UIControlStateNormal];
       [self.marketingbutton setImage:[UIImage imageNamed:@"purple.png"] forState:UIControlStateNormal];
       
       [self.survillancebutton setImage:[UIImage imageNamed:@"sel_deep_yellow.png"] forState:UIControlStateNormal];
       
       
       
       [self.iconimagearray removeAllObjects];
       [self.iconimagearray addObject:@"icon_advance.png"];
       [self.iconimagearray addObject:@"icon_travel_expense.png"];
       
       
       
       [self.mytableview reloadData];
       

       
   }


    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    self.x=0;
}
- (IBAction)cartBtnAction:(id)sender {
    [self performSegueWithIdentifier:@"cartView" sender:nil];
}
-(IBAction)logoutAction:(id)sender
{
    [self.myconnection logoutAction];
}
@end
