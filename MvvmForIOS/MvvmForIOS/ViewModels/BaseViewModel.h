//
//  BaseViewModel.h
//  FrancoisDabonotTestApp
//
//  Created by Dabonot Francois on 24/11/2017.
//  Copyright © 2017 Dabonot Francois. All rights reserved.
//

#import <Foundation/Foundation.h>

//must be implemented
@protocol IBaseViewModel
@required
- (_Nonnull instancetype)initWithService:(id _Nonnull)service;
- (void)startViewModel:(nullable NSObject *)parameters;
@optional


/*
* Send property change by name
*/
- (void)updateProperty:(nonnull NSString *)name;
/*
 * Get value by property name
 */
- (nullable id)getValueForProperty:(nonnull NSString *)name;

@end

/*
 * BaseViewModel
 * Base class for all viewModel
 * Contains the service and binding properties
 * Use Generic for specify the type of the service
 */
@interface BaseViewModel<ObjectType>  : NSObject<IBaseViewModel>

@property (nonatomic, weak, readonly) ObjectType _Nullable service;

@end
