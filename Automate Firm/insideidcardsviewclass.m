//
//  insideidcardsviewclass.m
//  bablusdemokpproject
//
//  Created by leonine on 24/06/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "insideidcardsviewclass.h"
#import "idcollectioncellclass.h"
#import "idcollectioncellsecondclass.h"
@implementation insideidcardsviewclass
@synthesize selecetdArray;
- (void)awakeFromNib {
    
    self.mycollectionView.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake(266.0,400.0);
    [self.mycollectionView setCollectionViewLayout:flowLayout];
    
    [ self.mycollectionView registerNib:[UINib nibWithNibName:@"idcollectioncell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    [ self.mycollectionView registerNib:[UINib nibWithNibName:@"idcollectioncellsecond" bundle:nil] forCellWithReuseIdentifier:@"simplecell2"];
    self.selecetdArray=[[NSMutableArray alloc]init];
    
    self.mycollectionData1=[[NSMutableArray alloc]init];
}


- (void)setCollectionData:(NSArray *)data {
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
    
    
        idcollectioncellsecondclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"simplecell2" forIndexPath:indexPath];
        
        NSDictionary *cellData = [self.mycollectionData1 objectAtIndex:[indexPath row]];
        cell.employeename.text = [cellData objectForKey:@"emp_name"];
        cell.designationtittle.text = [cellData objectForKey:@"designation_title"];
        cell.mylabel.text = [NSString stringWithFormat:@"EMP###%@",[cellData objectForKey:@"emp_code"]];
        cell.dateofbirth.text = [cellData objectForKey:@"emp_dob"];
        cell.dataofjoined.text = [cellData objectForKey:@"emp_date_of_join"];
        cell.bloodgroup.text = [cellData objectForKey:@"emp_blood_group"];
    
    [cell.bartextview setText: [NSString stringWithFormat:@"(%@)",[cellData objectForKey:@"emp_code"]]];
    [cell.bartextview setFont:[UIFont fontWithName:@"IDAutomationHC39M" size:15.0]];

    
    
    if ([cellData objectForKey:@"office_name"] != nil) {
        
        cell.workpremiselabel.text = [cellData objectForKey:@"office_name"];
        
    }
    else
    {
        cell.workpremiselabel.text = [cellData objectForKey:@"store_name"];
    }

       if ([cellData objectForKey:@"telephone"] != nil) {
        
        cell.phonenumberlabel.text = [cellData objectForKey:@"telephone"];
        
       }
      else
      {
        cell.phonenumberlabel.text = [cellData objectForKey:@"store_telephone"];
      }
    
    if ([cellData objectForKey:@"email"] != nil) {
        
        cell.mailid.text = [cellData objectForKey:@"email"];
        
    }
    else
    {
        cell.mailid.text = [cellData objectForKey:@"store_email"];
    }
    
        //cell.phonenumberlabel.text = [cellData objectForKey:@"telephone"];
       // cell.mailid.text = [cellData objectForKey:@"email"];
    

        cell.myimgview.layer.cornerRadius =10.0f;
        cell.myimgview.clipsToBounds = YES;
        cell.myimgview.layer.borderWidth = 1.0;
        cell.myimgview.layer.borderColor = [UIColor grayColor].CGColor;
    
        
        if ([[cellData objectForKey:@"emp_encode_image"]isEqualToString:@""]) {
            
            
            cell.myimgview.image=[UIImage imageNamed:@"photo.png"];
            
        }
        else
        {
            
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[cellData objectForKey:@"emp_encode_image"] options:0];
            
        cell.myimgview.image=[UIImage imageWithData:decodedData];
            
        }
    
    
    if ([[cellData objectForKey:@"logo_binary"]isEqualToString:@""]) {
        
        
        cell.logoimg.image=[UIImage imageNamed:@"unnamedlogo.png"];
        
    }
    else
    {
        
        NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:[cellData objectForKey:@"logo_binary"] options:0];
        
        cell.logoimg.image=[UIImage imageWithData:decodedData];
        
    }

    
        return cell;
   // }
   
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.selecetdArray containsObject:indexPath]) {
        
        idcollectioncellclass *cell1 = (idcollectioncellclass *)[collectionView cellForItemAtIndexPath:indexPath];
        cell1.backgroundColor=[UIColor whiteColor];
        cell1.backgroundView.alpha=0.7;
        [self.selecetdArray removeObject:indexPath];

    }
    else
    {
        idcollectioncellclass *cell1 = (idcollectioncellclass *)[collectionView cellForItemAtIndexPath:indexPath];
        [self.selecetdArray addObject:indexPath];
        cell1.backgroundColor=[UIColor redColor];
        cell1.backgroundView.alpha=0.7;
        //cell1.checkBoxImg1.image=[UIImage imageNamed:@"check_box.png32.png"];
    }
}
@end
