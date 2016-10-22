//
//  NotificationScheduler.h
//  Finally it is
//
//  Created by Mark Cornelisse on 17/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import Foundation;

/**
 schedule a local notification in timeInterval with a title and informativeText

 @param interval        Time in seconds until the Notification Should Occur.
 @param title           The title of the notification
 @param informativeText The message of the notification

 @return The identifier of the NSNotification that has been scheduled.
 */
extern NSString * scheduleLocalNotificationWithTimeInterval(NSTimeInterval interval, NSString *title, NSString *informativeText);
extern NSString * scheduleLocalNotificationOnDate(NSDate *deliveryDate, NSString *title, NSString *informativeText);
extern void removeScheduledLocalNotification(NSString *identifier);
extern void removeDeliveredLocalNoticication(NSString *identifier);
extern void removeAllDeliveredLocalNotifications();
