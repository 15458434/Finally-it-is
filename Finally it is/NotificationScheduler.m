//
//  NotificationScheduler.m
//  Finally it is
//
//  Created by Mark Cornelisse on 20/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "NotificationScheduler.h"

#import "CoreNotificationScheduler.h"
#import "IdentifiersController.h"

// Debug Helpers
#import "DebugLog.h"

@interface NotificationScheduler () <NSUserNotificationCenterDelegate>

@property (nonatomic, strong) IdentifiersController *identifiersController;

@end

@implementation NotificationScheduler

+ (instancetype)sharedScheduler
{
    static NotificationScheduler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSString *)scheduleLocalNotificationWithTimeInterval:(NSTimeInterval)timeInterval withTitle:(NSString *)title andText:(NSString *)informativeText
{
    NSString *identifier = scheduleLocalNotificationWithTimeInterval(timeInterval, title, informativeText);
    [_identifiersController addIdentifier:identifier];
    return identifier;
}

- (NSString *)scheduleLocalNotificationOnDate:(NSDate *)deliveryDate withTitle:(NSString *)title andText:(NSString *)informativeText
{
    NSString *identifier = scheduleLocalNotificationOnDate(deliveryDate, title, informativeText);
    [_identifiersController addIdentifier:identifier];
    return identifier;
}

- (void)removeScheduledNotificationWithIdentifier:(NSString *)identifier
{
    removeScheduledLocalNotification(identifier);
    [_identifiersController removeIdentifier:identifier];
}

- (void)removeDeliveredNotificationWithIdentifier:(NSString *)identifier
{
    removeDeliveredLocalNoticication(identifier);
    [_identifiersController removeIdentifier:identifier];
}

- (void)removeAllDeliveredLocalNotifications
{
    removeAllDeliveredLocalNotifications();
}

#pragma mark - NSUserNotificatoinCenterDelegate

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    DebugLog(@"userNotificationCenter:didDeliverNotification");
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    DebugLog(@"userNotificationCenter:didActivateNotification");
    
    removeDeliveredLocalNoticication(notification.identifier);
    [_identifiersController removeIdentifier:notification.identifier];
    [_identifiersController saveToDefaults];
}

- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    DebugLog(@"userNotificationCenter:shouldPresentNotification");
    
    BOOL identifierIsPresent = [_identifiersController isIdentifierPresent:notification.identifier];
    if (identifierIsPresent == NO) {
        return identifierIsPresent;
    }
    return YES;
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
        _identifiersController = [[IdentifiersController alloc] init];
    }
    return self;
}

@end
