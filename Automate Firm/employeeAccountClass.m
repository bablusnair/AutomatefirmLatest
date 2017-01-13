//
//  employeeAccountClass.m
//  bablusdemokpproject
//
//  Created by leonine on 8/22/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeeAccountClass.h"
#import "IndividualAccordionView.h"
#import "homeViewController.h"
@implementation employeeAccountClass
@synthesize flag;
-(void)awakeFromNib
{
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSMutableDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
      flag=0;
    self.descriptionArray=[[NSMutableArray alloc]init];
    NSString *description=[[employeedictdetails objectForKey:@"basic_info"]objectForKey:@"des_description"];
    self.descriptionArray=[[description componentsSeparatedByString:@"###"] mutableCopy];
    [self.descriptionArray removeObject:@""];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(viewLoaded) name:@"descriptionLoad" object:nil];
}
-(void)viewLoaded
{
    self.saveButton.hidden=true;
    [self.myconnection employeeindividualServicedata:[[NSUserDefaults standardUserDefaults] objectForKey:@"employeeIndividualid"]];
    flag=0;
    [self.descriptionTC reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.descriptionArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    designationTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"designationTableViewCell" owner:self options:nil];
        cell=[array objectAtIndex:0];
    }
    cell.descriptionView.text=[self.descriptionArray objectAtIndex:indexPath.row];
    cell.descriptionView.delegate=self;
    cell.headingLabel.text=[NSString stringWithFormat:@"Job Description %d",indexPath.row+1];
    if (flag==0) {
        cell.descriptionView.layer.borderWidth=0.0;
    }
    else
    {
        if(indexPath.row==self.descriptionArray.count-1)
        {
            cell.descriptionView.layer.borderWidth = 1.0;
            
            cell.descriptionView.layer.borderColor = [UIColor grayColor].CGColor;
        }
    }
    
    return cell;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    designationTableViewCell *cell=(designationTableViewCell *)[[textView superview ]superview];
    
    NSIndexPath *inPath=[self.descriptionTC indexPathForCell:cell];
    if (inPath.row==self.descriptionArray.count-1) {
        [self.descriptionArray replaceObjectAtIndex:inPath.row withObject:cell.descriptionView.text];
        flag=0;
    }
    else
    {
        [self.descriptionArray replaceObjectAtIndex:inPath.row withObject:cell.descriptionView.text];
    }
    self.saveButton.hidden=false;
    [self.descriptionTC reloadData];
    return  YES;
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    self.app.warningflag=1;
    return  YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle==UITableViewCellEditingStyleDelete) {
        UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Delete?"
                                       message:@"Are you sure you want to delete?"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           self.app.warningflag=1;
                                                           self.saveButton.hidden=false;
                                                           [self.descriptionArray removeObjectAtIndex:indexPath.row];
                                                           [self.descriptionTC reloadData];
                                                           
                                                           
                                                       }];
            
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               [self.descriptionTC setEditing:false animated:YES];
                                                           }];
            [alert addAction:ok];
            [alert addAction:cancel];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
    }
}
-(IBAction)plusDescription:(id)sender
{
    if (!([self.descriptionArray containsObject:@""])) {
        [self.descriptionArray addObject:@""];
        flag=1;
        
        
        NSArray *visibleItems = [self.descriptionTC indexPathsForVisibleRows];
        [self.descriptionTC reloadData];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.descriptionArray.count - 1 inSection:currentItem.section];
        //[self.expenseCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        [self.descriptionTC scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    else
    {
        [self showalerviewcontroller:@"Can not make an empty description"];
    }
    
}
-(IBAction)saveDescription:(id)sender
{
    [self.descriptionArray removeObject:@""];
    NSString *description=[self.descriptionArray componentsJoinedByString:@"###"];
    NSMutableDictionary *descriptionDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.empID,@"emp_id",description,@"description", nil];
    [self.myconnection saveDesignationDescription:descriptionDict];
}


-(void)employeeindividualGotreponsedata:(NSMutableDictionary *)idresponsedict
{
    dispatch_async(dispatch_get_main_queue(), ^{
       
        [self.descriptionArray removeAllObjects];
        
        NSString *description=[[idresponsedict objectForKey:@"basic_info"]objectForKey:@"des_description"];
        self.empID=[[idresponsedict objectForKey:@"basic_info"]objectForKey:@"emp_id"];
        self.descriptionArray=[[description componentsSeparatedByString:@"###"] mutableCopy];
        [self.descriptionArray removeObject:@""];
        [self.descriptionTC reloadData];

    });
}
-(void)createResponse:(id)Response
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([Response isEqualToString:@"1"]) {
            self.app.warningflag=0;
            IndividualAccordionView *ob = (IndividualAccordionView *)self.superview.superview;
            
            [ob closeTile];
            
        }
        else
        {
            [self showalerviewcontroller:@"Failed to Save"];
        }
        
        
    });
}
-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                       
                                                   }];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}
@end
