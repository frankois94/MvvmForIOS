//
//  Locator.h
//  MvvmForIOS
//
//  Created by Dabonot Francois on 22/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Locator : NSObject

+ (void)save:(nonnull id)service;
+ (nullable id)get:(nonnull Protocol *)service;
@end
