//
//  employeedocumentviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/11/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeedocumentviewclass.h"
#import "documentcollectionviewcellclass.h"
@implementation employeedocumentviewclass
-(void)awakeFromNib
{
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"documentcollectionviewcell" bundle:nil] forCellWithReuseIdentifier:@"documentcell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    documentcollectionviewcellclass *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentcell" forIndexPath:indexPath];
    
    
    return cell1;
    
}
-(IBAction)uploadDocument:(id)sender
{
    
    UIImagePickerController *imgPicker=[[UIImagePickerController alloc]init];
    imgPicker.delegate=self;
    imgPicker.allowsEditing=TRUE;
    imgPicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    NSLog(@"%@",self.superview.superview.superview.superview.superview.superview);
    [(ViewController *)[self.superview.superview.superview.superview.superview.superview.superview nextResponder] presentViewController:imgPicker animated:YES completion:nil];
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    //UIImage *chosenImage = [info objectForKey:UIImagePickerControllerEditedImage];
    //self.myimgviews.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

@end
