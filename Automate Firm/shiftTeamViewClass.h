//
//  shiftTeamViewClass.h
//  Automate Firm
//
//  Created by leonine on 06/10/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "I3DragBetweenHelper.h"

@interface shiftTeamViewClass : UIView<UICollectionViewDataSource,UICollectionViewDelegate,I3DragBetweenDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) I3DragBetweenHelper* dragingObject;
@property (nonatomic, strong) I3DragBetweenHelper* dragingObject1;

@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion;
@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion1;
@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion2;
@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion3;
@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion4;
@property (weak, nonatomic) IBOutlet UICollectionView *teamcollcetion5;

@property(nonatomic,retain)NSMutableArray *teamFirstAray;
@property(nonatomic,retain)NSMutableArray *teamsecondAray;
@property(nonatomic,retain)NSMutableArray *teamThirdAray;
@property(nonatomic,retain)NSMutableArray *teamFourthAray;
@property(nonatomic,retain)NSMutableArray *teamFifthAray;
@property(nonatomic,retain)NSMutableArray *teamSixthAray;

@property(nonatomic,assign)int collectionId;
@property(nonatomic,retain)UIImageView *movingCell;
@property(nonatomic,retain)NSIndexPath *selctIndex;
@end
