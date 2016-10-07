//
//  EventStateViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "EventStateViewController.h"
#import "EventStateController+EventChangeHandling.h"

#import "DebugLog.h"

@interface EventStateViewController ()

@end

@implementation EventStateViewController

- (void)updateNow
{
    BOOL isHetAl = _dayController.isHetAl;
    if (isHetAl) {
        _isHetAlLabel.textColor = [NSColor greenColor];
        _isHetAlLabel.stringValue = @"JA";
    } else {
        _isHetAlLabel.textColor = [NSColor redColor];
        _isHetAlLabel.stringValue = @"NEE";
    }
}

- (void)updateOnAllNextChangeEvents
{
    __weak typeof(self) weakSelf = self;
    [self.dayController executeOnStateChange:^{
        [weakSelf updateNow];
    }];
}

#pragma mark - NSNotification

- (void)applicationDidBecomeActive:(NSNotification *)sender
{
    [self updateNow];
}

- (void)applicationDidUnhide:(NSNotification *)sender
{
    [self updateNow];
}

#pragma mark - NSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.view.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
    
    [self updateOnAllNextChangeEvents];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:) name:NSApplicationDidBecomeActiveNotification object:[NSApplication sharedApplication]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidUnhide:) name:NSApplicationDidUnhideNotification object:[NSApplication sharedApplication]];
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    
    [self updateNow];
}

@end
