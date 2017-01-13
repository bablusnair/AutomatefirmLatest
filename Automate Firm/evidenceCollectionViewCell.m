//
//  evidenceCollectionViewCell.m
//  Automate Firm
//
//  Created by leonine on 8/1/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "evidenceCollectionViewCell.h"

@implementation evidenceCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    UIPinchGestureRecognizer *uipinch =[[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchfunction:)];
    
    [self.sigview addGestureRecognizer:uipinch];
}


-(void)pinchfunction:(UIPinchGestureRecognizer *)recognizer
{
    recognizer.view.transform = CGAffineTransformScale(recognizer.view.transform, recognizer.scale, recognizer.scale);
    recognizer.scale = 1;
    
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view]==self.boximg)
    {
        CGPoint location = [touch locationInView:self];
        self.sigview.center=location;

         NSLog(@"%f",location.x);
         NSLog(@"%f",location.y);
    }
}

@end
