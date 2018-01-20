//
//  BaseViewModelServices.m
//  FrancoisDabonotExercice
//
//  Created by Dabonot Francois on 30/11/2017.
//  Copyright © 2017 FrancoisDabonot. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaseServices.h>
#import <BaseViewModel.h>
#import <BaseView.h>

@interface BaseServices ()
{
    UIViewController *_modalView;
    UINavigationController *_navController;
}

@property (weak, readonly, nonatomic) UIWindow *window;

@end

@implementation BaseServices

#pragma mark init

- (nonnull instancetype)initWithWindow:(nonnull UIWindow *)window
{
    if (self = [super init])
    {
        _window = window;
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
        [_window setRootViewController:_navController];
        [_window makeKeyAndVisible];
    }
}

#pragma mark - PUSH ModalViewModel

- (void)showModalViewModel:(nonnull Class)viewModelToShow onCompletion:(nullable onNavigationCompletion)onCompletion
{
    [self showModalViewModel:viewModelToShow withParameters:nil onCompletion:onCompletion];
}

- (void)showModalViewModel:(nonnull Class)viewModelToShow withParameters:(nullable id)userData onCompletion:(onNavigationCompletion)onCompletion
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

- (void)showViewModel:(nonnull Class)viewModelToShow onCompletion:(nullable onNavigationCompletion)onCompletion
{
    [self showViewModel:viewModelToShow withParameters:nil onCompletion:onCompletion];
}

- (void)showViewModel:(nonnull Class)viewModelToShow withParameters:(nullable id)userData onCompletion:(nullable onNavigationCompletion)onCompletion
{
    if (viewModelToShow)
    {
        //getting view
        UIViewController *view = [self getView:viewModelToShow Andparameters:userData];
        [self pushVC:view animated:YES onCompletion:onCompletion];
        view = nil;
    }
}

- (void)pushVC:(UIViewController *)view animated:(BOOL)animated onCompletion:(nullable onNavigationCompletion)onCompletion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:onCompletion];
    [_navController pushViewController:view animated:animated];
    [CATransaction commit];
}

#pragma mark - POP ViewModel

- (void)closeCurrentViewModelOnCompletion:(nullable onNavigationCompletion)onCompletion
{
    if (_modalView)
    {
        [_modalView dismissViewControllerAnimated:YES completion:onCompletion];
    }
    else
    {
        [self popCurrentViewWithAnimated:YES OnCompetion:onCompletion];
    }
    _modalView = nil;
}

- (void)popCurrentViewWithAnimated:(BOOL)animated OnCompetion:(nullable onNavigationCompletion)completion
{
    [CATransaction begin];
    [CATransaction setCompletionBlock:completion];
    [_navController popViewControllerAnimated:animated];
    [CATransaction commit];
}

@end
