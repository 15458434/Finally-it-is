//
//  NotificationSchedulerTests.m
//  Finally it is
//
//  Created by Mark Cornelisse on 19/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import XCTest;

#import "NotificationScheduler.h"

@interface NotificationSchedulerTests : XCTestCase

@end

@implementation NotificationSchedulerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAddLocalNotificationwithTimeInterval
{
    NSString *notificationIdentifier = scheduleLocalNotificationWithTimeInterval(3, @"Unit Test", @"User notification from testAddLocalNotificationwithTimeInterval");
    XCTAssertNotNil(notificationIdentifier, @"Notification Identifier shouldn't be zero");
    removeScheduledLocalNotification(notificationIdentifier);
}

@end
