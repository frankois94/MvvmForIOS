//
//  Data.m
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "Data.h"
#import "MainData.h"

@implementation Data

- (nullable NSString *)getData
{
    return ([MainData getData]);
}

- (void)setData:(nullable NSString *)newData
{
    [MainData setData:newData];
}


@end
