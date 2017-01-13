//
//  signaturethumbview.m
//  bablusdemokpproject
//
//  Created by leonine on 31/08/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "signaturethumbviewclass.h"
#import "sealcustumclass.h"
#import "AppDelegate.h"
@implementation signaturethumbviewclass
@synthesize mySignatureImage,lastContactPoint1,lastContactPoint2,fingerMoved,currentPoint;

- (void)drawRect:(CGRect)rect
{
    
    self.frame=CGRectMake(70, 140, self.frame.size.width, self.frame.size.height);
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake(-350, -300, 1400, 1000)];
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
}

-(void)awakeFromNib
{
    [ self.mysignaturecollctionview registerNib:[UINib nibWithNibName:@"sealcustumcell" bundle:nil] forCellWithReuseIdentifier:@"simplecell"];
    self.selectedarray=[[NSMutableArray alloc] init];
    
  //  AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    
   // [appDelegate.petennityleavesignaturearray removeAllObjects];
    
    self.myselectedcolor=[UIColor blackColor];

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
   return 15;

}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"simplecell";
    sealcustumclass *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if([self.selectedarray containsObject:indexPath]) {
        
        
        [cell.checkbutton setImage:[UIImage imageNamed:@"check box_tick2.png"] forState:UIControlStateNormal];
        
    }
    
    else {
        
        [cell.checkbutton setImage:[UIImage imageNamed:@"check box_white2.png"] forState:UIControlStateNormal];
    }
    
    
    return cell;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    sealcustumclass *cell1= (sealcustumclass *) [self.mysignaturecollctionview cellForItemAtIndexPath:indexPath];
    
    if ([cell1.checkbutton.currentImage isEqual:[UIImage imageNamed:@"check box_white2.png"]]) {
        
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box_tick2.png"] forState:UIControlStateNormal];
        [self.selectedarray addObject:indexPath];
    }
    
    else {
        
        [cell1.checkbutton setImage:[UIImage imageNamed:@"check box_white2.png"] forState:UIControlStateNormal];
        [self.selectedarray removeObject:indexPath];
        
    }
    
    [self.mysignaturecollctionview deselectItemAtIndexPath:indexPath animated:YES];
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor clearColor];
    cell1.selectedBackgroundView = v;
}

 -(IBAction)donebuttonaction:(id)sender
 {
   
    //NSLog(@"%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]);
     
    if (!(mySignatureImage.image==Nil)) {
        
         AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
        
        
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"PATR"]) {
        
            for (int i=0; i<appDelegate.petennityleavesignaturearray.count; i++) {
                
                if (![[appDelegate.petennityleavesignaturearray objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    
                    [appDelegate.petennityleavesignaturearray replaceObjectAtIndex:i withObject:mySignatureImage.image];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadingthecollectionview" object:Nil];
                    
                    break;
                }
                
            }

        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"VACT"] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"EMGT"] || [[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"SICK"])
        {
            
            for (int i=0; i<appDelegate.vact_emrc_sickleavearray.count; i++) {
                
                if (![[appDelegate.vact_emrc_sickleavearray objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    
                    [appDelegate.vact_emrc_sickleavearray replaceObjectAtIndex:i withObject:mySignatureImage.image];
                    
                [[NSNotificationCenter defaultCenter] postNotificationName:@"vactemergsickleave" object:Nil];

                    break;
                }
                
            }
            
        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"MATR"])
        {
            for (int i=0; i<appDelegate.maternityleavearray.count; i++) {
                
                if (![[appDelegate.maternityleavearray objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    
                    [appDelegate.maternityleavearray replaceObjectAtIndex:i withObject:mySignatureImage.image];
                    
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"metenityleave" object:Nil];
                    
                    break;
                }
                
            }

        }
        else if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"leavetypename"]isEqualToString:@"ADVC"])
        {
            for (int i=0; i<appDelegate.advanceformsign_array.count; i++) {
                
                if (![[appDelegate.advanceformsign_array objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    
                    [appDelegate.advanceformsign_array replaceObjectAtIndex:i withObject:mySignatureImage.image];
                    
                   [[NSNotificationCenter defaultCenter] postNotificationName:@"advanceformsign" object:Nil];
                    
                    break;
                }
                
            }
            
        }
        else
        {
            
            for (int i=0; i<appDelegate.otherleave_array.count; i++) {
                
                if (![[appDelegate.otherleave_array objectAtIndex:i]isKindOfClass:[UIImage class]]) {
                    
                    [appDelegate.otherleave_array replaceObjectAtIndex:i withObject:mySignatureImage.image];
                    
                  [[NSNotificationCenter defaultCenter] postNotificationName:@"otherleavenotification" object:Nil];
                    
                    break;
                }
            }
        }
    }
    
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
