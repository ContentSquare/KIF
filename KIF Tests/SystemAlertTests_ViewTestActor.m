//
//  NewSystemAlertTests.m
//  KIF
//
//  Created by Alex Odawa on 1/26/15.
//
//


#import <KIF/KIF.h>

@interface SystemAlertTests_ViewTestActor : KIFTestCase
@end


@implementation SystemAlertTests_ViewTestActor

+ (XCTestSuite *)defaultTestSuite
{
    // 'acknowledgeSystemAlert' can't be used on iOS7
    // The console shows a message "AX Lookup problem! 22 com.apple.iphone.axserver:-1"
    if ([UIDevice.currentDevice.systemVersion compare:@"8.0" options:NSNumericSearch] < 0) {
        return nil;
    }
    
    return [super defaultTestSuite];
}

- (void)beforeEach
{
    [[viewTester usingAccessibilityLabel:@"System Alerts"] tap];
}

- (void)afterEach
{
    [[[viewTester usingAccessibilityLabel:@"Test Suite"] usingTraits:UIAccessibilityTraitButton] tap];
}

// This cantest appears to have issues passing reliably, most likely due to other tests running before this one
- (void)DISABLED_testAuthorizingLocationServices
{
    [tester tapViewWithAccessibilityLabel:@"Location Services and Notifications"];
    XCTAssertTrue([viewTester acknowledgeSystemAlert]);
    XCTAssertTrue([viewTester acknowledgeSystemAlert]);
    XCTAssertFalse([viewTester acknowledgeSystemAlert]);
}

- (void)testAuthorizingPhotosAccess
{
    [[viewTester usingAccessibilityLabel:@"Photos"] tap];
    [viewTester acknowledgeSystemAlert];
    [[viewTester usingAccessibilityLabel:@"Cancel"] tap];
}

@end