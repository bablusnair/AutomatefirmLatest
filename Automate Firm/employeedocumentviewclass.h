//
//  employeedocumentviewclass.h
//  bablusdemokpproject
//
//  Created by leonine on 7/11/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface employeedocumentviewclass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *mycollectionView;
-(IBAction)uploadDocument:(id)sender;
@end
