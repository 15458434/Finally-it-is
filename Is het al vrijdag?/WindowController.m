//
//  WindowController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 05/08/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "WindowController.h"

@interface WindowController ()

@end

@implementation WindowController

- (void)windowDidLoad {
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    self.window.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
}

@end
