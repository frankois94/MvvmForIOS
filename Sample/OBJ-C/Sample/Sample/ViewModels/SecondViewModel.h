//
//  SecondViewModel.h
//  Sample
//
//  Created by Dabonot Francois on 20/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <MvvmForIOS/MvvmForIOS.h>
#import "Service.h"

@interface SecondViewModel : BaseViewModel<Service *>

- (void)closeViewModel;

@end
