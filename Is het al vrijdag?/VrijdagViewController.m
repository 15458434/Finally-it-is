//
//  ViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "VrijdagViewController.h"
#import "DayController.h"

@interface VrijdagViewController ()

@property (nonatomic, weak) IBOutlet NSTextField *isHetAlVrijdagLabel;

@property (nonatomic, strong) DayController *dayController;

@end

@implementation VrijdagViewController

#pragma mark - New in this class

- (void)update
{
    BOOL isHetAlVrijdag = _dayController.isHetAlVrijdag;
    if (isHetAlVrijdag) {
        _isHetAlVrijdagLabel.textColor = [NSColor greenColor];
        _isHetAlVrijdagLabel.stringValue = @"JA";
    } else {
        _isHetAlVrijdagLabel.textColor = [NSColor redColor];
        _isHetAlVrijdagLabel.stringValue = @"NEE";
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
    activity.title = @"Is het al vrijdag";
    activity.keywords = [NSSet setWithArray:@[@"is", @"het", @"al", @"vrijdag"]];
    activity.userInfo = @{@"state": _isHetAlVrijdagLabel.stringValue};
    activity.eligibleForSearch = YES;
    activity.eligibleForPublicIndexing = YES;
    self.userActivity = activity;
    [self.userActivity becomeCurrent];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
