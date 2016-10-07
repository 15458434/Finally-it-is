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

@interface DayController : NSObject

- (instancetype)initWithType:(DayControllerType)type;

@property (nonatomic, readonly) BOOL isHetAl;
@property (nonatomic, readonly) NSDate *nextChange;

- (NSDate *)nextChangeFromDate:(NSDate *)date;

@end

#pragma mark - SeventeenHourDayController

@interface SeventeenHourDayController : DayController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end

#pragma mark - FridayDayController

@interface FridayDayController : DayController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end

#pragma mark - WeekendDayController

@interface WeekendDayController : DayController

- (instancetype)initWithType:(DayControllerType)type NS_UNAVAILABLE;

@end
