//
//  NotificationScheduler+EventStateController.h
//  Finally it is
//
//  Created by Mark Cornelisse on 23/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "NotificationScheduler.h"

/**
 What EventStateController generated the notification.

 - NotificationSourceTypeSeventeenHundredHours: SeventeenHourDayController
 - NotificationSourceTypeFridday:               FridayDayController
 - NotificationSourceTypeWeekend:               WeekendDayController
 */
typedef NS_ENUM(NSUInteger, NotificationSourceType) {
    NotificationSourceTypeSeventeenHundredHours,
    NotificationSourceTypeFridday,
    NotificationSourceTypeWeekend
};

@interface NotificationScheduler (EventStateController)

/**
 Returns a notification identifier prefix for the different EventStateControllers

 @param type What type of EventStateController the notification identifier prefix needs to be generated for.

 @return return a prefix for the notification.identifier
 */
- (NSString *)notificationIdentifierPrefixForNotificationSourceType:(NotificationSourceType)type;

/**
 Returns a unique notification identifier with a prefix per EventStateControllerType

 @param type What type of EventStateContreoller the notification identifier needs to be generated for.

 @return return a notifification identifier with a 4 character prefix unit per EventStateControllerType
 */
- (NSString *)notificationIdentifierForNotificationSourceType:(NotificationSourceType)type;


/**
 Check to see if there at least one Scheduled notification for a given EventStateController type.

 @param type What type of EventStateController the scheduled notification has been generated for.

 @return YES if at least one scheduled notification of EventStateControllerType has been found. No if not.
 */
- (BOOL)isNotificationScheduledForNotificationSourceType:(NotificationSourceType)type;

/**
 Returns the amount of delivered notification of a given EventStateControllerType

 @param type What type of EventStateController the delivered notification has been generated for.

 @return The amount of delivered notification of a given EventStateControllerType.
 */
- (NSUInteger)notificationDeliveredCountForNotificationSourceType:(NotificationSourceType)type;



@end
