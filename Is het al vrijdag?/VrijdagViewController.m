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

@property (nonatomic, weak) IBOutlet NSTextField *isHetAlVrijdagLabel;

@property (nonatomic, strong) EventStateController *dayController;

@end

@implementation VrijdagViewController

#pragma mark - New in this class

- (void)update
{
    BOOL isHetAlVrijdag = _dayController.isHetAl;
    if (isHetAlVrijdag) {
        _isHetAlVrijdagLabel.textColor = [NSColor greenColor];
        _isHetAlVrijdagLabel.stringValue = @"JA";
    } else {
        _isHetAlVrijdagLabel.textColor = [NSColor redColor];
        _isHetAlVrijdagLabel.stringValue = @"NEE";
    }
}

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al vrijdag";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"vrijdag"]];
        activity.userInfo = @{@"state": _isHetAlVrijdagLabel.stringValue};
        activity.eligibleForHandoff = NO;
        activity.eligibleForSearch = YES;
        activity.eligibleForPublicIndexing = YES;
        self.userActivity = activity;    }
}

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    _dayController = [[EventStateController alloc] initWithType:DayControllerTypeFriday];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self update];
    
    [self createUserActivity];
    [self.userActivity becomeCurrent];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
