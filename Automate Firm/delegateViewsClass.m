//
//  delegateViewClass.m
//  
//
//  Created by leonine on 10/8/15.
//
//

#import "delegateViewsClass.h"
#import "delegateCollectionViewsCell.h"
#import "rulesTableViewCell.h"
#import "settingcell.h"
#import "designationSearchTableViewCell.h"
#import "workingPremisesTableViewCell.h"
@implementation delegateViewsClass
@synthesize inPath;
@synthesize x,y,sampleArray1,sampleArray2,sampleArray3,sampleArray4,sampleArray5,sampleArray6,designationArray,filteredArray;
-(void)awakeFromNib
{
     [ self.delegateCollectionView registerNib:[UINib nibWithNibName:@"delegateCollectionViewsCell" bundle:nil] forCellWithReuseIdentifier:@"delegateCell"];
    [ self.delegateiconscollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
        self.authorizationNameArray=[[NSMutableArray alloc]initWithObjects:@"Authorization Name",@"Authorization Name",@"Authorization Name",@"Authorization Name",@"Authorization Name", nil];
    
    
    self.iconsarray=[[NSMutableArray alloc]initWithObjects:@"top_office_active.png",  nil];
    
    self.iconnamesarray=[[NSMutableArray alloc]initWithObjects:@"Office 1", nil];
    
    self.officetypeimagearray=[[NSMutableArray alloc] initWithObjects:@"top_office_normal.png",@"store.png",@"online_store.png",@"warehouse.png",@"production_blacks.png", nil];
    self.officetypearray=[[NSMutableArray alloc] initWithObjects:@"Office 1",@"Store",@"Online Store",@"Warehouse",@"Production Unit", nil];
    
    
    self.sampleArray1=[[NSMutableArray alloc]initWithObjects:@"Sales Manager",@"Westmister Abby", nil];
    self.sampleArray2=[[NSMutableArray alloc] initWithObjects:@"Sales Coordinator",@"Store Manhattan 2", nil];
    self.sampleArray3=[[NSMutableArray alloc] initWithObjects:@"Salesman",@"Crome Production Unit", nil];
    self.sampleArray4=[[NSMutableArray alloc]initWithObjects:@"Finance Manager",@"Westmister Abby", nil];
    self.sampleArray5=[[NSMutableArray alloc] initWithObjects:@"Accountant",@"Store Manhattan 2", nil];
    self.sampleArray6=[[NSMutableArray alloc] initWithObjects:@"Sales Executive",@"Crome Production Unit", nil];
    self.designationArray=[[NSMutableArray alloc]init];
    self.filteredArray=[[NSMutableArray alloc]init];
    self.desigDict=[[NSMutableDictionary alloc]init];
    [self.desigDict setObject:self.sampleArray1 forKey:[self.sampleArray1 objectAtIndex:0]];
    [self.desigDict setObject:self.sampleArray2 forKey:[self.sampleArray2 objectAtIndex:0]];
    [self.desigDict setObject:self.sampleArray3 forKey:[self.sampleArray3 objectAtIndex:0]];
    [self.desigDict setObject:self.sampleArray4 forKey:[self.sampleArray4 objectAtIndex:0]];
    [self.desigDict setObject:self.sampleArray5 forKey:[self.sampleArray5 objectAtIndex:0]];
    [self.desigDict setObject:self.sampleArray6 forKey:[self.sampleArray6 objectAtIndex:0]];
    
    self.designationSearchView.hidden=true;
    self.workingPremisesTC.hidden=true;
    
    self.designationArray=[[self.desigDict allKeys]mutableCopy];
    x=0;
    y=0;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disablecollcetionview) name:@"disableoffice" object:Nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enablecollcetionview) name:@"enableoffice" object:Nil];
}
-(void)disablecollcetionview
{
    [self.delegateiconscollectionview setUserInteractionEnabled:FALSE];
    
}

-(void)enablecollcetionview
{
    [self.delegateiconscollectionview setUserInteractionEnabled:TRUE];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView==self.delegateCollectionView)
    {
        return 10;
    }
    else
    {
        return  self.iconsarray.count;
    }
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.delegateCollectionView) {
        delegateCollectionViewsCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"delegateCell" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    
        cell.myimg.image=[UIImage imageNamed:[self.iconsarray objectAtIndex:indexPath.row]];
        cell.mylabel.text=[self.iconnamesarray objectAtIndex:indexPath.row];
        
    
        UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.delegateiconscollectionview.collectionViewLayout;
        flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        flow.minimumLineSpacing = 27;
        return cell;
    }
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.rulesTavleView) {
        return 5;
    }
    else if(tableView==self.designationSearchTableView)
    {
        if (y==0) {
            return self.designationArray.count;
        }
        else
        {
            return self.filteredArray.count;
        }
    }
    else
        return self.officetypearray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.rulesTavleView) {
        rulesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"rulesTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        cell.mainLabel.text=[self.authorizationNameArray objectAtIndex: indexPath.row];
        return cell;
    }
    else if(tableView==self.designationSearchTableView)
    {
        designationSearchTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"designationSearchTableViewCell" owner:self options:nil];
            cell=[nib objectAtIndex:0];
        }
        if (y==1) {
            
            NSMutableArray *loadarray=[self.desigDict objectForKey:[self.filteredArray objectAtIndex:indexPath.row]];
            cell.designationLabel.text=[loadarray objectAtIndex:0];
            cell.unitLabel.text=[loadarray objectAtIndex:1];
        }
        else
        {
            NSMutableArray *loadarray=[self.desigDict objectForKey:[self.self.designationArray objectAtIndex:indexPath.row]];
            
            cell.designationLabel.text=[loadarray objectAtIndex:0];
            cell.unitLabel.text=[loadarray objectAtIndex:1];
            
        }
        return  cell;
    }
    else
    {
        workingPremisesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell==nil) {
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"workingPremisesTableViewCell" owner:self options:nil];
            cell=[array objectAtIndex:0];
        }
        cell.myImage.image=[UIImage imageNamed:[self.officetypeimagearray objectAtIndex:indexPath.row]];
        cell.myLabel.text=[self.officetypearray objectAtIndex:indexPath.row];
        return  cell;
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.rulesTavleView) {
        
    }
    else if (tableView==self.designationSearchTableView)
    {
        designationSearchTableViewCell *cell=[self.designationSearchTableView cellForRowAtIndexPath:indexPath];
        self.designationSearchText.text=cell.designationLabel.text;
        [self.designationSearchText resignFirstResponder];
        self.designationSearchView.hidden=true;
    }
    else if (tableView==self.workingPremisesTC)
    {
        self.workingPremisestext.text=[self.officetypearray objectAtIndex:indexPath.row];
        self.workingPremisesTC.hidden=true;
        
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField==self.designationSearchText) {
        self.designationSearchView.hidden=false;
        return  YES;
    }
    else if(textField==self.workingPremisestext)
    {
        self.workingPremisesTC.hidden=false;
        return  NO;
    }
    else
        return  YES;
    
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    self.designationSearchView.hidden=true;
    return  YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField==self.designationSearchText) {
        y=1;
        NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",[self.designationSearchText.text stringByReplacingCharactersInRange:range withString:string]];
        self.filteredArray = [[self.designationArray filteredArrayUsingPredicate:bPredicate] mutableCopy];
        [self.designationSearchTableView reloadData];
        
        if ([string isEqualToString:@""] && textField.text.length==1) {
            
            y=0;
            
            [self.designationSearchTableView reloadData];
            
        }
        
        return  YES;
    }
    else
    {
        return  YES;
    }
    return false;
    
    
}

-(IBAction)addNewDelegateAction:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disableoffice" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"addNewDelegateViews" owner:self options:Nil];
    [self.settingswholeview addSubview:[nib objectAtIndex:0]];
}
@end
