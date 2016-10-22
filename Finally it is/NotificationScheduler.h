//
//  NotificationScheduler.h
//  Finally it is
//
//  Created by Mark Cornelisse on 20/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import Foundation;

@interface NotificationScheduler : NSObject

+ (instancetype)sharedScheduler;

- (NSString *)scheduleLocalNotificationWithTimeInterval:(NSTimeInterval)timeInterval withTitle:(NSString *)title andText:(NSString *)informativeText;
- (NSString *)scheduleLocalNotificationOnDate:(NSDate *)deliveryDate withTitle:(NSString *)title andText:(NSString *)informativeText;
- (void)removeScheduledNotificationWithIdentifier:(NSString *)identifier;
- (void)removeDeliveredNotificationWithIdentifier:(NSString *)identifier;
- (void)removeAllDeliveredLocalNotifications;

#pragma mark - NSObject

- (instancetype)init NS_UNAVAILABLE;

@end
