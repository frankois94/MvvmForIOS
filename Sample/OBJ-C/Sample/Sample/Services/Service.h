//
//  Service.h
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MvvmForIOS/MvvmForIOS.h>
#import "IData.h"

@interface Service : BaseServices

@property (nonatomic, strong, readonly)NSObject<IData> *data;

@end
