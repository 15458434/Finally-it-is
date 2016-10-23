//
//  NotificationScheduler.m
//  Finally it is
//
//  Created by Mark Cornelisse on 20/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "NotificationScheduler.h"

// Debug Helpers
#import "DebugLog.h"

@interface NotificationScheduler () <NSUserNotificationCenterDelegate>

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

- (void)scheduleLocalNotificationOnDate:(NSDate *)deliveryDate withTitle:(NSString *)title andText:(NSString *)informativeText withIdentifier:(NSString *)identifier
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.identifier = identifier;
    notification.title = title;
    notification.informativeText = informativeText;
    notification.deliveryDate = deliveryDate;
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:notification];
}

- (BOOL)isPresentInScheduledNotificationWithIdentifier:(NSString *)identifier
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier is %@", identifier];
    NSArray *resultsFromScheduledNotifications = [[self scheduledNotifications] filteredArrayUsingPredicate:predicate];
    if (resultsFromScheduledNotifications.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (void)removeScheduledNotificationWithIdentifier:(NSString *)identifier
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.identifier = identifier;
    
    [self removeScheduledNotification:notification];
}

/**
 Removes scheduled notification from [NSUserNotificationCenter defaultUserNotificationCenter]

 @param notification NSUserNotification to be removed from scheduledNotifications. (The check is based on notification identifier?)
 */
- (void)removeScheduledNotification:(NSUserNotification *)notification
{
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center removeScheduledNotification:notification];
}

- (void)removeDeliveredNotificationWithIdentifier:(NSString *)identifier
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.identifier = identifier;
    
    [self removeDeliveredNotification:notification];
}

/**
 Removes delivered notification from [NSUserNotificationCenter defaultNotificationCenter]

 @param notification Notification to be removed from delivered notifications. (The check is based on notification identifier?)
 */
- (void)removeDeliveredNotification:(NSUserNotification *)notification
{
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center removeDeliveredNotification:notification];
}

- (void)removeAllDeliveredLocalNotifications
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
}

#pragma mark - Getters 

- (NSArray *)scheduledNotifications {
    return [[NSUserNotificationCenter defaultUserNotificationCenter] scheduledNotifications];
}

- (NSArray *)deliveredNotifications {
    return [[NSUserNotificationCenter defaultUserNotificationCenter] deliveredNotifications];
}

#pragma mark - NSUserNotificatoinCenterDelegate

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    DebugLog(@"userNotificationCenter:didDeliverNotification");
}

- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    DebugLog(@"userNotificationCenter:didActivateNotification");
    
    [self removeDeliveredNotification:notification];
}

#pragma mark - NSObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    }
    return self;
}

@end
