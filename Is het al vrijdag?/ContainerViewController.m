//
//  ContainerViewController.m
//  Is het al vrijdag?
//
//  Created by Mark Cornelisse on 05/08/16.
//  Copyright © 2016 Over de muur producties. All rights reserved.
//

#import "ContainerViewController.h"

@interface ContainerViewController ()

@property (weak) IBOutlet NSVisualEffectView *visualEffectView;

@property (nonatomic, strong) NSLayoutConstraint *topConstraint;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.
    
    // TODO: Set constraint for top to title bar.
    self.view.appearance = [NSAppearance appearanceNamed:NSAppearanceNameVibrantLight];
}

- (void)updateViewConstraints
{
    if (!_topConstraint) {
        NSLayoutAnchor *topAnchor = [self.view.window.contentLayoutGuide topAnchor];
        if (topAnchor) {
            _topConstraint = [self.visualEffectView.topAnchor constraintEqualToAnchor:topAnchor constant:0];
            [_topConstraint setActive:YES];
        }
    }
    [super updateViewConstraints];
}

@end
