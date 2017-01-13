//
//  paperworkViewClass.h
//  bablusdemokpproject
//
//  Created by leonine on 9/5/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface paperworkViewClass : UIView<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,retain)NSMutableArray *priorityimgarray;
@property(nonatomic,retain)NSMutableArray *statusLabelArray;
@property(nonatomic,retain)NSMutableArray *statusImageArray;
@property(nonatomic,retain)NSMutableArray *priorityImageArray;
@property(nonatomic,retain)NSMutableArray *numberArray;


@end
