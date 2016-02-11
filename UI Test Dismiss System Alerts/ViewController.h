//
//  ViewController.h
//  UI Test Dismiss System Alerts
//
//  Created by Dustin Hill on 2/11/16.
//  Copyright © 2016 Dustin Hill. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface ViewController : UIViewController <CLLocationManagerDelegate>

- (BOOL)notificationAlertAlreadyShown;

@end

