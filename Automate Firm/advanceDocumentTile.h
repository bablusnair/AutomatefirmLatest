//
//  advanceDocumentTile.h
//  Automate Firm
//
//  Created by leonine on 11/4/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import <UIKit/UIKit.h>

@class advanceDocumentTile;
@protocol AccordionViewDelegate <NSObject>
@optional
- (void)accordion:(advanceDocumentTile *)accordion didChangeSelection:(NSIndexSet *)selection;
@end

@interface advanceDocumentTile : UIView <UIScrollViewDelegate> {
    NSMutableArray *views;
    NSMutableArray *headers;
    NSMutableArray *originalSizes;
    int flag;
    int selectedIndexValue;
    int deleteflag;
}
-(void)addaccordianview;
- (void)addHeader:(UIControl *)aHeader withView:(id)aView;
- (void)removeHeaderAtIndex:(NSInteger)index;
- (void)setOriginalSize:(CGSize)size forIndex:(NSUInteger)index;
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView;

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

@end
