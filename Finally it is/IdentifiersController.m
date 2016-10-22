//
//  IdenfifiersController.m
//  Finally it is
//
//  Created by Mark Cornelisse on 22/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "IdentifiersController.h"

NSString * const kIdentifiersControllerDefaultArrayOfNotificationIdentifiers = @"kIdentifierControllerArrayOfIdentifiers";

@interface IdentifiersController ()

/**
 A mutableSet containing all the identifiers that has been added.
 */
@property (nonatomic, strong, nonnull) NSMutableSet<NSString *> *mutableIdentifiers;

/**
 Returns the [NSUserDefault standardUserDefaults] instance with it's getter.
 */
@property (nonatomic, strong, readonly, nonnull) NSUserDefaults *userDefaults;

@end

@implementation IdentifiersController

/**
 Gets the NSString pointer to the object inside the _mutableIdentifiers Set

 @param identifier An NSString containing an identical NSString

 @return The NSString pointer to the object inside the _mutableIdentifiers Set
 */
- (NSString *)filterIdenfifierFromSet:(NSString *)identifier {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF in %@", identifier];
    NSSet *filteredSet = [_mutableIdentifiers filteredSetUsingPredicate:predicate];
    return filteredSet.anyObject;
}

- (void)addIdentifier:(NSString *)identifier {
    [_mutableIdentifiers addObject:identifier];
}

- (void)removeIdentifier:(NSString *)identifier {
    NSString *identifierObjectItself = [self filterIdenfifierFromSet:identifier];
    [_mutableIdentifiers removeObject:identifierObjectItself];
}

- (void)removeAllIdentifiers {
    [_mutableIdentifiers removeAllObjects];
}

- (void)readFromDefaults {
    NSArray *arrayFromDefaults = [self.userDefaults arrayForKey:kIdentifiersControllerDefaultArrayOfNotificationIdentifiers];
    [_mutableIdentifiers addObjectsFromArray:arrayFromDefaults];
}

- (void)saveToDefaults {
    NSArray *arrayToSave = self.identifiers;
    [self.userDefaults setObject:arrayToSave forKey:kIdentifiersControllerDefaultArrayOfNotificationIdentifiers];
}

- (BOOL)synchronizeToDefaults {
    return [self.userDefaults synchronize];
}

#pragma mark - Setters

#pragma mark - Getters

- (NSArray *)identifiers {
    return _mutableIdentifiers.allObjects;
}

- (NSUserDefaults *)userDefaults {
    return [NSUserDefaults standardUserDefaults];
}

#pragma mark - NSObject

- (instancetype)init {
    self = [super init];
    if (self) {
        _mutableIdentifiers = [[NSMutableSet alloc] init];
    }
    return self;
}

@end
