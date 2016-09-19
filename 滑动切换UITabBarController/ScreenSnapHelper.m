//
//  ScreenSnapHelper.m
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/9/19.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import "ScreenSnapHelper.h"

@implementation ScreenSnapHelper

+ (UIImage *)imageByNeighbourView:(UIView *)NeighbourView {
    UIGraphicsBeginImageContextWithOptions(NeighbourView.frame.size, NO, [UIScreen mainScreen].scale);
    [NeighbourView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return result;
}

@end
