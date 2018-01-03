//
//  Service.m
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "Service.h"
#import "Data.h"


@implementation Service

- (instancetype)initWithWindow:(UIWindow *)window
{
    if (self = [super initWithWindow:window])
    {
        _data = [Data new];
    }
    return (self);
}

@end
