//
//  HomeViewController.m
//  Water Savers
//
//  Created by Utsav Parikh on 10/4/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "HomeViewController.h"
#import "SignUpViewController.h"
#import "CommonMethods.h"
#import "SurveyViewController.h"
#import "Constant.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([CLLocationManager locationServicesEnabled]) {
        if (!locationManager) {
            locationManager = [[CLLocationManager alloc] init];
            locationManager.delegate = self;
        }
        // Check for iOS 8. Without this guard the code will crash with "unknown selector" on iOS 7.
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])
            [locationManager requestWhenInUseAuthorization];
        
        [locationManager startUpdatingLocation];
    }
    else {
        appDel.strLatitude = @"32.7150";
        appDel.strLongitude = @"-117.1625";
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"username"] isEqualToString:@""])
        txtUsername.text = @"";
    else
        txtUsername.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"username"];
    
    if([[[NSUserDefaults standardUserDefaults] valueForKey:@"password"] isEqualToString:@""])
        txtPassword.text = @"";
    else
        txtPassword.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeNone];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

#pragma mark - UIButton Action Methods

-(IBAction)btnLoginAction:(id)sender
{
    [self.view endEditing:YES];
    if([self validate])
        [self callLoginAPI];
}

#pragma mark - Validation Methods

-(BOOL)validate
{
    if ([CommonMethods isObjectEmpty:txtUsername.text])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter the username." withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:txtPassword.text])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter the password." withViewController:self andCompletion:nil];
        return NO;
    }
    else
         return YES;

}

#pragma mark - Registration API

-(IBAction)btnRegister:(id)sender
{
    SignUpViewController *controller = [[SignUpViewController alloc] initWithNibName:@"SignUpViewController" bundle:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Login API

-(void)callLoginAPI
{
    [CommonMethods showGlobalHUDWithTitle:HUDTitle];
    NSString *strUserName  = [txtUsername.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strPassword  = [txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@/%@/%@",LOGIN_URL,strUserName,strPassword] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
        [CommonMethods hideGlobalHUD];
        if ([[dict valueForKey:@"status"] boolValue])
        {
            [[NSUserDefaults standardUserDefaults] setObject:strUserName forKey:@"username"];
            [[NSUserDefaults standardUserDefaults] setObject:strPassword forKey:@"password"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            appDel.dictUser = [dict mutableCopy];
            SurveyViewController *viewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
            [self.navigationController pushViewController:viewController animated:YES];
        }
        else
        {
            [CommonMethods displayAlertwithTitle:AppName withMessage:[dict valueForKey:@"message"] withViewController:self andCompletion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonMethods hideGlobalHUD];
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - Location Manager Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    CLLocation *location = [locations lastObject];
    if (location != nil) {
        appDel.strLatitude  = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.latitude];
        appDel.strLongitude = [NSString stringWithFormat:@"%f", locationManager.location.coordinate.longitude];
    }
    [manager stopUpdatingLocation];
    [locationManager stopUpdatingLocation];
}


- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Error = %@", error.localizedDescription);
    appDel.strLatitude = @"32.7150";
    appDel.strLongitude = @"-117.1625";
}

@end
