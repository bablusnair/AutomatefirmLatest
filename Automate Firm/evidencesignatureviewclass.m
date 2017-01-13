//
//  evidencesignatureviewclass.m
//  Automate Firm
//
//  Created by leonine on 9/1/16.
//  Copyright © 2016 leonine. All rights reserved.
//

#import "evidencesignatureviewclass.h"
#import "AppDelegate.h"
@implementation evidencesignatureviewclass
@synthesize mySignatureImage,lastContactPoint1,lastContactPoint2,fingerMoved,currentPoint;
- (void)drawRect:(CGRect)rect
{
    
    self.frame=CGRectMake(70, 140, self.frame.size.width, self.frame.size.height);
//    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-350, -300, 1400, 1000)];
//    self.layer.masksToBounds = NO;
//    self.layer.shadowColor = [UIColor blackColor].CGColor;
//    self.layer.shadowOpacity = 0.5f;
//    self.layer.shadowPath = shadowPath.CGPath;
}

-(void)awakeFromNib
{
    
    self.myselectedcolor=[UIColor blackColor];
    [super awakeFromNib];
}

-(IBAction)donebuttonaction:(id)sender
{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    appDelegate.sigimg=mySignatureImage.image;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"evidencesignature" object:Nil];
    [self removeFromSuperview];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    fingerMoved = NO;
    UITouch *touch = [touches anyObject];
    
    currentPoint = [touch locationInView:mySignatureImage];
    lastContactPoint1 = [touch previousLocationInView:mySignatureImage];
    lastContactPoint2 = [touch previousLocationInView:mySignatureImage];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //well its obvious that our finger moved on the screen
    fingerMoved = YES;
    UITouch *touch = [touches anyObject];
    
    //save previous contact locations
    lastContactPoint2 = lastContactPoint1;
    lastContactPoint1 = [touch previousLocationInView:mySignatureImage];
    //save current location
    currentPoint = [touch locationInView:mySignatureImage];
    
    //find mid points to be used for quadratic bezier curve
    CGPoint midPoint1 = [self midPoint:lastContactPoint1 withPoint:lastContactPoint2];
    CGPoint midPoint2 = [self midPoint:currentPoint withPoint:lastContactPoint1];
    
    //create a bitmap-based graphics context and makes it the current context
    UIGraphicsBeginImageContext(mySignatureImage.frame.size);
    
    //draw the entire image in the specified rectangle frame
    [mySignatureImage.image drawInRect:CGRectMake(0, 0, mySignatureImage.frame.size.width, mySignatureImage.frame.size.height)];
    
    //set line cap, width, stroke color and begin path
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0f);
    // CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), [self.myselectedcolor CGColor]);
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    
    //begin a new new subpath at this point
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), midPoint1.x, midPoint1.y);
    //create quadratic Bézier curve from the current point using a control point and an end point
    CGContextAddQuadCurveToPoint(UIGraphicsGetCurrentContext(),
                                 lastContactPoint1.x, lastContactPoint1.y, midPoint2.x, midPoint2.y);
    
    //set the miter limit for the joins of connected lines in a graphics context
    CGContextSetMiterLimit(UIGraphicsGetCurrentContext(), 2.0);
    
    //paint a line along the current path
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    
    //set the image based on the contents of the current bitmap-based graphics context
    mySignatureImage.image = UIGraphicsGetImageFromCurrentImageContext();
    
    //remove the current bitmap-based graphics context from the top of the stack
    UIGraphicsEndImageContext();
    
    //lastContactPoint = currentPoint;
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //UITouch *touch = [touches anyObject];
    
    //    //just clear the image if the user tapped twice on the screen
    //    if ([touch tapCount] == 2) {
    //        mySignatureImage.image = nil;
    //        return;
    //    }
    
    
    //if the finger never moved draw a point
    if(!fingerMoved) {
        UIGraphicsBeginImageContext(mySignatureImage.frame.size);
        [mySignatureImage.image drawInRect:CGRectMake(0, 0, mySignatureImage.frame.size.width, mySignatureImage.frame.size.height)];
        
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), 3.0f);
        CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(),[self.myselectedcolor CGColor]);
        
        //  CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), 0.0, 0.0, 0.0, 1.0);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        
        mySignatureImage.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

- (CGPoint) midPoint:(CGPoint )p0 withPoint: (CGPoint) p1 {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}

-(IBAction)clearsignature:(id)sender
{
    self.mySignatureImage.image=Nil;
}

-(IBAction)selectedcolorbuttonaction:(id)sender
{
    UIButton *mybutton =(UIButton *)sender;
    
    if (mybutton.tag==1) {
        
        self.myselectedcolor=[UIColor blackColor];
    }
    else if (mybutton.tag==2)
    {
        self.myselectedcolor=[UIColor redColor];
    }
    else
    {
        self.myselectedcolor=[UIColor blueColor];
    }
    
}

@end
