//
//  WeekendViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "WeekendViewController.h"

#import "EventStateController.h"
#import "NotificationScheduler+EventStateController.h"

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

#pragma mark - EventStateViewController

- (void)updateNow
{
    NSDate *nextChangeDate = self.dayController.nextChange;
    NSString *title = NSLocalizedString(@"Finally it is weekend", @"Message to the user that it is finally weekend.");
    NSString *informativeText = NSLocalizedString(@"Have a wonderful weekend and don't care about your work!", @"Wishing the user a wonderful weekend.");
    NSString *notificationIdentifier = [self.notificationScheduler notificationIdentifierForNotificationSourceType:NotificationSourceTypeWeekend];
    
    [super updateNow];
    
    BOOL isAllreadyScheduled = [self.notificationScheduler isNotificationScheduledForNotificationSourceType:NotificationSourceTypeWeekend];
#ifdef DEBUG
    NSLog(@"********************************************* WeekeendViewController *********************************************");
    NSLog(@"Current date: %@", [NSDate date]);
    NSLog(@"isAllReadyScheduled: %@", [NSNumber numberWithBool:isAllreadyScheduled]);
    NSLog(@"isHetAl: %@", [NSNumber numberWithBool:self.dayController.isHetAl]);
    NSLog(@"isAllReadyScheduled || isHetAl : %@", [NSNumber numberWithBool:(isAllreadyScheduled || self.dayController.isHetAl)]);
    NSLog(@"nextChangeDate: %@", nextChangeDate);
#endif
    if (isAllreadyScheduled || self.dayController.isHetAl) {
        return;
    }
    
    [self.notificationScheduler scheduleLocalNotificationOnDate:nextChangeDate withTitle:title andText:informativeText withIdentifier:notificationIdentifier];
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
