//
//  IdentifiersControllerTests.m
//  Finally it is
//
//  Created by Mark Cornelisse on 22/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

@import XCTest;

#import "IdentifiersController.h"

@interface IdentifiersControllerTests : XCTestCase

@property (nonatomic, strong) IdentifiersController *iController;

@property (nonatomic, strong) NSString *first;
@property (nonatomic, strong) NSString *second;
@property (nonatomic, strong) NSString *third;
@property (nonatomic, strong) NSString *fourth;
@property (nonatomic, strong) NSString *fifth;

@property (nonatomic, copy) NSString *firstCopy;
@property (nonatomic, copy) NSString *secondCopy;
@property (nonatomic, copy) NSString *thirdCopy;
@property (nonatomic, copy) NSString *fourthCopy;
@property (nonatomic, copy) NSString *fifthCopy;

@end

@implementation IdentifiersControllerTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    self.iController = [[IdentifiersController alloc] init];
    
    self.first = [[NSUUID UUID] UUIDString];
    self.second = [[NSUUID UUID] UUIDString];
    self.third = [[NSUUID UUID] UUIDString];
    self.fourth = [[NSUUID UUID] UUIDString];
    self.fifth = [[NSUUID UUID] UUIDString];
    
    self.firstCopy = self.first;
    self.secondCopy = self.second;
    self.thirdCopy = self.third;
    self.fourthCopy = self.fourth;
    self.fifthCopy = self.fifth;
    
    [NSUserDefaults resetStandardUserDefaults];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    self.iController = nil;
    
    self.first = nil;
    self.second = nil;
    self.third = nil;
    self.fourth = nil;
    self.fifth = nil;
    
    self.firstCopy = nil;
    self.secondCopy = nil;
    self.thirdCopy = nil;
    self.fourthCopy = nil;
    self.fifthCopy = nil;
}

- (void)preloadAllIdentifiers {
    [_iController addIdentifier:_first];
    [_iController addIdentifier:_second];
    [_iController addIdentifier:_third];
    [_iController addIdentifier:_fourth];
    [_iController addIdentifier:_fifth];
    XCTAssertEqual(_iController.identifiers.count, 5, @"There should be five identifiers present.");
}

- (void)testAddIdenfifier {
    [_iController addIdentifier:_first];
    XCTAssertEqual(_iController.identifiers.count, 1, @"There should be one object present.");
    XCTAssertTrue([[_iController.identifiers firstObject] isEqual:_first], @"The only object should be present in Array.");
    [_iController addIdentifier:_second];
    XCTAssertEqual(_iController.identifiers.count, 2, @"There should be two objects presen.");
}

- (void)testRemoveIdentifier {
    [self preloadAllIdentifiers];
    
    [_iController removeIdentifier:_fourthCopy];
    XCTAssertEqual(_iController.identifiers.count, 4, @"There should be 4 identifiers present.");
    [_iController removeIdentifier:_third];
    XCTAssertEqual(_iController.identifiers.count, 3, @"There should be 3 identifiers present.");
    
    NSPredicate *predicateOne = [NSPredicate predicateWithFormat:@"SELF in %@", _firstCopy];
    NSArray *arrayWithOnlyFirst = [_iController.identifiers filteredArrayUsingPredicate:predicateOne];
    XCTAssertEqual(arrayWithOnlyFirst.count, 1, @"There should only be one value containing the first identifier");
    
    NSPredicate *predicateTwo = [NSPredicate predicateWithFormat:@"SELF in %@", _secondCopy];
    NSArray *arrayWithOnlySecond = [_iController.identifiers filteredArrayUsingPredicate:predicateTwo];
    XCTAssertEqual(arrayWithOnlySecond.count, 1, @"There should only be one value containing the second identifier");
    
    NSPredicate *predicateFive = [NSPredicate predicateWithFormat:@"SELF in %@", _fifthCopy];
    NSArray *arrayWithOnlyFifth = [_iController.identifiers filteredArrayUsingPredicate:predicateFive];
    XCTAssertEqual(arrayWithOnlyFifth.count, 1, @"There should only be one value containing the fifth identifier.");
}

- (void)testRemoveAllIdentifiers {
    [self preloadAllIdentifiers];
    
    [_iController removeAllIdentifiers];
    XCTAssertEqual(_iController.identifiers.count, 0, @"There should be no identifiers present.");
}

- (void)testSaveToDefaults {
    [self preloadAllIdentifiers];
    [_iController saveToDefaults];
    [_iController synchronizeToDefaults];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *storedIdentifier = [defaults arrayForKey:kIdentifiersControllerDefaultArrayOfNotificationIdentifiers];
    XCTAssertEqual(storedIdentifier.count, 5, @"There should be five identifiers were stored.");
    
    NSPredicate *predicateOne = [NSPredicate predicateWithFormat:@"SELF in %@", _firstCopy];
    NSArray *arrayWithOnlyFirst = [_iController.identifiers filteredArrayUsingPredicate:predicateOne];
    XCTAssertEqual(arrayWithOnlyFirst.count, 1, @"There should only be one value containing the first identifier");
    
    NSPredicate *predicateTwo = [NSPredicate predicateWithFormat:@"SELF in %@", _secondCopy];
    NSArray *arrayWithOnlySecond = [_iController.identifiers filteredArrayUsingPredicate:predicateTwo];
    XCTAssertEqual(arrayWithOnlySecond.count, 1, @"There should only be one value containing the second identifier");
    
    NSPredicate *predicateThree = [NSPredicate predicateWithFormat:@"SELF in %@", _thirdCopy];
    NSArray *arrayWithOnlyThird = [_iController.identifiers filteredArrayUsingPredicate:predicateThree];
    XCTAssertEqual(arrayWithOnlyThird.count, 1, @"There should be only one value containing the third identifier");
    
    NSPredicate *predicateFour = [NSPredicate predicateWithFormat:@"SELF in %@", _fourthCopy];
    NSArray *arrayWithOnlyFour = [_iController.identifiers filteredArrayUsingPredicate:predicateFour];
    XCTAssertEqual(arrayWithOnlyFour.count, 1, @"There should be only one value containing the fourth idenifier");
    
    NSPredicate *predicateFive = [NSPredicate predicateWithFormat:@"SELF in %@", _fifthCopy];
    NSArray *arrayWithOnlyFifth = [_iController.identifiers filteredArrayUsingPredicate:predicateFive];
    XCTAssertEqual(arrayWithOnlyFifth.count, 1, @"There should only be one value containing the fifth identifier.");
}

- (void)testReadFromDefaults {
    [self preloadAllIdentifiers];
    [_iController saveToDefaults];
    [_iController synchronizeToDefaults];
    
    IdentifiersController *readTestController = [[IdentifiersController alloc] init];
    [readTestController readFromDefaults];
    XCTAssertEqual(readTestController.identifiers.count, 5, @"There should be five identifiers present.");
    
    NSPredicate *predicateOne = [NSPredicate predicateWithFormat:@"SELF in %@", _firstCopy];
    NSArray *arrayWithOnlyFirst = [readTestController.identifiers filteredArrayUsingPredicate:predicateOne];
    XCTAssertEqual(arrayWithOnlyFirst.count, 1, @"There should only be one value containing the first identifier");
    
    NSPredicate *predicateTwo = [NSPredicate predicateWithFormat:@"SELF in %@", _secondCopy];
    NSArray *arrayWithOnlySecond = [readTestController.identifiers filteredArrayUsingPredicate:predicateTwo];
    XCTAssertEqual(arrayWithOnlySecond.count, 1, @"There should only be one value containing the second identifier");
    
    NSPredicate *predicateThree = [NSPredicate predicateWithFormat:@"SELF in %@", _thirdCopy];
    NSArray *arrayWithOnlyThird = [readTestController.identifiers filteredArrayUsingPredicate:predicateThree];
    XCTAssertEqual(arrayWithOnlyThird.count, 1, @"There should be only one value containing the third identifier");
    
    NSPredicate *predicateFour = [NSPredicate predicateWithFormat:@"SELF in %@", _fourthCopy];
    NSArray *arrayWithOnlyFour = [readTestController.identifiers filteredArrayUsingPredicate:predicateFour];
    XCTAssertEqual(arrayWithOnlyFour.count, 1, @"There should be only one value containing the fourth idenifier");
    
    NSPredicate *predicateFive = [NSPredicate predicateWithFormat:@"SELF in %@", _fifthCopy];
    NSArray *arrayWithOnlyFifth = [readTestController.identifiers filteredArrayUsingPredicate:predicateFive];
    XCTAssertEqual(arrayWithOnlyFifth.count, 1, @"There should only be one value containing the fifth identifier.");
}

@end
