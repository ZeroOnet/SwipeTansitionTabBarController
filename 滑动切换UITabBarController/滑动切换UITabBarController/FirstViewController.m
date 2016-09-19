//
//  FirstViewController.m
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/9/11.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import "FirstViewController.h"
#import "ScreenSnapHelper.h"

@interface FirstViewController () {
    UIImageView *_rightView;
}

@end

@implementation FirstViewController

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
    
    [self initRightView];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];

    [_rightView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)initBgColorAndBarItem {
    
    self.view.backgroundColor = [UIColor grayColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemHistory tag:1000];
    
}

- (void)initView {
    
    UILabel *first = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    first.backgroundColor = [UIColor whiteColor];
    first.center = self.view.center;
    first.textAlignment = NSTextAlignmentCenter;
    first.text = @"firstVC";
    
    [self.view addSubview:first];

    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeGesture];
    
    [panGesture requireGestureRecognizerToFail:swipeGesture];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    CGPoint point = [pan translationInView:self.view];
    
    if (point.x < 0) {
        pan.view.center = CGPointMake(pan.view.center.x + point.x, pan.view.center.y);
    }
    
    [pan setTranslation:CGPointZero inView:self.view];
    
    if (pan.state == UIGestureRecognizerStateEnded) {
        if (pan.view.center.x <= 0) {
            [UIView animateWithDuration:TIME animations:^{
                pan.view.center = CGPointMake(-self.view.frame.size.width / 2, self.view.frame.size.height / 2);
            } completion:^(BOOL finished) {
                NSUInteger selectedIndex = [self.tabBarController selectedIndex];

                [self.tabBarController setSelectedIndex:selectedIndex + 1];
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
        swipe.view.center = CGPointMake(-self.view.frame.size.width / 2, self.view.frame.size.height / 2);
    } completion:^(BOOL finished) {
        NSUInteger selectedIndex = [self.tabBarController selectedIndex];
        
        [self.tabBarController setSelectedIndex:selectedIndex + 1];
        swipe.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
    }];

}

- (void)initRightView {
    
    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    UIViewController *VC2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1];
    UIImage *image2 = [ScreenSnapHelper imageByNeighbourView:VC2.view];
    _rightView = [[UIImageView alloc] initWithImage:image2];
    _rightView.frame = CGRectMake(_rightView.frame.origin.x + self.view.frame.size.width, _rightView.frame.origin.y, _rightView.frame.size.width, _rightView.frame.size.height);
    
    [self.view addSubview:_rightView];
    
}


@end
