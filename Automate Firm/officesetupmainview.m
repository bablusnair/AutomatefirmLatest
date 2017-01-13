//
//  officesetupmainview.m
//  Automate Firm
//
//  Created by leonine on 05/11/15.
//  Copyright © 2015 leonine. All rights reserved.
//

#import "officesetupmainview.h"
#import "settingcell.h"
#import "officesetupcustomcell.h"
#import "settingsViewController.h"
#import "connectionclass.h"
@implementation officesetupmainview

-(void)awakeFromNib
{
    // office view service
    app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    [self getofficefunction];
    
    
    //for loading collectionview
    
    [ self.officesetupcollectionview registerNib:[UINib nibWithNibName:@"settingcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.iconsarray=[[NSMutableArray alloc]initWithObjects:@"top_office_normal.png",  nil];
    self.iconnamesarray=[[NSMutableArray alloc]initWithObjects:@"Office 1", nil];
    self.onlinestoredictionary=[[NSMutableDictionary alloc]init];
    self.departmentary = [[NSMutableArray alloc]init];
    self.categoryaray = [[NSMutableArray alloc]init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(disabledaction) name:@"disabled" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enabledaction) name:@"enabled" object:Nil];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(getofficefunction) name:@"reloadoffice" object:Nil];
    

    }


-(void)getofficefunction
{
    dispatch_async(dispatch_get_main_queue(), ^{
       [app hudStart:self];
        [self.myconnection displayOfficeDetail:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        [self.myconnection OfficeStoreView:[[NSUserDefaults standardUserDefaults]objectForKey:@"selectedofficeId"]];
        
    
    });

    
}

//Office View Service Response

-(void)individualOfficeView:(NSMutableDictionary *)officelist :(UIImage *)logoimg
{
    if (!(logoimg==Nil)) {
        [app hudStop];
    }
    
    NSData *officeEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:officelist];
    
    NSUserDefaults *userData = [NSUserDefaults standardUserDefaults];
    
    [userData setObject:officeEncodedObject forKey:@"dictionaryKey"];
    
     dispatch_async(dispatch_get_main_queue(), ^{
        self.logoimgview.image = logoimg;
        self.ofcnamelabel.text = [NSString stringWithFormat:@"%@ (%@)",[[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"office_name"],[[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"sub_title"]];
        self.oficesector.text = [[[[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"sector"]componentsSeparatedByString:@"###"]objectAtIndex:1];
        self.oficefinancialyear.text = [NSString stringWithFormat:@"%@ (Book Begins)",[[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"year"]];
        self.oficeregid.text = [[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"reg_id"];
        self.curency.text = [[[[[officelist objectForKey:@"office"]objectAtIndex:0]objectForKey:@"currency"]componentsSeparatedByString:@"###"]objectAtIndex:1];
          dispatch_async(dispatch_get_main_queue(), ^{
         [self.officesetupcollectionview reloadData];
         });
    });
}

//Store View Service Response
-(void)storeviewresponse:(id)storelist
{
    self.onlinestoredictionary=storelist;
      
     dispatch_async(dispatch_get_main_queue(), ^{
         [self.officesetupcontainstableview reloadData];
    });
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    
    return self.iconnamesarray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    settingcell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell" forIndexPath:indexPath];
    cell.myimg.image=[UIImage imageNamed:@"top_office_active.png"];
    cell.mylabel.text=[self.iconnamesarray objectAtIndex:indexPath.row];
    cell.mylabel.textColor=[UIColor blueColor];
    cell.myimg.hidden=TRUE;
    cell.mylabel.hidden=TRUE;
    UICollectionViewFlowLayout *flow = (UICollectionViewFlowLayout*)self.officesetupcollectionview.collectionViewLayout;
    flow.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flow.minimumLineSpacing = 27;
    return cell;
 }

//delegate functions for tableview

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[self.onlinestoredictionary objectForKey:@"store_details" ]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"simplecell";
    officesetupcustomcell  *cell = (officesetupcustomcell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"officesetupcell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
    }
    
    cell.mainLabel.text=[[[self.onlinestoredictionary objectForKey:@"store_details"]objectAtIndex:indexPath.row]objectForKey:@"store_name"];
    cell.descriptionLabel.text=[[[self.onlinestoredictionary objectForKey:@"store_details"]objectAtIndex:indexPath.row]objectForKey:@"description"];
    cell.lastModifiedLabel.text=[[[self.onlinestoredictionary objectForKey:@"store_details"]objectAtIndex:indexPath.row]objectForKey:@"last_modified"];
    cell.storeidlabel.text=[[[self.onlinestoredictionary objectForKey:@"store_details"]objectAtIndex:indexPath.row]objectForKey:@"store_id"];

    return cell;
    
}
//individualview for logged office and enable and disable setttings tableview and collctionview
-(IBAction)updationofcreatedoffice:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disabled" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    [[NSUserDefaults standardUserDefaults] setObject:@"office" forKey:@"key"];
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"individualofficeview" owner:self options:nil];
    UIView *myview=[nib objectAtIndex:0];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.officesetupsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
    [self.officesetupsettingscontainsview addSubview:myview];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"wpsdictionary"];
      [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerdictionary"];

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    officesetupcustomcell *cell1 = (officesetupcustomcell *)[self.officesetupcontainstableview cellForRowAtIndexPath:indexPath];
    [[NSUserDefaults standardUserDefaults] setObject:cell1.storeidlabel.text forKey:@"storeidKey"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"disabled" object:Nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Tableview" object:Nil];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"printerstoredictionary"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"storewpsdictionary"];
   // officesetupcustomcell *cell1 = (officesetupcustomcell *)[self.officesetupcontainstableview cellForRowAtIndexPath:indexPath];
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell1.selectedBackgroundView = v;
    //individualview for store and enable and disable setttings tableview and collctionview
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"individualstoreviewview" owner:self options:nil];
    UIView *myview=[nib objectAtIndex:0];
    CATransition *applicationLoadViewIn =[CATransition animation];
    [applicationLoadViewIn setDuration:0.5];
    [applicationLoadViewIn setType:kCATransitionReveal];
    [applicationLoadViewIn setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    [[self.officesetupsettingscontainsview layer]addAnimation:applicationLoadViewIn forKey:kCAMediaTimingFunctionEaseOut];
    [self.officesetupsettingscontainsview addSubview:myview];
    
}
//To change office logo image
-(IBAction)uploadimagepickeraction:(id)sender
{
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [(settingsViewController *)[self.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
}


//imagepicker delegates and datasources
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    UIImage *chosenImage = info[UIImagePickerControllerOriginalImage];
    [self.myconnection uploadNewImage:chosenImage :@"1"];
    
   // self.logoimgview.contentMode=UIViewContentModeScaleAspectFill;
    self.logoimgview.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
//To disabled and enabled settings tableview and collectionview

-(void)enabledaction
{
    [self.officesetupcollectionview setUserInteractionEnabled:TRUE];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"tableenabled" object:Nil];
}


-(void)disabledaction
{
    [self.officesetupcollectionview setUserInteractionEnabled:FALSE];
     [[NSNotificationCenter defaultCenter] postNotificationName:@"tabledisabled" object:Nil];
}


@end
