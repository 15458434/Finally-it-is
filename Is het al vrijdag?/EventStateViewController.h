//
//  EventStateViewController.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import Cocoa;

@class EventStateController;

@interface EventStateViewController : NSViewController

@property (weak) IBOutlet NSTextField *isHetAlLabel;

@property (strong) EventStateController *dayController;

- (void)updateNow;
- (void)updateOnAllNextChangeEvents;

@end
