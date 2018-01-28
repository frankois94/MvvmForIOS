//
//  Navigation.m
//  MvvmForIOS
//
//  Created by Dabonot Francois on 16/01/2018.
//  Copyright © 2018 Dabonot Francois. All rights reserved.
//

#import "NavigationService.h"
#import <MvvmForIOS.h>
#import <UIKit/UIKit.h>

@interface NavigationService ()
{
    UIViewController *_modalView;
    UINavigationController *_navController;
}

@end

@implementation NavigationService

@synthesize window;

- (instancetype)init
{
    if (self = [super init])
    {
        NSLog(@"[MVVMFORIOS]Start NavigationService");
        _navController = [UINavigationController new];
    }
    return (self);
}

#pragma mark - navigation

/*
 * We instanciate a view from the name of the corresponding viewModel
 *      - From a viewModel :
 * ViewModel = testViewModel
 *      - We're getting the corresponding view from a storyboard :
 * StoryboardName = test
 *      - The identifier of the view inside the storyboard :
 * Identifier : testView
 *
 * We must follow this rules and it's easy to get what we want!
 */
- (UIViewController *)getView:(nonnull Class<IBaseViewModel>)viewModelToShow Andparameters:(nullable id)parameters
{
    //getting view et viewModel names
    NSString *viewModelName = NSStringFromClass(viewModelToShow);
    if ([viewModelName containsString:@"."])
        viewModelName = [[viewModelName componentsSeparatedByString:@"."] lastObject];
    
    NSString *viewName = [viewModelName stringByReplacingOccurrencesOfString:@"ViewModel" withString:@"View"];
    NSString *storyBoardName = [viewModelName stringByReplacingOccurrencesOfString:@"ViewModel" withString:@""];
    
    //Create View with the view Model
    UIStoryboard *story = [UIStoryboard storyboardWithName:storyBoardName bundle:nil];
    UIViewController<IBaseView> *view = [story instantiateViewControllerWithIdentifier:viewName];
    
    //Create ViewModel
    NSObject<IBaseViewModel> *viewModel = [[(id)viewModelToShow alloc] initWithService:self];
    [view setViewModel:viewModel];
    
    [viewModel startViewModel:parameters];
    viewModel = nil;
    return (view);
}

- (void)showInitialViewModel:(nonnull Class)viewModelToShow
{
    if (viewModelToShow)
    {
        UIViewController *view = [self getView:viewModelToShow Andparameters:nil];
        //Show initial view
        
        [_navController pushViewController:view animated:NO];
        view = nil;
        [window setRootViewController:_navController];
        [window makeKeyAndVisible];
    }
}

#pragma mark - PUSH ModalViewModel

- (void)showModalViewModel:(nonnull Class)viewModelToShow completion:(nullable onNavigationCompletion)onCompletion
{
    [self showModalViewModel:viewModelToShow parameters:nil completion:onCompletion];
}

- (void)showModalViewModel:(nonnull Class)viewModelToShow parameters:(nullable id)userData completion:(onNavigationCompletion)onCompletion
{
    if (viewModelToShow)
    {
        //getting view
        UIViewController *view = [self getView:viewModelToShow Andparameters:userData];
        UIViewController *top = [_navController topViewController];
        [top presentViewController:view animated:YES completion:onCompletion];
        _modalView = view;
        view = nil;
    }
}

#pragma mark - PUSH ViewModel

- (void)showViewModel:(nonnull Class)viewModelToShow completion:(nullable onNavigationCompletion)onCompletion
{
    [self showViewModel:viewModelToShow parameters:nil completion:onCompletion];
}

- (void)showViewModel:(nonnull Class)viewModelToShow parameters:(nullable id)userData completion:(nullable onNavigationCompletion)onCompletion
{
    [self showViewModel:viewModelToShow animated:YES parameters:userData completion:onCompletion];
}

/*
 * Show a viewModel with parameters (optional) and animation
 */
- (void)showViewModel:(nonnull Class)viewModelToShow animated:(BOOL)animated parameters:(nullable id)userData completion:(onNavigationCompletion _Nullable)onCompletion
{
    //getting view
    UIViewController *view = [self getView:viewModelToShow Andparameters:userData];
    [self pushVC:view animated:animated completion:onCompletion];
    view = nil;
}

- (void)pushVC:(UIViewController *)view animated:(BOOL)animated completion:(nullable onNavigationCompletion)onCompletion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:onCompletion];
    [_navController pushViewController:view animated:animated];
    [CATransaction commit];
}

#pragma mark - POP ViewModel

- (void)closeCurrentViewModelOnCompletion:(nullable onNavigationCompletion)onCompletion
{
    [self closeCurrentViewModelWithAnimation:YES completion:onCompletion];
}

- (void)closeCurrentViewModelWithAnimation:(BOOL)animated completion:(onNavigationCompletion _Nullable)onCompletion
{
    if (_modalView)
    {
        [_modalView dismissViewControllerAnimated:animated completion:onCompletion];
    }
    else
    {
        [self popCurrentViewWithAnimated:animated completion:onCompletion];
    }
    _modalView = nil;
}

- (void)popCurrentViewWithAnimated:(BOOL)animated completion:(nullable onNavigationCompletion)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [_navController popViewControllerAnimated:animated];
    [CATransaction commit];
}

@end


