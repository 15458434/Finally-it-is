//
//  DayController.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import Foundation;

typedef NS_ENUM(NSUInteger, DayControllerType) {
    DayControllerTypeSeventeenHour,
    DayControllerTypeFriday,
    DayControllerTypeWeekend
};

NS_ASSUME_NONNULL_BEGIN

@interface EventStateController : NSObject

- (instancetype)initWithType:(DayControllerType)type;

@property (nonatomic, readonly) BOOL isHetAl;
@property (nonatomic, readonly) NSString *isHetAlString;
@property (nonatomic, readonly) NSDate *nextChange;
@property (nonatomic, strong, nullable) NSString *userNotificationIdentifier;

- (NSDate *)nextChangeFromDate:(NSDate *)date;
- (void)scheduleANotificationOnNextChange;

@end

#pragma mark - SeventeenHourDayController

@interface SeventeenHourDayController : EventStateController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end

#pragma mark - FridayDayController

@interface FridayDayController : EventStateController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end

#pragma mark - WeekendDayController

@interface WeekendDayController : EventStateController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
