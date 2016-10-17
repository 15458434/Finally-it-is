//
//  TabViewController.m
//  Finally it is
//
//  Created by Mark Cornelisse on 17/10/2016.
//  Copyright © 2016 Mark Cornelisse. All rights reserved.
//

#import "TabViewController.h"

@interface TabViewController ()

@end

@implementation TabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    self.tabViewItems[0].label = NSLocalizedString(@"5 pm", @"5 pm");
    self.tabViewItems[1].label = NSLocalizedString(@"Friday", @"Friday");
    self.tabViewItems[2].label = NSLocalizedString(@"Weekend", @"Weekend");
}

@end
