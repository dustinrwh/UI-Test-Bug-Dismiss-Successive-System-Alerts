//
//  ViewController.m
//  UI Test Dismiss System Alerts
//
//  Created by Dustin Hill on 2/11/16.
//  Copyright © 2016 Dustin Hill. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (strong, nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UILabel *notificationLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self notificationAlertAlreadyShown];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)initiateSystemAlertsPressed:(UIButton *)sender {
    [self askToAllowNotifications];
    [self askToAllowUserLocation];
}

- (IBAction)showNotificationPressed:(UIButton *)sender {
    [self askToAllowNotifications];
}

- (IBAction)showLocationPressed:(UIButton *)sender {
    [self askToAllowUserLocation];
}

- (void)askToAllowNotifications {
    UIUserNotificationType types = UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    
    self.notificationLabel.text = @"Notification alert shown. Must delete & rebuild.";
}

- (void)askToAllowUserLocation {
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.locationLabel.text = @"Location alert shown. Must delete & rebuild.";
}

- (BOOL)notificationAlertAlreadyShown {
    UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (settings.types & UIUserNotificationTypeAlert) {
        self.notificationLabel.text = @"Notification alert shown. Must delete & rebuild.";
        return true;
    } else {
        return false;
    }
}

- (IBAction)donePressed:(id)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Test done!" message:@"The test was successfully completed" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *close = [UIAlertAction actionWithTitle:@"Yay!" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:close];
    [self presentViewController:alert animated:YES completion:nil];
}


@end
