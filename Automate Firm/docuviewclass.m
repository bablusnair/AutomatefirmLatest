//
//  docuviewclass.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 17/08/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "docuviewclass.h"
#import "docucollcetioncell.h"
#import "documentationfronttablecellviewclass.h"
#import "AppDelegate.h"
#import "homeViewController.h"
#import "pdfViewController.h"
@implementation docuviewclass

- (void)awakeFromNib {
    
    [super awakeFromNib];
    
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.mycollectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(156.0,149.0);
    [self.mycollectionView setCollectionViewLayout:flowLayout];
    
    self.selecteddictionary =[[NSMutableDictionary alloc] init];
    self.strorearray=[[NSMutableArray alloc] init];
    // Register the collection cell
    [ self.mycollectionView registerNib:[UINib nibWithNibName:@"docucollcetioncell" bundle:nil] forCellWithReuseIdentifier:@"ArticleCollectionViewCell"];
    
    self.imgarray=[[NSMutableArray alloc]initWithObjects:@"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg",@"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg",@"document-thumbnail.jpg", @"document-thumbnail.jpg", @"document-thumbnail.jpg",  nil];
    
    //self.selectedarray=[[NSMutableArray alloc] init];
    
     self.selectedarray2=[[NSMutableArray alloc] init];
     self.selectedarray=[[NSMutableArray alloc] init];
    
}
- (void)setCollectionData:(NSArray *)data {
    // self.selectedarray=[[NSMutableArray alloc] init];

    self.mycollectionData1 = data;
    [ self.mycollectionView setContentOffset:CGPointZero animated:NO];
    [ self.mycollectionView reloadData];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [self.mycollectionData1 count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    docucollcetioncell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCollectionViewCell" forIndexPath:indexPath];
    NSMutableDictionary *cellData =[self.mycollectionData1 objectAtIndex:indexPath.row];
    
    
    
    if ([[cellData objectForKey:@"doc_data"]isEqualToString:@""]){
        
        
        cell.myimg.image=[UIImage imageNamed:@"img 1.png"];
        
    }
    else
    {
        
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[cellData objectForKey:@"doc_data"] options:0];
        
        cell.myimg.image=[UIImage imageWithData:decodedData];
        
    }
    
    
    cell.docname.text=[NSString stringWithFormat:@"EMP %@",[cellData objectForKey:@"emp_id"]];
    cell.docname.userInteractionEnabled=NO;
    cell.docname.delegate=self;
    
    
    UILongPressGestureRecognizer *press =[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longpressaction:)];
    [cell addGestureRecognizer:press];
    UITapGestureRecognizer *TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
    [TapRecognizer setNumberOfTapsRequired:2];
    TapRecognizer.delaysTouchesBegan = YES;
    [cell  addGestureRecognizer:TapRecognizer];
    
    NSString *str = [cellData objectForKey:@"id"];
    
    //self.selectedarray=[[NSUserDefaults standardUserDefaults] objectForKey:@"selectedarraykey"];
    
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];

    if ([myappde.documentarray containsObject:str]) {
        
        cell.selectedtickimage.hidden=FALSE;
    }
    else
    {
        cell.selectedtickimage.hidden=TRUE;
    }

    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSMutableDictionary *cellData =[self.mycollectionData1 objectAtIndex:indexPath.row];
    
    NSLog(@"%@",cellData);
    
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    docucollcetioncell *cell = (docucollcetioncell *)[self.mycollectionView cellForItemAtIndexPath:indexPath];
    
     NSMutableDictionary *dict =[self.mycollectionData1 objectAtIndex:indexPath.row];
    
    // NSLog(@"%ld",(long)indexPath.section);
    
    if (cell.selectedtickimage.hidden==TRUE) {
        
        cell.selectedtickimage.hidden=FALSE;
        [myappde.documentarray addObject:[dict objectForKey:@"id"]];
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttondisabledfunction" object:Nil];
        
        if(myappde.documentarray.count==6)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"disablesignbutton" object:Nil];
        }
        
        if(myappde.documentarray.count==2)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectallpresent" object:Nil];
        }
    }
    else
    {
        
        cell.selectedtickimage.hidden=TRUE;
        
        [myappde.documentarray removeObject:[dict objectForKey:@"id"]];
        
        if (!(myappde.documentarray.count>0)) {
            
        [[NSNotificationCenter defaultCenter] postNotificationName:@"buttonenabledfunction" object:Nil];
            
        }
        
        if(myappde.documentarray.count==5)
        {
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"enablesignbutton" object:Nil];
            
        }
        
        if(myappde.documentarray.count==6)
        {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"enablesignbutton" object:Nil];
            
        }

        if(myappde.documentarray.count==1)
        {
            
          [[NSNotificationCenter defaultCenter] postNotificationName:@"deselectallabsent" object:Nil];
            
        }
        
    }
    
    NSLog(@"%@",myappde.documentarray);
}

-(void)longpressaction:(UILongPressGestureRecognizer *)press
{
    docucollcetioncell *cell = (docucollcetioncell *)press.view;
    cell.docname.userInteractionEnabled=YES;
    [cell.docname becomeFirstResponder];
    
    UITableView *tableview=(UITableView *)self.superview.superview.superview.superview;
    
    CGPoint buttonPosition = [cell.docname convertPoint:CGPointZero toView:tableview];
    

    [tableview setContentOffset:CGPointMake(0, buttonPosition.y-125) animated:YES];
    
   // NSLog(@"%@",self.superview.superview.superview.superview)
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    docucollcetioncell *cell = (docucollcetioncell *)textField.superview.superview;
    NSIndexPath *indexpath=[self.mycollectionView indexPathForCell:cell];
    cell.docname.userInteractionEnabled=NO;
    [cell.docname resignFirstResponder];
    UITableView *tableview=(UITableView *)self.superview.superview.superview.superview;
    [tableview setContentOffset:CGPointMake(0, 0) animated:YES];
    
    NSMutableDictionary *dict =[self.mycollectionData1 objectAtIndex:indexpath.row];
      
    if (textField.text.length>0) {
        
        [self.myconnection documentRenameprocessingFunctionality:[dict objectForKey:@"id"] renameVariable:textField.text];
    }
    
    return YES;
}

-(void)handleTapView:(UITapGestureRecognizer *)guesture
{
    pdfViewController *ob=(pdfViewController *)[self.superview.superview.superview.superview.superview.superview.superview.superview nextResponder];
    [ob performSegueWithIdentifier:@"pdfcontroller" sender:nil];
    
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
        
        [(homeViewController *)[self.superview.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
    
}

@end
