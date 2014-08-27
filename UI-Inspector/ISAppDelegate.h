//
//  ISAppDelegate.h
//  UI-Inspector
//
//  Created by James Thompson on 8/26/14.
//  Copyright (c) 2014 IntelligentSprite. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "ISLayerViewController.h"

@interface ISAppDelegate : NSObject <NSApplicationDelegate>

@property (weak) IBOutlet NSWindow *window;
@property (strong) IBOutlet ISLayerViewController *layerViewController;

@end
