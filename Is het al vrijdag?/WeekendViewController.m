//
//  WeekendViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "WeekendViewController.h"
#import "DayController.h"

@interface WeekendViewController ()

@property (nonatomic, weak) IBOutlet NSTextField *isHetAlWeekendLabel;
@property (nonatomic, strong) DayController *dayController;

@end

@implementation WeekendViewController

- (void)update
{
    BOOL isHetAlWeekend = _dayController.isHetAl;
    if (isHetAlWeekend) {
        _isHetAlWeekendLabel.textColor = [NSColor greenColor];
        _isHetAlWeekendLabel.stringValue = @"JA";
    } else {
        _isHetAlWeekendLabel.textColor = [NSColor redColor];
        _isHetAlWeekendLabel.stringValue = @"NEE";
    }
}

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al weekend";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"weekend"]];
        activity.userInfo = @{@"state": _isHetAlWeekendLabel.stringValue};
        activity.eligibleForHandoff = NO;
        activity.eligibleForSearch = YES;
        activity.eligibleForPublicIndexing = YES;
        self.userActivity = activity;
    }
}

#pragma mark - NSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dayController = [[DayController alloc] initWithType:DayControllerTypeWeekend];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self update];
    
    [self createUserActivity];
    [self.userActivity becomeCurrent];
}

@end
