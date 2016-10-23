//
//  NotificationScheduler+EventStateController.m
//  Finally it is
//
//  Created by Mark Cornelisse on 23/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "NotificationScheduler+EventStateController.h"

@implementation NotificationScheduler (EventStateController)

- (NSString *)notificationIdentifierPrefixForNotificationSourceType:(NotificationSourceType)type
{
    switch (type) {
        case NotificationSourceTypeSeventeenHundredHours:
            return @"000-";
            break;
        case NotificationSourceTypeFridday:
            return @"001-";
            break;
        case NotificationSourceTypeWeekend:
            return @"002-";
            break;
        default:
            return nil;
            break;
    }
}

- (NSString *)notificationIdentifierForNotificationSourceType:(NotificationSourceType)type
{
    NSString *prefix = [self notificationIdentifierPrefixForNotificationSourceType:type];
    return [prefix stringByAppendingString:[[NSUUID UUID] UUIDString]];
}

- (BOOL)isNotificationScheduledForNotificationSourceType:(NotificationSourceType)type
{
    NSString *prefix = [self notificationIdentifierPrefixForNotificationSourceType:type];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier BEGINSWITH %@", prefix];
    NSArray *filteredResults = [[self scheduledNotifications] filteredArrayUsingPredicate:predicate];
    if (filteredResults.count > 0) {
        return YES;
    } else {
        return NO;
    }
}

- (NSUInteger)notificationDeliveredCountForNotificationSourceType:(NotificationSourceType)type
{
    NSString *prefix = [self notificationIdentifierPrefixForNotificationSourceType:type];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"identifier BEGINSWITH %@", prefix];
    NSArray *filteredResults = [[self deliveredNotifications] filteredArrayUsingPredicate:predicate];
    return filteredResults.count;
}

@end
