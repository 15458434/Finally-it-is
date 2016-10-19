//
//  NotificationScheduler.h
//  Finally it is
//
//  Created by Mark Cornelisse on 17/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import Foundation;

extern NSString * scheduleLocalNotificationWithTimeInterval(NSTimeInterval interval, NSString *title, NSString *informativeText);
extern NSString * scheduleLocalNotificationOnDate(NSDate *deliveryDate, NSString *title, NSString *informativeText);
extern void removeScheduledLocalNotification(NSString *identifier);
extern void removeAllDeliveredLocalNotifications();
