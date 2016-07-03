//
//  DayController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "DayController.h"

@implementation DayController

- (BOOL)isHetAlZeventienUur
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

- (BOOL)isHetAlVrijdag
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

- (BOOL)isHetAlWeekend
{
    NSDate *now = [NSDate date];
    NSCalendar *calender = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSCalendarUnit units = NSCalendarUnitHour | NSCalendarUnitWeekday;
    NSDateComponents *components = [calender components:units fromDate:now];
    if (self.isHetAlVrijdag) {
        return self.isHetAlZeventienUur;
    }
    
    if (components.weekday == 2 && components.hour < 9) {
        return YES;
    }
    
    if (components.weekday == 7 || components.weekday == 1) {
        return YES;
    } else {
        return NO;
    }
    
}

@end
