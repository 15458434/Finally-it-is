//
//  AppDelegate.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 28/06/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (IBAction)bringAllToFrontPressed:(id)sender
{
    NSApplication *sharedApplication = [NSApplication sharedApplication];
    if (sharedApplication.windows.count == 0) {
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        NSWindowController *windowController = [storyboard instantiateControllerWithIdentifier:@"WindowController"];
        [windowController showWindow:self];
    } else {
        if (sharedApplication.mainWindow) {
            [sharedApplication.mainWindow makeKeyAndOrderFront:self];
        } else if (sharedApplication.windows.firstObject) {
            [sharedApplication.windows.firstObject makeKeyAndOrderFront:self];
        }
    }
}


#pragma mark - NSApplicationDelegate

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag
{
    if (sender.windows.count == 0) {
        NSStoryboard *storyboard = [NSStoryboard storyboardWithName:@"Main" bundle:nil];
        NSWindowController *windowController = [storyboard instantiateControllerWithIdentifier:@"WindowController"];
        [windowController showWindow:self];
        return YES;
    } else {
        if (sender.mainWindow) {
            [sender.mainWindow makeKeyAndOrderFront:self];
            return YES;
        } else if (sender.windows.firstObject) {
            [sender.windows.firstObject makeKeyAndOrderFront:self];
            return YES;
        }
    }
    return NO;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



@end
