//
//  ISAppDelegate.m
//  UI-Inspector
//
//  Created by James Thompson on 8/26/14.
//  Copyright (c) 2014 IntelligentSprite. All rights reserved.
//

#import "ISAppDelegate.h"

@implementation ISAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    self.layerViewController = [[ISLayerViewController alloc] initWithNibName:nil bundle:nil];
    self.window.contentView = self.layerViewController.view;
}

@end
