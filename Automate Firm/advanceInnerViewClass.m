//
//  advanceInnerViewClass.m
//  Automate Firm
//
//  Created by leonine on 11/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "advanceInnerViewClass.h"
#import "groupcollceioncellclass.h"
#import "popupTableViewCell.h"
#import "advanceDocumentTile.h"

@implementation advanceInnerViewClass

@synthesize buttonFlag,x,y,z,p,q;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.mycollectionview registerNib:[UINib nibWithNibName:@"Groupcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    self.grouparray=[[NSMutableArray alloc]init];
    self.popupArray=[[NSMutableArray alloc] initWithObjects:@"Designations",@"Owners",@"Specific Individuals", nil];
    
    self.finalDict=[[NSMutableDictionary alloc]init];
    
    self.popUpView.hidden=true;
    self.button2.userInteractionEnabled=NO;
    self.button3.userInteractionEnabled=NO;
    self.button4.userInteractionEnabled=NO;
    buttonFlag=0;
    x=0;
    y=0;
    z=0;
    p=q=0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.grouparray count];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"simplecell";
    groupcollceioncellclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    if (self.grouparray.count>0) {
        cell.grouplabel.text=[self.grouparray objectAtIndex:indexPath.row];
        
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.popupArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil) {
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"popupTableViewCell" owner:self options:nil];
        cell=[nib objectAtIndex:0];
    }
    cell.popupLabel.text=[self.popupArray objectAtIndex:indexPath.row];
    return  cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[self.popupTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"drop_box_blue.png"];
    cell.popupLabel.textColor=[UIColor whiteColor];
    if (indexPath.row==0) {
        [[NSUserDefaults standardUserDefaults]setObject:@"designation" forKey:@"popupAction"];
        [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"includeDesignation"];
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeDesignationView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    }
    if (indexPath.row==1) {
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.button3 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.button4 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.button5 setImage:[UIImage imageNamed:@"circle_1.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
    }
    if (indexPath.row==2) {
        [[NSUserDefaults standardUserDefaults]setObject:@"employee" forKey:@"popupAction"];
        NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"assignToSpecificEmployeeView" owner:self options:nil];
        [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
        
    }
}
-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    popupTableViewCell *cell=[self.popupTableView cellForRowAtIndexPath:indexPath];
    cell.backImage.image=[UIImage imageNamed:@"drop_box_white.png"];
    cell.popupLabel.textColor=[UIColor blackColor];
}
-(IBAction)button1Action:(id)sender
{
    if (x%2==0) {
        buttonFlag=1;
        app.flowAction=@"1";
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(-5, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        x++;
    }
    else
    {
        x++;
        self.popUpView.hidden=true;
    }
    
    
}
-(IBAction)button2Action:(id)sender
{
    if (y%2==0) {
        buttonFlag=2;
        app.flowAction=@"2";
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(95, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        y++;
    }
    else
    {
        y++;
        self.popUpView.hidden=true;
    }
}
-(IBAction)button3Action:(id)sender
{
    if (z%2==0) {
        buttonFlag=3;
        app.flowAction=@"3";
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(208, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
        z++;
    }
    else
    {
        z++;
        self.popUpView.hidden=true;
    }
    
}
-(IBAction)button4Action:(id)sender
{
    if (p%2==0) {
        buttonFlag=4;
        app.flowAction=@"4";
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(325, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
    }
    else
    {
        p++;
        self.popUpView.hidden=true;
    }
    
}
-(IBAction)button5Action:(id)sender
{
    if (q%2==0) {
        buttonFlag=5;
        app.flowAction=@"5";
        self.popUpView.hidden=false;
        [self.popupTableView reloadData];
        self.popUpView.frame=CGRectMake(425, 126, self.popUpView.frame.size.width, self.popUpView.frame.size.height);
    }
    else
    {
        q++;
        self.popUpView.hidden=true;
    }
    
}

-(IBAction)includeDesignationAction:(id)sender
{
    [[NSUserDefaults standardUserDefaults]setObject:@"includedesignation" forKey:@"popupAction"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"includeEmployeePopup" owner:self options:nil];
    [self.superview.superview.superview addSubview:[nib objectAtIndex:0]];
    
}
-(void)collectionViewReload:(NSMutableArray *)desigArray
{
    [self.finalDict setObject:desigArray forKey:@"selectedEmployees"];
    
    self.mycollectionview.hidden=false;
    [self.grouparray addObjectsFromArray:desigArray];
    [self.mycollectionview reloadData];
    
    
    
}
-(void)assignDesignation:(NSMutableArray *)desigArray
{
    if (desigArray.count > 0) {
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.button3 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.button4 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=YES;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.button5 setImage:[UIImage imageNamed:@"circle_2.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        NSMutableDictionary *designationDict=[[NSMutableDictionary alloc]init];
        [designationDict setObject:desigArray forKey:@"selected_designation"];
        [designationDict  setObject:@"designation" forKey:@"type"];
        [self.finalDict setObject:designationDict forKey:app.flowAction];
    }
    
    
    
}



-(void)specificEmployee:(NSMutableArray *)selectedEmployee :(NSData *)selectedEmployeeIcon
{
    if (selectedEmployee.count > 1) {
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.button3 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.button4 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=NO;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.button5 setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    else if (selectedEmployee.count == 1)
    {
        if (buttonFlag==1) {
            [self.button1 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button1.layer.cornerRadius = self.button1.frame.size.width / 2;
            self.button1.clipsToBounds = YES;
            self.button2.userInteractionEnabled=YES;
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==2)
        {
            [self.button2 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button3.userInteractionEnabled=YES;
            self.arrowImage1.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if (buttonFlag==3)
        {
            [self.button3 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button4.userInteractionEnabled=YES;
            self.arrowImage2.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else if(buttonFlag==4)
        {
            [self.button4 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.button5.userInteractionEnabled=YES;
            self.arrowImage3.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        else
        {
            [self.button5 setImage:[UIImage imageWithData:selectedEmployeeIcon] forState:UIControlStateNormal];
            self.arrowImage4.image=[UIImage imageNamed:@"process_arrow_blue.png"];
            self.popUpView.hidden=true;
        }
        
    }
    NSMutableDictionary *designationDict=[[NSMutableDictionary alloc]init];
    [designationDict setObject:selectedEmployee forKey:@"selected_employee"];
    [designationDict setObject:@"employee" forKey:@"type"];
    [self.finalDict setObject:designationDict forKey:app.flowAction];
}
-(IBAction)removegroupfromcollectionview:(id)sender
{
    groupcollceioncellclass *clickedCell = (groupcollceioncellclass *)[[sender superview] superview];
    self.indexpath = [self.mycollectionview indexPathForCell:clickedCell];
    [self.grouparray removeObjectAtIndex:self.indexpath.row];
    [self.mycollectionview reloadData];
}
-(IBAction)saveButtonAction:(id)sender
{
    [self.finalDict setObject:self.descriptionText.text forKey:@"description"];
    
    
    advanceDocumentTile *ob = (advanceDocumentTile *)self.superview.superview;
    
    [ob addaccordianview];
}

@end
