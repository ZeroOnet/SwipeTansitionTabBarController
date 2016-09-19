//
//  ThirdViewController.m
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/9/11.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import "ThirdViewController.h"
#import "ScreenSnapHelper.h"

@interface ThirdViewController () {
    UIImageView *_leftView;
}

@end

@implementation ThirdViewController

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        [self initBgColorAndBarItem];
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initView];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    [self initLeftView];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [_leftView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];

}

- (void)initBgColorAndBarItem {
    
    self.view.backgroundColor = [UIColor brownColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag:1002];
    
}

- (void)initView {
    
    UILabel *third = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    third.backgroundColor = [UIColor whiteColor];
    third.center = self.view.center;
    third.textAlignment = NSTextAlignmentCenter;
    third.text = @"thirdVC";
    
    [self.view addSubview:third];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeGesture];
    
    [panGesture requireGestureRecognizerToFail:swipeGesture];
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {

    CGPoint point = [pan translationInView:self.view];
    
    if (point.x > 0) {
        pan.view.center = CGPointMake(pan.view.center.x + point.x, pan.view.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.center.x >= self.view.frame.size.width) {
            [UIView animateWithDuration:TIME animations:^{
                pan.view.center = CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height / 2);
            } completion:^(BOOL finished) {
                NSUInteger selectedIndex = [self.tabBarController selectedIndex];
                
                [self.tabBarController setSelectedIndex:selectedIndex - 1];
                pan.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
            }];
        } else {
            [UIView animateWithDuration:TIME animations:^{
                pan.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
            }];
        }
    }
    
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    [UIView animateWithDuration:TIME animations:^{
        swipe.view.center = CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height / 2);
    } completion:^(BOOL finished) {
        NSUInteger selectedIndex = [self.tabBarController selectedIndex];
        
        [self.tabBarController setSelectedIndex:selectedIndex - 1];
        swipe.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
    }];

}

- (void)initLeftView {
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    UIViewController *VC1 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1];
    UIImage *image1 = [ScreenSnapHelper imageByNeighbourView:VC1.view];
    _leftView = [[UIImageView alloc] initWithImage:image1];
    _leftView.frame = CGRectMake(-_leftView.frame.size.width, _leftView.frame.origin.y, _leftView.frame.size.width, _leftView.frame.size.height);
    
    [self.view addSubview:_leftView];
    
}

@end
