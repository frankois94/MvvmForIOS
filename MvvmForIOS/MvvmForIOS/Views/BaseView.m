//
//  BaseViewViewController.m
//  FrancoisDabonotTestApp
//
//  Created by Dabonot Francois on 24/11/2017.
//  Copyright © 2017 Dabonot Francois. All rights reserved.
//

#import <BaseView.h>
#import <BaseViewModel.h>

@interface BaseView ()
{
@private
    NSMutableDictionary<NSString *, refreshPropertyBlock> *_callbackOnNotifications;
    id _viewModel;
}

@end

@implementation BaseView

-(void)setViewModel:(id)viewModel
{
    _viewModel = viewModel;
}

- (id)viewModel
{
    return (_viewModel);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _callbackOnNotifications = [NSMutableDictionary dictionary];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)didMoveToParentViewController:(UIViewController *)parent
{
    if (!parent)
    {
        //Unding all and clean viewModel
        [self unbindAllProperties];
        _viewModel = nil;
        _callbackOnNotifications = nil;
        [self performSelectorOnMainThread:@selector(setViewModel:) withObject:nil waitUntilDone:YES];
    }
}

#pragma mark binding

- (void)bindProperty:(nonnull NSString *)propertyName onUpdate:(nonnull refreshPropertyBlock)onUpdate
{
    [_callbackOnNotifications setObject:onUpdate forKey:propertyName];
    
    [_viewModel addObserver:self forKeyPath:propertyName options:NSKeyValueObservingOptionNew context:nil];
    //Send existing viewModel value to the view if not nil
    id valueToSend = [_viewModel getValueForProperty:propertyName];
    if (valueToSend)
        onUpdate(valueToSend);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context
{
    refreshPropertyBlock callback = _callbackOnNotifications[keyPath];
    if (callback)
    {
        //Only send on the main thread
        if (![NSThread isMainThread])
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(change[NSKeyValueChangeNewKey]);
            });
        }
        else
        {
            callback(change[NSKeyValueChangeNewKey]);
        }
    }
}

#pragma mark unbinding

- (void)unbindAllProperties
{
    NSLog(@"[BaseView]unbindAllProperties");
    for (NSString *keypath in _callbackOnNotifications) {
        [_viewModel removeObserver:self forKeyPath:keypath];
    }
    [_callbackOnNotifications removeAllObjects];
}

- (void)unbindProperty:(nonnull NSString *)propertyName
{
    NSLog(@"[BaseView]Unbind %@", propertyName);
    [_viewModel removeObserver:self forKeyPath:propertyName];
    [_callbackOnNotifications removeObjectForKey:propertyName];
}

#pragma mark - popup

- (void)showPopupWithTitle:(nonnull NSString *)title andMessage:(nonnull NSString *)msg
{
    UIAlertController *ctr = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    [ctr addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:ctr animated:YES completion:nil];
}


@end
