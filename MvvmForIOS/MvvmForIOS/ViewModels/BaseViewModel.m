//
//  BaseViewModel.m
//  FrancoisDabonotTestApp
//
//  Created by Dabonot Francois on 24/11/2017.
//  Copyright © 2017 Dabonot Francois. All rights reserved.
//

#import <BaseViewModel.h>

#ifndef STR_PROP
#define STR_PROP(prop) NSStringFromSelector(@selector(prop))
#endif

@interface BaseViewModel ()
{
@private
    id _service;
}
@end

@implementation BaseViewModel

- (id)service
{
    return (_service);
}

- (nonnull instancetype)initWithService:(id _Nonnull)service
{
    if (self = [super init])
    {
        _service = service;
    }
    return (self);
}

- (void)startViewModel:(nullable NSObject *)parameters
{
    
}

/*
 * Dynamically get property value of the current instance by name
 */
- (nullable id)getValueForProperty:(NSString *)name
{
    id result = nil;
    SEL selector = NSSelectorFromString(name);
    if ([self respondsToSelector:selector])
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        result = [self performSelector:selector];
#pragma clang diagnostic pop
    }
    return (result);
}

- (void)dealloc
{
    
}

@end
