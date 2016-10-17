//
//  WeekendDayControllerTests.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import XCTest;
#import "EventStateController.h"

@interface WeekendDayControllerTests : XCTestCase

@property (nonatomic, strong) EventStateController *testController;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic) NSCalendarUnit units;

@end

@implementation WeekendDayControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _testController = [[EventStateController alloc] initWithType:DayControllerTypeWeekend];
    XCTAssertNotNil(_testController, "Test Controller should exist at this moment");
    _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    XCTAssertNotNil(_calendar, "Calender should exist at this moment");
    _units = NSCalendarUnitHour | NSCalendarUnitWeekday;
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testNextChangeFromDate {
    NSDateComponents *saturdayComponents = [[NSDateComponents alloc] init];
    saturdayComponents.weekday = 7;
    saturdayComponents.hour = 14;
    saturdayComponents.year = 2016;
    saturdayComponents.weekOfYear = 40;
    NSDate *saturdayDate = [_calendar dateFromComponents:saturdayComponents];
    NSDate *nextSwitchDate = [_testController nextChangeFromDate:saturdayDate];
    
    NSDateComponents *components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 2, "Next switch should be on Monday.");
    XCTAssertEqual(components.hour, 0, "Next switch should be on 0:00 hour.");
    
    // Test morning on any other day
    NSDateComponents *tuesdayMonrningComponents = [[NSDateComponents alloc] init];
    tuesdayMonrningComponents.year = 2016;
    tuesdayMonrningComponents.weekOfYear = 40;
    tuesdayMonrningComponents.weekday = 3;
    tuesdayMonrningComponents.hour = 12;
    NSDate *tuesdayMorningDate = [_calendar dateFromComponents:tuesdayMonrningComponents];
    nextSwitchDate = [_testController nextChangeFromDate:tuesdayMorningDate];
    components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 6, "Next switch date should happen on a friday");
    XCTAssertEqual(components.hour, 17, "Next switch hour should happen at 17:00 hours");
}

@end
