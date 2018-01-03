//
//  MainViewModel.m
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "MainViewModel.h"

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
    _helloWorld = [[[self service] data] getData];
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
        [[[self service] data] setData:newValue];
    }
}

@end
