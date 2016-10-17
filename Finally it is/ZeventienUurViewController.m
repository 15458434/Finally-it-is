//
//  ZeventienUurViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 29/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "ZeventienUurViewController.h"
#import "EventStateController.h"

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
