//
//  BaseViewModelServices.m
//  FrancoisDabonotExercice
//
//  Created by Dabonot Francois on 30/11/2017.
//  Copyright © 2017 FrancoisDabonot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Locator.h>
#import <NavigationService.h>
#import <Setup.h>
#import <BaseViewModel.h>
#import <BaseView.h>

@interface Setup ()

@property (weak, readonly, nonatomic) UIWindow *window;

@end

@implementation Setup

#pragma mark init

- (nonnull instancetype)initWithWindow:(nonnull UIWindow *)window
{
    if (self = [super init])
    {
        NSLog(@"[MVVMFORIOS]Start Setup");
        _window = window;
        NavigationService *service = [NavigationService new];
        [service setWindow:_window];
        [Locator save:service];
    }
    return (self);
}

@end
