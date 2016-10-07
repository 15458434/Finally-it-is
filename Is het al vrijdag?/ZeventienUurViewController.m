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

@property (nonatomic, weak) IBOutlet NSTextField *isHetAlZeventienUurLabel;

@property (nonatomic, strong) EventStateController *dayController;

@end

@implementation ZeventienUurViewController

#pragma mark - New in this class

- (void)update
{
    BOOL isHetAlZeventienUur = _dayController.isHetAl;
    if (isHetAlZeventienUur) {
        _isHetAlZeventienUurLabel.textColor = [NSColor greenColor];
        _isHetAlZeventienUurLabel.stringValue = @"JA";
    } else {
        _isHetAlZeventienUurLabel.textColor = [NSColor redColor];
        _isHetAlZeventienUurLabel.stringValue = @"NEE";
    }
}

- (void)createUserActivity
{
    NSOperatingSystemVersion elCapitan = (NSOperatingSystemVersion){10, 11, 0};
    if ([[NSProcessInfo processInfo] isOperatingSystemAtLeastVersion:elCapitan]) {
        NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
        activity.title = @"Is het al Zeventien uur";
        activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"zeventien", @"vijf", @"uur"]];
        activity.userInfo = @{@"state" : _isHetAlZeventienUurLabel.stringValue};
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
    self.view.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    
    _dayController = [[EventStateController alloc] initWithType:DayControllerTypeSeventeenHour];
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
