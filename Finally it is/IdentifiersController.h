//
//  IdenfifiersController.h
//  Finally it is
//
//  Created by Mark Cornelisse on 22/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import Foundation;

NS_ASSUME_NONNULL_BEGIN

extern NSString * const kIdentifiersControllerDefaultArrayOfNotificationIdentifiers;

@interface IdentifiersController : NSObject

/**
 List of identifiers of the Notifications that has been scheduled.
 */
@property (nonatomic, strong, readonly, nonnull) NSArray<NSString *> *identifiers;


/**
 Add an identifier to the controller.

 @param identifier The identifier to be stored.
 */
- (void)addIdentifier:(NSString *)identifier;

/**
 Remove the identifier from the controller.

 @param identifier The identifier to be removed from the controller.
 */
- (void)removeIdentifier:(NSString *)identifier;

/**
 Removes all identifiers from the controller.
 */
- (void)removeAllIdentifiers;

/**
 Reads any identifiers stored in defauls.
 */
- (void)readFromDefaults;

/**
 Stores all identifiers in defaults.
 */
- (void)saveToDefaults;

/**
 Synchronizes all the identifiers to defaults.

 @return YES if synchronize is succesful. No if synchronize is unsuccesful. 
 */
- (BOOL)synchronizeToDefaults;

@end

NS_ASSUME_NONNULL_END
