//
//  leaveDocumentsClass.m
//  Automate Firm
//
//  Created by leonine on 11/20/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "leaveDocumentsClass.h"
#import "documentInnerViewClass.h"
#import "settingsViewController.h"
@implementation leaveDocumentsClass

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
   // [[NSUserDefaults standardUserDefaults]setObject:@"advance" forKey:@"accordianAction"];
    
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    app.ruleID=@"0";
    app.conditionID=@"0";
    app.conditionCount=0;
    [app.conditionIDArray removeAllObjects];
    
    app.ruleID=[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveID"];
    [self.myconnection individualProtocolRuleView:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] :app.ruleID :@"leave"];
    
    

    
}

-(void)willRemoveSubview:(UIView *)subview
{
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"employee"]) {
        NSMutableArray *selectedEmployeeArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployee"];
        NSData *imageData=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedEmployeeIcon"];
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                
                [myView specificEmployee:selectedEmployeeArray :  imageData];
            }
        }
    }
    else if([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"includedesignation"])
    {
        NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selected_emp"];
        NSLog(@"%@",self.subviews);
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                
                [myView collectionViewReload:selectedDeignationArray];
            }
        }
    }
    else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"popupAction"]isEqualToString:@"designation"])
    {
        NSMutableArray *selectedDesignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        for (documentInnerViewClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[documentInnerViewClass class]]) {
                [myView assignDesignation:selectedDesignationArray];
            }
        }
    }
    else
    {
        
    }
    
}
-(IBAction)doneButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
-(IBAction)cancelButtonAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enableDocumentsCollectionView" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    [self removeFromSuperview];
}
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if ([self.declarationText.text isEqualToString:@"Declaration Message"]) {
        self.declarationText.text=@"";
    }
    self.declarationText.textColor=[UIColor blackColor];
    return YES;
}
- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (!(self.declarationText.text.length > 0 )) {
        self.declarationText.text=@"Declaration Message";
        self.declarationText.textColor=[UIColor lightGrayColor];
    }
    return YES;
}
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        NSLog(@"%@",responseData);
        
        NSMutableDictionary *leaveDetailsDict=[[responseData objectForKey:@"leave_details"]objectAtIndex:0];
        
        if ([leaveDetailsDict objectForKey:@"declaration_msg"]!=(id)[NSNull null]) {
            self.declarationText.text=[leaveDetailsDict objectForKey:@"declaration_msg"];
        }
        else
            self.declarationText.text=@"";
        
        self.leaveTypeLabel=[leaveDetailsDict objectForKey:@"leave_abbrv"];
        self.leaveNameLabel.text=[NSString stringWithFormat:@"%@ (%@)",[leaveDetailsDict objectForKey:@"leave_name"],self.leaveTypeLabel];
        if ([self.leaveTypeLabel isEqualToString:@"MTRN"]) {
            self.declarationView.hidden=false;
        }
        else
        {
            self.declarationView.hidden=true;
            
        }
        
        
        
        NSMutableArray *protocolArray=[responseData objectForKey:@"protocol_details"];
        for (int i=0; i<protocolArray.count; i++) {
            NSMutableDictionary *protocolDict=[protocolArray objectAtIndex:i];
            [app.conditionIDArray addObject:[protocolDict objectForKey:@"tile_id"]];
        }
        
        
        NSInteger count=app.conditionIDArray.count;
        int arrayCount= (int)count;
        if (arrayCount > 0) {
            
            [[NSUserDefaults standardUserDefaults]setObject:@"update" forKey:@"paperworkAction"];
            self.plusButton.hidden=false;
            if ([self.leaveTypeLabel isEqualToString:@"MTRN"]) {
                accordion = [[DocumentTile alloc] initWithFrame:CGRectMake(22, 145, 602, 465)];
                self.plusButton.frame=CGRectMake(self.plusButton.frame.origin.x, 108, self.plusButton.frame.size.width, self.plusButton.frame.size.height);
            }
            else
            {
                accordion = [[DocumentTile alloc] initWithFrame:CGRectMake(22, 95, 602, 465)];
                self.plusButton.frame=CGRectMake(self.plusButton.frame.origin.x, 58, self.plusButton.frame.size.width, self.plusButton.frame.size.height);
            }
            [self addSubview:accordion];
            
            
            app.conditionCount=arrayCount;
            DocumentTile *myobj = (DocumentTile *)[self.subviews lastObject];
            [myobj CreationoftileforUpdation:arrayCount];

            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"create" forKey:@"paperworkAction"];
            self.plusButton.hidden=true
            ;
            if ([self.leaveTypeLabel isEqualToString:@"MTRN"]) {
                accordion = [[DocumentTile alloc] initWithFrame:CGRectMake(22, 108, 602, 465)];
            }
            else
            {
                accordion = [[DocumentTile alloc] initWithFrame:CGRectMake(22, 58, 602, 465)];
            }
            [app.conditionIDArray addObject:@"0"];
            [self addSubview:accordion];
        }
        
        
        
        
    });
}

-(IBAction)plusButtonAction:(id)sender
{
    if ([app.conditionIDArray.lastObject isEqualToString:@"0"]) {
        [self showalerviewcontroller:@"Can't make an empty Condition"];
    }
    else
    {
        NSInteger count=app.conditionIDArray.count;
        int arrayCount= (int)count;
        
        DocumentTile *myobj = (DocumentTile *)[self.subviews lastObject];
        [myobj addNewTileForUpdation:arrayCount];
    }
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",errorMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                   
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"%@",self.superview.superview.superview.superview);
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}

@end
