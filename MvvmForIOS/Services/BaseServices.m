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

- (void)showViewModel:(nonnull Class)viewModelToShow
{
    [self showViewModel:viewModelToShow withParameters:nil];
}

- (void)showViewModel:(nonnull Class)viewModelToShow withParameters:(nullable id)userData
{
    if (viewModelToShow)
    {
        //getting view
        UIViewController *view = [self getView:viewModelToShow Andparameters:userData];
        [_navController pushViewController:view animated:YES];
        view = nil;
    }
}

- (void)closeCurrentViewModel
{
    [_navController popViewControllerAnimated:YES];
}

@end
