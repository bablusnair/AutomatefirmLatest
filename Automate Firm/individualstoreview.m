//
//  individualstoreview.m
//  Automate Firm
//
//  Created by leonine on 12/01/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "individualstoreview.h"
#import "otherdetailscellclass.h"
#import "officetypecellclass.h"
#import "settingsViewController.h"
#import "connectionclass.h"
@implementation individualstoreview
@synthesize filteredFlag,filteredFlag1,filteredFlag2,g,myoficeDictionary,bankflag,printerflag;
-(IBAction)cancel:(id)sender
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerstoredictionary"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storewpsdictionary"];
    
    [self removeFromSuperview];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
    
}


-(void)awakeFromNib
{
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];

//Function Calling
    self.storeid=[[NSUserDefaults standardUserDefaults]objectForKey:@"storeidKey"];
    [self.myconnection StoreViewDetails:self.storeid];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disabled" object:Nil];
    self.officetypeimagearray=[[NSMutableArray alloc] initWithObjects:@"store.png",@"online_store.png",@"warehouse.png",@"production_blacks.png", nil];
    self.outlettypearray=[[NSMutableArray alloc]init];
    self.bankarray=[[NSMutableArray alloc] initWithObjects:@"SBI(Tvm)",@"ICICI(Ekm)",@"FBI(Klm)",@"SBI(Tvm)",nil];
    self.finyrarray=[[NSMutableArray alloc] initWithObjects:@"Jan",@"Feb",@"Mar",@"Apr",@"May",@"Jun",@"Jul",@"Aug",@"Sep",@"Oct",@"Nov",@"Dec", nil];
    self.sectoraray=[[NSMutableArray alloc]initWithObjects:@"Public Sector",@"Private Sector", nil];
    self.currencyarray=[[NSMutableArray alloc]initWithObjects:@"Rupees",@"Dollor",@"Yen",@"Euro",@"Rubil", nil];
    self.statedict=[[NSMutableDictionary alloc]init];
    self.citydict=[[NSMutableDictionary alloc]init];
    self.countryaray=[[NSMutableArray alloc]init];
    self.statearay=[[NSMutableArray alloc]init];
    self.city=[[NSMutableArray alloc]init];
    self.fileteredArray=[[NSMutableArray alloc]init];
    self.fileteredArraycity=[[NSMutableArray alloc]init];
    self.fileteredArraystate=[[NSMutableArray alloc]init];
    self.selectedarray=[[NSMutableArray alloc]init];
    self.otherdetailsfield1array=[[NSMutableArray alloc] init];
    self.otherdetailsfield2array=[[NSMutableArray alloc] init];
    self.send_otherdetailsarray=[[NSMutableArray alloc] init];
    self.send_selectedbankarray=[[NSMutableArray alloc] init];
    self.send_selectedprinterarray=[[NSMutableArray alloc] init];


    myoficeDictionary =[[NSMutableDictionary alloc]init];
    for (int a=0; a<[[myoficeDictionary objectForKey:@"other_details"] count]; a++) {
        [self.otherdetailsfield1array insertObject:[[[myoficeDictionary objectForKey:@"other_details"]objectAtIndex:a]objectForKey:@"heading"]atIndex:a];
        [self.otherdetailsfield2array insertObject:[[[myoficeDictionary objectForKey:@"other_details"]objectAtIndex:a]objectForKey:@"description"]atIndex:a];
    }
    
    if (!self.otherdetailsfield1array.count>0) {
        
        [self.otherdetailsfield1array addObject:@""];
        [self.otherdetailsfield2array addObject:@""];
        
    }
    self.send_otherdetailsarray=[[NSMutableArray alloc]init];
    

    self.countrydict=[[NSMutableDictionary alloc]init];


    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    self.sameasbutton.hidden=TRUE;
    self.sameaslabel.hidden=TRUE;
    
    self.financialyrtableview.hidden=TRUE;
    self.outlettypetableview.hidden=TRUE;
    g=1;
    self.bankflag=0;
    self.printerflag=0;
    
    [self.sameasbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
    
    
}
-(void)StoreDetailsViewResponse:(id)storelist
{
    dispatch_async(dispatch_get_main_queue(), ^{
     self.outletnametext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_name"];
     self.abbrvtextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"abrevation"];
     self.outlettextfield.text=[[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"type"]componentsSeparatedByString:@"###"]objectAtIndex:1];
     self.subtitltext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"subtitle"];
     self.sectortextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"sector"];
     self.regtext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"reg_id"];
     self.currencytextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"currency"];
     self.finanialtextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"office_year"];
     self.emailtextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_email"];
     self.telephonetextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_telephone"];
     self.faxtextfield.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_fax"];
     self.webtext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_site"];
     self.buildingtext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_building"];
     self.blocktext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_block"];
     self.streettext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_street"];
        

        
        NSString *string1 = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"country"]componentsSeparatedByString:@"###"]objectAtIndex:1] ;
        
        if ([string1 rangeOfString:@"###"].location == NSNotFound) {
           
            
              self.countrytext.text = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"country"]componentsSeparatedByString:@"###"]objectAtIndex:1] ;
        }
        else {
            
           self.countrytext.text =[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"country"];
        }
        
        
        NSString *string = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"city"]componentsSeparatedByString:@"###"]objectAtIndex:1];
        if ([string rangeOfString:@"###"].location == NSNotFound) {
           
            
           
            
            self.citytext.text = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"city"]componentsSeparatedByString:@"###"]objectAtIndex:1];
            
        }
        else {
            
            
             self.citytext.text = [[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"city"];
            
            
        }
        
        
        
        NSString *string2 = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"state"]componentsSeparatedByString:@"###"]objectAtIndex:1];
        
        if ([string2 rangeOfString:@"###"].location == NSNotFound) {
            
          
            
             self.statetext.text = [[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"state"]componentsSeparatedByString:@"###"]objectAtIndex:1];
            
            
        }
        else {
            
            
            self.statetext.text = [[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"state"];
            
            
        }

    
    self.landmarktext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"store_landmark"];
    self.postcodetext.text=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"Postal_code"];
         [self.myconnection displayAllCountries];
        [self.myconnection displaySelectedStates:[[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"country"]componentsSeparatedByString:@"###"]objectAtIndex:0]];
        [self.myconnection displayAllCities:[[[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"state"]componentsSeparatedByString:@"###"]objectAtIndex:0]];
        //[self.outlettypearray removeAllObjects];
        
        [self.outlettypearray addObjectsFromArray:[storelist objectForKey:@"outlet"]];
        self.sendoutletString=[[[storelist objectForKey:@"store"]objectAtIndex:0]objectForKey:@"type"];
        [self.outlettypetableview reloadData];
        NSMutableArray *otherdetailsAray=[storelist objectForKey:@"details"];
        [self.otherdetailsfield1array removeAllObjects];
        [self.otherdetailsfield2array removeAllObjects];
        if (otherdetailsAray.count>0) {
            for (int a=0; a<otherdetailsAray.count; a++) {
                NSMutableDictionary *detailDict=[otherdetailsAray objectAtIndex:a];
                [self.otherdetailsfield1array addObject:[detailDict objectForKey:@"heading"]];
                [self.otherdetailsfield2array addObject:[detailDict objectForKey:@"description"]];
                

            }
            
        }
        else
        {
            [self.otherdetailsfield1array addObject:@""];
            [self.otherdetailsfield2array addObject:@""];
        }
        

    [self.otherdetailstableview reloadData];
        
     });
     [[NSUserDefaults standardUserDefaults] setObject:[storelist objectForKey:@"selected_printer"] forKey:@"store_selectedprinter"];
     [[NSUserDefaults standardUserDefaults] setObject:[storelist objectForKey:@"available_bank"] forKey:@"store_availablebank"];
     [[NSUserDefaults standardUserDefaults] setObject:[storelist objectForKey:@"selected_bank"] forKey:@"store_selectedbank"];
    //g=1;
}

-(void)allcountryresponse:(id)countrylist
{
    filteredFlag=0;
    
    [self.countryaray removeAllObjects];
    for (int a=0; a<[countrylist count]; a++) {
        
        NSString *mystring=[[countrylist objectAtIndex:a] objectForKey:@"name"];
        [self.countryaray addObject:mystring];
        [self.countrydict setObject:[[countrylist objectAtIndex:a] objectForKey:@"country_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.countrytable reloadData];
    });
    
}
//state Listing
-(void)allstateresponse:(id)statelist
{
    
    
    self.filteredFlag1=0;
    [self.statearay removeAllObjects];
    for (int a=0; a<[statelist count]; a++) {
        
        NSString *mystring=[[statelist objectAtIndex:a] objectForKey:@"name"];
        [self.statearay addObject:mystring];
        [self.statedict setObject:[[statelist objectAtIndex:a] objectForKey:@"state_id"] forKey:mystring];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.statetable reloadData];
    });
}

//City Listing
-(void)allcityresponse:(id)Citylist

{
    
    if (!([Citylist count] > 0)) {
        self.citytext.backgroundColor=[UIColor lightGrayColor];
        self.citytext.text=@"No City to Select";
        self.citytext.textColor=[UIColor redColor];
        self.citytext.userInteractionEnabled=NO;
    }
    else
    {
        self.filteredFlag2=0;
        self.citytext.backgroundColor=[UIColor clearColor];
        self.citytext.userInteractionEnabled=YES;
        //self.citytext.text=@"";
        self.citytext.textColor=[UIColor blackColor];
        
        [self.city removeAllObjects];
        for (int a=0; a<[Citylist count]; a++) {
            [self.city addObject:[[Citylist objectAtIndex:a]objectForKey:@"name"]];
            [self.citydict setObject:[[Citylist objectAtIndex:a] objectForKey:@"city_id"] forKey:[[Citylist objectAtIndex:a]objectForKey:@"name"]];
        }
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.citytable reloadData];
        });
    }
    
    
}


- (void) keyboardDidShow:(NSNotification *)notification
{
    
    
    NSDictionary* info = [notification userInfo];
    CGRect kbRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    kbRect = [self convertRect:kbRect fromView:nil];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbRect.size.height+50, 0.0);
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.frame;
    aRect.size.height -= kbRect.size.height;
    
    if (!CGRectContainsPoint(aRect, self.activeField.frame.origin)) {
        
        [self.scrollView scrollRectToVisible:self.activeField.frame animated:YES];
        
    }
    
}



- (void) keyboardWillBeHidden:(NSNotification *)notification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.otherdetailstableview) {
        
        
        return [self.otherdetailsfield2array count];
    }
    
    else if(tableView==self.financialyrtableview)
    {
        return self.finyrarray.count;
        
    }
    else if(tableView==self.sectortable)
    {
        return self.sectoraray.count;
        
    }
    else if(tableView==self.cuurencytable)
    {
        return self.currencyarray.count;
        
    }
    else if(tableView==self.countrytable)
    {
        if (filteredFlag==1) {
            return  self.fileteredArray.count;
        }
        else
            
            return self.countryaray.count;
    }
    else if(tableView==self.statetable)
    {
        if (filteredFlag1==1) {
            return  self.fileteredArraystate.count;
        }
        else
        {
            return self.statearay.count;
        }
    }
    else if(tableView==self.citytable)
    {
        if (filteredFlag2==1) {
            return  self.fileteredArraycity.count;
        }
        else
        {
            return self.city.count;
        }
    }
    else if(tableView==self.outlettypetableview)
    {
        return self.outlettypearray.count;
        
    }
    else
    {
        
        return self.outlettypearray.count;
    }
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView==self.otherdetailstableview) {
        
        static NSString *simpleTableIdentifier = @"simplecell";
        otherdetailscellclass  *cell = (otherdetailscellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"otherdetailscellview" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        cell.field1.text=[self.otherdetailsfield1array objectAtIndex:indexPath.row];
        cell.field2.text=[self.otherdetailsfield2array objectAtIndex:indexPath.row];
            cell.field1.userInteractionEnabled=YES;
            cell.field2.userInteractionEnabled=YES;
        

        
        
        
        if ([self.selectedarray containsObject:indexPath]) {
            
            if (cell.field1.text.length>0 && cell.field2.text.length>0) {
                
                [cell.field1 setUserInteractionEnabled:FALSE];
                [cell.field2 setUserInteractionEnabled:FALSE];
            }
            else
            {
                
                [cell.field1 setUserInteractionEnabled:TRUE];
                [cell.field2 setUserInteractionEnabled:TRUE];
                
            }
            
        }
        else
        {
            
            if (cell.field1.text.length>0 && cell.field2.text.length>0) {
                
                [cell.field1 setUserInteractionEnabled:FALSE];
                [cell.field2 setUserInteractionEnabled:FALSE];
                
                
            }
            
        }
        
        
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressaction:)];
        [cell addGestureRecognizer:press];
        return cell;
        
        
    }
    else if(tableView==self.financialyrtableview)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.finyrarray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if(tableView==self.sectortable)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.sectoraray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if(tableView==self.cuurencytable)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        cell.textLabel.text=[self.currencyarray objectAtIndex:indexPath.row];
        return cell;
        
    }
    else if(tableView==self.outlettypetableview)
    {
        static NSString *cellIdentifier = @"cellID";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                 cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
        NSMutableDictionary * dict =[self.outlettypearray objectAtIndex:indexPath.row];
        cell.textLabel.text=[dict objectForKey:@"name"];
        return cell;
        
    }
    else if(tableView==self.countrytable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (filteredFlag==0) {
            cell.textLabel.text=[self.countryaray objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArray objectAtIndex:indexPath.row];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        
        return  cell;
    }
    
    else if(tableView==self.statetable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        if (filteredFlag1==0) {
            cell.textLabel.text=[self.statearay objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArraystate objectAtIndex:indexPath.row];
        }
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        return  cell;
    }
    
    else if(tableView==self.citytable)
    {
        
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        
        
        if (filteredFlag2==0) {
            cell.textLabel.text=[self.city objectAtIndex:indexPath.row];
        }
        else
        {
            cell.textLabel.text=[self.fileteredArraycity objectAtIndex:indexPath.row];
        }
        
        cell.textLabel.font=[UIFont systemFontOfSize:11];
        return  cell;
    }
    
    
       else  {
    
           static NSString *simpleTableIdentifier = @"simplecell";
           officetypecellclass  *cell = (officetypecellclass *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
           if (cell == nil)
           {
               NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"officetypecell" owner:self options:nil];
               cell = [nib objectAtIndex:0];
    
           }
    
           cell.storelabel.text=[self.outlettypearray objectAtIndex:indexPath.row];
           cell.storeimage.image=[UIImage imageNamed:[self.officetypeimagearray objectAtIndex:indexPath.row]];
           
           return cell;
           
    
        }
        
    
}

-(IBAction)shipdetailsbuttonaction:(id)sender
{
    UIButton *mybutton=(UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        [self.shipingbutton1 setImage:[UIImage imageNamed:@"shipping_address_actie.png"] forState:UIControlStateNormal];
        self.shipingbutton1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        
        self.sameasbutton.hidden=TRUE;
        self.sameaslabel.hidden=TRUE;
        
    }
    
    else  if (mybutton.tag==2)
    {
        [self.shipingbutton1 setImage:[UIImage imageNamed:@"shipping_address_normal.png"] forState:UIControlStateNormal];
        self.shipingbutton1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
        self.sameasbutton.hidden=FALSE;
        self.sameaslabel.hidden=FALSE;
        self.sameaslabel.text=@"Same As Location";
        [self.sameasbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.shipingbutton1 setImage:[UIImage imageNamed:@"shipping_address_normal.png"] forState:UIControlStateNormal];
        self.shipingbutton1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 0);
        
        self.sameasbutton.hidden=FALSE;
        self.sameaslabel.hidden=FALSE;
        self.sameaslabel.text=@"Same As Billing";
        [self.sameasbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
    }
    
    
}

-(IBAction)addotherdetailsaction:(id)sender
{
    
    if (![self.otherdetailsfield1array containsObject:@""] && ![self.otherdetailsfield2array containsObject:@""] && g==1) {
        
        [self.otherdetailsfield1array addObject:@""];
        [self.otherdetailsfield2array addObject:@""];
        NSArray *visibleItems = [self.otherdetailstableview indexPathsForVisibleRows];
        [self.otherdetailstableview reloadData];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.otherdetailsfield1array.count - 1 inSection:currentItem.section];
        //NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.otherdetailsfield1array.count inSection:currentItem.section];
        [self.otherdetailstableview scrollToRowAtIndexPath:nextItem atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}
-(void)longpressaction:(UILongPressGestureRecognizer *)pressguster
{
    
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)pressguster.view;
    [clickedCell.field1 setUserInteractionEnabled:TRUE];
    [clickedCell.field2 setUserInteractionEnabled:TRUE];
    clickedCell.closebutton.hidden=FALSE;
    self.otherdteialsdeleteflag=0;
    
}

-(IBAction)otherdetailsclosebuttonaction:(id)sender
{
    
    otherdetailscellclass *cell1 = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myindex=[self.otherdetailstableview indexPathForCell:cell1];
    [self.otherdetailsfield1array removeObjectAtIndex:myindex.row];
    [self.otherdetailsfield2array removeObjectAtIndex:myindex.row];
    cell1.closebutton.hidden=TRUE;
    self.otherdteialsdeleteflag=1;
    g=1;
    [self.otherdetailstableview reloadData];
    
}
-(IBAction)textfieldbegininaction:(id)sender
{    g=0;
    self.otherdteialsdeleteflag=0;
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,375);
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    self.inPath=[self.otherdetailstableview indexPathForCell:clickedCell];
    clickedCell.field1.userInteractionEnabled=TRUE;
    clickedCell.closebutton.hidden=TRUE;
    
}


//for ending action of heading textfield of otherdetails


-(IBAction)textfieldendinginaction:(id)sender
{
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myinedx = [self.otherdetailstableview indexPathForCell:clickedCell];
        if (self.otherdteialsdeleteflag==0) {
        
        [self.otherdetailsfield1array replaceObjectAtIndex:myinedx.row withObject:clickedCell.field1.text];
        
        if (clickedCell.field2.text.length>0) {
            
            if ([clickedCell.field1.text isEqualToString:@""]) {
                
                [clickedCell.field1 setUserInteractionEnabled:TRUE];
                //[clickedCell.field2 setUserInteractionEnabled:TRUE];
            }
            else
            {
                [self.otherdetailstableview reloadData];
                 //clickedCell.field2.userInteractionEnabled=YES;
            }
            
        }
        clickedCell.field2.userInteractionEnabled=YES;
        g=1;
           // [clickedCell.field1 resignFirstResponder];
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
        
    }
    
    
}


//for begin action of heading_details textfield of otherdetails


-(IBAction)textfieldbegininaction2:(id)sender
{
       g=0;
    self.otherdteialsdeleteflag=0;
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    self.inPath=[self.otherdetailstableview indexPathForCell:clickedCell];
   // [clickedCell.field2 resignFirstResponder];
    if (!(clickedCell.field1.text.length > 0)) {
        clickedCell.field2.userInteractionEnabled=NO;
        [clickedCell.field2 resignFirstResponder];
    }
    else
    {
        clickedCell.field2.userInteractionEnabled=YES;
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,375);
    }
    clickedCell.closebutton.hidden=TRUE;
}

//for ending action of heading_details textfield of otherdetails

-(IBAction)textfieldendinginaction2:(id)sender
{
    
      
    otherdetailscellclass *clickedCell = (otherdetailscellclass *)[[sender superview] superview];
    NSIndexPath *myinedx = [self.otherdetailstableview indexPathForCell:clickedCell];
    [clickedCell.field2 resignFirstResponder];
    
    if (self.otherdteialsdeleteflag==0) {
        
        [self.otherdetailsfield2array replaceObjectAtIndex:myinedx.row withObject:clickedCell.field2.text];
        [self.selectedarray addObject:myinedx];
        
        if (clickedCell.field2.text.length>0) {
            
            if ([clickedCell.field1.text isEqualToString:@""])
            {
                
                [clickedCell.field1 setUserInteractionEnabled:TRUE];
                [clickedCell.field2 setUserInteractionEnabled:TRUE];
            }
            else
            {
                [self.otherdetailstableview reloadData];
            }
            
        }
        
        g=1;
        
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.origin.x,0);
        
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.financialyrtableview) {
        
        self.finanialtextfield.text=[self.finyrarray objectAtIndex:indexPath.row];
        self.financialyrtableview.hidden=TRUE;
    }
    if (tableView==self.sectortable) {
        
        self.sectortextfield.text=[self.sectoraray objectAtIndex:indexPath.row];
        self.sectortable.hidden=TRUE;
    }
    if (tableView==self.cuurencytable) {
        
        self.currencytextfield.text=[self.currencyarray objectAtIndex:indexPath.row];
        self.cuurencytable.hidden=TRUE;
    }
    
  if (tableView==self.outlettypetableview) {
      
        NSMutableDictionary *dictinary=[self.outlettypearray objectAtIndex:indexPath.row];
        self.outlettextfield.text=[dictinary objectForKey:@"name"];
        self.sendoutletString=[NSString stringWithFormat:@"%@###%@",[dictinary objectForKey:@"id"],[dictinary objectForKey:@"name"]];
        self.outlettypetableview.hidden=TRUE;
  }
    if (tableView == self.countrytable)
    {
        if (filteredFlag == 0) {
            self.countrytext.text = [self.countryaray objectAtIndex:indexPath.row];
        }
        else
        {
            self.countrytext.text = [self.fileteredArray objectAtIndex:indexPath.row];
            
        }
        if ([self.countryaray containsObject:self.countrytext.text ])
        {
            [self.myconnection displaySelectedStates:[self.countrydict objectForKey:self.countrytext.text]];
            
            self.statetext.text =@"";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
            
            self.filteredFlag1 = self.filteredFlag2=0;
            
            self.countrytable.hidden=TRUE;
            
        }
        [self.countrytext resignFirstResponder];
    }
    
    if (tableView == self.statetable)
    {
        
        if (filteredFlag1 == 0) {
            self.statetext.text = [self.statearay objectAtIndex:indexPath.row];
        }
        else
        {
            self.statetext.text = [self.fileteredArraystate objectAtIndex:indexPath.row];
            
        }
        [self.myconnection displayAllCities:[self.statedict objectForKey:self.statetext.text]];
        self.citytext.text=@"";
        self.postcodetext.text=@"";
        self.filteredFlag2=0;
        self.statetable.hidden=TRUE;
        [self.statetext resignFirstResponder];
        
    }
    if (tableView == self.citytable)
    {
        
        if (filteredFlag2 == 0) {
            
            self.citytext.text = [self.city objectAtIndex:indexPath.row];
        }
        else
        {
            self.citytext.text = [self.fileteredArraycity objectAtIndex:indexPath.row];
        }
        self.citytable.hidden=TRUE;
        [self.citytext resignFirstResponder];
        
    }
    
    
}
-(IBAction)sameasbillingaction:(id)sender
{
    
    if ([self.sameasbutton.currentImage isEqual:[UIImage imageNamed:@"check box.png"]]) {
        
        
        [self.sameasbutton setImage:[UIImage imageNamed:@"check box (tick).png"] forState:UIControlStateNormal];
        
    }
    else
    {
        [self.sameasbutton setImage:[UIImage imageNamed:@"check box.png"] forState:UIControlStateNormal];
        
    }
    
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
        if (textField==self.countrytext) {
        
        filteredFlag=1;
        
        self.countrytable.hidden=FALSE;
        
        //   NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",[self.mytextfield.text stringByReplacingCharactersInRange:range withString:string]];
        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.countrytext.text stringByReplacingCharactersInRange:range withString:string]];
        
        self.fileteredArray = [[self.countryaray filteredArrayUsingPredicate:bPredicate] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.countrytable reloadData];
            
            
        });
        if ([string isEqualToString:@""] && textField.text.length==1) {
                        filteredFlag=0;
            
                    dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.countrytable reloadData];
                
                
            });
            
            
            
            
        }
        
        
        
        return  YES;
        
    }
    
    if (textField==self.statetext) {
        
        filteredFlag1=1;
        
        //self.statetable.hidden=TRUE;
        
        //   NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@",[self.mytextfield.text stringByReplacingCharactersInRange:range withString:string]];
        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.statetext.text stringByReplacingCharactersInRange:range withString:string]];
        
        self.fileteredArraystate = [[self.statearay filteredArrayUsingPredicate:bPredicate] mutableCopy];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.statetable.hidden=FALSE;
            [self.statetable reloadData];
            
            
        });
        
        
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            
            
            
            filteredFlag1=0;
            
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.statetable reloadData];
                
                
            });
            
            
            
            
        }
        
        return  YES;
        
    }
    if (textField==self.citytext) {
        
        filteredFlag2=1;
        
        self.citytable.hidden=FALSE;
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.citytext.text stringByReplacingCharactersInRange:range withString:string]];
        
        self.fileteredArraycity = [[self.city filteredArrayUsingPredicate:bPredicate] mutableCopy];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.citytable reloadData];
            
            
        });
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            filteredFlag2=0;
               dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.citytable reloadData];
                
                
            });
            
            
        }
      }
    if (textField==self.abbrvtextfield) {
        
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
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.outletnametext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.subtitltext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.regtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
//    if (textField==self.webtext) {
//        
//        if ([string isEqualToString:@""]) {
//            return YES;
//        }
//        if (textField.text.length<=25) {
//            
//            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-_.@"];
//            unichar c = [string characterAtIndex:0];
//            if ([myCharSet characterIsMember:c])
//            {
//                return YES;
//            }
//            else
//            {
//                return NO;
//            }
//            //return YES;
//        }
//        return NO;
//    }
    if (textField==self.regtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.buildingtext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.blocktext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.postcodetext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=13) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.streettext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=33) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    if (textField==self.landmarktext) {
        
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=35) {
            
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else
            {
                return NO;
            }
            //return YES;
        }
        return NO;
    }
    
    
    if ((textField==self.telephonetextfield) || (textField==self.faxtextfield))
    {
        if ([string isEqualToString:@""]) {
            return YES;
        }
        if (textField.text.length<=12) {
            NSCharacterSet *myCharSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789+-"];
            unichar c = [string characterAtIndex:0];
            if ([myCharSet characterIsMember:c])
            {
                return YES;
            }
            else{
                return NO;
            }
        
        }
        return NO;
    }
    
  
    return  YES;
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.emailtextfield)
    {
        
        [self validateEmail:self.emailtextfield.text];
        
    }
    if (textField == self.webtext)
    {
        
        [self validateWebsite:self.webtext.text];
        
    }
    if (textField==self.countrytext) {
        
        if (!(self.countrytext.text.length > 0))
        {
            self.countrytable.hidden=true;
            self.statetext.text=@"";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
        }
        if ([self.countryaray containsObject:self.countrytext.text ])
        {
            //self.statetable.hidden= FALSE;
        }
        else
        {
            self.countrytext.text=@"Invalid choice";
            self.statetext.text=@"";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
            self.countrytable.hidden=TRUE;
        }
        
    }
    if (textField==self.statetext) {
        if (!(self.statetext.text.length > 0)) {
            self.statetable.hidden=true;
            self.citytext.text=@"";
            self.postcodetext.text=@"";
        }
        if ([self.statearay containsObject:self.statetext.text ])
        {
            // self.citytable.hidden= FALSE;
        }
        else
        {
            self.statetext.text=@"Invalid choice";
            self.citytext.text=@"";
            self.postcodetext.text=@"";
            self.citytable.hidden=TRUE;
        }
    }
    if (textField==self.citytext) {
        if (!(self.citytext.text.length > 0)) {
            self.citytable.hidden=true;
            self.postcodetext.text=@"";
        }
        if ([self.city containsObject:self.citytext.text ])
        {
            // self.citytable.hidden= FALSE;
        }
        else
        {
            self.citytext.text=@"Invalid choice";
            
            self.postcodetext.text=@"";
            self.citytable.hidden=TRUE;
        }
        
        
    }
    

}

- (BOOL)validateEmail:(NSString *)emailStr
{
    if([emailStr isEqualToString:@""])
    {
        return YES;
    }
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    if ([emailTest evaluateWithObject:emailStr]) {
        
        NSLog(@"Correct");
        
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Please enter valid Email Address"
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
    return [emailTest evaluateWithObject:emailStr];
}

- (BOOL)validateWebsite:(NSString *)webStr
{
    if([webStr isEqualToString:@""])
    {
        return YES;
    }
    NSString *webRegex = @"www.+[A-Za-z0-9-]+\\.[A-Za-z]{2,4}";
    NSPredicate *webTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", webRegex];
    if ([webTest evaluateWithObject:webStr]) {
        
        NSLog(@"Correct");
        
    }
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@"Please enter valid Website Address"
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
    return [webTest evaluateWithObject:webStr];
}

-(IBAction)donebuttonaction:(id)sender
{
    
    BOOL value = [self validateEmail:self.emailtextfield.text];
    BOOL value1= [self validateWebsite:self.webtext.text];
    [self.emailtextfield resignFirstResponder];
    [self.webtext resignFirstResponder];

    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"enabletable" object:Nil];
   
    //String Formatting for Services
    
    NSString *countrystring=[NSString stringWithFormat:@"%@###%@",[self.countrydict objectForKey:self.countrytext.text],self.countrytext.text];
    NSString *statestring=[NSString stringWithFormat:@"%@###%@",[self.statedict objectForKey:self.statetext.text],self.statetext.text];
    NSString *citystring   =[NSString stringWithFormat:@"%@###%@",[self.citydict objectForKey:self.citytext.text],self.citytext.text];
    NSMutableArray *selectedbanks=[[NSUserDefaults standardUserDefaults]objectForKey:@"store_selectedbank"];
    if (self.bankflag==0) {
        
        [self.send_selectedbankarray removeAllObjects];
        
        for (int m=0; m<selectedbanks.count; m++) {
            
            NSMutableDictionary *dict=[[selectedbanks objectAtIndex:m] mutableCopy];
            [dict removeObjectForKey:@"bank_branch"];
            [dict removeObjectForKey:@"bank_name"];
            [self.send_selectedbankarray addObject:dict];
            
        }
    }
    else
    {
        
        NSMutableDictionary *mydict=[[NSUserDefaults standardUserDefaults] objectForKey:@"storewpsdictionary"];
        
        NSMutableArray *myarray=[[[[NSUserDefaults standardUserDefaults] objectForKey:@"storewpsdictionary"] allKeys] mutableCopy];
        
        [self.send_selectedbankarray removeAllObjects];
        
        for (int a=0; a<myarray.count; a++) {
            
            NSMutableDictionary *mydictionarybank=[[NSMutableDictionary alloc] init];
            [mydictionarybank setObject:[myarray objectAtIndex:a] forKey:@"bank_id"];
            [mydictionarybank setObject:[mydict objectForKey:[myarray objectAtIndex:a]] forKey:@"code"];
            [self.send_selectedbankarray addObject:mydictionarybank];
        }
        
        
    }
    
    
NSMutableArray *seletedprinters=[[NSUserDefaults standardUserDefaults]objectForKey:@"store_selectedprinter"];
    
    if (self.printerflag==0) {
        
        [self.send_selectedprinterarray removeAllObjects];
        
        for (int m=0; m<seletedprinters.count; m++) {
            
            NSMutableDictionary *dict=[[seletedprinters objectAtIndex:m] mutableCopy];
            [dict removeObjectForKey:@"p_id"];
            [dict removeObjectForKey:@"o_id"];
            
            [self.send_selectedprinterarray addObject:dict];
            
        }
        
    }
    
    else
    {
        [self.send_selectedprinterarray removeAllObjects];
        
        NSMutableDictionary *printerdict = [[NSUserDefaults standardUserDefaults]objectForKey:@"printerstoredictionary"];
        
        NSMutableArray *printnamearray = [printerdict objectForKey:@"printername"];
        NSMutableArray *emailarray = [printerdict objectForKey:@"emailarray"];
        NSMutableArray *ratearray = [printerdict objectForKey:@"ratearray"];
        
        
        for (int b=0; b<printnamearray.count; b++) {
            
            
            NSMutableDictionary *dict=[[NSMutableDictionary alloc] init];
            [dict setObject:[printnamearray objectAtIndex:b] forKey:@"name"];
            NSString *str=[NSString stringWithFormat:@"%@@%@",[emailarray objectAtIndex:b],[ratearray objectAtIndex:b]];
            [dict setObject:str forKey:@"email"];
            [self.send_selectedprinterarray addObject:dict];
            
            
        }
        
    }
     if ((value==YES)&&(value1==YES))
     {
         otherdetailscellclass *clickedCell = (otherdetailscellclass *)[self.otherdetailstableview cellForRowAtIndexPath:self.inPath];
         [clickedCell.field1 resignFirstResponder];
         [clickedCell.field2 resignFirstResponder];
    
         [self.otherdetailsfield1array removeObject:@""];
         [self.otherdetailsfield2array removeObject:@""];
         if (self.otherdetailsfield1array.count == self.otherdetailsfield2array.count) {
        for (int c=0; c<self.otherdetailsfield1array.count; c++) {
            NSMutableDictionary *mydict=[[NSMutableDictionary alloc] init];
            [mydict setObject:[self.otherdetailsfield1array objectAtIndex:c] forKey:@"heading"];
            [mydict setObject:[self.otherdetailsfield2array objectAtIndex:c] forKey:@"description"];
            [self.send_otherdetailsarray addObject:mydict];
            
        }
    }
    
    
    if (self.outletnametext.text.length>0 && self.sectortextfield.text.length>0 && self.abbrvtextfield.text.length>0 && self.currencytextfield.text.length>0 && self.finanialtextfield.text.length>0 &&self.send_selectedbankarray.count>0 && self.otherdetailsfield1array.count==self.otherdetailsfield2array.count) {
        
        [self.myconnection updateStorefunction:self.outletnametext.text officeId:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"] storeid:self.storeid outletType:self.sendoutletString abbrev:self.abbrvtextfield.text subtittle:self.subtitltext.text sector:self.sectortextfield.text regid:self.regtext.text currency:self.currencytextfield.text financialyear:self.finanialtextfield.text emailid:self.emailtextfield.text telephonenumber:self.telephonetextfield.text fax:self.faxtextfield.text website:self.webtext.text building:self.buildingtext.text block:self.blocktext.text street:self.streettext.text country:countrystring state:statestring city:citystring postcode:self.postcodetext.text landmark:self.landmarktext.text bank_listarray:self.send_selectedbankarray printer_listarray:self.send_selectedprinterarray otherdetails_array:self.send_otherdetailsarray];
        
        [app hudStart:self];
        
    }
    else
    {
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Warning"
                                   message:@"Please Enter the Mandatory Fields"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       [self.otherdetailsfield2array addObject:@""];
  
                                                       
                                                                                                          }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
    }

}
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.finanialtextfield) {
        
        self.sectortable.hidden=TRUE;
        self.cuurencytable.hidden=TRUE;
        self.outlettypetableview.hidden=TRUE;
        self.financialyrtableview.hidden=FALSE;
        return NO;
    }
    
   else if (textField==self.outlettextfield)
    {
        self.sectortable.hidden=TRUE;
        self.cuurencytable.hidden=TRUE;
        self.financialyrtableview.hidden=TRUE;
        self.outlettypetableview.hidden=FALSE;
        return NO;
    }
   else if (textField==self.sectortextfield)
   {
       self.cuurencytable.hidden=TRUE;
       self.outlettypetableview.hidden=TRUE;
       self.financialyrtableview.hidden=TRUE;
       self.sectortable.hidden=FALSE;
       return NO;
   }
   else if (textField==self.currencytextfield)
   {
       self.sectortable.hidden=TRUE;
       self.outlettypetableview.hidden=TRUE;
       self.financialyrtableview.hidden=TRUE;
       self.cuurencytable.hidden=FALSE;
       return NO;
   }
    
    if (textField==self.countrytext) {
        if([self.countrytext.text isEqualToString:@"Invalid choice"])
        {
            self.countrytext.text=@"";
            filteredFlag=0;
            [self.countrytable reloadData];
            
        }
        self.statetable.hidden=TRUE;
        self.citytable.hidden=TRUE;
        self.countrytable.hidden=FALSE;
        return YES;
    }
    
    if (textField==self.statetext) {
        self.countrytable.hidden=TRUE;
        self.citytable.hidden=TRUE;
        if([self.statetext.text isEqualToString:@"Invalid choice"])
        {
            self.statetext.text=@"";
            filteredFlag1=0;
            [self.statetable reloadData];
            
        }
        if(self.countrytext.text.length > 0)
        {
            if ([self.countrytext.text isEqualToString:@"Invalid choice"]) {
                self.statetext.text =@"Select a Country";
                self.statetext.textColor=[UIColor redColor];
                self.statetable.hidden=TRUE;
                return NO;
            }
            else
            {
                self.statetext.textColor=[UIColor blackColor];
                self.statetable.hidden=FALSE;
                return YES;
            }
            
            
        }
        else{
            self.statetext.text =@"Select a Country";
            self.statetext.textColor=[UIColor redColor];
            return  NO;
        }
        
    }
    
    if (textField==self.citytext) {
        self.countrytable.hidden=TRUE;
        self.statetable.hidden=TRUE;
        if([self.citytext.text isEqualToString:@"Invalid choice"])
        {
            self.citytext.text=@"";
            filteredFlag2=0;
            [self.citytable reloadData];
        }
        if(self.statetext.text.length > 0)
        {
            if ([self.statetext.text isEqualToString:@"Invalid choice"]) {
                self.citytext.text=@"Select a state";
                self.citytext.textColor=[UIColor redColor];
                self.citytable.hidden=TRUE;
                return  NO;
            }
            else
            {
                self.citytext.textColor=[UIColor blackColor];
                self.citytable.hidden=FALSE;
                return  YES;
            }
            
        }
        else{
            self.citytext.text =@"Select a State";
            self.citytext.textColor=[UIColor redColor];
            return  NO;
        }
        
    }
    else
    {
        
        return YES;
    }
    
}

-(IBAction)addnewbank:(id)sender
{
    self.bankflag=1;
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"addnewstorebankview" owner:self options:Nil];
    [self addSubview:[nib objectAtIndex:0]];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storewpsdictionary"];
    
}



-(IBAction)addnewvehile:(id)sender
{
    
    NSArray *nib=[[NSBundle mainBundle] loadNibNamed:@"addnewvehileviewview" owner:self options:Nil];
    [self addSubview:[nib objectAtIndex:0]];
    
}



-(IBAction)addnewprinter:(id)sender
{
    self.printerflag=1;
    NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"addneewstoreprinterview" owner:self options:nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerstoredictionary"];
    [self addSubview:[array objectAtIndex:0]];

}
-(void)updateStoreResponse:(NSString *)updatedmessage
{

  //  if ([updatedmessage isEqualToString:@"\t\nsuccess"])
     if ([updatedmessage isEqualToString:@"\t\n1"]){
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"UpdatedSuccessfully"
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       
                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadoffice" object:Nil];
                                                       [[NSNotificationCenter defaultCenter] postNotificationName:@"enabled" object:Nil];
                                                       [app hudStop];
                                                       [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerstoredictionary"];
                                                       [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storewpsdictionary"];

                                                       
                                                       [self removeFromSuperview];
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
        
        
        
    }
    else
    {
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@"Error"
                                   message:@""
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       
                                                       
                                                   }];
        [alert addAction:ok];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
    }
    
    
    
}








@end
