//
//  settingsleaveviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 20/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "settingsleaveviewsclass.h"
#import "settingsViewController.h"
#import "leaveSettingsViewsClass.h"
#import "connectionclass.h"
#import "attendancesettingsviewclass.h"
@implementation settingsleaveviewsclass


- (void)awakeFromNib
{
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    self.leaveTileIDArray=[[NSMutableArray alloc]init];
    
    self.finalDict=[[NSMutableDictionary alloc]init];
    
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];
    
    self.typeValue=@"1";
    [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
    [self.finalDict setObject:@"" forKey:@"leaveName"];
    [self.finalDict setObject:@"" forKey:@"abbreviation"];
    [self.finalDict setObject:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"] forKey:@"office_id"];
    
    
    accordion = [[AccordionView alloc] initWithFrame:CGRectMake(10, 110, 625, 460)];
    [self addSubview:accordion];
    
    //appdelegate array clearing
    
    [app.conditionIDArray removeAllObjects];
    app.selectedRow=0;
    app.ruleID=app.conditionID=@"0";
    [app.conditionIDArray addObject:@"0"];
    app.conditionCount=0;
    
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"leaveDict"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabledabledradiobuttons) name:@"enabledabledradiobuttons" object:Nil];
    
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
        
        self.plusButton.hidden=false;
        
        [self.myconnection individualLeaveView:[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveRuleID"]];
    }
    else
    {
        self.plusButton.hidden=true;
    }
    
}
-(IBAction)cancelButtonAction:(id)sender
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"create"])
        {
            if (!([app.ruleID isEqualToString:@"0"])) {
                [self.myconnection deleteLeave:app.ruleID];
            }
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"leaveStatus"];
        [self removeFromSuperview];
    });
    
}

-(IBAction)donebuttonaction:(id)sender
{
    if ([app.ruleID isEqualToString:@"0"]) {
        [self alertAction:@"Must Save Atleast one Condition"];
    }
    else
    {
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveAction"]isEqualToString:@"update"]) {
            NSLog(@"%@",self.finalDict);
            if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveStatus"]isEqualToString:@"D"]) {
                if ((self.leaveName.text.length >0 ) && (self.abbrvText.text.length > 0)) {
                    
                    [self saveAction];
                }
                else
                {
                    [self alertAction:@"Mandatory Field Required"];
                }
            }
            else
            {
                [self saveAction];
            }
            
        }
        
        else
        {
            if ((self.leaveName.text.length >0 ) && (self.abbrvText.text.length > 0)) {
                [self.finalDict setObject:app.ruleID forKey:@"leave_id"];
                [self.finalDict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] forKey:@"office_id"];
                [self saveAction];
            }
            else
            {
                [self alertAction:@"Mandatory Field Required"];
            }
            
            
        }
    }
    
}
-(void)saveAction
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        
        
        [self.myconnection finalUpdateLeaveSettings:self.finalDict];
        [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"leaveStatus"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"close" object:Nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
        
        //[self removeFromSuperview];
    });
    
}

-(void)initiallyLeaveRuleViewResponse:(NSMutableArray *)leavesArray
{
    if ([leavesArray count]>0) {
            
        dispatch_async(dispatch_get_main_queue(), ^{
            attendancesettingsviewclass *ob = (attendancesettingsviewclass *)self.superview.superview;
                
            [ob initiallyLeaveRuleViewResponse:leavesArray];
                
            [self removeFromSuperview];
        });
            
            
        }
}
-(void)alertAction:(NSString *)alertMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Warning"
                               message:[NSString stringWithFormat:@"%@",alertMessage]
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
}

-(IBAction)radioButtonAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if (button.tag==1) {
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];
        self.typeValue=@"1";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        
    }
    else if (button.tag==2)
    {
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"radioButtonSelection"];
        self.typeValue=@"3";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
    }
    else
    {
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"radioButtonSelection"];
        self.typeValue=@"2";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];

    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.fixedText) {
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];
        self.typeValue=@"1";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        return  NO;
    }
    else if (textField==self.onrequestText)
    {
        
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"radioButtonSelection"];
        self.typeValue=@"2";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        return  NO;
    }
    else if (textField==self.attendanceText)
    {
        [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
        [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
        [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"radioButtonSelection"];
        self.typeValue=@"3";
        [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        return  NO;
    }
    else
    {
        return  YES;
    }
    


}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if (textField==self.leaveName) {
        [self.finalDict setObject:self.leaveName.text forKey:@"leaveName"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
    }
    else if (textField==self.abbrvText)
    {
        [self.finalDict setObject:self.abbrvText.text forKey:@"abbreviation"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
    }
    return  YES;
}

-(void)disabledradiobuttons
{
    self.radioButtonFirst.userInteractionEnabled=FALSE;
    self.radioButtonSecond.userInteractionEnabled=FALSE;
    self.radioButtonThird.userInteractionEnabled=FALSE;
    self.fixedText.userInteractionEnabled=FALSE;
    self.onrequestText.userInteractionEnabled=FALSE;
    self.attendanceText.userInteractionEnabled=FALSE;
    self.doneButton.enabled=false;
    self.plusButton.enabled=false;
    self.cancelButton.enabled=false;
    
    
    
}
-(void)enabledabledradiobuttons
{
    if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leaveStatus"]isEqualToString:@"S"]) {
        self.radioButtonFirst.userInteractionEnabled=NO;
        self.radioButtonSecond.userInteractionEnabled=NO;
        self.radioButtonThird.userInteractionEnabled=NO;
        self.fixedText.userInteractionEnabled=NO;
        self.onrequestText.userInteractionEnabled=NO;
        self.attendanceText.userInteractionEnabled=NO;
        
    }
    else
    {
        self.radioButtonFirst.userInteractionEnabled=TRUE;
        self.radioButtonSecond.userInteractionEnabled=TRUE;
        self.radioButtonThird.userInteractionEnabled=TRUE;
        self.fixedText.userInteractionEnabled=TRUE;
        self.onrequestText.userInteractionEnabled=TRUE;
        self.attendanceText.userInteractionEnabled=TRUE;
    }
    self.cancelButton.enabled=true;
    self.doneButton.enabled=true;
    self.plusButton.enabled=true;
}
-(void)willRemoveSubview:(UIView *)subview
{
    if([app.action isEqualToString:@"popup"])
    {
        //self.superview.superview.userInteractionEnabled=true;
        //self.superview.superview.superview.userInteractionEnabled=true;
        //self.superview.userInteractionEnabled=true;
        for (leaveSettingsViewsClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[leaveSettingsViewsClass class]]) {
                
                for (UIView *view in myView.subviews) {
                    if ([view isKindOfClass:[UIButton class]]) {
                        if (view.tag==101) {
                            UIButton *button=(UIButton *)view;
                            button.enabled=YES;
                            
                        }
                    }
                }
            }
        }
    
    }
    
    else
    {
        NSMutableArray *selectedDeignationArray=[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedDesig"];
        // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"selectedDesig"];
        NSLog(@"%@",self.subviews);
        for (leaveSettingsViewsClass *myView in accordion.scrollView.subviews) {
            if ([myView isKindOfClass:[leaveSettingsViewsClass class]]) {
                
                [myView collectionViewReload:selectedDeignationArray];
            }
        }
    }
}


//<<--------------------------Service Response--------------------------------->>
-(void)serviceGotResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
   
        NSMutableArray *leaveArray=[responseData objectForKey:@"leave_rule"];
        NSMutableDictionary *leaveDetails=[leaveArray objectAtIndex:0];
        NSMutableArray *condtionArray=[responseData objectForKey:@"leave_rule_condtions"];
        app.conditionCount=condtionArray.count;
    
        [self.leaveTileIDArray removeLastObject];
    
        for (int i=0; i<condtionArray.count; i++) {
            NSMutableDictionary *condtionDict=[condtionArray objectAtIndex:i];
            [self.leaveTileIDArray addObject:[condtionDict objectForKey:@"id"]];
        }
        
        AccordionView *myobj = (AccordionView *)[self.subviews lastObject];
        [myobj CreationoftileforUpdation:condtionArray.count];
        
        
        [app.conditionIDArray removeAllObjects];
        [app.conditionIDArray addObjectsFromArray:self.leaveTileIDArray];
        app.ruleID=[leaveDetails objectForKey:@"leave_id"];
        //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"conditionID"];
        //[[NSUserDefaults standardUserDefaults]setObject:self.leaveTileIDArray forKey:@"conditionID"];
    
        [[NSUserDefaults standardUserDefaults]setObject:[leaveDetails objectForKey:@"leave_flag_type"] forKey:@"leaveStatus"];
        if ([[leaveDetails objectForKey:@"leave_flag_type"]isEqualToString:@"S"]) {
            self.leaveName.hidden=true;
            self.abbrvText.hidden=true;
            self.mandatoryLabel1.hidden=true;
            self.mandatoryLabel2.hidden=true;
            self.leaveNameLabel.frame=CGRectMake(self.leaveNameLabel.frame.origin.x, 32, self.leaveNameLabel.frame.size.width, self.leaveNameLabel.frame.size.height);
            self.abbrvLabel.frame=CGRectMake(self.abbrvLabel.frame.origin.x, 32, self.abbrvLabel.frame.size.width, self.abbrvLabel.frame.size.height);
            self.leaveNameLabel.text=[leaveDetails objectForKey:@"leave_name"];
            self.abbrvLabel.text=[leaveDetails objectForKey:@"leave_abbrv"];
            
            self.radioButtonFirst.userInteractionEnabled=NO;
            self.radioButtonSecond.userInteractionEnabled=NO;
            self.radioButtonThird.userInteractionEnabled=NO;
            self.fixedText.userInteractionEnabled=NO;
            self.onrequestText.userInteractionEnabled=NO;
            self.attendanceText.userInteractionEnabled=NO;
        
        
        }
        else
        {
            self.leaveName.text=[leaveDetails objectForKey:@"leave_name"];
            self.abbrvText.text=[leaveDetails objectForKey:@"leave_abbrv"];
        }
        if ([[leaveDetails objectForKey:@"leave_type"]isEqualToString:@"1"]) {
            [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"radioButtonSelection"];
            self.typeValue=@"1";
            [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
            [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        }
        if ([[leaveDetails objectForKey:@"leave_type"]isEqualToString:@"2"]) {
            [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"radioButtonSelection"];
            self.typeValue=@"2";
            [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
            [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        }
        if ([[leaveDetails objectForKey:@"leave_type"]isEqualToString:@"3"]) {
            [self.radioButtonSecond setImage:[UIImage imageNamed:@"radio button on11.png"] forState:UIControlStateNormal];
            [self.radioButtonFirst setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [self.radioButtonThird setImage:[UIImage imageNamed:@"radio button off11.png"] forState:UIControlStateNormal ];
            [[NSUserDefaults standardUserDefaults]setObject:@"3" forKey:@"radioButtonSelection"];
            self.typeValue=@"3";
            [self.finalDict setObject:self.typeValue forKey:@"leaveType"];
            [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
        }
        [[NSUserDefaults standardUserDefaults]setObject:[leaveDetails objectForKey:@"leave_abbrv"] forKey:@"abbrv"];
       
        
        [self.finalDict setObject:[leaveDetails objectForKey:@"leave_id"] forKey:@"leave_id"];
        [self.finalDict setObject:[leaveDetails objectForKey:@"office_id"] forKey:@"office_id"];
        [self.finalDict setObject:[leaveDetails objectForKey:@"leave_name"] forKey:@"leaveName"];
        [self.finalDict setObject:[leaveDetails objectForKey:@"leave_abbrv"] forKey:@"abbreviation"];
        [[NSUserDefaults standardUserDefaults]setObject:self.finalDict forKey:@"leaveDict"];
    
        
    });
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.abbrvText) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=4) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return  NO;
        }
        
    }
    else if (textField==self.leaveName)
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=49) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ abcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        }
        else
        {
            return  NO;
        }
    }
    else
    {
        return YES;
    }

}
-(IBAction)plusNewTile:(id)sender
{
    if ([app.conditionIDArray.lastObject isEqualToString:@"0"]) {
        [self alertAction:@"Can't make an empty Condition"];
    }
    else
    {
        AccordionView *myobj = (AccordionView *)[self.subviews lastObject];
        [myobj addNewTileForUpdation:app.conditionIDArray.count];
    }

    
}

@end
