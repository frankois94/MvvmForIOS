//
//  MainViewModel.h
//  Sample
//
//  Created by Dabonot Francois on 03/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MvvmForIOS/MvvmForIOS.h>

@interface MainViewModel : BaseViewModel<BaseServices *>

@property (strong, nonatomic, nullable) NSString *helloWorld;

- (void)pushViewModel;
- (void)modalViewModel;



@end
