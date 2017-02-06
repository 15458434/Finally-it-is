//
//  ZeventienUurViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 29/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "ZeventienUurViewController.h"

#import "EventStateController.h"
#import "NotificationScheduler+EventStateController.h"

@interface ZeventienUurViewController ()

@end

@implementation ZeventienUurViewController



#pragma mark - New in this class

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al Zeventien uur";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"zeventien", @"vijf", @"uur"]];
        activity.userInfo = @{@"state" : self.isHetAlLabel.stringValue};
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
    NSString *title = NSLocalizedString(@"Finally it is 5 pm", @"Message to the user that it is finally 5 pm.");
    NSString *informativeText = NSLocalizedString(@"Have a wonderful evening doing the stuff you love to do!", @"Wishing the user a happy evening");
    NSString *notificationIdentifier = [self.notificationScheduler notificationIdentifierForNotificationSourceType:NotificationSourceTypeSeventeenHundredHours];
    
    [super updateNow];
    BOOL isAllreadyScheduled = [self.notificationScheduler isNotificationScheduledForNotificationSourceType:NotificationSourceTypeSeventeenHundredHours];
#ifdef DEBUG
    NSLog(@"********************************************* ZeventienUurViewController *********************************************");
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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.dayController = [[EventStateController alloc] initWithType:DayControllerTypeSeventeenHour];
    
    self.title = NSLocalizedString(@"5 pm", @"5 pm");
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self createUserActivity];
    [self.userActivity becomeCurrent];
}

@end
