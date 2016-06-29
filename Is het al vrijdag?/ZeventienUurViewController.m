//
//  ZeventienUurViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 29/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "ZeventienUurViewController.h"
#import "DayController.h"

@interface ZeventienUurViewController ()

@property (nonatomic, weak) IBOutlet NSTextField *isHetAlZeventienUurLabel;

@property (nonatomic, strong) DayController *dayController;

@end

@implementation ZeventienUurViewController

#pragma mark - New in this class

- (void)update
{
    BOOL isHetAlZeventienUur = _dayController.isHetAlZeventienUur;
    if (isHetAlZeventienUur) {
        _isHetAlZeventienUurLabel.textColor = [NSColor greenColor];
        _isHetAlZeventienUurLabel.stringValue = @"YES";
    } else {
        _isHetAlZeventienUurLabel.textColor = [NSColor redColor];
        _isHetAlZeventienUurLabel.stringValue = @"NO";
    }
}

#pragma mark - NSViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    _dayController = [[DayController alloc] init];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self update];
    
    NSUserActivity *activity = [[NSUserActivity alloc] initWithActivityType:@"com.greenhair.ishetal.observe"];
    activity.title = @"Is het al Zeventien uur";
    activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"zeventien", @"vijf", @"uur"]];
    activity.userInfo = @{@"state" : _isHetAlZeventienUurLabel.stringValue};
    activity.eligibleForSearch = YES;
    self.userActivity = activity;
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];
    
    // Update the view, if already loaded.
}

@end
