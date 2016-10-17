//
//  EventStateController+EventChangeHandling.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "EventStateController.h"

typedef void (^EventStateControllerEvent)();

@interface EventStateController (EventChangeHandling)

- (NSTimeInterval)timeIntervalUntilNextChangeFromDate:(NSDate *)date;
- (void)executeOnStateChange:(EventStateControllerEvent)changeHandler;

@end
