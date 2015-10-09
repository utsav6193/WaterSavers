//
//  HomeViewController.h
//  Water Savers
//
//  Created by Utsav Parikh on 10/4/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface HomeViewController : UIViewController<CLLocationManagerDelegate>
{
    IBOutlet UITextField *txtUsername;
    IBOutlet UITextField *txtPassword;
    CLLocationManager *locationManager;
}
@end
