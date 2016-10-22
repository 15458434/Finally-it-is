//
//  WeekendViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "WeekendViewController.h"
#import "EventStateController.h"

@interface WeekendViewController ()

@end

@implementation WeekendViewController

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al weekend";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"weekend"]];
        activity.userInfo = @{@"state": self.isHetAlLabel.stringValue};
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
    
    self.dayController = [[EventStateController alloc] initWithType:DayControllerTypeWeekend];
    self.title = NSLocalizedString(@"Weekend", @"Weekend");
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self createUserActivity];
    [self.userActivity becomeCurrent];
}

@end