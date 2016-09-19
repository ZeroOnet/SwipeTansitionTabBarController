//
//  SecondViewController.m
//  滑动切换UITabBarController
//
//  Created by FunctionMaker on 16/9/11.
//  Copyright © 2016年 FunctionMaker. All rights reserved.
//

#import "SecondViewController.h"
#import "ScreenSnapHelper.h"

@interface SecondViewController () {
    UIImageView *_leftView;
    UIImageView *_rightView;
}

@end

@implementation SecondViewController

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
    
    [self initLeftAndRightView];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
    
    [_leftView removeFromSuperview];
    [_rightView removeFromSuperview];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

- (void)initBgColorAndBarItem {
    
    self.view.backgroundColor = [UIColor orangeColor];
    self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemBookmarks tag:1001];
    
}

- (void)initView {
    
    UILabel *second = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    second.backgroundColor = [UIColor whiteColor];
    second.center = self.view.center;
    second.textAlignment = NSTextAlignmentCenter;
    second.text = @"secondVC";
    
    [self.view addSubview:second];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    
    [self.view addGestureRecognizer:panGesture];
    
    UISwipeGestureRecognizer *swipeLeftGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeLeftGesture.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:swipeLeftGesture];
    
    UISwipeGestureRecognizer *swipeRightGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    swipeRightGesture.direction = UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:swipeRightGesture];
    
    [panGesture requireGestureRecognizerToFail:swipeLeftGesture];
    [panGesture requireGestureRecognizerToFail:swipeRightGesture];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)pan {
    
    CGPoint point = [pan translationInView:self.view];
    
    pan.view.center = CGPointMake(pan.view.center.x + point.x, pan.view.center.y);
    
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
        } else if (pan.view.center.x >= self.view.frame.size.width) {
            
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
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        [UIView animateWithDuration:TIME animations:^{
            
            swipe.view.center = CGPointMake(self.view.frame.size.width * 1.5, self.view.frame.size.height / 2);
        } completion:^(BOOL finished) {
            
            NSUInteger selectedIndex = [self.tabBarController selectedIndex];
            
            [self.tabBarController setSelectedIndex:selectedIndex - 1];
            swipe.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
        }];

    } else if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        [UIView animateWithDuration:TIME animations:^{
            swipe.view.center = CGPointMake(-self.view.frame.size.width / 2, self.view.frame.size.height / 2);
        } completion:^(BOOL finished) {
            NSUInteger selectedIndex = [self.tabBarController selectedIndex];
            
            [self.tabBarController setSelectedIndex:selectedIndex + 1];
            swipe.view.center = CGPointMake(self.view.frame.size.width / 2 , self.view.frame.size.height / 2);
        }];
    }
}

- (void)initLeftAndRightView {

    NSUInteger selectedIndex = [self.tabBarController selectedIndex];
    
    UIViewController *VC1 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex - 1];
    UIImage *image1 = [ScreenSnapHelper imageByNeighbourView:VC1.view];
    _leftView = [[UIImageView alloc] initWithImage:image1];
    _leftView.frame = CGRectMake(_leftView.frame.origin.x - self.view.frame.size.width, _leftView.frame.origin.y, _leftView.frame.size.width, _leftView.frame.size.height);
    
    [self.view addSubview:_leftView];
    
    UIViewController *VC2 = [self.tabBarController.viewControllers objectAtIndex:selectedIndex + 1];
    UIImage *image2 = [ScreenSnapHelper imageByNeighbourView:VC2.view];
    _rightView = [[UIImageView alloc] initWithImage:image2];
    _rightView.frame = CGRectMake(_rightView.frame.origin.x + self.view.frame.size.width, _leftView.frame.origin.y, _rightView.frame.size.width, _rightView.frame.size.height);
    
    [self.view addSubview:_rightView];
    
}

@end
