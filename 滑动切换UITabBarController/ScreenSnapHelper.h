//
//  ScreenSnapHelper.h
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/9/19.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TIME 0.3f

@interface ScreenSnapHelper : UIView

+ (UIImage *)imageByNeighbourView:(UIView *)NeighbourView;

@end
