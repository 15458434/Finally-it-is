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
    BOOL isHetAlWeekend = _dayController.isHetAlWeekend;
    if (isHetAlWeekend) {
        _isHetAlWeekendLabel.textColor = [NSColor greenColor];
        _isHetAlWeekendLabel.stringValue = @"YES";
    } else {
        _isHetAlWeekendLabel.textColor = [NSColor redColor];
        _isHetAlWeekendLabel.stringValue = @"NO";
    }
}

#pragma mark - NSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _dayController = [[DayController alloc] init];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self update];
}

@end
