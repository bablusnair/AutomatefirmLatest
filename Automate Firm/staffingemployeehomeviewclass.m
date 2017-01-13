//
//  staffingemployeehomeviewclass.m
//  Automate Firm
//
//  Created by leonine on 03/09/15.
//  Copyright (c) 2015 leonine. All rights reserved.

#import "staffingemployeehomeviewclass.h"
#import "ContainerTableCell.h"
#import "filtercellTableViewCell.h"
#import "homeViewController.h"
#import "presentfilterTableViewCell.h"
#import "demostaffingviewclass.h"


@implementation staffingemployeehomeviewclass
@synthesize myarray;


- (void)drawRect:(CGRect)rect {
    
    self.frame=CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
}

-(void)awakeFromNib
{
    
    [super awakeFromNib];
    
    self.myconnection=[[connectionclass alloc] init];
    self.myconnection.mydelegate=self;
    
    self.presentfilterview.hidden=TRUE;
    
    
    [self.myconnection employeeListingservice:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    
    [self.myconnection filterlistingaction:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];


    self.flagvalue=0;
    self.filtertableView1.hidden=TRUE;
    self.workingpremisetableview.hidden=TRUE;
    self.departmenttableview.hidden=TRUE;
    self.categorytableview.hidden=TRUE;

    
    self.filtertableView1.layer.borderWidth = 1.0;
    self.filtertableView1.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.workingpremisetableview.layer.borderWidth = 1.0;
    self.workingpremisetableview.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.departmenttableview.layer.borderWidth = 1.0;
    self.departmenttableview.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.categorytableview.layer.borderWidth = 1.0;
    self.categorytableview.layer.borderColor = [UIColor grayColor].CGColor;
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filteractionon) name:@"filteron" object:Nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(filteractionoff) name:@"filteroff" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentpopupon) name:@"presentpopupon" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(presentpopupoff) name:@"presentpopupoff" object:Nil];
    

    
    self.filterview.hidden=TRUE;
    
    
    self.selectedarray=[[NSMutableArray alloc] init];
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
    
    
    [self.tableView registerClass:[ContainerTableCell class] forCellReuseIdentifier:@"ContainerTableCell"];
    
    
    
    [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_blue.png"] forState:UIControlStateNormal];
    [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
    [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
    [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
    
    self.subcreativedictionary=[[NSMutableDictionary alloc] init];
    
    self.filterdict=[[NSMutableDictionary alloc] init];
    
    self.maincreativedictionary=[[NSMutableDictionary alloc] init];
    
    self.storesubcreativedictionary=[[NSMutableDictionary alloc] init];
    
     self.officefilterdictionary=[[NSMutableDictionary alloc] init];
     self.storefilterdictionary=[[NSMutableDictionary alloc] init];
     self.departmentfilterdictionary=[[NSMutableDictionary alloc] init];
     self.categoryfilterdictionary=[[NSMutableDictionary alloc] init];
     self.designationfilterdictionary=[[NSMutableDictionary alloc] init];
    
    self.statusarray= [[NSMutableArray alloc]initWithObjects:@"Present",@"Absent",@"Holiday",@"Leave",@"Offday", nil];
    
    self.statusimagearray= [[NSMutableArray alloc]initWithObjects:@"present_icon (1).png",@"absent_icon.png",@"holiday_icon.png",@"sickleave_icon.png",@"holiday_icon.png", nil];
    
   }

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ([string isEqualToString:@""] && textField.text.length==1) {
        
        self.flagvalue=0;
        
    }
    else
    {
        self.flagvalue=1;
        
    }
    
    
    [self.filterdict removeAllObjects];
    
    //NSArray *dictioarray=[self.creativedictionary allKeys];
    
    
    NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *dictioarray  = [[self.maincreativedictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
    
    for (int i=0; i<dictioarray.count; i++) {
        
        NSMutableDictionary *dict=[self.maincreativedictionary objectForKey:[dictioarray objectAtIndex:i]];
        
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[textField.text stringByReplacingCharactersInRange:range withString:string]];
        
        NSDictionary *whiteDictionary = [dict dictionaryWithValuesForKeys:[dict.allKeys filteredArrayUsingPredicate:bPredicate]];
        
        [self.filterdict setObject:whiteDictionary forKey:[dictioarray objectAtIndex:i]];
        
    }
    
    
    int countvalue=[[self.filterdict copy] count];
    
    for (int i=0; i<countvalue; i++) {
        
        NSMutableDictionary *dict = [self.filterdict objectForKey:[dictioarray objectAtIndex:i]];
        
        if(!(dict.count>0)) {
            
            [self.filterdict removeObjectForKey:[dictioarray objectAtIndex:i]];
        }
        
    }
    
    
    [self.tableView reloadData];
    
    
    return YES;
    
}



-(void)filteractionon
{
    
  self.filterview.hidden=FALSE;
//    
//    self.frame=CGRectMake(9, 116, self.frame.size.width, self.frame.size.height);
//    
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-350, -300, 1300, 1000)];
//    
//    self.layer.masksToBounds = NO;
//    
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    
//    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
//    
//    self.layer.shadowOpacity = 0.5f;
//    
//    self.layer.shadowPath = shadowPath.CGPath;
    
    self.filtertableView1.hidden=TRUE;
    self.workingpremisetableview.hidden=FALSE;
    self.departmenttableview.hidden=TRUE;
    self.categorytableview.hidden=TRUE;
    
    
    
    [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_red.png"] forState:UIControlStateNormal];
    [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
    [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
    [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
    

}



-(void)filteractionoff
{
    
    self.filterview.hidden=TRUE;
    self.filtertableView1.hidden=TRUE;
    self.workingpremisetableview.hidden=TRUE;
    self.departmenttableview.hidden=TRUE;
    self.categorytableview.hidden=TRUE;
    
    [self.workingpremisebutton setImage:[UIImage imageNamed:@"work_premise_blue.png"] forState:UIControlStateNormal];
    [self.departmentbutton setImage:[UIImage imageNamed:@"dept_blue.png"] forState:UIControlStateNormal];
    [self.categorybutton setImage:[UIImage imageNamed:@"category_blue.png"] forState:UIControlStateNormal];
    [self.designationbutton setImage:[UIImage imageNamed:@"salesman_blue.png"] forState:UIControlStateNormal];
    
}


-(void)presentpopupon
{

  self.presentfilterview.hidden=FALSE;
    
}

-(void)presentpopupoff
{
    
   self.presentfilterview.hidden=TRUE;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView==self.tableView) {
        
        if (self.flagvalue==0) {
            
            
             return [self.maincreativedictionary count];
        }
        else
        {
            
            return [self.filterdict count];
        }

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
    else if (tableView==self.workingpremisetableview) {
        
        return [self.officearray count];
    }
    
    else if (tableView==self.departmenttableview) {
        
        return [self.departmentarray count];
    }
    else if (tableView==self.categorytableview){
        
        return [self.categoryarray count];
    }
    else if (tableView==self.filtertableView1){
        
        return [self.designationarray count];
    }
    else
    {
        return [self.statusarray count];
    }
    // Only one "row" per section - with the NSArray of article titles
}

// Customize the appearance of table view cells.

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView==self.tableView) {
      
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        ContainerTableCell *cell = (ContainerTableCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"staffingtablecell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            
        }
        
        
         if (self.flagvalue==0) {
             
        NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *dictarray  = [[self.maincreativedictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
        
        
        // NSDictionary *cellData = [self.gettinglastarray objectAtIndex:[indexPath section]];  // Note we're using section, not row here
        
        NSDictionary *articleData = [self.maincreativedictionary objectForKey:[dictarray objectAtIndex:indexPath.section]];
        
        
        NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *sortedarray  = [[articleData allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder1]];
        
        
        NSMutableArray *sendarray=[[NSMutableArray alloc] init];
        
        
        for (int i=0; i<sortedarray.count; i++) {
            
            [sendarray addObject:[articleData objectForKey:[sortedarray objectAtIndex:i]]];
            
        }
        
        
        [cell setCollectionData:sendarray];
        
        }
        else
        {
            
            NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
            NSArray *dictarray  = [[self.filterdict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
            
            
            // NSDictionary *cellData = [self.gettinglastarray objectAtIndex:[indexPath section]];  // Note we're using section, not row here
            
            
            NSDictionary *articleData = [self.filterdict objectForKey:[dictarray objectAtIndex:indexPath.section]];
            
            
            NSSortDescriptor *sortOrder1 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
            NSArray *sortedarray  = [[articleData allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder1]];
            
            
            NSMutableArray *sendarray=[[NSMutableArray alloc] init];
            
            
            for (int i=0; i<sortedarray.count; i++) {
                
                [sendarray addObject:[articleData objectForKey:[sortedarray objectAtIndex:i]]];
                
            }
            
            
            [cell setCollectionData:sendarray];
            
        }
        
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
        
        if ([self.selectedarray containsObject:indexPath]) {
            
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
    
    else if (tableView==self.filtertableView1)
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
    else
    {
        
        static NSString *simpleTableIdentifier = @"ContainerTableCell";
        
        presentfilterTableViewCell *cell = (presentfilterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
        
        
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"presentfilterTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        
        
        cell.mainlabel.text=[self.statusarray objectAtIndex:indexPath.row];
        cell.myimgview.image=[UIImage imageNamed:[self.statusimagearray objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor whiteColor];
        return cell;
        
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    
    ContainerTableCell *cell= (ContainerTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.selectedBackgroundView = v;
   
    
    if (tableView==self.workingpremisetableview) {
        
        filtercellTableViewCell *cell1= (filtercellTableViewCell *)[self.workingpremisetableview cellForRowAtIndexPath:indexPath];
        cell1.selectedBackgroundView = v;
        
        if (indexPath.row==0) {
            
            [self.selectedarray removeAllObjects];
            
        if ([cell1.myimgview.image isEqual:[UIImage imageNamed:@"check box (tick).png"]]) {
                
                for (int i=0; i<self.officearray.count; i++) {
                    
                    NSIndexPath *myindex = [NSIndexPath indexPathForRow:i inSection:0];
                    [self.selectedarray addObject:myindex];
                    
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
                [self.selectedarray removeObject:indexPath];
                
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
                
                [self.selectedarray addObject:indexPath];
                
                NSIndexPath *myindex = [NSIndexPath indexPathForRow:0 inSection:0];
                [self.selectedarray addObject:myindex];
                
                
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
    
    if (tableView==self.departmenttableview) {
        
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

    if (tableView==self.categorytableview) {
        
        
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

    if (tableView==self.filtertableView1) {
        
        
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
    
    if (tableView==self.presentabsenttableview) {
        
        
        
        presentfilterTableViewCell *filter =[self.presentabsenttableview cellForRowAtIndexPath:indexPath];
        
        if (filter.backgroundColor==[UIColor whiteColor]) {
            
            UIView *view=[[UIView alloc] init];
            view.backgroundColor=[UIColor clearColor];
            filter.selectedBackgroundView=view;

            
            filter.backgroundColor = [UIColor grayColor];
         
            NSString *string1 = [self.statusarray objectAtIndex:indexPath.row];
            
            NSString *string2 = [self.statusimagearray objectAtIndex:indexPath.row];
            
            demostaffingviewclass *ob = (demostaffingviewclass *)self.superview.superview;
            
            [ob setimageandsearchvalue:string1 and:string2];
        
            self.presentfilterview.hidden=TRUE;
            
            
        }
        else
        {
            
        
            filter.backgroundColor = [UIColor whiteColor];

            UIView *view=[[UIView alloc] init];
            view.backgroundColor=[UIColor clearColor];
            filter.selectedBackgroundView=view;
            

            NSString *string1 = @"";
            
            NSString *string2 = @"se-ecffh.png";
            
            demostaffingviewclass *ob = (demostaffingviewclass *)self.superview.superview;
            
            [ob setimageandsearchvalue:string1 and:string2];

            self.presentfilterview.hidden=TRUE;

            
        }
        
        
    }
    
    
    //NSLog(@"%@",self.office_servicesendarray);
  //  NSLog(@"%@",self.store_servicesendarray);
    
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
      presentfilterTableViewCell *filter =[self.presentabsenttableview cellForRowAtIndexPath:indexPath];
     filter.backgroundColor=[UIColor whiteColor];
}

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
        
        return 153.0;
    }
    else
    {
        return 25;
    }

}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tableView) {
        
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,tableView.frame.size.width,40)];
        imageview.image=[UIImage imageNamed:@"department blank.png"];
        [self.tableView.tableHeaderView addSubview:imageview];
        
        if (self.flagvalue==0) {
            
        NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *array11  = [[self.maincreativedictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1,250,30)];
        headerLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
        headerLabel.text = [array11 objectAtIndex:section];
        headerLabel.backgroundColor = [UIColor clearColor];
        [imageview addSubview:headerLabel];
        return imageview;
            
        }
        else
        {
            
            NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
            NSArray *array11  = [[self.filterdict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
            
            UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 1,250,30)];
            headerLabel.font = [UIFont fontWithName:@"Helvetica-Light" size:15];
            headerLabel.text = [array11 objectAtIndex:section];
            headerLabel.backgroundColor = [UIColor clearColor];
            [imageview addSubview:headerLabel];
            return imageview;

            
        }

    }
    else
    
        return Nil;
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

-(void)employeelistingService:(NSMutableDictionary *)listingResponse
{
  
  if (listingResponse.count>0) {
        
   [self.maincreativedictionary removeAllObjects];
    
    NSMutableDictionary *officedict = [listingResponse objectForKey:@"office"];
    NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
    NSArray *dictioarray  = [[officedict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
    
    for (int i=0; i<dictioarray.count; i++) {
        
        
        NSMutableArray *myarrays = [officedict objectForKey:[dictioarray objectAtIndex:i]];
        
        NSMutableDictionary *storeingdictionary=[[NSMutableDictionary alloc] init];
        
        for (int j=0; j<myarrays.count; j++) {
            
            NSMutableDictionary *dict = [myarrays objectAtIndex:j];
            [storeingdictionary setObject:dict forKey:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"emp_name"],[dict objectForKey:@"emp_id"]]];
        
        }
        
        
        [self.maincreativedictionary setObject:storeingdictionary forKey:[NSString stringWithFormat:@"Office:%@",[dictioarray objectAtIndex:i]]];
        
    }
    
     NSMutableDictionary *storedict = [listingResponse objectForKey:@"store"];
    
     NSSortDescriptor *sortOrder2 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
     NSArray *dictioarray2  = [[storedict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder2]];
    
    
    
    for (int i=0; i<dictioarray2.count; i++) {
        
        NSMutableDictionary *mydict = [storedict objectForKey:[dictioarray2 objectAtIndex:i]];
        NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *array  = [[mydict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
     
        for (int j=0; j<array.count; j++) {
            
            
            NSMutableArray *myarrays = [mydict objectForKey:[array objectAtIndex:j]];
            
            NSMutableDictionary *storeingdictionary=[[NSMutableDictionary alloc] init];
            
            for (int k=0; k<myarrays.count; k++) {
                
                NSMutableDictionary *dict = [myarrays objectAtIndex:k];
                [storeingdictionary setObject:dict forKey:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"emp_name"],[dict objectForKey:@"emp_id"]]];
                
            }
            
            [self.maincreativedictionary setObject:storeingdictionary forKey:[NSString stringWithFormat:@"%@:%@",[dictioarray2 objectAtIndex:i],[array objectAtIndex:j]]];
            
        }
        
    }
        
    
//        NSSortDescriptor *sortingforfilterOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
//        NSArray *karray  = [[self.maincreativedictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortingforfilterOrder]];
//        
//        
//        for (int k=0; k<karray.count; k++) {
//            
//            
//        NSMutableArray *sarray=[self.maincreativedictionary objectForKey:[karray objectAtIndex:k]];
//            
//        if (!(sarray.count>0)) {
//                
//            [self.maincreativedictionary removeObjectForKey:[karray objectAtIndex:k]];
//                
//           
//        }
//            
//            
//    }
      
  //  NSLog(@"%@",self.maincreativedictionary);
        
    dispatch_async(dispatch_get_main_queue(), ^{
    
    [self.tableView reloadData];
        
    });

  }
    
    
}

-(IBAction)donebuttonaction:(id)sender
{
   
    
    demostaffingviewclass *ob = (demostaffingviewclass *)self.superview.superview;
    [ob forfilterviewdoneaction];
     self.filterview.hidden=TRUE;
    

       NSLog(@"%@",self.office_servicesendarray);
       NSLog(@"%@",self.store_servicesendarray);
       NSLog(@"%@",self.department_servicesendarray);
       NSLog(@"%@",self.category_servicesendarray);
       NSLog(@"%@",self.designation_servicesendarray);
    
    
    [self.myconnection filteringEmployeelist:self.office_servicesendarray storearray:self.store_servicesendarray departArray:self.department_servicesendarray catearray:self.category_servicesendarray designation:self.designation_servicesendarray officeid:[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedofficeId"]];
    
    
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:@"No internet connection"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
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

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    
//     demostaffingviewclass *ob = (demostaffingviewclass *)self.superview.superview;
//     ob.searchfield.text=@"";
//     [self.presentabsenttableview reloadData];
//     ob.searchicon.image=[UIImage imageNamed:@"se-ecffh.png"];
//     return YES;
//}

-(void)filterigemployeelistingService:(NSMutableDictionary *)filterlistingResponse
{
    self.flagvalue=0;
    
    if (filterlistingResponse.count>0) {
        
        [self.maincreativedictionary removeAllObjects];
        
        NSMutableDictionary *officedict = [filterlistingResponse objectForKey:@"office"];
        NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *dictioarray  = [[officedict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
        
        for (int i=0; i<dictioarray.count; i++) {
            
            
            NSMutableArray *myarrays = [officedict objectForKey:[dictioarray objectAtIndex:i]];
            
            NSMutableDictionary *storeingdictionary=[[NSMutableDictionary alloc] init];
            
            for (int j=0; j<myarrays.count; j++) {
                
                NSMutableDictionary *dict = [myarrays objectAtIndex:j];
                [storeingdictionary setObject:dict forKey:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"emp_name"],[dict objectForKey:@"emp_id"]]];
                
            }
            
            [self.maincreativedictionary setObject:storeingdictionary forKey:[NSString stringWithFormat:@"Office:%@",[dictioarray objectAtIndex:i]]];
            
            
        }
        
        
        NSMutableDictionary *storedict = [filterlistingResponse objectForKey:@"store_list"];
        
        NSSortDescriptor *sortOrder2 = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
        NSArray *dictioarray2  = [[storedict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder2]];
        
        
        
        for (int i=0; i<dictioarray2.count; i++) {
            
            NSMutableDictionary *mydict = [storedict objectForKey:[dictioarray2 objectAtIndex:i]];
            NSSortDescriptor *sortOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
            NSArray *array  = [[mydict allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortOrder]];
            
            for (int j=0; j<array.count; j++) {
                
                
                NSMutableArray *myarrays = [mydict objectForKey:[array objectAtIndex:j]];
                
                NSMutableDictionary *storeingdictionary=[[NSMutableDictionary alloc] init];
                
                for (int k=0; k<myarrays.count; k++) {
                    
                    NSMutableDictionary *dict = [myarrays objectAtIndex:k];
                    [storeingdictionary setObject:dict forKey:[NSString stringWithFormat:@"%@%@",[dict objectForKey:@"emp_name"],[dict objectForKey:@"emp_id"]]];
                    
                }
                
                [self.maincreativedictionary setObject:storeingdictionary forKey:[NSString stringWithFormat:@"%@:%@",[dictioarray2 objectAtIndex:i],[array objectAtIndex:j]]];
                
            }
            
        }
        
               NSLog(@"%@",self.selectedarray);
   
        
                NSSortDescriptor *sortingforfilterOrder = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:YES];
                NSArray *karray  = [[self.maincreativedictionary allKeys] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortingforfilterOrder]];
                NSLog(@"%@",karray);
                
                
                for (int k=0; k<karray.count; k++) {
                    
                    
                    NSMutableDictionary *sdictionary=[self.maincreativedictionary objectForKey:[karray objectAtIndex:k]];
                    
                    if (!(sdictionary.count>0)) {
                        
                        [self.maincreativedictionary removeObjectForKey:[karray objectAtIndex:k]];
                        
                    }
                }

        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });
    }
    else
    {
       
        [self.maincreativedictionary removeAllObjects];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
            
        });

        
    }

}


@end
