//
//  SeventeenHourDayControllerTests.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import XCTest;
#import "EventStateController.h"

@interface SeventeenHourDayControllerTests : XCTestCase

@property (nonatomic, strong) EventStateController *testController;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic) NSCalendarUnit units;

@end

@implementation SeventeenHourDayControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _testController = [[EventStateController alloc] initWithType:DayControllerTypeSeventeenHour];
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
    // Test Friday night
    NSDateComponents *fridayNightComponents = [[NSDateComponents alloc] init];
    fridayNightComponents.weekday = 6;
    fridayNightComponents.hour = 20;
    fridayNightComponents.year = 2016;
    fridayNightComponents.weekOfYear = 40;
    NSDate *fridayNightDate = [_calendar dateFromComponents:fridayNightComponents];
    NSDate *nextSwitchDate = [_testController nextChangeFromDate:fridayNightDate];
    
    NSDateComponents *components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 2, "Next switch should be on monday.");
    XCTAssertEqual(components.hour, 0, "Next switch should be on 0 hour.");
    
    // Test morning on a weekday
    NSDateComponents *tuesdayMonrningComponents = [[NSDateComponents alloc] init];
    tuesdayMonrningComponents.year = 2016;
    tuesdayMonrningComponents.weekOfYear = 40;
    tuesdayMonrningComponents.weekday = 3;
    tuesdayMonrningComponents.hour = 12;
    NSDate *tuesdayMorningDate = [_calendar dateFromComponents:tuesdayMonrningComponents];
    nextSwitchDate = [_testController nextChangeFromDate:tuesdayMorningDate];
    components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 3, "Next switch date should happen on a tuesday");
    XCTAssertEqual(components.hour, 17, "Next switch hour should happen at 17:00 hours");
    
    // Test evening on a weekday
    NSDateComponents *wednesdayNightComponents = [[NSDateComponents alloc] init];
    wednesdayNightComponents.year = 2016;
    wednesdayNightComponents.weekOfYear = 40;
    wednesdayNightComponents.weekday = 4;
    wednesdayNightComponents.hour = 17;
    NSDate *wednesdayNightDate = [_calendar dateFromComponents:wednesdayNightComponents];
    nextSwitchDate = [_testController nextChangeFromDate:wednesdayNightDate];
    components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 5, "Should happen on Thursday.");
    XCTAssertEqual(components.hour, 0, "Should happen at midnight.");
}

@end
