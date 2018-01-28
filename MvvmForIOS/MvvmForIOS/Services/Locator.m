//
//  Locator.m
//  MvvmForIOS
//
//  Created by Dabonot Francois on 22/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "Locator.h"
#import <objc/runtime.h>

@interface Locator ()

@property (nonatomic, strong)NSMutableArray<NSObject *> *array;

@end

@implementation Locator

+ (instancetype)sharedLocator
{
    static dispatch_once_t onceQueue;
    static Locator *locator = nil;
    
    dispatch_once(&onceQueue, ^{ locator = [[self alloc] init]; });
    return locator;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _array = [NSMutableArray new];
    }
    return (self);
}

+ (void)save:(nonnull id)service
{
    //check and remove existing class in array
    NSInteger idx = [[[Locator sharedLocator] array] indexOfObjectPassingTest:^BOOL(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[service class]])
            return (true);
        return (false);
    }];
    if (idx != NSNotFound)
    {
        NSLog(@"[MvvmForIOS]The instance %@ is already registered, remove the previous one", [service class]);
        [[[Locator sharedLocator] array]removeObjectAtIndex:idx];
    }
    [[[Locator sharedLocator] array] addObject:service];
}

+ (nullable id)get:(nonnull Protocol *)service
{
    NSInteger idx = [[[Locator sharedLocator] array] indexOfObjectPassingTest:^BOOL(NSObject * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj conformsToProtocol:service])
            return (true);
        return (false);
    }];
    if (idx == NSNotFound)
    {
        NSLog(@"[MvvmForIOS]The instance %@ is not registered, return nil", service);
        return (nil);
    }
    return ([[Locator sharedLocator] array][idx]);
}

@end
