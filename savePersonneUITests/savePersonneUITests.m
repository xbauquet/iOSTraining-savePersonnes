//
//  savePersonneUITests.m
//  savePersonneUITests
//
//  Created by xavier on 16/02/2016.
//  Copyright © 2016 xavier. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface savePersonneUITests : XCTestCase

@end

@implementation savePersonneUITests

- (void)setUp {
    [super setUp];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    // In UI tests it is usually best to stop immediately when a failure occurs.
    self.continueAfterFailure = NO;
    // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
    [[[XCUIApplication alloc] init] launch];
    
    // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
    XCUIApplication *app = [[XCUIApplication alloc] init];
    [app.navigationBars[@"List"].buttons[@"Add"] tap];
    
    XCUIElement *lastNameTextField = app.textFields[@"Last Name"];
    [lastNameTextField tap];
    [lastNameTextField typeText:@"selon"];
    
    XCUIElement *firstNameTextField = app.textFields[@"First Name"];
    [firstNameTextField tap];
    [firstNameTextField typeText:@"selon"];
    [[[[[[[[[[[[[[[[[app childrenMatchingType:XCUIElementTypeWindow] elementBoundByIndex:0] childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther].element childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeOther] elementBoundByIndex:1] childrenMatchingType:XCUIElementTypeSwitch] matchingIdentifier:@"0"] elementBoundByIndex:0] tap];
    [app.navigationBars[@"Form"].buttons[@"Save"] tap];
    [app.navigationBars[@"Display"].buttons[@"Form"] tap];
    [app.navigationBars[@"Form"].buttons[@"List"] tap];
    
}

@end
