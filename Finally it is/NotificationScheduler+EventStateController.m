//
//  NotificationScheduler+EventStateController.m
//  Finally it is
//
//  Created by Mark Cornelisse on 23/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "NotificationScheduler+EventStateController.h"

NSString * const NotificationSourceTypeSeventeenHundredHoursPrefixString = @"000-";
NSString * const NotificationSourceTypeFridayPrefixString = @"001-";
NSString * const NotificationSourceTypeWeekendPrefixString = @"002-";

@implementation NotificationScheduler (EventStateController)

- (NSString *)notificationIdentifierPrefixForNotificationSourceType:(NotificationSourceType)type
{
    switch (type) {
        case NotificationSourceTypeSeventeenHundredHours:
            return NotificationSourceTypeSeventeenHundredHoursPrefixString;
            break;
        case NotificationSourceTypeFridday:
            return NotificationSourceTypeFridayPrefixString;
            break;
        case NotificationSourceTypeWeekend:
            return NotificationSourceTypeWeekendPrefixString;
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

+ (NotificationSourceType)typeOfIdentifier:(NSString *)identifier
{
    if ([identifier hasPrefix:NotificationSourceTypeSeventeenHundredHoursPrefixString]) {
        return NotificationSourceTypeSeventeenHundredHours;
    } else if ([identifier hasPrefix:NotificationSourceTypeFridayPrefixString]) {
        return NotificationSourceTypeFridday;
    } else if ([identifier hasPrefix:NotificationSourceTypeWeekendPrefixString]) {
        return NotificationSourceTypeWeekend;
    } else {
        [NSException raise:NSInternalInconsistencyException format:@"Identifier doesn't contain a valid prefix."];
        return NotificationSourceTypeInvalid;
    }
}

@end
