//
//  DayController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "EventStateController.h"

#import "NotificationScheduler.h"

@interface EventStateController ()

@end

@implementation EventStateController

- (instancetype)initWithType:(DayControllerType)type
{
    switch (type) {
        case DayControllerTypeSeventeenHour:
            return [[SeventeenHourDayController alloc] init];
            break;
        case DayControllerTypeFriday:
            return [[FridayDayController alloc] init];
            break;
        case DayControllerTypeWeekend:
            return [[WeekendDayController alloc] init];
            break;
        default:
            break;
    }
}

- (NSString *)isHetAlString {
    if (self.isHetAl) {
        return NSLocalizedString(@"Yes", @"Yes");
    } else {
        return NSLocalizedString(@"No", @"No");
    }
}

- (NSDate *)nextChange {
    return [self nextChangeFromDate:[NSDate date]];
}

- (NSDate *)nextChangeFromDate:(NSDate *)date {
    [NSException raise:NSInternalInconsistencyException format:@"nextChangeFromDate should be implemented in a subclass"];
    return nil;
}

- (void)scheduleANotificationOnNextChange {
    [NSException raise:NSInternalInconsistencyException format:@"scheduleANotificationOnNextChange should be implemented in a subclass"];
}

@end

#pragma mark - SeventeenHourDayController

@implementation SeventeenHourDayController

- (BOOL)isHetAl
{
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:now];
    if (components.weekday == 7 || components.weekday == 1) {
        return NO;
    }
    if (components.hour >= 17) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)nextChangeFromDate:(NSDate *)date
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    if (components.weekday >= 2 && components.weekday <= 6 && components.hour >= 0 && components.hour < 17) {
        NSDateComponents *nextYesComponents = [[NSDateComponents alloc] init];
        nextYesComponents.weekday = components.weekday;
        nextYesComponents.hour = 17;
        return [calendar nextDateAfterDate:date matchingComponents:nextYesComponents options:NSCalendarMatchNextTime];
    } else {
        if (components.weekday == 6 && components.hour >= 17) {
            // Vrijdag na vijf uur, dan is maandagochtend om 0:00 uur de volgende.
            NSDateComponents *nextNOComponents = [[NSDateComponents alloc] init];
            nextNOComponents.weekday = 2;
            nextNOComponents.hour = 0;
            return [calendar nextDateAfterDate:date matchingComponents:nextNOComponents options:NSCalendarMatchNextTime];
        } else {
            // Iedere maandag, dinsdag, woensdag, donderdag na 17:00 is 0:00 de volgende.
            NSDateComponents *nextNOComponents = [[NSDateComponents alloc] init];
            nextNOComponents.weekday = components.weekday + 1;
            nextNOComponents.hour = 0;
            return [calendar nextDateAfterDate:date matchingComponents:nextNOComponents options:NSCalendarMatchNextTime];
        }
    }
}

- (void)scheduleANotificationOnNextChange
{
    NSDate *nextChangeDate = self.nextChange;
    BOOL currentValue = [self isHetAl];
    
    NSString *title;
    NSString *informativeText;
    if (!currentValue) {
        title = NSLocalizedString(@"Finally it is 5 pm", @"Message to the user that it is finally 5 pm.");
        informativeText = NSLocalizedString(@"Have a wonderful evening doing the stuff you love to do!", @"Wishing the user a happy evening");
        [[NotificationScheduler sharedScheduler] scheduleLocalNotificationOnDate:nextChangeDate withTitle:title andText:informativeText withIdentifier:@"5 pm notification"];
    }
}

@end

#pragma mark - FridayDayController

@implementation FridayDayController

- (BOOL)isHetAl
{
    NSDate *now = [NSDate date];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitWeekday;
    NSDateComponents *components = [calender components:units fromDate:now];
    if (components.weekday == 6) {
        return YES;
    } else {
        return NO;
    }
}

- (NSDate *)nextChangeFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    if (components.weekday == 6) {
        // Next change after friday
        NSDateComponents *nextNoComponents = [[NSDateComponents alloc] init];
        nextNoComponents.weekday = 7;
        nextNoComponents.hour = 0;
        return [calendar nextDateAfterDate:date matchingComponents:nextNoComponents options:NSCalendarMatchNextTime];
    } else {
        // Next change on friday
        NSDateComponents *nextYesComponents = [[NSDateComponents alloc] init];
        nextYesComponents.weekday = 6;
        nextYesComponents.hour = 0;
        return [calendar nextDateAfterDate:date matchingComponents:nextYesComponents options:NSCalendarMatchNextTime];
    }
}

- (void)scheduleANotificationOnNextChange
{
    NSDate *nextChangeDate = self.nextChange;
    BOOL currentValue = [self isHetAl];
    
    NSString *title;
    NSString *informativeText;
    if (!currentValue) {
        title = NSLocalizedString(@"Finally it is Friday", @"Message to the user that it is finally Friday.");
        informativeText = NSLocalizedString(@"You're almost there", @"Encouragement to make through the Friday.");
        [[NotificationScheduler sharedScheduler] scheduleLocalNotificationOnDate:nextChangeDate withTitle:title andText:informativeText withIdentifier:@"Friday notification"];
    }
}

@end

#pragma mark - WeekendDayController

@implementation WeekendDayController

- (BOOL)isHetAl {
    NSDate *now = [NSDate date];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calender components:units fromDate:now];
    
    if ((components.weekday >= 2 && components.weekday <= 5) || (components.weekday == 6 && components.hour < 17)) {
        return NO;
    } else {
        return YES;
    }
}

- (NSDate *)nextChangeFromDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calendar components:units fromDate:date];
    
    if ((components.weekday >= 2 && components.weekday <= 5) || (components.weekday == 6 && components.hour < 17)) {
        // Next Yes Date
        NSDateComponents *nextYesComponents = [[NSDateComponents alloc] init];
        nextYesComponents.weekday = 6;
        nextYesComponents.hour = 17;
        return [calendar nextDateAfterDate:date matchingComponents:nextYesComponents options:NSCalendarMatchNextTime];
    } else {
        // Next No Date
        NSDateComponents *nextYesComponents = [[NSDateComponents alloc] init];
        nextYesComponents.weekday = 2;
        nextYesComponents.hour = 0;
        return [calendar nextDateAfterDate:date matchingComponents:nextYesComponents options:NSCalendarMatchNextTime];
    }
}

- (void)scheduleANotificationOnNextChange
{
    NSDate *nextChangeDate = self.nextChange;
    BOOL currentValue = [self isHetAl];
    
    NSString *title;
    NSString *informativeText;
    if (!currentValue) {
        title = NSLocalizedString(@"Finally it is weekend", @"Message to the user that it is finally weekend.");
        informativeText = NSLocalizedString(@"Have a wonderful weekend and don't care about your work!", @"Wishing the user a wonderful weekend.");
        [[NotificationScheduler sharedScheduler] scheduleLocalNotificationOnDate:nextChangeDate withTitle:title andText:informativeText withIdentifier:@"weekend notification"];
    }
}

@end
