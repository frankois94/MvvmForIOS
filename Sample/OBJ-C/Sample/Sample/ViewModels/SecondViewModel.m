//
//  SecondViewModel.m
//  Sample
//
//  Created by Dabonot Francois on 20/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "SecondViewModel.h"

@implementation SecondViewModel

- (void)closeViewModel
{
    NSLog(@"closeViewModel start!");
    [[Locator get:@protocol(INavigationService)] closeCurrentViewModelOnCompletion:^{
        NSLog(@"closeViewModel end!");
    }];
}

@end
