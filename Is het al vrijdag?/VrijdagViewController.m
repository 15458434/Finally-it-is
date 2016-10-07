//
//  VrijdagViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "VrijdagViewController.h"
#import "EventStateController.h"

@interface VrijdagViewController ()

@end

@implementation VrijdagViewController

#pragma mark - New in this class

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al vrijdag";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"vrijdag"]];
        activity.userInfo = @{@"state": self.isHetAlLabel.stringValue};
        activity.eligibleForHandoff = NO;
        activity.eligibleForSearch = YES;
        activity.eligibleForPublicIndexing = YES;
        self.userActivity = activity;    }
}

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.dayController = [[EventStateController alloc] initWithType:DayControllerTypeFriday];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self createUserActivity];
    [self.userActivity becomeCurrent];
}

@end
