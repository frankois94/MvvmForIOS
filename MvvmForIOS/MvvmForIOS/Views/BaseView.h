//
//  BaseViewViewController.h
//  FrancoisDabonotTestApp
//
//  Created by Dabonot Francois on 24/11/2017.
//  Copyright © 2017 Dabonot Francois. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^refreshPropertyBlock)(_Nonnull id value);

//must be implemented
@protocol IBaseView
@required
-(void)setViewModel:(id _Nonnull)viewModel;
@end

/*
 * BaseView
 * Base class for all views
 * Contains binding methods and other usefull tools
 * Use Generic for specify the type of the viewModel
 */
@interface BaseView<ObjectType> : UIViewController <IBaseView>

@property (nonatomic, weak, readwrite) ObjectType _Nullable viewModel;

#pragma mark binding

/*
 * Bind a property of the viewModel and receive callback when this one change
 */
- (void)bindProperty:(nonnull NSString *)propertyName onUpdate:(nonnull refreshPropertyBlock)onUpdate;

#pragma mark unbinding

/*
 * UnBind all properties in the view
 */
- (void)unbindAllProperties;

/*
 * UnBing a particular propery
 */
- (void)unbindProperty:(nonnull NSString *)propertyName;

#pragma mark - popup

/*
 * Show a simple popup
 */
- (void)showPopupWithTitle:(nonnull NSString *)title andMessage:(nonnull NSString *)msg;

@end
