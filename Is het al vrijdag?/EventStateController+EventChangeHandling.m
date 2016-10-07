//
//  EventStateController+EventChangeHandling.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "EventStateController+EventChangeHandling.h"

@implementation EventStateController (EventChangeHandling)

- (NSTimeInterval)timeIntervalUntilNextChange
{
    return [self timeIntervalUntilNextChangeFromDate:[NSDate date]];
}

- (NSTimeInterval)timeIntervalUntilNextChangeFromDate:(NSDate *)date
{
    NSDate *nextChangeDate = [self nextChangeFromDate:date];
    return [nextChangeDate timeIntervalSinceDate:date];
}

- (void)executeOnStateChange:(EventStateControllerEvent)changeHandler
{
    __weak typeof(self) weakSelf = self;
    NSTimeInterval delayTimeUntilNextEventChange = [self timeIntervalUntilNextChange];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTimeUntilNextEventChange * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        changeHandler();
        // If self still exists execute again on next change
        [weakSelf executeOnStateChange:changeHandler];
    });
}

@end
