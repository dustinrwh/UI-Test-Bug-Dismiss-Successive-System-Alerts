//
//  UI_Test_Dismiss_System_AlertsUITests.m
//  UI Test Dismiss System AlertsUITests
//
//  Created by Dustin Hill on 2/11/16.
//  Copyright © 2016 Dustin Hill. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface UI_Test_Dismiss_System_AlertsUITests : XCTestCase

@property (strong, nonatomic) XCUIApplication *app;

@end

@implementation UI_Test_Dismiss_System_AlertsUITests

- (void)setUp {
    [super setUp];
    self.continueAfterFailure = NO;
    _app = [[XCUIApplication alloc] init];
    [_app launch];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSuccessiveSystemAlerts {
    // FAILS
    // Make sure the app was deleted before running.
    XCUIElement *notificationLabel = _app.staticTexts[@"notificationLabel"];
    NSString *label =notificationLabel.label;
    XCTAssert([label isEqualToString:@"Notification alert not shown."]); // If it fails here you need to delete the app and run again.
    
    XCUIElement *initiateButton = _app.buttons[@"initiateSystemAlerts"];
    [initiateButton tap];
    
    [_app tap];
    
    XCUIElement *doneButton = _app.buttons[@"done"];
    [doneButton tap];
    
    [_app tap];
    
    XCUIElement *alert = _app.alerts[@"Test done!"];
    XCUIElement *closeButton = alert.buttons[@"Yay!"];
    [closeButton tap];
}

- (void)testSuccessiveSystemAlertsWithInterruptionHandler {
    // FAILS
    // Make sure the app was deleted before running.
    XCUIElement *notificationLabel = _app.staticTexts[@"notificationLabel"];
    NSString *label =notificationLabel.label;
    XCTAssert([label isEqualToString:@"Notification alert not shown."]); // If it fails here you need to delete the app and run again.
    
    [self addUIInterruptionMonitorWithDescription:@"System Alert Handler" handler:^BOOL(XCUIElement *alert) {
        XCUIElement *allowButton = alert.buttons[@"Allow"];
        if (allowButton.exists) {
            [allowButton tap];
            return true;
        }
        
        XCUIElement *okButton = alert.buttons[@"OK"];
        if (okButton.exists) {
            [okButton tap];
            return true;
        }
        
        return true;
    }];
    
    XCUIElement *initiateButton = _app.buttons[@"initiateSystemAlerts"];
    [initiateButton tap];
    
    [_app tap];
    
    XCUIElement *doneButton = _app.buttons[@"done"];
    [doneButton tap];
    
    [_app tap];
    
    [doneButton tap];
    
    XCUIElement *alert = _app.alerts[@"Test done!"];
    XCUIElement *closeButton = alert.buttons[@"Yay!"];
    [closeButton tap];
}

- (void)testSuccessiveSystemAlertsWithTwoInterruptionHandlers {
    // FAILS
    // Make sure the app was deleted before running.
    XCUIElement *notificationLabel = _app.staticTexts[@"notificationLabel"];
    NSString *label =notificationLabel.label;
    XCTAssert([label isEqualToString:@"Notification alert not shown."]); // If it fails here you need to delete the app and run again.
    
    // The InterruptionMonitor gets called twice (in reverse order). It seems that you can only do one at a time.
    [self addUIInterruptionMonitorWithDescription:@"System Alert Handler 1" handler:^BOOL(XCUIElement *alert) {
        XCUIElement *allowButton = alert.buttons[@"Allow"];
        if (allowButton.exists) {
            [allowButton tap];
            return false;
        }
        
        XCUIElement *okButton = alert.buttons[@"OK"];
        if (okButton.exists) {
            [okButton tap];
            return false;
        }
        
        return false;
    }];
    
    [self addUIInterruptionMonitorWithDescription:@"System Alert Handler 2" handler:^BOOL(XCUIElement *alert) {
        XCUIElement *allowButton = alert.buttons[@"Allow"];
        if (allowButton.exists) {
            [allowButton tap];
            return false;
        }
        
        XCUIElement *okButton = alert.buttons[@"OK"];
        if (okButton.exists) {
            [okButton tap];
            return false;
        }
        
        return false;
    }];
    
    XCUIElement *initiateButton = _app.buttons[@"initiateSystemAlerts"];
    [initiateButton tap];
    
    [_app tap];
    
    XCUIElement *doneButton = _app.buttons[@"done"];
    [doneButton tap];
    
    [_app tap];
    
    [doneButton tap];
    
    XCUIElement *alert = _app.alerts[@"Test done!"];
    XCUIElement *closeButton = alert.buttons[@"Yay!"];
    [closeButton tap];
}

- (void)testOneByOneSystemAlerts {
    // PASSES
    XCUIElement *notificationLabel = _app.staticTexts[@"notificationLabel"];
    NSString *label =notificationLabel.label;
    XCTAssert([label isEqualToString:@"Notification alert not shown."]); // If it fails here you need to delete the app and run again.
    
    XCUIElement *notificationButton = _app.buttons[@"notificationButton"];
    [notificationButton tap];
    
    [_app tap];
    
    XCUIElement *locationButton = _app.buttons[@"locationButton"];
    [locationButton tap];
    
    [_app tap];
    
    XCUIElement *doneButton = _app.buttons[@"done"];
    [doneButton tap];
    
    XCUIElement *alert = _app.alerts[@"Test done!"];
    XCUIElement *closeButton = alert.buttons[@"Yay!"];
    [closeButton tap];
}

@end
