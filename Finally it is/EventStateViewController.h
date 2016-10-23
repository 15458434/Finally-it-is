//
//  EventStateViewController.h
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 07/10/2016.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

@import Cocoa;

@class EventStateController;
@class NotificationScheduler;

@interface EventStateViewController : NSViewController

@property (weak) IBOutlet NSTextField *isHetAlLabel;

@property (strong) EventStateController *dayController;
@property (readonly) NotificationScheduler *notificationScheduler;

- (void)updateNow;
- (void)updateOnAllNextChangeEvents;

@end
