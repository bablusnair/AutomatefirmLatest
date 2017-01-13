//
//  documentViewClass.m
//  Automate Firm
//
//  Created by leonine on 8/9/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#define RADIANS(degrees) ((degrees * M_PI) / 180.0)
#import "documentViewClass.h"
#import "documentViewCollectionViewCell.h"
#import "homeViewController.h"
#import "pdfViewController.h"
#import <DropboxSDK/DropboxSDK.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
//stpe4
#define APP_KEY  @"d1npf9a2hx66ano"
#define APP_SECRET  @"xrhv29os1g8mq2e"


@implementation documentViewClass
@synthesize actionFlag;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.frame=CGRectMake(80, 130, self.frame.size.width, self.frame.size.height);
    self.backgroundColor=[UIColor whiteColor];
    self.alpha=100;
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-330, -250, 1300, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    //  self.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    self.obj=[[commonFunctionsCallClass alloc]init];
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    
    self.app=(AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    
    [self.documentCollectionView registerNib:[UINib nibWithNibName:@"documentViewCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"documentViewCell"] ;
    
    self.documentDictionary=[[NSMutableDictionary alloc]init];
    self.documentIDDictionary=[[NSMutableDictionary alloc]init];
    self.documentTitle.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"titleLabel"];
    self.documentArray=[[NSMutableArray alloc] init];
    self.deleteIndexArray=[[NSMutableArray alloc]init];
    self.hideFlag=0;
    self.replaceFlag=1;
    self.replaceString=@"0";
    
    //For Cell
    self.centralWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(0.0));
//    UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
//    doubleTapGesture.numberOfTapsRequired = 2;
//    [self.documentCollectionView addGestureRecognizer:doubleTapGesture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDropbox) name:@"dropboxLoad" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDocuments) name:@"viewDocuments" object:Nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewPdf) name:@"viewPdf" object:Nil];
    
    
    [self.myconnection viewUploadedDocument:[[NSUserDefaults standardUserDefaults]objectForKey:@"folderID"] :[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeIndividualid"]];
    [self.app hudStart:self];
    
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.documentArray.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    documentViewCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentViewCell" forIndexPath:indexPath];
    if (indexPath.row < self.documentArray.count) {
        cell.documentImage.image=[UIImage imageWithData:[self.documentArray objectAtIndex:indexPath.row]];
        UITapGestureRecognizer *TapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapView:)];
        [TapRecognizer setNumberOfTapsRequired:2];
        TapRecognizer.delaysTouchesBegan = YES;
        
        [cell  addGestureRecognizer:TapRecognizer];
        
    }
    else
    {
        cell.documentImage.image=[UIImage imageNamed:@"2 (2).png"];
    }
    if ([self.deleteIndexArray containsObject:indexPath]) {
        cell.deleteButton.hidden=false;
    }
    else
    {
        cell.deleteButton.hidden=true;
    }
    cell.transform=self.centralWobble;
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]
                                             initWithTarget:self
                                             action:@selector(handleLongPress:)];
    [cell  addGestureRecognizer:longPress];
    

    [self.app hudStop];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    if (self.replaceFlag==1) {
//        self.replaceString=@"0";
//    }
//    else
//    {
        if (indexPath.row < self.documentArray.count) {
           // self.replaceString=@"1";
        }
        else
        {
           // self.replaceString=@"0";
            self.inPath=indexPath;
            UICollectionViewLayoutAttributes *attributes = [self.documentCollectionView layoutAttributesForItemAtIndexPath:indexPath];
            
            CGRect cellRect = attributes.frame;
            
            
            CGRect cellFrameInSuperview = [self.documentCollectionView convertRect:cellRect toView:[self.documentCollectionView superview]];
            self.frame1=CGRectMake(cellFrameInSuperview.origin.x+200,cellFrameInSuperview.origin.y+75,0,0);
            
            NSLog(@"%f",cellFrameInSuperview.origin.x);
            [self actionSheet];
        }
  //  }
    
        
    
    //}
//    else
//    {
    
//        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
//        picker.delegate = self;
//        picker.allowsEditing = YES;
//        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//        [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:picker animated:YES completion:nil];
        
    //}
    
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
                                                              
                                                              actionFlag=4;
                                                              
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
    
    [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    
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
    
    [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:picker animated:NO completion:nil];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image=info[UIImagePickerControllerOriginalImage];
    if (self.inPath.row<self.documentArray.count) {
        
        [self.documentArray replaceObjectAtIndex:self.inPath.row withObject:UIImagePNGRepresentation(image)];
        
        [self.documentCollectionView reloadData];
        
        NSMutableArray *getarray =[self.documentDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
        
        NSMutableDictionary *getddict = [getarray objectAtIndex:0];
            
            
        NSString *getstring = [getddict objectForKey:@"doc_id"];
            
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
        [pdfDict setObject:image forKey:@"image_doc"];
        [pdfDict setObject:getstring forKey:@"doc_id"];
       // [pdfDict setObject:self.replaceString forKey:@"replace"];
        [imageArray addObject:pdfDict];

        [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
    }
    else
    {
        [self.documentArray addObject:UIImagePNGRepresentation(image)];
    
        NSArray *visibleItems = [self.documentCollectionView indexPathsForVisibleItems];
        [self.documentCollectionView reloadData];
        NSIndexPath *currentItem = [visibleItems objectAtIndex:0];
        NSIndexPath *nextItem = [NSIndexPath indexPathForItem:self.documentArray.count - 1 inSection:currentItem.section];
        [self.documentCollectionView scrollToItemAtIndexPath:nextItem atScrollPosition:UICollectionViewScrollPositionCenteredVertically animated:YES];
        
        
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
        [pdfDict setObject:image forKey:@"image_doc"];
        [pdfDict setObject:@"0" forKey:@"doc_id"];
      //  [pdfDict setObject:self.replaceString forKey:@"replace"];
        [imageArray addObject:pdfDict];
        
        
        [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];

    }
    
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}
    
    
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
        
    [picker dismissViewControllerAnimated:YES completion:NULL];
        
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)gesture
{
    [self.deleteIndexArray removeAllObjects];
    [self.hideButtonTimer invalidate];
    documentViewCollectionViewCell *cell1=(documentViewCollectionViewCell *)[self.documentCollectionView cellForItemAtIndexPath:self.inPath];
    cell1.deleteButton.hidden=true;
    
    documentViewCollectionViewCell *cell=(documentViewCollectionViewCell *)gesture.view;
    if (!([cell.documentImage.image isEqual:[UIImage imageNamed:@"2 (2).png"]])) {
        cell.deleteButton.hidden=false;
        self.inPath=[self.documentCollectionView indexPathForCell:cell];
        [self.deleteIndexArray addObject:self.inPath];
        
        self.cellFrame=cell.frame;
        
//        CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity,RADIANS(-5.0));
//        CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(5.0));
//        cell.transform = leftWobble;  // starting point
        
        
//        [UIView beginAnimations:@"wobble" context:(__bridge void * _Nullable)(cell.contentView)];
//        [UIView setAnimationRepeatAutoreverses:YES]; // important
//        [UIView setAnimationRepeatCount:15];
//        [UIView setAnimationDuration:0.25];
//        [UIView setAnimationDelegate:self];
//        
//        [UIView setAnimationDidStopSelector:@selector(wobbleEnded:finished:context:)];
//        
//        cell.transform = rightWobble;// end here & auto-reverse
//        [UIView commitAnimations];
        
    }

}
-(void)handleTapView:(UITapGestureRecognizer *)guesture
{
    
//    CGPoint pointInCollectionView = [guesture locationInView:self.documentCollectionView];
//    NSIndexPath *selectedIndexPath = [self.documentCollectionView indexPathForItemAtPoint:pointInCollectionView];
//    UICollectionViewCell *selectedCell = [self.documentCollectionView cellForItemAtIndexPath:selectedIndexPath];
//    
    // do something

    
           pdfViewController *ob=(pdfViewController *)[self.superview.superview.superview.superview nextResponder];
           [ob performSegueWithIdentifier:@"pdfcontroller" sender:nil];

}

-(void)dropboxAction
{
    homeViewController *vc=(homeViewController *)[self.superview.superview.superview.superview nextResponder];
    [vc performSegueWithIdentifier:@"dropbox" sender:nil];
    
    
    
//        [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:add animated:YES completion:nil];
    
}
- (void) wobbleEnded:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
    
    if ([finished boolValue]) {
        UIView* item = (__bridge UIView *)context;
        item.transform = CGAffineTransformIdentity;
        documentViewCollectionViewCell *cell1=(documentViewCollectionViewCell *)[self.documentCollectionView cellForItemAtIndexPath:self.inPath];
        cell1.transform=self.centralWobble;
        cell1.deleteButton.hidden=true;

    
    
    }
}
-(IBAction)deleteDocument:(id)sender
{

    
    if (self.documentDictionary.count>0) {
        
        
         NSMutableArray *deletedarray =[self.documentDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
        
        if (deletedarray.count>0) {
            
            NSMutableDictionary *deleteddict = [deletedarray objectAtIndex:0];
            
            
            NSString *deletedstring = [deleteddict objectForKey:@"doc_id"];
            
            
            if ([deletedstring isEqualToString:@"0"]) {
                
                [self.documentArray removeObjectAtIndex:self.inPath.row];
                NSString *str=[NSString stringWithFormat: @"%ld",(long)self.inPath.row];
                [self.documentDictionary removeObjectForKey:str];
                
                NSMutableDictionary *dict=[[[NSMutableDictionary alloc] initWithDictionary:self.documentDictionary] mutableCopy];
                NSMutableArray *keyaray=[[dict allKeys]mutableCopy];
                [self.documentDictionary removeAllObjects];
                NSArray * AscendingArray = [keyaray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;
                    }
                    
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
                
                for (int i=0; i<AscendingArray.count; i++) {
                    id value=[dict objectForKey:[AscendingArray objectAtIndex:i]];
                    
                    [self.documentDictionary setObject:value forKey:[NSString stringWithFormat:@"%d",i]];
                    
                }
                
                [self.deleteIndexArray removeObject:self.inPath];
                
                [self.documentCollectionView reloadData];
            }
            else
            {
              
                [self.myconnection deletedDocumentinEmployeeindividual:deletedstring employeeid:[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeIndividualid"]];
                
            }
        }
    }
}

-(void)deletedDocumentsResponse:(NSString *)deletedresponse
{
    NSLog(@"%@",deletedresponse);
    
    if ([deletedresponse isEqualToString:@"1"]) {
        

            dispatch_async(dispatch_get_main_queue(), ^{
        
                [self.documentArray removeObjectAtIndex:self.inPath.row];
                [self.deleteIndexArray removeAllObjects];
                [self.deleteIndexArray removeObject:self.inPath];
        
                NSString *str=[NSString stringWithFormat: @"%ld",(long)self.inPath.row];
                [self.documentDictionary removeObjectForKey:str];
        
                NSMutableDictionary *dict=[[[NSMutableDictionary alloc] initWithDictionary:self.documentDictionary] mutableCopy];
                NSMutableArray *keyaray=[[dict allKeys]mutableCopy];
                [self.documentDictionary removeAllObjects];
                NSArray * AscendingArray = [keyaray sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                    if ([obj1 integerValue] > [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedDescending;
                    }
        
                    if ([obj1 integerValue] < [obj2 integerValue]) {
                        return (NSComparisonResult)NSOrderedAscending;
                    }
                    return (NSComparisonResult)NSOrderedSame;
                }];
        
                for (int i=0; i<AscendingArray.count; i++) {
                    id value=[dict objectForKey:[AscendingArray objectAtIndex:i]];
                    
                    [self.documentDictionary setObject:value forKey:[NSString stringWithFormat:@"%d",i]];
                    
                }
                
                [self.documentCollectionView reloadData];
            });
    }
    
}

-(IBAction)closePopup:(id)sender
{
    //[[DBSession sharedSession] unlinkAll];
    
     AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    [myappde.dropbox_array removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"filePath"];
    [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"fileName"];
    
    [self.documentDictionary removeAllObjects];
    [self.documentArray removeAllObjects];
    [self removeFromSuperview];

}


//Dropbox


-(void)loadDropbox
{
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"dropboxView" owner:self options:nil];
    [self.superview.superview addSubview:[nib objectAtIndex:0]];
   
    
}
-(void)viewDocuments
{
    if(self.app.dropboxFlag==1)
    {
        NSString *filePath=[[NSUserDefaults standardUserDefaults]objectForKey:@"filePath"];
        NSString *fileName=[[NSUserDefaults standardUserDefaults]objectForKey:@"fileName"];
        
        // [[NSUserDefaults standardUserDefaults]removeObjectForKey:@"filePath"];
        //[[NSUserDefaults standardUserDefaults]removeObjectForKey:@"fileName"];
        
        
        if ([[fileName pathExtension]isEqualToString:@"png"]||[[fileName pathExtension]isEqualToString:@"jpeg"] || [[fileName pathExtension]isEqualToString:@"jpg"]) {
            
            UIImage *selectedImage=[UIImage new];
            selectedImage=[UIImage imageWithContentsOfFile:filePath];
            //selectedImage=[UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
            NSLog(@"%@",selectedImage);
            if (self.inPath.row<self.documentArray.count) {
                [self.documentArray replaceObjectAtIndex:self.inPath.row withObject:UIImagePNGRepresentation(selectedImage)];
                
                [self.documentCollectionView reloadData];
                
                if (self.documentDictionary.count>0) {
                    
                    
                    
                    NSMutableArray *getarray =[self.documentDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
                    
                    NSMutableDictionary *getddict = [getarray objectAtIndex:0];
                    
                    
                    NSString *getstring = [getddict objectForKey:@"doc_id"];
                    
                    NSMutableArray *imageArray=[[NSMutableArray alloc]init];
                    NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
                    [pdfDict setObject:selectedImage forKey:@"image_doc"];
                    [pdfDict setObject:getstring forKey:@"doc_id"];
                  //  [pdfDict setObject:self.replaceString forKey:@"replace"];
                    [imageArray addObject:pdfDict];
                    
                    [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];

                }

            }
            else
            {
                [self.documentArray addObject:UIImagePNGRepresentation(selectedImage)];
                
                NSMutableArray *imageArray=[[NSMutableArray alloc]init];
                NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
                [pdfDict setObject:selectedImage forKey:@"image_doc"];
                [pdfDict setObject:@"0" forKey:@"doc_id"];
               // [pdfDict setObject:self.replaceString forKey:@"replace"];
                
                [imageArray addObject:pdfDict];
                [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
                [self.documentCollectionView reloadData];

            }
                   }
        else if([[fileName pathExtension]isEqualToString:@"pdf"])
        {
            [self.app.dropbox_array removeAllObjects];
            NSLog(@"%@",self.documentDictionary);
            [self.obj splittingPDF:filePath];
           
        }
    }

}
-(void)viewPdf
{
    AppDelegate *myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSLog(@"%@",myappde.dropbox_array);
    
    if (self.inPath.row<self.documentArray.count)
    {
        [self.documentArray replaceObjectAtIndex:self.inPath.row withObject:UIImagePNGRepresentation([myappde.dropbox_array objectAtIndex:0])];
        
           [self.documentCollectionView reloadData];
        
        
         NSMutableArray *getarray =[self.documentDictionary objectForKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
        NSMutableDictionary *getddict = [getarray objectAtIndex:0];
        NSString *getstring = [getddict objectForKey:@"doc_id"];
        
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        
        NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
        [pdfDict setObject:[myappde.dropbox_array objectAtIndex:0] forKey:@"image_doc"];
        [pdfDict setObject:getstring forKey:@"doc_id"];
       // [pdfDict setObject:self.replaceString forKey:@"replace"];
        [imageArray addObject:pdfDict];

        for (int i=1; i<myappde.dropbox_array.count; i++) {
            NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
            [pdfDict setObject:[myappde.dropbox_array objectAtIndex:i] forKey:@"image_doc"];
            [pdfDict setObject:@"0" forKey:@"doc_id"];
            [imageArray addObject:pdfDict];
        }
        
        
        [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];

    
    }
    else
    {
        [self.documentArray addObject:UIImagePNGRepresentation([myappde.dropbox_array objectAtIndex:0])];
        
         [self.documentCollectionView reloadData];
        
        NSMutableArray *imageArray=[[NSMutableArray alloc]init];
        for (int i=0; i<myappde.dropbox_array.count; i++) {
            NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
            [pdfDict setObject:[myappde.dropbox_array objectAtIndex:i] forKey:@"image_doc"];
            [pdfDict setObject:@"0" forKey:@"doc_id"];
           // [pdfDict setObject:self.replaceString forKey:@"replace"];
            [imageArray addObject:pdfDict];
        }
        
        
        [self.documentDictionary setObject:imageArray forKey:[NSString stringWithFormat:@"%ld",(long)self.inPath.row]];
        
    }
    
}

-(IBAction)save:(id)sender
{
    NSLog(@"%@",self.documentDictionary);
    NSArray *dictKeys=[self.documentDictionary allKeys];
    dictKeys = [dictKeys sortedArrayUsingComparator:^(id str1, id str2){
        return [(NSString *)str1 compare:(NSString *)str2 options:NSNumericSearch];
    }];
    
    for (int i=0; i<dictKeys.count; i++) {
        
        if ([[self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]]isKindOfClass:[NSMutableArray class]]) {
            
            NSMutableArray *imageArray=[self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]];
            NSMutableArray *imageDataArray=[[NSMutableArray alloc]init];
            for (int i=0; i<imageArray.count; i++) {
                
                NSMutableDictionary *pdfDict=[imageArray objectAtIndex:i];
                
                NSData *data=UIImagePNGRepresentation([pdfDict objectForKey:@"image_doc"]);
                NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
                NSString *image64BaseString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];
                
                [pdfDict setObject:image64BaseString forKey:@"image_doc"];
                
//                NSMutableDictionary *dataDict=[[NSMutableDictionary alloc]initWithObjectsAndKeys:image64BaseString,@"image_doc",[pdfDict objectForKey:@"image_doc"],@"image_doc", nil];
                
                [imageDataArray addObject:pdfDict];
            }
            
            [self.documentDictionary setObject:imageDataArray forKey:[NSString stringWithFormat:@"%d",i]];
        }
        else
        {
            NSData *data=UIImagePNGRepresentation([self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]]);
            NSData *image64BaseData= [data base64EncodedDataWithOptions:0];
            NSString *image64BaseString=[[NSString alloc]initWithData:image64BaseData encoding:NSUTF8StringEncoding];
            [self.documentDictionary setObject:image64BaseString forKey:[NSString stringWithFormat:@"%d",i]];
            

        }
    }
    
    [self.myconnection uploadDocumentFromIndividual:[[NSUserDefaults standardUserDefaults]objectForKey:@"folderID"] :[[NSUserDefaults standardUserDefaults]objectForKey:@"employeeIndividualid"] :self.documentDictionary ];
    
}

-(void)createResponse:(id)responseData
{
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if([responseData isEqualToString:@"1"])
        {
            [self.documentDictionary removeAllObjects];
            [self.documentArray removeAllObjects];
            [self removeFromSuperview];
        }
        else
        {
            [self showalerviewcontroller:@"Error Occurred"];
            
            NSArray *dictKeys=[[NSMutableArray alloc]initWithArray:[self.documentDictionary allKeys]];
            
            dictKeys = [dictKeys sortedArrayUsingComparator:^(id str1, id str2){
                
                return [(NSString *)str1 compare:(NSString *)str2 options:NSNumericSearch];
            }];
            
            
           for (int i=0; i<dictKeys.count; i++) {
                
               id pages=[self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]];
                
                if([pages isKindOfClass:[NSMutableArray class]])
                {
                    NSMutableArray *imageDataArray=[[NSMutableArray alloc]init];
                    NSMutableArray *imageArray=[[NSMutableArray alloc]initWithArray:[self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]]];
                    for (int j=0; j<imageArray.count; j++) {
                        
                        NSMutableDictionary *pdfDict=[imageArray objectAtIndex:j];
                        
                        
                        NSString *imageBase64String=[pdfDict objectForKey:@"image_doc"];
                        NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
                        
                        [pdfDict setObject:[UIImage imageWithData:data] forKey:@"image_doc"];
                        [imageDataArray addObject:pdfDict];
                    }
                    
                    [self.documentDictionary setObject:imageDataArray forKey:[NSString stringWithFormat:@"%d",i]];
                }
                else
                {
                    NSString *imageBase64String=[self.documentDictionary objectForKey:[dictKeys objectAtIndex:i]];
                    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
                    UIImage *image=[UIImage imageWithData:data];
                    [self.documentDictionary setObject:image forKey:[NSString stringWithFormat:@"%d",i]];
                }
            }
        }

    });
}

-(void)serviceGotResponse:(id)responseData
{
    [self.documentArray removeAllObjects];
    [self.documentDictionary removeAllObjects];
    [self.documentIDDictionary removeAllObjects];
    if ([responseData count] > 0) {
        self.replaceFlag=2;
    }
    else
    {
        self.replaceFlag=1;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        
        for ( int i=0; i<[responseData count]; i++) {
            
            NSMutableDictionary *documentDictionary=[responseData objectAtIndex:i];
            
            NSString *imageBase64String=[documentDictionary objectForKey:@"image_data"];
            
        
            NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
            
            [self.documentArray addObject:data];
            
            NSMutableArray *pagesArray=[documentDictionary objectForKey:@"pages"];
            
            if (pagesArray.count > 0) {
                
                NSMutableArray *imageDataArray=[[NSMutableArray alloc]init];
                NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
                
                NSString *imageBase64String=[documentDictionary objectForKey:@"image_data"];
                NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
                UIImage *image=[UIImage imageWithData:data];
                [pdfDict setObject:image forKey:@"image_doc"];
                [pdfDict setObject:[documentDictionary objectForKey:@"id"] forKey:@"doc_id"];
                //[pdfDict setObject:@"0" forKey:@"replace"];
                [imageDataArray addObject:pdfDict];
                
                for (int i=0; i<pagesArray.count; i++) {
                    NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
                    NSMutableDictionary *imageDict=[pagesArray objectAtIndex:i];
                    NSString *imageBase64String=[imageDict objectForKey:@"doc_data"];
                    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
                    
                    [pdfDict setObject:[UIImage imageWithData:data] forKey:@"image_doc"];
                    [pdfDict setObject:[imageDict objectForKey:@"id"] forKey:@"doc_id"];
                   // [pdfDict setObject:@"0" forKey:@"replace"];
                    [imageDataArray addObject:pdfDict];
                }
                
                
                [self.documentDictionary setObject:imageDataArray forKey:[NSString stringWithFormat:@"%d",i]];
                
            }
            else
            {
                
                if (![[documentDictionary objectForKey:@"image_data"] isEqualToString:@""]) {
                    
                    
                    NSMutableDictionary *pdfDict=[[NSMutableDictionary alloc]init];
                    NSMutableArray *imageDataArray=[[NSMutableArray alloc]init];
                    NSString *imageBase64String=[documentDictionary objectForKey:@"image_data"];
                    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
                    UIImage *image=[UIImage imageWithData:data];
                    imageBase64String=[documentDictionary objectForKey:@"image_data"];
                    [pdfDict setObject:image forKey:@"image_doc"];
                    [pdfDict setObject:[documentDictionary objectForKey:@"id"] forKey:@"doc_id"];
                    // [pdfDict setObject:@"0" forKey:@"replace"];
                    [imageDataArray addObject:pdfDict];
                
                    [self.documentDictionary setObject:imageDataArray forKey:[NSString stringWithFormat:@"%d",i]];

                }

                
                
            }
            
//            if(pagesArray.count > 0)
//            {
//                NSMutableArray *imageDataArray=[[NSMutableArray alloc]init];
//                NSMutableArray *imageIDArray=[[NSMutableArray alloc]init];
//                for (int i=0; i<pagesArray.count; i++) {
//                    
//                    
//                    NSMutableDictionary *imageDict=[pagesArray objectAtIndex:i];
//                    NSString *imageBase64String=[imageDict objectForKey:@"doc_data"];
//                    NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
//                    
//                    
//                    [imageDataArray addObject:[UIImage imageWithData:data]];
//                    
//                }
//                [self.documentDictionary setObject:imageDataArray forKey:[NSString stringWithFormat:@"%d",i]];
//                [self.documentIDDictionary setObject:imageIDArray forKey:[NSString stringWithFormat:@"%d",i]];
//            }
//            else
//            {
//                NSString *imageBase64String=[documentDictionary objectForKey:@"image_data"];
//                NSData *data = [[NSData alloc]initWithBase64EncodedString:imageBase64String options:0];
//                UIImage *image=[UIImage imageWithData:data];
//                [self.documentDictionary setObject:image forKey:[NSString stringWithFormat:@"%d",i]];
//               // self.documentIDDictionary
//            }
        }
        
        [self.documentCollectionView reloadData];
        [self.app hudStop];
        
    });
}

-(void)showalerviewcontroller:(NSString *)errorMessage
{
  
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@"Error"
                               message:@"Error Occurred"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   //Do Some action here
                                               }];
    [alert addAction:ok];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [(homeViewController *)[self.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}



@end
