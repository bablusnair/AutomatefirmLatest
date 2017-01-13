//
//  employeedocumentviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 7/11/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "employeeDocumentViewsclass.h"
#import "documentcollectionviewclass.h"
@implementation employeeDocumentViewsclass
-(void)awakeFromNib
{
    self.documentNameArray=[[NSMutableArray alloc]init];
    self.documentIDArray=[[NSMutableArray alloc]init];
    
    NSData *newData = [[NSUserDefaults standardUserDefaults] objectForKey:@"employeewholeDetails"];
    NSDictionary *employeedictdetails = [NSKeyedUnarchiver unarchiveObjectWithData:newData];
    
    NSMutableArray *empDocumentArray = [employeedictdetails objectForKey:@"documents"];
    for (int i=0; i<empDocumentArray.count; i++) {
        NSMutableDictionary *documentDict=[empDocumentArray objectAtIndex:i];
        [self.documentNameArray addObject:[documentDict objectForKey:@"document_title"]];
        [self.documentIDArray addObject:[documentDict objectForKey:@"id"]];
    }
   

    
    
    [self.mycollectionView registerNib:[UINib nibWithNibName:@"documentcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"documentcell"];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.documentNameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    documentcollectionviewclass *cell1=[collectionView dequeueReusableCellWithReuseIdentifier:@"documentcell" forIndexPath:indexPath];
    cell1.foldername.text=[self.documentNameArray objectAtIndex:indexPath.row];
    
    return cell1;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",self.superview.superview.superview);
    [[NSUserDefaults standardUserDefaults]setObject:[self.documentIDArray objectAtIndex:indexPath.row] forKey:@"folderID"];
    [[NSUserDefaults standardUserDefaults]setObject:[self.documentNameArray objectAtIndex:indexPath.row] forKey:@"titleLabel"];
    NSArray *nib=[[NSBundle mainBundle]loadNibNamed:@"documentViewScreen" owner:self options:nil];
    [self.superview.superview.superview.superview addSubview:[nib objectAtIndex:0]];
}
@end
