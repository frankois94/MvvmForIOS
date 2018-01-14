//
//  BaseViewModelServices.h
//  FrancoisDabonotExercice
//
//  Created by Dabonot Francois on 30/11/2017.
//  Copyright © 2017 FrancoisDabonot. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^onNavigationCompletion)(void);

@class UIWindow;

/*
 * BaseServices
 * Contains navigation methods between viewModel
 * Only use default animation (can be improve)
 */
@interface BaseServices : NSObject

#pragma mark init

- (nonnull instancetype)initWithWindow:(nonnull UIWindow *)window;

#pragma mark - navigation

/*
 * Must be use when strting the application
 */
- (void)showInitialViewModel:(nonnull Class)viewModelToShow;
/*
 * Show a viewModel without parameters and completion (optional)
 */
- (void)showViewModel:(nonnull Class)viewModelToShow onCompletion:(onNavigationCompletion _Nullable)onCompletion;
/*
 * Show a viewModel with parameters (optional) and completion (optional)
 */
- (void)showViewModel:(nonnull Class)viewModelToShow withParameters:(nullable id)userData onCompletion:(onNavigationCompletion _Nullable)onCompletion;
/*
 * Close the current ViewModel and completion (optional)
 */
- (void)closeCurrentViewModelOnCompletion:(onNavigationCompletion _Nullable)onCompletion;

@end
