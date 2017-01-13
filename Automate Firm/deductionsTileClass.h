//
//  earningsAccordianview.h
//  Automate Firm
//
//  Created by Ambu Vamadevan on 05/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "connectionclass.h"
@class deductionsTileClass;
@protocol AccordionViewDelegate <NSObject>
@optional
- (void)accordion:(deductionsTileClass *)accordion didChangeSelection:(NSIndexSet *)selection;


@end

@interface deductionsTileClass : UIView <UIScrollViewDelegate,headerprotocol> {
    NSMutableArray *views;
    NSMutableArray *headers;
    NSMutableArray *originalSizes;
    int flag;
    int selectedIndexValue;
    int deleteflag;
    AppDelegate *myappde;
}



-(void)addaccordianview;
- (void)addHeader:(UIControl *)aHeader withView:(id)aView;
- (void)removeHeaderAtIndex:(NSInteger)index;
- (void)setOriginalSize:(CGSize)size forIndex:(NSUInteger)index;
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView;
-(void)CreationoftileforUpdation:(NSInteger)count;
-(void)addNewTileForUpdation:(int)conditionId;

@property(nonatomic,retain)connectionclass *myconnection;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (readonly) BOOL isHorizontal;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, assign) UIViewAnimationCurve animationCurve;
@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, strong) NSIndexSet *selectionIndexes;
@property (nonatomic, strong) id <AccordionViewDelegate> delegate;
@property (nonatomic, assign) BOOL startsClosed;
@property (nonatomic, assign) BOOL allowsEmptySelection;
@property (nonatomic, assign) BOOL autoScrollToTopOnSelect;
@property (nonatomic, assign)NSInteger indexvalue;
@property(nonatomic,retain)NSMutableArray *subviewarray;
@property(nonatomic,assign)int mytag;
@property(nonatomic,assign)NSString * tagString;

@property(nonatomic,assign)NSString * tileId;
-(void)closeTile;


@end