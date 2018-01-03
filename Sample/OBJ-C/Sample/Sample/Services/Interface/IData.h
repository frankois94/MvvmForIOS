//
//  IData.h
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol IData <NSObject>

- (nullable NSString *)getData;
- (void)setData:(nullable NSString *)newData;

@end
