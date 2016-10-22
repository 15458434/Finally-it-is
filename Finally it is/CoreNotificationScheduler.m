//
//  NotificationScheduler.m
//  Finally it is
//
//  Created by Mark Cornelisse on 17/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import Cocoa;

#import "CoreNotificationScheduler.h"

NSString * scheduleLocalNotificationWithTimeInterval(NSTimeInterval interval, NSString *title, NSString *informativeText)
{
    NSDate *now = [NSDate date];
    NSDate *scheduledDate = [now dateByAddingTimeInterval:interval];
    NSString *notificationIdentifier = scheduleLocalNotificationOnDate(scheduledDate, title, informativeText);
    return notificationIdentifier;
}

NSString * scheduleLocalNotificationOnDate(NSDate *deliveryDate, NSString *title, NSString *informativeText)
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.identifier = [[NSUUID UUID] UUIDString];
    notification.title = title;
    notification.informativeText = informativeText;
    notification.deliveryDate = deliveryDate;
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:notification];
    return notification.identifier;
}

void removeScheduledLocalNotification(NSString *identifier)
{
    NSUserNotification *notification = [[NSUserNotification alloc] init];
    notification.identifier = identifier;
    
    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center removeScheduledNotification:notification];
}

void removeAllDeliveredLocalNotifications()
{
    [[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
}
