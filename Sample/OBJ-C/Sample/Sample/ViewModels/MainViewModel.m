//
//  MainViewModel.m
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "MainViewModel.h"
#import "SecondViewModel.h"
#import "IData.h"

@interface MainViewModel ()
{
@private;
    NSString *_helloWorld;
}
@end


@implementation MainViewModel

@dynamic helloWorld;

- (void)startViewModel:(NSObject *)parameters
{
    _helloWorld = [[Locator get:@protocol(IData)] getData];
}

- (NSString *)helloWorld
{
    return (_helloWorld);
}

- (void)setHelloWorld:(NSString *)newValue
{
    if (![_helloWorld isEqualToString:newValue])
    {
        _helloWorld = newValue;
        [[Locator get:@protocol(IData)] setData:newValue];
    }
}

- (void)pushViewModel
{
    NSLog(@"pushViewModel start!");
    [[Locator get:@protocol(INavigationService)] showViewModel:[SecondViewModel class] completion:^{
        NSLog(@"pushViewModel over!");
    }];
}

- (void)modalViewModel
{
    NSLog(@"modalViewModel start!");
    [[Locator get:@protocol(INavigationService)] showModalViewModel:[SecondViewModel class] completion:^{
        NSLog(@"modalViewModel over!");
    }];
}

@end
