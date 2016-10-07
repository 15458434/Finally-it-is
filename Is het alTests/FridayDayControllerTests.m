//
//  FridayDayControllerTests.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import XCTest;
#import "DayController.h"

@interface FridayDayControllerTests : XCTestCase

@property (nonatomic, strong) DayController *testController;
@property (nonatomic, strong) NSCalendar *calendar;
@property (nonatomic) NSCalendarUnit units;

@end

@implementation FridayDayControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    _testController = [[DayController alloc] initWithType:DayControllerTypeFriday];
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
    NSDateComponents *fridayComponents = [[NSDateComponents alloc] init];
    fridayComponents.weekday = 6;
    fridayComponents.hour = 14;
    fridayComponents.year = 2016;
    fridayComponents.weekOfYear = 40;
    NSDate *fridayDate = [_calendar dateFromComponents:fridayComponents];
    NSDate *nextSwitchDate = [_testController nextChangeFromDate:fridayDate];
    
    NSDateComponents *components = [_calendar components:_units fromDate:nextSwitchDate];
    XCTAssertEqual(components.weekday, 7, "Next switch should be on Saturday.");
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
    XCTAssertEqual(components.hour, 0, "Next switch hour should happen at 00:00 hours");
}

@end
