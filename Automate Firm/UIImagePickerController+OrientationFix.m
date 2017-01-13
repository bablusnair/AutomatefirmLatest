//
//  UIImagePickerController+OrientationFix.m
//  bablusdemokpproject
//
//  Created by Emvigo on 23/01/15.
//  Copyright (c) 2015 Emvigo. All rights reserved.
//

#import "UIImagePickerController+OrientationFix.h"

@implementation UIImagePickerController (OrientationFix)
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsLandscape(toInterfaceOrientation);
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskLandscape;
}

@end
