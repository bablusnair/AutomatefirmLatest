//
//  earningsAccordianview.m
//  Automate Firm
//
//  Created by Ambu Vamadevan on 05/04/2016.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "earningsAccordianview.h"
#import "advanceTileClass.h"
#import "AppDelegate.h"
#import "settingsViewController.h"
#import "earningsview.h"

@implementation earningsAccordianview

@synthesize selectedIndex, isHorizontal, animationDuration, animationCurve;
@synthesize allowsMultipleSelection, selectionIndexes, delegate, startsClosed, allowsEmptySelection;
@synthesize scrollView,indexvalue,mytag;

-(void)initAccordion{
    
    flag=1;
    selectedIndexValue=-1;
    self.myconnection=[[connectionclass alloc]init];
    self.myconnection.mydelegate=self;
    views = [NSMutableArray new];
    headers = [NSMutableArray new];
    originalSizes = [NSMutableArray new];
    
    self.backgroundColor = [UIColor clearColor];
    
    scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
    scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:scrollView];
    //  self.delegate=self;
    self.userInteractionEnabled = YES;
    scrollView.userInteractionEnabled = YES;
    
    animationDuration = 0.3;
    animationCurve = UIViewAnimationCurveEaseIn;
    
    self.autoresizesSubviews = NO;
    scrollView.autoresizesSubviews = NO;
    scrollView.scrollsToTop = NO;
    scrollView.delegate = self;
    
    self.allowsMultipleSelection = YES;
    self.autoScrollToTopOnSelect=YES;

    self.startsClosed = NO;
    
    self.allowsEmptySelection = YES;
    self.subviewarray=[[NSMutableArray alloc] init];
    
    myappde = (AppDelegate *)[[UIApplication sharedApplication]delegate];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initAccordion];
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:(@"earningsAction")]isEqualToString:@"create"]) {
      
        [self addaccordianview];
        }
    }
    
    return self;
}
/***
 NIB constructor
 **/
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initAccordion];
    }
    
    return self;
}

- (void)addHeader:(UIControl *)aHeader withView:(id)aView {
    if ((aHeader != nil) && (aView != nil)) {
        [headers addObject:aHeader];
        [views addObject:aView];
        [originalSizes addObject:[NSValue valueWithCGSize:[aView frame].size]];
        
        [aView setAutoresizingMask:UIViewAutoresizingNone];
        [aView setClipsToBounds:YES];
        
        CGRect frame = [aHeader frame];
        
        if (self.isHorizontal) {
            // TODO
        } else {
            frame.origin.x = 0;
            frame.size.width = [self frame].size.width;
            [aHeader setFrame:frame];
            
            frame = [aView frame];
            frame.origin.x = 0;
            frame.size.width = [self frame].size.width;
            [aView setFrame:frame];
        }
        
        [scrollView addSubview:aView];
        [scrollView addSubview:aHeader];
        
        if ([aHeader respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            [aHeader setTag:[headers count] - 1];
            [aHeader addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        if (!self.startsClosed && [selectionIndexes count] == 0) {
            [self setSelectedIndex:0];
        }
    }
}

- (void)removeHeaderAtIndex:(NSInteger)index {
    
    if (index > [headers count] - 1) return;
    
    NSMutableIndexSet *cleanIndexes = [NSMutableIndexSet new];
    [selectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx == index) return;
        if (idx > index) idx--;
        
        [cleanIndexes addIndex:idx];
    }];
    
    for (UIView *aHeader in headers) {
        if (aHeader.tag > index) {
            aHeader.tag--;
        }
    }
    UIView *aHeader = [headers objectAtIndex:index];
    [aHeader removeFromSuperview];
    [headers removeObjectAtIndex:index];
    
    
    UIView *aView = [views objectAtIndex:index];
    [aView removeFromSuperview];
    [views removeObjectAtIndex:index];
    
    [originalSizes removeObjectAtIndex:index];
    
    [self setSelectionIndexes:cleanIndexes];
}

- (void)setSelectionIndexes:(NSIndexSet *)aSelectionIndexes {
    if ([headers count] == 0) return;
    if (!allowsMultipleSelection && [aSelectionIndexes count] > 1) {
        aSelectionIndexes = [NSIndexSet indexSetWithIndex:[aSelectionIndexes firstIndex]];
    }
    
    NSMutableIndexSet *cleanIndexes = [NSMutableIndexSet new];
    [aSelectionIndexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL *stop) {
        if (idx > [headers count] - 1) return;
        
        [cleanIndexes addIndex:idx];
    }];
    
    selectionIndexes = cleanIndexes;
    [self setNeedsLayout];
    
    if ([delegate respondsToSelector:@selector(accordion:didChangeSelection:)]) {
        [delegate accordion:self didChangeSelection:self.selectionIndexes];
    }
}

- (void)setSelectedIndex:(NSInteger)aSelectedIndex {
    indexvalue=aSelectedIndex;
    [self setSelectionIndexes:[NSIndexSet indexSetWithIndex:aSelectedIndex]];
    for (int i=0; i<[headers count]; i++) {
        UIButton *mybutton=[headers objectAtIndex:i];
        [mybutton setUserInteractionEnabled:FALSE];
    }
    
    [[headers objectAtIndex:aSelectedIndex]setUserInteractionEnabled:TRUE];
    earningsview *ob = (earningsview *)self.superview;
    [ob disableDropDown];
    
    
}

- (NSInteger)selectedIndex {
    return [selectionIndexes firstIndex];
}

- (void)setOriginalSize:(CGSize)size forIndex:(NSUInteger)index {
    if (index >= [views count]) return;
    
    [originalSizes replaceObjectAtIndex:index withObject:[NSValue valueWithCGSize:size]];
    
    if ([selectionIndexes containsIndex:index]) [self setNeedsLayout];
}

- (void)setStartsClosed:(BOOL)itStartsClosed {
    
    
    
    if (itStartsClosed) {
        
        [self setSelectionIndexes:[NSIndexSet indexSet]];
        
    }
    
    
    else{
        
        startsClosed = YES;
        
    }
}

- (void)touchDown:(id)sender {
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication ]delegate];
    if (app.warningflag==0) {
        if (deleteflag==1) {
            UIButton *mybutton=(UIButton *)[headers objectAtIndex:mytag];
            
            for (UIView *myview in mybutton.subviews) {
                if ([myview isKindOfClass:[UIButton class]]) {
                    [myview removeFromSuperview];
                }
                
            }
            
        }
        
selectedIndexValue=[sender tag];
        app.earningTileIdString=[NSString stringWithFormat:@"%d",selectedIndexValue];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadView" object:Nil];
        
    if (allowsMultipleSelection) {
            
            allowsMultipleSelection=NO;
            self.startsClosed=YES;
            NSMutableIndexSet *mis = [selectionIndexes mutableCopy];
            if ([selectionIndexes containsIndex:[sender tag]]) {
                if (self.allowsEmptySelection || [selectionIndexes count] > 1) {
                    [mis removeIndex:[sender tag]];
                }
            } else {
                [mis addIndex:[sender tag]];
            }
            
            // [self setSelectionIndexes:mis];
            [self setSelectedIndex:[sender tag]];
        }
        else {
            // If the touched section is already opened, close it.
            self.startsClosed=NO;
            if (startsClosed) {
                for (int i=0; i<[headers count]; i++) {
                    UIButton *mybutton=[headers objectAtIndex:i];
                    [mybutton setUserInteractionEnabled:TRUE];
                }
                [[headers objectAtIndex:indexvalue]setUserInteractionEnabled:TRUE];
                earningsview *ob = (earningsview *)self.superview;
                [ob enableDropDown];
                self.startsClosed=NO;
            }
            else
            {
                self.startsClosed=YES;
                
            }
            
            if (([selectionIndexes firstIndex] == [sender tag]) && self.allowsEmptySelection) {
                
                [self setSelectionIndexes:[NSIndexSet indexSet]];
                
            }
            else {
                
                [self setSelectedIndex:[sender tag]];
            }
        }
        
    }
    else{
        
        UIAlertController *alert= [UIAlertController
                                   alertControllerWithTitle:@""
                                   message:@"Changes are not being saved"
                                   preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Discard Changes" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       self.startsClosed=YES;
                                                       earningsview *ob = (earningsview *)self.superview;
                                                       [ob enableDropDown];
                                                       myappde =(AppDelegate *)[[UIApplication sharedApplication]delegate];
                                                       myappde.warningflag=0;
                                                       if ([myappde.earningsTileIdDict objectForKey:myappde.earningTileIdString]==Nil) {
                                                           [[NSNotificationCenter defaultCenter] postNotificationName:@"resetfunction" object:Nil];
                                                       }
                                                       
                                                   }];
        [alert addAction:ok];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction * action){
                                                           //Do Some action here
                                                           
                                                       }];
        [alert addAction:cancel];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [(settingsViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
        });
        
        
        
        
    }
    
    
}

- (void)animationDone {
    for (int i=0; i<[views count]; i++) {
        if (![selectionIndexes containsIndex:i]) [[views objectAtIndex:i] setHidden:YES];
    }
}

- (void)layoutSubviews {
    if (self.isHorizontal) {
        // TODO
    } else {
        int height = 0;
        for (int i=0; i<[views count]; i++) {
            id aHeader = [headers objectAtIndex:i];
            id aView = [views objectAtIndex:i];
            
            CGSize originalSize = [[originalSizes objectAtIndex:i] CGSizeValue];
            CGRect viewFrame = [aView frame];
            CGRect headerFrame = [aHeader frame];
            headerFrame.origin.y = height;
            height += headerFrame.size.height;
            viewFrame.origin.y = height;
            
            if ([selectionIndexes containsIndex:i]) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:self.animationDuration];
                [UIView setAnimationCurve:self.animationCurve];
                [UIView setAnimationBeginsFromCurrentState:YES];
                viewFrame.size.height = originalSize.height;
                [aView setFrame:CGRectMake(0, viewFrame.origin.y, [self frame].size.width, 0)];
                [aView setHidden:NO];
                [UIView commitAnimations];
            } else {
                viewFrame.size.height = 5;
            }
            
            height += viewFrame.size.height;
            
            if (!CGRectEqualToRect([aHeader frame], headerFrame) || !CGRectEqualToRect([aView frame], viewFrame)) {
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDelegate:self];
                [UIView setAnimationDidStopSelector:@selector(animationDone)];
                [UIView setAnimationDuration:self.animationDuration];
                [UIView setAnimationCurve:self.animationCurve];
                [UIView setAnimationBeginsFromCurrentState:YES];
                [aHeader setFrame:headerFrame];
                [aView setFrame:viewFrame];
                [UIView commitAnimations];
            }
        }
        
        CGPoint offset = scrollView.contentOffset;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:self.animationDuration];
        [UIView setAnimationCurve:self.animationCurve];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [scrollView setContentSize:CGSizeMake([self frame].size.width, height)];
        [UIView commitAnimations];
        
        
        if (offset.y + scrollView.frame.size.height > height) {
            offset.y = height - scrollView.frame.size.height;
            if (offset.y < 0) {
                offset.y = 0;
            }
        }
        
        if ([selectionIndexes firstIndex] && [selectionIndexes firstIndex] < headers.count && self.autoScrollToTopOnSelect)
        {
            offset = ((UIButton *)headers[[selectionIndexes firstIndex]]).frame.origin;
        }
        
        [scrollView setContentOffset:offset animated:YES];
        [self scrollViewDidScroll:scrollView];
    }
    
    
}





- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    scrollView.frame = frame;
}



#pragma mark UIScrollView delegate




//- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
//    int i = 0;
//    for (UIView *view in views) {
//        if (self.isHorizontal) {
//            // TODO
//        } else {
//            if (view.frame.size.height > 0) {
//                UIView *header = [headers objectAtIndex:i];
//                CGRect content = view.frame;
//                content.origin.y -= header.frame.size.height;
//                content.size.height += header.frame.size.height;
//                
//                CGRect frame = header.frame;
//                if (CGRectContainsPoint(content, aScrollView.contentOffset)) {
//                    if (aScrollView.contentOffset.y < content.origin.y + content.size.height - frame.size.height) {
//                        frame.origin.y = aScrollView.contentOffset.y;
//                    } else {
//                        frame.origin.y = content.origin.y + content.size.height - frame.size.height;
//                    }
//                    
//                } else {
//                    frame.origin.y = view.frame.origin.y - frame.size.height;
//                }
//                header.frame = frame;
//            }
//        }
//        
//        i++;
//    }
//}
//
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView {
    int i = 0;
    for (UIView *view in views) {
        if (self.isHorizontal) {
            // TODO
        } else {
            if (view.frame.size.height > 0) {
                UIView *header = [headers objectAtIndex:i];
                CGRect content = view.frame;
                content.origin.y -= header.frame.size.height;
                content.size.height += header.frame.size.height;
                
                CGRect frame = header.frame;
                if (CGRectContainsPoint(content, aScrollView.contentOffset)) {
                    if (aScrollView.contentOffset.y < content.origin.y + content.size.height - frame.size.height) {
                        frame.origin.y = aScrollView.contentOffset.y;
                    } else {
                        frame.origin.y = content.origin.y + content.size.height - frame.size.height;
                    }
                    
                } else {
                    frame.origin.y = view.frame.origin.y - frame.size.height;
                }
                header.frame = frame;
            }
        }
        
        i++;
    }
}



-(void)addaccordianview
{
    [self setStartsClosed:YES];
    if (selectedIndexValue==flag-2) {
        UIButton *header = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
        label.text=[NSString stringWithFormat:@"Condition %d",flag];
        
        [label setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header addSubview:label];
        [header setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"earningstileview" owner:self options:nil];
        [self  addHeader:header withView:[array objectAtIndex:0]];
        
        //[[headers objectAtIndex:indexvalue]setUserInteractionEnabled:TRUE];
        
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletetile:)];
        
        [header addGestureRecognizer:press];
        flag++;
    }
    for (int i=0; i<[headers count]; i++) {
        UIButton *mybutton=[headers objectAtIndex:i];
        [mybutton setUserInteractionEnabled:TRUE];
    }
    earningsview *ob = (earningsview *)self.superview;
    [ob enableDropDown];
}
-(void)deletetile:(UILongPressGestureRecognizer *)sender
{
    if (headers.count > 1)
    {
        AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication ]delegate];

        UIButton *btn = (UIButton*)sender.view;
        mytag=btn.tag;
        NSLog(@"%i",mytag);
        // indexvalue=selectedIndex;
        self.tagString=[NSString stringWithFormat: @"%d",mytag];
        self.tileId=[app.earningsTileIdDict objectForKey:self.tagString];
        UIButton *mybutton=[headers objectAtIndex:mytag];
        UIButton *closebutton = [[UIButton alloc] initWithFrame:CGRectMake(595, 8, 15, 15)];
        [closebutton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
        closebutton.tag=100;
        deleteflag=1;
        [closebutton addTarget:self action:@selector(deletebuttonaction) forControlEvents:UIControlEventTouchUpInside];
        [mybutton addSubview:closebutton];
    }
}
-(void)deletebuttonaction
{
    UIAlertController *alert= [UIAlertController
                               alertControllerWithTitle:@""
                               message:@"Are you sure you want to delete?"
                               preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDefault
                                               handler:^(UIAlertAction * action){
                                                   self.startsClosed=YES;
                                                  // myappde.addnewCount=app.addnewCount-1;

                                                   if (!(self.tileId==Nil))
                                                   {
                                                       
                                                       
                                                       [self.myconnection deleteEarningRule:self.tileId typeOfDel:@"2"];
                                                   }
//                                                   earningsview *ob = (earningsview *)self.superview;
//                                                   [ob enableDropDown];
//                                                   
//                                                   [self removeHeaderAtIndex:mytag];
//                                                   [self renamefunction];
//                                                   flag--;
//                                                   if (!(self.indexvalue==0)) {
//                                                       self.indexvalue--;
//                                                   }
//
//                                                   deleteflag=0;
//                                                   for (int i=0; i<[headers count]; i++) {
//                                                       UIButton *mybutton=[headers objectAtIndex:i];
//                                                       [mybutton setUserInteractionEnabled:TRUE];
//                                                   }
//                                                   
                                               }];
    [alert addAction:ok];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action){
                                                       //Do Some action here
                                                       if (deleteflag==1) {
                                                           UIButton *mybutton=(UIButton *)[headers objectAtIndex:mytag];
                                                           
                                                           for (UIView *myview in mybutton.subviews) {
                                                               if ([myview isKindOfClass:[UIButton class]]) {
                                                                   [myview removeFromSuperview];
                                                               }
                                                               
                                                           }
                                                           
                                                       }
                                                   }];
    [alert addAction:cancel];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [(settingsViewController *)[self.superview.superview.superview.superview.superview nextResponder] presentViewController:alert animated:YES completion:nil];
    });
    
}
-(void)renamefunction
{
    for (int i=0; i< headers.count; i++) {
        UIButton *button=[headers objectAtIndex:i];
        for (UILabel *myview in button.subviews) {
            if ([myview isKindOfClass:[UILabel class]]) {
                myview.text=[NSString stringWithFormat:@"Condition %d",i+1];
            }
            
        }
    }
}
-(void)CreationoftileforUpdation:(NSInteger)count
{
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        myappde.addnewCount=count;
        [self setStartsClosed:YES];
        
        for (int i=1; i<=count; i++) {
            
            flag=count+1;
            UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
            UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
            label1.text= [NSString stringWithFormat:@"Condition %d",i];
            [label1 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
            label1.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
            [header1 addSubview:label1];
            [header1 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
            NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"earningstileview" owner:self options:nil];
            [self addHeader:header1 withView:[array objectAtIndex:0]];
            header1.tag=i-1;
            
            UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletetile:)];
            
            [header1 addGestureRecognizer:press];
            
            [self setStartsClosed:YES];
            
        }
        
    });
    
    
}

// delete response
-(void)deleteAllTileResponse:(id)response flag:(NSString *)delFlag;
{
    AppDelegate *app=(AppDelegate *)[[UIApplication sharedApplication ]delegate];

    if ([[response objectForKey:@"status"] isEqualToString:@"200"]&& [delFlag isEqualToString:@"1"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
               earningsview *ob = (earningsview *)self.superview;
        [ob enableDropDown];
        
        [self removeHeaderAtIndex:mytag];
        [self renamefunction];
        flag--;
        if (!(self.indexvalue==0)) {
            self.indexvalue--;
        }
        
        deleteflag=0;
        for (int i=0; i<[headers count]; i++) {
            UIButton *mybutton=[headers objectAtIndex:i];
            [mybutton setUserInteractionEnabled:TRUE];
        }

        });

        
        NSString *str=[NSString stringWithFormat: @"%d",mytag];
        [app.earningsTileIdDict removeObjectForKey:str];
        
        NSMutableDictionary *dict=[[[NSMutableDictionary alloc] initWithDictionary:app.earningsTileIdDict] mutableCopy];
        NSMutableArray *keyaray=[[dict allKeys]mutableCopy];
        [app.earningsTileIdDict removeAllObjects];
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
            
            [app.earningsTileIdDict setObject:value forKey:[NSString stringWithFormat:@"%d",i]];
            
        }
        if ([app.earningsTileIdDict count]==0) {
            app.addnewCount=0;
        }
    }
    else
    {
        dispatch_async(dispatch_get_main_queue(), ^{
             for (int i=0; i<[app.earningsTileIdDict count]; i++) {
            earningsview *ob = (earningsview *)self.superview;
            [ob enableDropDown];
            
            [self removeHeaderAtIndex:0];
            [self renamefunction];
            flag--;
            if (!(self.indexvalue==0)) {
                self.indexvalue--;
            }
            
            deleteflag=0;
            for (int i=0; i<[headers count]; i++) {
                UIButton *mybutton=[headers objectAtIndex:i];
                [mybutton setUserInteractionEnabled:TRUE];
            }
        }
            [app.earningsTileIdDict removeAllObjects];
            app.addnewCount=0;
        });

    }
}
-(void)addNewTileForUpdation:(int)conditionId
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        flag=conditionId+1;
        UIButton *header1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 0, 30)];
        UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
        label1.text= [NSString stringWithFormat:@"Condition %d",flag];
        [label1 setTextColor:[UIColor colorWithRed:88.0/255.0 green:89.0/255.0 blue:91.0/255.0 alpha:1.000]];
        label1.font = [UIFont fontWithName:@"Oxygen-Regular" size:14];
        [header1 addSubview:label1];
        [header1 setImage:[UIImage imageNamed:@"tab_plain.png"] forState:UIControlStateNormal];
        
        NSArray *array=[[NSBundle mainBundle]loadNibNamed:@"earningstileview" owner:self options:nil];
        [self addHeader:header1 withView:[array objectAtIndex:0]];
        header1.tag=flag-1;
        
        UILongPressGestureRecognizer *press=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deletetile:)];
        
        [header1 addGestureRecognizer:press];
        [self setStartsClosed:YES];
        myappde.addnewCount=flag;
        
        
    });
    
}
-(void)closeTile
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self setStartsClosed:YES];
        for (int i=0; i<[headers count]; i++) {
            UIButton *mybutton=[headers objectAtIndex:i];
            [mybutton setUserInteractionEnabled:TRUE];
        }
    });
    //    loansettingsviewclass *obj = (loansettingsviewclass *)self.superview;
    //    [obj enableddonebutton];
    
}


@end


