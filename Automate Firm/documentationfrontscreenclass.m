//
//  documentationfrontscreenclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "documentationfrontscreenclass.h"
#import "documentationfronttablecellviewclass.h"
#import "movetableviewcellview.h"
#import "documentcollectionviewclass.h"
#import "homeViewController.h"
#import "AppDelegate.h"
#import "filtercellTableViewCell.h"
@implementation documentationfrontscreenclass
@synthesize actionFlag;

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
     self.obj=[[commonFunctionsCallClass alloc]init];
    
    [self.myconnection filterlistingaction:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];

    [self.myconnection documentationList:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    self.folderFlag=0;
     self.documentDictionary=[[NSMutableDictionary alloc]init];
    self.documentdict=[[NSMutableDictionary alloc] init];
    
     self.saveingDictionary=[[NSMutableDictionary alloc] init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upperbuttonchaneges) name:@"buttondisabledfunction" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(upperbuttonoldchanges) name:@"buttonenabledfunction" object:Nil];
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablesignbutton) name:@"disablesignbutton" object:Nil];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablesignbutton) name:@"enablesignbutton" object:Nil];
    
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectallpresent) name:@"deselectallpresent" object:Nil];
    
    
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deselectallabsent) name:@"deselectallabsent" object:Nil];

    
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"documentcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"documentcell"];
    
    self.y=0;
    self.y1=0;
    self.filterflag=0;
    self.actionstring=@"Move";
    self.moveView.hidden=TRUE;
    self.folderslistview.hidden=TRUE;
     self.filterviews.hidden=TRUE;
     self.deletebutton.hidden=TRUE;
    
    self.maindict=[[NSMutableDictionary alloc] init];
    
     self.foldernamesdict=[[NSMutableDictionary alloc] init];
    
    self.selectedarray=[[NSMutableArray alloc] init];
    
    self.customfoldernamesarray=[[NSMutableArray alloc] init];
    
    self.CustomFolderarray=[[NSMutableArray alloc] init];
    
    
    self.Folderstring=@"New Folder 1";
    
    
    //self.uploadbutton.hidden=TRUE;
    
    self.deselectallbutton.hidden=TRUE;
    
    self.signaturebutton.hidden=TRUE;
    
    self.printbutton.alpha=0.5;
    
    self.emailbutton.alpha=0.5;
    
    self.printbutton.userInteractionEnabled=FALSE;
    
    self.emailbutton.userInteractionEnabled=FALSE;
    
    
//    self.dictarray5=[[NSMutableArray alloc] initWithObjects:dict1124,dict2124,dict3124,dict4124,dict5124,dict6124,dict7124, nil];
//    self.dictarray6=[[NSMutableArray alloc] initWithObjects:dict1124,dict2124,dict3124,dict4124,dict5124,dict6124,dict7124, nil];
//    self.dictarray7=[[NSMutableArray alloc] initWithObjects:dict1124,dict2124,dict3124,dict4124,dict5124,dict6124,dict7124, nil];
//    self.dictarray8=[[NSMutableArray alloc] initWithObjects:dict1124,dict2124,dict3124,dict4124,dict5124,dict6124,dict7124, nil];
    
    
    [self.folderbutton setImage:[UIImage imageNamed:@"folder_plusfrfr.png"] forState:UIControlStateNormal];
   
   

   // NSLog(@"%@",self.maindict);
    
    
    [self.tableView registerClass:[documentationfronttablecellviewclass class] forCellReuseIdentifier:@"ContainerTableCell"];
    
     self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
   // self.app.dropboxFlag=1;
    //NSLog(@"%d",self.app.dropboxFlag);
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDocuments) name:@"viewDocuments" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewPdf) name:@"viewPdf" object:Nil];
    
    self.storeviewsarray=[[NSMutableArray alloc] init];
    
    
    [self.renameTextField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
    
    
    
    self.selectedarray1=[[NSMutableArray alloc] init];
    self.selectedarray2=[[NSMutableArray alloc] init];
    self.selectedarray3=[[NSMutableArray alloc] init];
    self.selectedarray4=[[NSMutableArray alloc] init];
    
    
    
    self.office_servicesendarray=[[NSMutableArray alloc] init];
    self.store_servicesendarray=[[NSMutableArray alloc] init];
    self.department_servicesendarray=[[NSMutableArray alloc] init];
    self.category_servicesendarray=[[NSMutableArray alloc] init];
    self.designation_servicesendarray=[[NSMutableArray alloc] init];
    
    
    
    
    self.officearray= [[NSMutableArray alloc]init];
    self.departmentarray= [[NSMutableArray alloc]init];
    self.categoryarray= [[NSMutableArray alloc]init];
    self.designationarray= [[NSMutableArray alloc]init];
    
    

    
    self.officefilterdictionary=[[NSMutableDictionary alloc] init];
    self.storefilterdictionary=[[NSMutableDictionary alloc] init];
    self.departmentfilterdictionary=[[NSMutableDictionary alloc] init];
    self.categoryfilterdictionary=[[NSMutableDictionary alloc] init];
    self.designationfilterdictionary=[[NSMutableDictionary alloc] init];
    

    
    
    
    
}

-(void)deselectallpresent
{
   
    self.deselectallbutton.hidden=FALSE;
    
}

-(void)deselectallabsent
{
    
    self.deselectallbutton.hidden=TRUE;
    
}

-(void)enablesignbutton
{
    
    self.signaturebutton.alpha=1;
    
    self.signaturebutton.userInteractionEnabled=TRUE;
    
}


-(void)disablesignbutton
{
    
    self.signaturebutton.alpha=0.5;
    
    self.signaturebutton.userInteractionEnabled=FALSE;
    
}

-(void)upperbuttonoldchanges
{
    
    self.uploadbutton.hidden=FALSE;
    self.uploadbutton.userInteractionEnabled=TRUE;
     self.uploadbutton.alpha=1;
    self.deselectallbutton.hidden=TRUE;
    self.deletebutton.hidden=TRUE;
    
    self.signaturebutton.hidden=TRUE;
    self.signaturebutton.alpha=1;
    
    self.signaturebutton.userInteractionEnabled=TRUE;

    
    self.printbutton.alpha=0.5;
    
    self.emailbutton.alpha=0.5;
    
    self.printbutton.userInteractionEnabled=FALSE;
    
    self.emailbutton.userInteractionEnabled=FALSE;
    
    [self.folderbutton setImage:[UIImage imageNamed:@"folder_plusfrfr.png"] forState:UIControlStateNormal];
    
}

-(void)upperbuttonchaneges
{
   
    self.uploadbutton.userInteractionEnabled=FALSE;
    
    self.uploadbutton.alpha=0.5;
    
  //  self.deselectallbutton.hidden=FALSE;
    
    self.deletebutton.hidden=FALSE;
    
    self.signaturebutton.hidden=FALSE;
    
    
    self.printbutton.alpha=1;
    
    self.emailbutton.alpha=1;
    
    self.printbutton.userInteractionEnabled=TRUE;
    
    self.emailbutton.userInteractionEnabled=TRUE;
    
    [self.folderbutton setImage:[UIImage imageNamed:@"folderrrf.png"] forState:UIControlStateNormal];
    
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    if (textField.text.length>0) {
        
       
        NSMutableArray *myarray=[self.saveingDictionary objectForKey:@"custom_folder"];
        
        if (myarray.count>0) {
            
            
            NSMutableArray *foldelistarray=[[NSMutableArray alloc] init];
            
            for (int i=0; i<myarray.count; i++) {
               
                NSMutableDictionary *dict=[myarray objectAtIndex:i];
                [foldelistarray addObject:[dict objectForKey:@"folder"]];
                
            }
            
            if (foldelistarray.count>0) {
                
                if ([foldelistarray containsObject:textField.text]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:[self.foldernamesdict objectForKey:textField.text] forKey:@"myfolderId"];
                    
                    [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"folderNames"];
                    
                    [textField becomeFirstResponder];
                    
                    CGPoint buttonPosition = [textField convertPoint:CGPointZero toView:self.tableView];
                    
                    [self.tableView setContentOffset:CGPointMake(0, buttonPosition.y) animated:YES];

                    
                    self.folderFlag=1;
                }
                else
                {
                    [textField resignFirstResponder];
                    
                    self.folderFlag=0;
                }
                
            }
            
        }
    }
    else
    {
        CGPoint buttonPosition = [textField convertPoint:CGPointZero toView:self.tableView];
        
        [self.tableView setContentOffset:CGPointMake(0, buttonPosition.y) animated:YES];
        
    }

}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.renameTextField) {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=39) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar u = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:u])
            {
                return YES;
            }
            else{
                return NO;
            }
            
        }
        else
            return NO;
    }
    else
        return  YES;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.renameTextField) {
        self.renameView.frame=CGRectMake(self.renameView.frame.origin.x, 200, self.renameView.frame.size.width, self.renameView.frame.size.height);
    }
    return  YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.renameView.frame=CGRectMake(self.renameView.frame.origin.x, 227, self.renameView.frame.size.width, self.renameView.frame.size.height);
    return  YES;
}
-(void)textFieldDidChange:(UIButton *)sender
{
    
    if (self.renameTextField.text.length == 0) {
        self.renameDoneButton.enabled=NO;
    }
    else
        self.renameDoneButton.enabled=YES;
}
-(void)newDocumentationFolderaddedresponse:(NSString *)responsestring
{
    NSLog(@"%@",responsestring);
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (self.folderFlag==1) {
        
        if (textField.text.length>0) {
            
            if (![[self.documentdict allKeys]containsObject:textField.text] || [textField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"folderNames"]]) {
                
                NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
                [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] forKey:@"o_id"];
                [dict setObject:textField.text forKey:@"folder_name"];
                [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"myfolderId"] forKey:@"id"];
                
                [self.myconnection addnewDocumentationfolder:dict];
                
                self.folderFlag=0;
                
            }
            else
            {
                UIAlertController *alert= [UIAlertController
                                           alertControllerWithTitle:@"Error"
                                           message:@"Duplicate Entry Occured"
                                           preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction * action){
                                                               //Do Some action here
                                                               [self.tableView reloadData];
                                                               
                                                        }];
                [alert addAction:ok];
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
                });
                
           }
            
        }
        else
        {
            
            UIAlertController *alert= [UIAlertController
                                       alertControllerWithTitle:@"Error"
                                       message:@"NUll Entry Occured"
                                       preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                           
                                                           //self.folderFlag=0;
                                                       }];
            [alert addAction:ok];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
            });
            
        }

    }
    
    [self.tableView setContentOffset:CGPointMake(0,0) animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==self.tableView) {
        
        return [self.documentdict count];
    }
    else
    {
         return 1;
    }
     // Total number of rows in the sample data.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 
    if (tableView==self.tableView) {
        
        return 1;
    }
    
    else if(tableView==self.movetableview)
    {
        return [self.customfoldernamesarray count];
    }
    else if (tableView==self.workingpremisetableview) {
        
        return [self.officearray count];
    }
    
    else if (tableView==self.departmenttableview) {
        
        return [self.departmentarray count];
    }
    else if (tableView==self.categorytableview){
        
        return [self.categoryarray count];
    }
    else{
        
        return [self.designationarray count];
    }

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tableView) {
        
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        
        documentationfronttablecellviewclass *cell = (documentationfronttablecellviewclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"documentationfronttablecellview" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            
        }
        
        NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSMutableArray *dictarray  = [[[self.documentdict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]] mutableCopy];
        
        [dictarray removeObject:@"signed_document"];
        [dictarray insertObject:@"signed_document" atIndex:0];
    
        // NSDictionary *cellData = [self.gettinglastarray objectAtIndex:[indexPath section]];  // Note we're using section, not row here
        
        NSDictionary *articleData = [self.documentdict objectForKey:[dictarray objectAtIndex:indexPath.section]];
        
        
        NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *sortedarray  = [[articleData allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder1]];
        
        
        NSMutableArray *sendarray=[[NSMutableArray alloc] init];
        
        
        for (int i=0; i<sortedarray.count; i++) {
            
            [sendarray addObject:[articleData objectForKey:[sortedarray objectAtIndex:i]]];
            
        }

        
        [cell setCollectionData:sendarray];
        
        return cell;
    }
    else if(tableView==self.movetableview)
    {
        
        static NSString *simpleTableIdentifier = @"simplecell";
        
        
        movetableviewcellview *cell = (movetableviewcellview *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"movetableviewcellview" owner:self options:nil];
            
            cell = [nib objectAtIndex:0];
            
        }
        
        
        cell.customfoldername.text=[self.customfoldernamesarray objectAtIndex:indexPath.row];

        return cell;
        
    }
    else  if (tableView==self.workingpremisetableview)
    {
        
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        filtercellTableViewCell *cell = (filtercellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"filtercellTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.mainlabel.text=[self.officearray objectAtIndex:indexPath.row];
        //  cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        
        if ([self.selectedarray1 containsObject:indexPath]) {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        }
        else
        {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
            
        }
        
        return cell;
    }
    else  if (tableView==self.departmenttableview)
    {
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        filtercellTableViewCell *cell = (filtercellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"filtercellTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.mainlabel.text=[self.departmentarray objectAtIndex:indexPath.row];
        //  cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        
        if ([self.selectedarray2 containsObject:indexPath]) {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        }
        else
        {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
            
        }
        
        
        return cell;
    }
    else  if (tableView==self.categorytableview)
    {
        
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        filtercellTableViewCell *cell = (filtercellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"filtercellTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        cell.mainlabel.text=[self.categoryarray objectAtIndex:indexPath.row];
        //cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        
        if ([self.selectedarray3 containsObject:indexPath]) {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        }
        else
        {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
            
        }
        
        return cell;
    }
    
    else
    {
        
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        filtercellTableViewCell *cell = (filtercellTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"filtercellTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        cell.mainlabel.text=[self.designationarray objectAtIndex:indexPath.row];
        
        
        if ([self.selectedarray4 containsObject:indexPath]) {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box.png"];
        }
        else
        {
            
            cell.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
            
        }
        
        return cell;
    }

    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
   
    if (tableView==self.tableView) {
        
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor clearColor];
        documentationfronttablecellviewclass *cell= (documentationfronttablecellviewclass *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.selectedBackgroundView = v;

    }
    else if(tableView==self.movetableview)
    {
        
        UIView *v = [[UIView alloc] init];
        v.backgroundColor = [UIColor clearColor];
        movetableviewcellview *cell= (movetableviewcellview *)[self.movetableview cellForRowAtIndexPath:indexPath];
        cell.selectedBackgroundView = v;
       // NSLog(@"%@",[self.foldernamesdict objectForKey:cell.customfoldername.text]);
        
        [self.myconnection MovingCopyfunctionality:self.app.documentarray moveingfolder:[self.foldernamesdict objectForKey:cell.customfoldername.text] correspondingAction:self.actionstring];
        
    }
  else  if (tableView==self.workingpremisetableview) {
        
        filtercellTableViewCell *cell1= (filtercellTableViewCell *)[self.workingpremisetableview cellForRowAtIndexPath:indexPath];
        cell1.selectedBackgroundView = v;
        
        if (indexPath.row==0) {
            
            [self.selectedarray1 removeAllObjects];
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box (tick).png"]]) {
                
                for (int i=0; i<self.officearray.count; i++) {
                    
                    NSIndexPath *myindex = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.selectedarray1 addObject:myindex];
                    
                }
                
                [self.office_servicesendarray removeAllObjects];
                
                [self.store_servicesendarray removeAllObjects];
                
            }
            else
            {
                
                [self.office_servicesendarray removeAllObjects];
                
                [self.store_servicesendarray removeAllObjects];
                
                
                NSString *str =[self.officefilterdictionary objectForKey:[self.officearray objectAtIndex:1]];
                
                if (![self.office_servicesendarray containsObject:str]) {
                    
                    
                    [self.office_servicesendarray addObject:str];
                    
                    
                }
                
                for (int i=2; i<self.officearray.count; i++) {
                    
                    
                    NSString *str =[self.storefilterdictionary objectForKey:[self.officearray objectAtIndex:i]];
                    
                    [self.store_servicesendarray addObject:str];
                    
                    
                }
                
                
            }
            
        }
        else
        {
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box.png"]]) {
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
                [self.selectedarray1 removeObject:indexPath];
                
                if (indexPath.row==1) {
                    
                    NSString *str =[self.officefilterdictionary objectForKey:cell1.mainlabel.text];
                    
                    if (![self.office_servicesendarray containsObject:str]) {
                        
                        
                        [self.office_servicesendarray addObject:str];
                        
                        
                    }
                    
                    
                }
                else
                {
                    
                    NSString *str =[self.storefilterdictionary objectForKey:cell1.mainlabel.text];
                    
                    if (![self.store_servicesendarray containsObject:str]) {
                        
                        
                        [self.store_servicesendarray addObject:str];
                        
                    }
                    
                }
                
            }
            
            else{
                
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box.png"];
                
                [self.selectedarray1 addObject:indexPath];
                
                NSIndexPath *myindex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.selectedarray1 addObject:myindex];
                
                
                if (indexPath.row==1) {
                    
                    NSString *str =[self.officefilterdictionary objectForKey:cell1.mainlabel.text];
                    
                    if ([self.office_servicesendarray containsObject:str]) {
                        
                        
                        [self.office_servicesendarray removeObject:str];
                        
                        
                    }
                    
                }
                else
                {
                    
                    NSString *str =[self.storefilterdictionary objectForKey:cell1.mainlabel.text];
                    
                    if ([self.store_servicesendarray containsObject:str]) {
                        
                        
                        [self.store_servicesendarray removeObject:str];
                        
                        
                    }
                    
                }
                
            }
            
            
        }
        
        
        [self.workingpremisetableview reloadData];
        
    }
    
  else  if (tableView==self.departmenttableview) {
        
        filtercellTableViewCell *cell1= (filtercellTableViewCell *)[self.departmenttableview cellForRowAtIndexPath:indexPath];
        
        cell1.selectedBackgroundView = v;
        
        
        if (indexPath.row==0) {
            
            [self.selectedarray2 removeAllObjects];
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box (tick).png"]]) {
                
                
                for (int i=0; i<self.departmentarray.count; i++) {
                    
                    NSIndexPath *myindex = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.selectedarray2 addObject:myindex];
                    
                    NSString *str =  [self.departmentfilterdictionary objectForKey:[self.departmentarray objectAtIndex:i]];
                    
                    [self.department_servicesendarray removeObject:str];
                    
                }
                
            }
            else
            {
                [self.department_servicesendarray removeAllObjects];
                
                for (int i=1; i<self.departmentarray.count; i++) {
                    
                    NSString *str =  [self.departmentfilterdictionary objectForKey:[self.departmentarray objectAtIndex:i]];
                    
                    [self.department_servicesendarray addObject:str];
                    
                }
                
                
            }
            
        }
        else
        {
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box.png"]]) {
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
                [self.selectedarray2 removeObject:indexPath];
                
                NSString *mystr =[self.departmentfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if (![self.department_servicesendarray containsObject:mystr]) {
                    
                    [self.department_servicesendarray addObject:mystr];
                    
                }
                
            }
            
            else{
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box.png"];
                [self.selectedarray2 addObject:indexPath];
                
                NSIndexPath *myindex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.selectedarray2 addObject:myindex];
                
                
                NSString *mystr =[self.departmentfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if ([self.department_servicesendarray containsObject:mystr]) {
                    
                    [self.department_servicesendarray removeObject:mystr];
                    
                }
                
                // [self.departmentfilterdictionary removeObjectForKey:cell1.mainlabel.text];
                
            }
            
        }
        
        
        // NSLog(@"%@",self.department_servicesendarray);
        
        
        
        [self.departmenttableview reloadData];
        
    }
    
   else if (tableView==self.categorytableview) {
        
        
        filtercellTableViewCell *cell1= (filtercellTableViewCell *)[self.categorytableview cellForRowAtIndexPath:indexPath];
        cell1.selectedBackgroundView = v;
        
        if (indexPath.row==0) {
            
            [self.selectedarray3 removeAllObjects];
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box (tick).png"]]) {
                
                
                for (int i=0; i<self.categoryarray.count; i++) {
                    
                    NSIndexPath *myindex = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.selectedarray3 addObject:myindex];
                    
                    NSString *str =  [self.categoryfilterdictionary objectForKey:[self.categoryarray objectAtIndex:i]];
                    
                    [self.category_servicesendarray removeObject:str];
                    
                }
                
            }
            else
            {
                
                [self.category_servicesendarray removeAllObjects];
                
                for (int i=1; i<self.categoryarray.count; i++) {
                    
                    NSString *str =  [self.categoryfilterdictionary objectForKey:[self.categoryarray objectAtIndex:i]];
                    
                    [self.category_servicesendarray addObject:str];
                    
                }
                
                
            }
            
        }
        else
        {
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box.png"]]) {
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
                [self.selectedarray3 removeObject:indexPath];
                
                NSString *mystr =[self.categoryfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if (![self.category_servicesendarray containsObject:mystr]) {
                    
                    [self.category_servicesendarray addObject:mystr];
                    
                }
                
                
            }
            
            else{
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box.png"];
                [self.selectedarray3 addObject:indexPath];
                
                NSIndexPath *myindex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.selectedarray3 addObject:myindex];
                
                
                NSString *mystr =[self.categoryfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if ([self.category_servicesendarray containsObject:mystr]) {
                    
                    [self.category_servicesendarray removeObject:mystr];
                    
                }
                
                
            }
            
        }
        
        [self.categorytableview reloadData];
        
    }
    
   else if (tableView==self.filtertableView1) {
        
        
        filtercellTableViewCell *cell1= (filtercellTableViewCell *)[self.filtertableView1 cellForRowAtIndexPath:indexPath];
        cell1.selectedBackgroundView = v;
        
        
        if (indexPath.row==0) {
            
            [self.selectedarray4 removeAllObjects];
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box (tick).png"]]) {
                
                for (int i=0; i<self.designationarray.count; i++) {
                    
                    NSIndexPath *myindex = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.selectedarray4 addObject:myindex];
                    
                    NSString *str =  [self.designationfilterdictionary objectForKey:[self.designationarray objectAtIndex:i]];
                    
                    [self.designation_servicesendarray removeObject:str];
                    
                }
                
            }
            else
            {
                [self.designation_servicesendarray removeAllObjects];
                
                for (int i=1; i<self.designationarray.count; i++) {
                    
                    NSString *str =  [self.designationfilterdictionary objectForKey:[self.designationarray objectAtIndex:i]];
                    
                    [self.designation_servicesendarray addObject:str];
                    
                }
                
                
            }
            
        }
        else
        {
            
            if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box.png"]]) {
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box (tick).png"];
                [self.selectedarray4 removeObject:indexPath];
                
                
                NSString *mystr =[self.designationfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if (![self.designation_servicesendarray containsObject:mystr]) {
                    
                    [self.designation_servicesendarray addObject:mystr];
                    
                }
                
            }
            
            else{
                
                cell1.myimgview.image=[UIImage imageNamed:@"check box.png"];
                [self.selectedarray4 addObject:indexPath];
                
                NSIndexPath *myindex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.selectedarray4 addObject:myindex];
                
                
                NSString *mystr =[self.designationfilterdictionary objectForKey:cell1.mainlabel.text];
                
                if ([self.designation_servicesendarray containsObject:mystr]) {
                    
                    [self.designation_servicesendarray removeObject:mystr];
                    
                }
                
            }
            
            
            
        }
        
        [self.filtertableView1 reloadData];
    }

  
}

/*- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 NSDictionary *sectionData = [self.myarray objectAtIndex:section];
 NSString *header = [sectionData objectForKey:@"description"];
 return header;
 }*/

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
   if (tableView==self.tableView) {
        return 35;
    }
    else
    {
        return 0;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tableView) {
        
        return 149.0;
    }
    else
    {
        return 30;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        
        UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, self.tableView.frame.size.width, 35)];
        
        UILongPressGestureRecognizer *press =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressaction:)];
        [tableHeaderView addGestureRecognizer:press];
        
        tableHeaderView.backgroundColor =[UIColor colorWithPatternImage:[UIImage imageNamed:@"department blank.png"]];
        
        self.sectionTitleTF1 = [[UITextField alloc] initWithFrame:CGRectMake(48, 1, 200, 30)];
        
        [self.sectionTitleTF1 setBackgroundColor:[UIColor clearColor]];
        
        
        self.sectionTitleTF1.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
        
        
        UIImageView *iconimgview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 25, 25)];
        
        [tableHeaderView addSubview:iconimgview];
    
        NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        
        NSMutableArray *sortedarray  = [[[self.documentdict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder1]] mutableCopy];
        
        [sortedarray removeObject:@"signed_document"];
        [sortedarray insertObject:@"signed_document" atIndex:0];
        
        
        NSMutableArray *custom_array=[self.saveingDictionary objectForKey:@"custom_folder"];
          NSMutableArray *foldelistarray=[[NSMutableArray alloc] init];
        if (custom_array.count>0) {
            
            for (int i=0; i<custom_array.count; i++) {
                
                NSMutableDictionary *dict=[custom_array objectAtIndex:i];
                [foldelistarray addObject:[dict objectForKey:@"folder"]];
                
            }
            
        }
        
        NSString *header = [sortedarray objectAtIndex:section];
        
        if ([header isEqualToString:@"signed_document"]) {
            
            iconimgview.image=[UIImage imageNamed:@"signature1_icon.png"];
        }
        else if ([foldelistarray count]>0)
        {
            if ([foldelistarray containsObject:header]) {
                
                iconimgview.image=[UIImage imageNamed:@"folder_icon_1.png"];
            }
            else
            {
                iconimgview.image=[UIImage imageNamed:@"icon_employee.png"];
            }
        }
        else
        {
             iconimgview.image=[UIImage imageNamed:@"icon_employee.png"];
        }
        
        self.sectionTitleTF1.text=header;
        self.sectionTitleTF1.delegate=self;
        self.sectionTitleTF1.tag=10;
        [tableHeaderView addSubview:self.sectionTitleTF1];
        return tableHeaderView;
    }
    else
    {
        return Nil;
    }
}

-(void)longpressaction:(UILongPressGestureRecognizer *)press
{

  if (press.state == UIGestureRecognizerStateBegan){
      
      if (self.storeviewsarray.count>0) {
        
          for (int i=0; i<self.storeviewsarray.count; i++) {
              
              UIView  *myviews = (UIView *)[self.storeviewsarray objectAtIndex:i];
              UIButton *deletedbutton = (UIButton *)[myviews viewWithTag:15];
              [deletedbutton removeFromSuperview];
              
          }
      }

      UIButton *deletebutton=[[UIButton alloc] initWithFrame:CGRectMake(785, 2, 30, 30)];
      
      [deletebutton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
      [deletebutton addTarget:self action:@selector(folderdeleteaction) forControlEvents:UIControlEventTouchUpInside];
      deletebutton.tag=15;
      UIView *myview = (UIView *)press.view;
      UITextField *textfiled=[myview viewWithTag:10];
      [[NSUserDefaults standardUserDefaults] setObject:[self.foldernamesdict objectForKey:textfiled.text] forKey:@"DeletedfolderID"];
      
      [[NSUserDefaults standardUserDefaults] setObject:textfiled.text forKey:@"DeletedfolderTextvalue"];
      
      [myview addSubview:deletebutton];
      
      [self.storeviewsarray addObject:myview];
      
  }
    
}

-(void)folderdeleteaction
{
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Delete"
                               message:@"Do u want to delete the folder"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here service
                                                   
                                                   
                                                   if (self.storeviewsarray.count>0) {
                                                       
                                                       for (int i=0; i<self.storeviewsarray.count; i++) {
                                                           
                                                           UIView  *myviews = (UIView *)[self.storeviewsarray objectAtIndex:i];
                                                           UIButton *deletedbutton = (UIButton *)[myviews viewWithTag:15];
                                                           [deletedbutton removeFromSuperview];
                                                           
                                                       }
                                                   }

                                                   
                                            NSMutableArray *customArray=[self.saveingDictionary objectForKey:@"custom_folder"];
                                                   
                                        
                                            NSMutableArray *checkingcustomarray=[[NSMutableArray alloc] init];
                                                   
                                                   if(customArray.count>0)
                                                   {
                                                       
                                                    for (int i=0; i<customArray.count; i++) {
                                                           
                                                           
                                                           NSMutableDictionary *custumDict=[customArray objectAtIndex:i];
                                                           
                                                           NSString *str=[custumDict objectForKey:@"folder"];
                                                           
                                                           [checkingcustomarray addObject:str];
                                                           
                                                    }
                                                       
                                                       
                                                   }
                                                       
                                                   if ([checkingcustomarray containsObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"DeletedfolderTextvalue"]]) {
                                                       
                                                         NSLog(@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"DeletedfolderID"]);
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                   }
                                                   else
                                                   {
                                                       
                                                    [self alertactionFordeletesettingsfolder];
                                                       
                                                   }
                                                   
                                                   
                                               }];
    
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   
                                                
                                                   if (self.storeviewsarray.count>0) {
                                                       
                                                       for (int i=0; i<self.storeviewsarray.count; i++) {
                                                           
                                                           UIView  *myviews = (UIView *)[self.storeviewsarray objectAtIndex:i];
                                                           UIButton *deletedbutton = (UIButton *)[myviews viewWithTag:15];
                                                           [deletedbutton removeFromSuperview];
                                                           
                                                       }
                                                   }
                                                }];
    
    
    [alert addAction:ok];
    [alert addAction:cancel];
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}

-(void)alertactionFordeletesettingsfolder
{
    
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Cant Delete This Folder"
                               message:@"Cannot delete Settingsfolder and Signed documents folder"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here service
    
                                               }];
    [alert addAction:ok];
    
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}

-(IBAction)adddnewsession:(id)sender
{
    NSLog(@"%@",self.documentdict);
    
    UIButton *mybutton =(UIButton *)sender;
    
    if ([mybutton.currentImage isEqual:[UIImage imageNamed:@"folder_plusfrfr.png"]]) {
        
        NSMutableDictionary *dict =[[NSMutableDictionary alloc] init];
        [dict setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] forKey:@"o_id"];
        [dict setObject:@"0" forKey:@"id"];
        
        
        NSLog(@"%@",[self.documentdict allKeys]);
       
        
        if ([[self.documentdict allKeys]containsObject:self.Folderstring]) {
            
          
           NSInteger lastChar = [[self.Folderstring substringFromIndex:[self.Folderstring length] - 1] integerValue];
        
           lastChar++;
            
          // NSLog(@"%d",lastChar);
            
            NSString *string =[NSString stringWithFormat:@"New Folder %li",(long)lastChar];
            
            [dict setObject:string forKey:@"folder_name"];
        }
        else
        {
            if ([self.Folderstring isEqualToString:@"New Folder 0"]) {
                
                  [dict setObject:@"New Folder 1" forKey:@"folder_name"];
            }
            else
            {
                 [dict setObject:self.Folderstring forKey:@"folder_name"];
            }
        }
        
        [self.myconnection addnewDocumentationfolder:dict];

        self.moveView.hidden=TRUE;
    }
    else
    {
        if (self.y%2==0) {
            
            self.moveView.hidden=FALSE;
            self.y++;
        }
        else
        {
            self.moveView.hidden=TRUE;
            self.y++;
        }
    }
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.CustomFolderarray count];
//    return  12;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    documentcollectionviewclass *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentcell" forIndexPath:indexPath];
    
    cell1.foldername.text=[self.CustomFolderarray objectAtIndex:indexPath.row];
    
    return cell1;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [[NSUserDefaults standardUserDefaults] setObject:[self.foldernamesdict objectForKey:[self.CustomFolderarray objectAtIndex:indexPath.row]] forKey:@"storeCustomfolderId"];
    
    self.inPath=indexPath;
    
    UICollectionViewLayoutAttributes *attributes = [self.mycollectionview layoutAttributesForItemAtIndexPath:indexPath];
    
    CGRect cellRect = attributes.frame;
    
    
    CGRect cellFrameInSuperview = [self.mycollectionview convertRect:cellRect toView:self];
    self.frame1=CGRectMake(cellFrameInSuperview.origin.x+40,cellFrameInSuperview.origin.y+45,0,0);
    
    NSLog(@"%f",cellFrameInSuperview.origin.x);
    [self actionSheet];
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((collectionView.frame.size.width/4)-1, 110);
}
-(void)imagePickerAction
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    if (actionFlag==1) {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
}

-(void)actionSheet
{
    //Alertcontroller(Action sheet)
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Select Source Type"
                                                                   message:@""
                                                            preferredStyle:UIAlertControllerStyleActionSheet]; // 1
    UIAlertAction *firstAction = [UIAlertAction actionWithTitle:@"Take Photo"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              actionFlag=1;
                                                              [self imagePickerAction];
                                                          }];
    UIAlertAction *secondAction = [UIAlertAction actionWithTitle:@"Upload Existing Photo"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                        
                                                               actionFlag=2;
                                                               [self imagePickerAction];
                                                               
                                                           }];
    
    
    UIAlertAction *thirdAction = [UIAlertAction actionWithTitle:@"Upload From Dropbox"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                              actionFlag=3;
                                                              [self dropboxAction];
                                                              
                                                              
                                                          }];
    UIAlertAction *fourthAction = [UIAlertAction actionWithTitle:@"Upload From Google Drive"
                                                           style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                               
                                                              // actionFlag=4;
                                                               
                                                           }];
    
    UIAlertAction *fifthAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                          style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
                                                              
                                                          }];
    [alert addAction:firstAction];
    [alert addAction:secondAction];
    [alert addAction:thirdAction];
    [alert addAction:fourthAction];
    [alert addAction:fifthAction];
    
    
    alert.popoverPresentationController.sourceView = self;
    alert.popoverPresentationController.sourceRect = self.frame1;
    
    [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
        UIImage *image=info[UIImagePickerControllerOriginalImage];
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
    
    
        NSData *data=UIImagePNGRepresentation(image);
        NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
        NSString *image64BaseString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];
    
    
    NSString *str;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"Autoincrementedalue"]==Nil) {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"Autoincrementedalue"];
        [[NSUserDefaults standardUserDefaults] synchronize];

        str=[[NSUserDefaults standardUserDefaults] objectForKey:@"Autoincrementedalue"];
        
    }
    else
    {
        NSInteger intgr = [[[NSUserDefaults standardUserDefaults] objectForKey:@"Autoincrementedalue"] integerValue];
        
        str=[NSString stringWithFormat:@"%ld",(long)intgr+1];
        
        [[NSUserDefaults standardUserDefaults] setObject:str forKey:@"Autoincrementedalue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    }
    
        [pdfDict setObject:image64BaseString forKey:@"image_doc"];
        [pdfDict setObject:@"0" forKey:@"doc_id"];
        [pdfDict setObject:[NSString stringWithFormat:@"image %@.png",str] forKey:@"file_name"];
        [imageArray addObject:pdfDict];
    
        [self.documentDictionary setObject:imageArray forKey:@"custom_documents"];
    
        [picker dismissViewControllerAnimated:YES completion:NULL];
    
       [self.myconnection customfolderAddnewdocuments:[[NSUserDefaults standardUserDefaults] objectForKey:@"storeCustomfolderId"] documentsdict:self.documentDictionary];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

-(void)dropboxAction
{
   
    homeViewController *vc=(homeViewController *)[self.superview.superview.superview nextResponder];
    [vc performSegueWithIdentifier:@"dropbox" sender:nil];
    
}

-(IBAction)uploadaction:(id)sender
{
    if (self.y1%2==0) {
        
        NSMutableArray *customArray=[self.saveingDictionary objectForKey:@"custom_folder"];
        
        NSMutableArray *checkingcustomarray=[[NSMutableArray alloc] init];
        
        if(customArray.count>0)
        {
            
            for (int i=0; i<customArray.count; i++) {
                
                
                NSMutableDictionary *custumDict=[customArray objectAtIndex:i];
                
                NSString *str=[custumDict objectForKey:@"folder"];
                
                [checkingcustomarray addObject:str];
                
            }
            
            [self.CustomFolderarray removeAllObjects];
            
            
            NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
            NSArray *sortedarray  = [checkingcustomarray sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder1]];
            
            [self.CustomFolderarray addObjectsFromArray:sortedarray];
            
            [self.mycollectionview reloadData];
            
        }
        
        self.folderslistview.hidden=FALSE;
        self.y1++;
    }
    else
    {
        self.folderslistview.hidden=TRUE;
        self.y1++;
    }

}

-(IBAction)closebutton:(id)sender
{
    self.folderslistview.hidden=TRUE;
    
    self.y1=0;
}

-(IBAction)movecopyactionbutton:(id)sender
{
    
    UIButton *mybutton =(UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        [self.movebutton setImage:[UIImage imageNamed:@"blue_elliyhhypse_1.png"] forState:UIControlStateNormal];
        [self.copybutton setImage:[UIImage imageNamed:@"reason_025.png"] forState:UIControlStateNormal];
        
         self.actionstring=@"Move";
    }
    else
    {
        
        [self.movebutton setImage:[UIImage imageNamed:@"reason_025.png"] forState:UIControlStateNormal];
        [self.copybutton setImage:[UIImage imageNamed:@"blue_elliyhhypse_1.png"] forState:UIControlStateNormal];
         self.actionstring=@"Copy";
        
    }
    
}

-(IBAction)deselectallbutton:(id)sender
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myappde.documentarray removeAllObjects];
    
    [self upperbuttonoldchanges];
    [self.tableView reloadData];
}

-(void)documentationFrontscreenlistingService:(NSMutableDictionary *)listingdocuments
{
    
    [self.documentdict removeAllObjects];
    [self.foldernamesdict removeAllObjects];
    [self.CustomFolderarray removeAllObjects];
    [self.customfoldernamesarray removeAllObjects];
    
    
    NSMutableArray *dictarray = [listingdocuments objectForKey:@"document_folder"];
    NSLog(@"%lu",(unsigned long)dictarray.count);
    
    [self.saveingDictionary addEntriesFromDictionary:listingdocuments];
    
    for (int i=0; i<dictarray.count; i++) {
   
        NSMutableDictionary *mydict=[dictarray objectAtIndex:i];
        
        NSMutableArray *array=[mydict objectForKey:@"thumb"];
        
        [self.foldernamesdict setObject:[mydict objectForKey:@"doc_id"] forKey:[mydict objectForKey:@"folder"]];
        
        
        if (array.count>0) {
           
            NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
            
            for (int j=0; j<array.count; j++) {
            
                
               NSMutableDictionary *mydocdict=[array objectAtIndex:j];
               
                [dictionary setObject:mydocdict forKey:[mydocdict objectForKey:@"emp_id"]];
            
            }
            
            [self.documentdict setObject:dictionary forKey:[mydict objectForKey:@"folder"]];
        }
        else
        {
             NSMutableDictionary *dictionary2=[[NSMutableDictionary alloc] init];
            
             [self.documentdict setObject:dictionary2 forKey:[mydict objectForKey:@"folder"]];
            
        }
    }
    
     NSMutableArray *signedarray = [listingdocuments objectForKey:@"signed_document"];
    
     if (signedarray.count>0) {
        
         NSMutableDictionary *mydict=[signedarray objectAtIndex:0];
         
         NSMutableArray *mysignearray=[mydict objectForKey:@"thumb"];
         
         [self.foldernamesdict setObject:[mydict objectForKey:@"doc_id"] forKey:@"signed_document"];
         
         if (mysignearray.count>0) {
             
             NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
             
             for (int j=0; j<mysignearray.count; j++) {
                 
                 
                 NSMutableDictionary *mydocdict=[mysignearray objectAtIndex:j];
                 
                 [dictionary setObject:mydocdict forKey:[mydocdict objectForKey:@"emp_id"]];
                 
             }
             
             [self.documentdict setObject:dictionary forKey:@"signed_document"];
         }
         else
         {
             
             NSMutableDictionary *dictionary2=[[NSMutableDictionary alloc] init];
             
             [self.documentdict setObject:dictionary2 forKey:@"signed_document"];
             
           //  [self.foldernamesdict setObject:@"100" forKey:[mydict objectForKey:@"signed_document"]];
             
         }

     }
    else
    {
        NSMutableDictionary *dictionary2=[[NSMutableDictionary alloc] init];
        
        [self.documentdict setObject:dictionary2 forKey:@"signed_document"];
        
        [self.foldernamesdict setObject:@"100" forKey:@"signed_document"];
        
    }
    
    NSMutableArray *customdictarray = [listingdocuments objectForKey:@"custom_folder"];
    NSLog(@"%lu",(unsigned long)dictarray.count);
    
    for (int i=0; i<customdictarray.count; i++) {
        
        
        NSMutableDictionary *mydict=[customdictarray objectAtIndex:i];
        NSMutableArray *array=[mydict objectForKey:@"thumb"];
        [self.foldernamesdict setObject:[mydict objectForKey:@"cus_id"] forKey:[mydict objectForKey:@"folder"]];
        [self.customfoldernamesarray addObject:[mydict objectForKey:@"folder"]];
        
        if (array.count>0) {
            
            NSMutableDictionary *dictionary=[[NSMutableDictionary alloc] init];
            
            for (int j=0; j<array.count; j++) {
                
                
                NSMutableDictionary *mydocdict=[array objectAtIndex:j];
                
                [dictionary setObject:mydocdict forKey:[mydocdict objectForKey:@"file_name"]];
                
            }
            
            [self.documentdict setObject:dictionary forKey:[mydict objectForKey:@"folder"]];
    }
        else
        {
            
            NSMutableDictionary *dictionary2=[[NSMutableDictionary alloc] init];
            
            [self.documentdict setObject:dictionary2 forKey:[mydict objectForKey:@"folder"]];
        }
    }
    
    
    NSMutableArray *folderarray=[[NSMutableArray alloc] init];
  
    for (int i=0; i<[self.documentdict allKeys].count; i++) {
        
        
        NSString *checkstring=[[self.documentdict allKeys] objectAtIndex:i];
        
        if ([checkstring rangeOfString:@"New Folder"].location == NSNotFound) {
        
            
          //  NSLog(@"string does not contain bla");
            
        }
        else {
            
           // NSLog(@"string contains bla!");
            
            [folderarray addObject:checkstring];
            
        }
    }
    
    if (folderarray.count>0) {
        
        NSMutableDictionary *numbicdict= [[NSMutableDictionary alloc] init];
        
        for (int i=0; i<folderarray.count; i++) {
            
            NSInteger lastChar = [[[folderarray objectAtIndex:i] substringFromIndex:[[folderarray objectAtIndex:i] length] - 1] integerValue];
            
            [numbicdict setObject:@"values" forKey:[NSString stringWithFormat:@"%ld",(long)lastChar]];
            
        }
        
        NSArray *numbicarray=[[NSArray alloc] init];
        numbicarray=[numbicdict allKeys];
        
        numbicarray = [numbicarray sortedArrayUsingComparator:^(id str1, id str2){
            return [(NSString *)str1 compare:(NSString *)str2 options:NSNumericSearch];
        }];
        
       self.Folderstring=[NSString stringWithFormat:@"New Folder %@",[numbicarray lastObject]];
    }
    else
    {
         self.Folderstring=@"New Folder 1";
    }
    
    
    NSLog(@"%@",self.Folderstring);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [self.tableView reloadData];
        [self.movetableview reloadData];
        
    });
    
  //  NSLog(@"%@",[self.documentdict allKeys]);
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:errorMessage
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}

-(void)viewDocuments
{
    NSLog(@"%d",self.app.dropboxFlag);
    if(self.app.dropboxFlag==1)
    {
       
        NSString *filePath=[[NSUserDefaults standardUserDefaults]objectForKey:@"filePath"];
        NSString *fileName=[[NSUserDefaults standardUserDefaults]objectForKey:@"fileName"];
        
        if ([[fileName pathExtension]isEqualToString:@"png"]||[[fileName pathExtension]isEqualToString:@"jpeg"] || [[fileName pathExtension]isEqualToString:@"jpg"]) {
            
            UIImage *selectedImage=[UIImage new];
            selectedImage=[UIImage imageWithContentsOfFile:filePath];
            //selectedImage=[UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
            NSLog(@"%@",selectedImage);
        
                NSMutableArray *imageArray=[[NSMutableArray alloc]init];
                NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
            
            
          
                NSData *data=UIImagePNGRepresentation(selectedImage);
                NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
                NSString *image64BaseString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];

            
                [pdfDict setObject:image64BaseString forKey:@"image_doc"];
                [pdfDict setObject:@"0" forKey:@"doc_id"];
                [pdfDict setObject:fileName forKey:@"file_name"];
                [imageArray addObject:pdfDict];
                [self.documentDictionary setObject:imageArray forKey:@"custom_documents"];
            
            
            
            [self.myconnection customfolderAddnewdocuments:[[NSUserDefaults standardUserDefaults] objectForKey:@"storeCustomfolderId"] documentsdict:self.documentDictionary];
            

        }
        else if([[fileName pathExtension]isEqualToString:@"pdf"])
        {
            [self.app.dropbox_array removeAllObjects];
            NSLog(@"%@",self.documentDictionary);
            [self.obj splittingPDF:filePath];
            
        }
    }
    
    NSLog(@"%@",self.documentDictionary);
}


-(void)viewPdf
{
 
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",myappde.dropbox_array);
    NSString *fileName=[[NSUserDefaults standardUserDefaults]objectForKey:@"fileName"];
    
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
    
        for (int i=0; i<myappde.dropbox_array.count; i++) {
            
            NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
            NSData *data=UIImagePNGRepresentation([myappde.dropbox_array objectAtIndex:i]);
            NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
            NSString *image64BaseString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];
            [pdfDict setObject:image64BaseString forKey:@"image_doc"];
            [pdfDict setObject:@"0" forKey:@"doc_id"];
            [pdfDict setObject:fileName forKey:@"file_name"];
            [imageArray addObject:pdfDict];
        }
    
    
    [self.documentDictionary setObject:imageArray forKey:@"custom_documents"];
    
    [self.myconnection customfolderAddnewdocuments:[[NSUserDefaults standardUserDefaults] objectForKey:@"storeCustomfolderId"] documentsdict:self.documentDictionary];
    

     // NSLog(@"%@",self.documentDictionary);
    
}


-(IBAction)rename:(id)sender
{
    self.renameView.hidden=false;
    [[self.renameButton layer] setBorderWidth:2.0f];
    [[self.renameButton layer] setBorderColor:[UIColor greenColor].CGColor];
    
}
-(IBAction)renameAlertViewAction:(id)sender
{
    UIButton *button=(UIButton *)sender;
    if(button.tag==1)
    {
        [[self.renameButton layer] setBorderWidth:2.0f];
        [[self.renameButton layer] setBorderColor:[UIColor greenColor].CGColor];
        [[self.makeCopyButton layer] setBorderWidth:0.0];
        [[self.makeCopyButton layer] setBorderColor:[UIColor clearColor].CGColor];
        [[self.cancelButton layer] setBorderWidth:0.0];
        [[self.cancelButton layer] setBorderColor:[UIColor clearColor].CGColor];
        
    }
    else if(button.tag==2)
    {
        [[self.makeCopyButton layer] setBorderWidth:2.0f];
        [[self.makeCopyButton layer] setBorderColor:[UIColor greenColor].CGColor];
        [[self.renameButton layer] setBorderWidth:0.0f];
        [[self.renameButton layer] setBorderColor:[UIColor clearColor].CGColor];
        [[self.cancelButton layer] setBorderWidth:0.0f];
        [[self.cancelButton layer] setBorderColor:[UIColor clearColor].CGColor];
    }
    else
    {
        [[self.cancelButton layer] setBorderWidth:2.0f];
        [[self.cancelButton layer] setBorderColor:[UIColor blueColor].CGColor];
        [[self.renameButton layer] setBorderWidth:0.0f];
        [[self.renameButton layer] setBorderColor:[UIColor clearColor].CGColor];
        [[self.cancelButton layer] setBorderWidth:0.0f];
        [[self.cancelButton layer] setBorderColor:[UIColor clearColor].CGColor];
    }
}

-(IBAction)renameDoneButtonAction:(id)sender
{
    self.convertImage.hidden=false;
}

-(IBAction)renameCloseAction:(id)sender
{
    self.renameView.hidden=true;
}

-(IBAction)filterbuttonaction:(id)sender
{
    if (self.folderFlag%2==0) {
        
        self.filterviews.hidden=FALSE;
        self.folderFlag++;
    }
    else
    {
        self.filterviews.hidden=TRUE;
        self.folderFlag++;
    }
}

-(IBAction)donebuttonaction:(id)sender
{
    self.filterviews.hidden=TRUE;
    self.folderFlag=0;

}

-(void)allEmployeeFilterResponse:(NSMutableDictionary *)responsedict
{
  
    if (responsedict.count>0) {
        
        
        [self.officearray removeAllObjects];
        [self.departmentarray removeAllObjects];
        [self.categoryarray removeAllObjects];
        [self.designationarray removeAllObjects];
        
        
        NSMutableArray *office_array = [responsedict objectForKey:@"office"];
        
        for (int i=0; i<office_array.count; i++) {
            
            NSMutableDictionary *dict = [office_array objectAtIndex:i];
            [self.officearray addObject:[dict objectForKey:@"office_name"]];
            [self.officefilterdictionary setObject:[dict objectForKey:@"id"] forKey:[dict objectForKey:@"office_name"]];
        }
        
        
        NSMutableArray *store_array = [responsedict objectForKey:@"store"];
        
        for (int i=0; i<store_array.count; i++) {
            
            NSMutableDictionary *dict = [store_array objectAtIndex:i];
            [self.officearray addObject:[dict objectForKey:@"store_name"]];
            [self.storefilterdictionary setObject:[dict objectForKey:@"store_id"] forKey:[dict objectForKey:@"store_name"]];
            
        }
        
        NSMutableArray *depart_array = [responsedict objectForKey:@"dept"];
        
        for (int i=0; i<depart_array.count; i++) {
            
            NSMutableDictionary *dict = [depart_array objectAtIndex:i];
            [self.departmentarray addObject:[dict objectForKey:@"department_name"]];
            [self.departmentfilterdictionary setObject:[dict objectForKey:@"dept_id"] forKey:[dict objectForKey:@"department_name"]];
            
        }
        
        NSMutableArray *category_array = [responsedict objectForKey:@"category"];
        
        
        for (int i=0; i<category_array.count; i++) {
            
            NSMutableDictionary *dict = [category_array objectAtIndex:i];
            [self.categoryarray addObject:[dict objectForKey:@"cat_name"]];
            [self.categoryfilterdictionary setObject:[dict objectForKey:@"id"] forKey:[dict objectForKey:@"cat_name"]];
            
        }
        
        
        NSMutableArray *designatn_array = [responsedict objectForKey:@"designation"];
        
        for (int i=0; i<designatn_array.count; i++) {
            
            NSMutableDictionary *dict = [designatn_array objectAtIndex:i];
            [self.designationarray addObject:[dict objectForKey:@"designation_title"]];
            [self.designationfilterdictionary setObject:[dict objectForKey:@"id"] forKey:[dict objectForKey:@"designation_title"]];
            
        }
        
        if (self.officearray.count>0) {
            
            [self.officearray insertObject:@"All" atIndex:0];
            
        }
        
        if (self.departmentarray.count>0) {
            
            [self.departmentarray insertObject:@"All" atIndex:0];
            
            
        }
        
        if (self.categoryarray.count>0) {
            
            [self.categoryarray insertObject:@"All" atIndex:0];
            
        }
        
        
        if (self.designationarray.count>0) {
            
            [self.designationarray insertObject:@"All" atIndex:0];
            
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self.workingpremisetableview reloadData];
            [self.departmenttableview reloadData];
            [self.categorytableview reloadData];
            [self.filtertableView1 reloadData];
            
        });
        

        NSLog(@"%@",self.officefilterdictionary);
        NSLog(@"%@",self.storefilterdictionary);
        NSLog(@"%@",self.departmentfilterdictionary);
        NSLog(@"%@",self.categoryfilterdictionary);
        NSLog(@"%@",self.designationfilterdictionary);
        
        
        
        NSSortDescriptor *sortOrderee = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arrayee  = [[self.departmentfilterdictionary allValues] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderee]];
        
        [self.department_servicesendarray addObjectsFromArray:[arrayee mutableCopy]];
        
        
        NSSortDescriptor *sortOrderee2 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arrayee2  = [[self.categoryfilterdictionary allValues] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderee2]];
        
        [self.category_servicesendarray addObjectsFromArray:[arrayee2 mutableCopy]];
        
        
        
        NSSortDescriptor *sortOrderee3 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arrayee3  = [[self.designationfilterdictionary allValues] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderee3]];
        
        [self.designation_servicesendarray addObjectsFromArray:[arrayee3 mutableCopy]];
        
        
        
        NSSortDescriptor *sortOrderee4 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arrayee4  = [[self.officefilterdictionary allValues] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderee4]];
        
        [self.office_servicesendarray addObjectsFromArray:[arrayee4 mutableCopy]];
        
        
        
        NSSortDescriptor *sortOrderee5 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *arrayee5  = [[self.storefilterdictionary allValues] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrderee5]];
        
        [self.store_servicesendarray addObjectsFromArray:[arrayee5 mutableCopy]];
        
    }
}


-(IBAction)actionbuttonforfilter:(id)sender
{
    
    UIButton *mybutton =(UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        self.filtertableView1.hidden=TRUE;
        self.workingpremisetableview.hidden=FALSE;
        self.departmenttableview.hidden=TRUE;
        self.categorytableview.hidden=TRUE;
        
        [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_red.png"] forState:UIControlStateNormal];
        [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
        [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
        [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
        
    }
    
    else if (mybutton.tag==2)
    {
        self.filtertableView1.hidden=TRUE;
        self.workingpremisetableview.hidden=TRUE;
        self.departmenttableview.hidden=FALSE;
        self.categorytableview.hidden=TRUE;
        
        [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_blue.png"] forState:UIControlStateNormal];
        [self.departmentbutton setImage:[UIImage imageNamed:@"dept_red.png"] forState:UIControlStateNormal];
        [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
        [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
        
    }
    else if (mybutton.tag==3)
    {
        self.filtertableView1.hidden=TRUE;
        self.workingpremisetableview.hidden=TRUE;
        self.departmenttableview.hidden=TRUE;
        self.categorytableview.hidden=FALSE;
        
        
        [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_blue.png"] forState:UIControlStateNormal];
        [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
        [self.categorybutton setImage:[UIImage imageNamed:@"category_red.png"] forState:UIControlStateNormal];
        [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
        
    }
    else if (mybutton.tag==4)
    {
        
        self.filtertableView1.hidden=FALSE;
        self.workingpremisetableview.hidden=TRUE;
        self.departmenttableview.hidden=TRUE;
        self.categorytableview.hidden=TRUE;
        
        
        [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_blue.png"] forState:UIControlStateNormal];
        [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
        [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
        [self.designationbutton setImage:[UIImage imageNamed:@"salesman_red.png"] forState:UIControlStateNormal];
    }
}

-(void)documentationemployeefilteringdocumentResponse:(NSMutableDictionary *)filteringemployeedocumentsresponsedict
{
    
    NSLog(@"%@",filteringemployeedocumentsresponsedict);
    
}

-(IBAction)deletedDocumentsInfrontscreen:(id)sender
{
     NSLog(@"%@",self.app.documentarray);
    
    if (self.app.documentarray.count>0) {
        
        [self.myconnection deletedDocumentsinDocumentationfrontscreen:self.app.documentarray];
       
    }
    
}
@end
