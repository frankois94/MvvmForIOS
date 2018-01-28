//
//  INavigation.h
//  MvvmForIOS
//
//  Created by Dabonot Francois on 16/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^onNavigationCompletion)(void);

@protocol INavigationService

- (nonnull instancetype)init;

/*
 Window for navigation
 */
@property (weak, nonatomic, nullable) UIWindow *window;

/*
 * Must be use when strting the application
 */
- (void)showInitialViewModel:(nonnull Class)viewModelToShow;
/*
 * Show a viewModel without parameters and completion (optional)
 */
- (void)showViewModel:(nonnull Class)viewModelToShow completion:(onNavigationCompletion _Nullable)onCompletion;
/*
 * Show a viewModel with parameters (optional) and completion (optional)
 */
- (void)showViewModel:(nonnull Class)viewModelToShow parameters:(nullable id)userData completion:(onNavigationCompletion _Nullable)onCompletion;
/*
 * Show a viewModel with parameters (optional) and animation
 */
- (void)showViewModel:(nonnull Class)viewModelToShow animated:(BOOL)animated parameters:(nullable id)userData completion:(onNavigationCompletion _Nullable)onCompletion;

/*
 * Close the current ViewModel and completion (optional)
 */
- (void)closeCurrentViewModelOnCompletion:(onNavigationCompletion _Nullable)onCompletion;

/*
 * Close the current ViewModel with animation and completion (optional)
 */
- (void)closeCurrentViewModelWithAnimation:(BOOL)animated completion:(onNavigationCompletion _Nullable)onCompletion;

/*
 * Show a modal viewModel with parameters (optional) and completion (optional)
 */
- (void)showModalViewModel:(nonnull Class)viewModelToShow completion:(nullable onNavigationCompletion)onCompletion;

/*
 * Show a modal viewModel with parameters (optional) and completion (optional)
 */
- (void)showModalViewModel:(nonnull Class)viewModelToShow parameters:(nullable id)userData completion:(nullable onNavigationCompletion)onCompletion;

@end
