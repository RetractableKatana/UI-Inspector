//
//  UI_InspectorTests.m
//  UI-InspectorTests
//
//  Created by James Thompson on 8/26/14.
//  Copyright (c) 2014 IntelligentSprite. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ISAppDelegate.h"

@interface UI_InspectorTests : XCTestCase

@property (nonatomic, weak) ISAppDelegate *appDelegate;

@end


@implementation UI_InspectorTests

- (void)setUp
{
    [super setUp];
    self.appDelegate = [[NSApplication sharedApplication] delegate];
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAppHasDelegate
{
    XCTAssertNotNil(self.appDelegate, @"There should be an AppDelegate");
}

- (void)testAppDelegateClass
{
    XCTAssertEqualObjects([self.appDelegate class], [ISAppDelegate class], @"AppDelegate should be of type ISAppDelegate.");
}

- (void)testAppDelegateHasLayerMenu
{
    XCTAssertNotNil([[NSApplication sharedApplication] mainMenu], @"Application should have a mainMenu");
}

@end
