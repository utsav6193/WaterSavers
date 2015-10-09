//
//  MapViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/7/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "MapViewController.h"
#include "Constant.h"

@interface MapViewController ()

@end

@implementation MapViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Map Me";
    arrayLeaders = [[NSMutableArray alloc] init];
    [self setSideMenuBarButtonItem];
    [self callLeaderBoardAPI];
    CLLocationDegrees latis = [[appDel.dictUser valueForKey:@"latitude"] doubleValue];
    CLLocationDegrees longis = [[appDel.dictUser valueForKey:@"longitude"] doubleValue];
    CLLocation *locationValues = [[CLLocation alloc] initWithLatitude:latis longitude:longis];
    
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(locationValues.coordinate, 800, 800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set up Navibar BarButtonItem

- (void)setSideMenuBarButtonItem {
    UIImage *sideImage = [UIImage imageNamed:@"menu-icon"];
    UIButton *btnSideMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSideMenu setImage:sideImage forState:UIControlStateNormal];
    [btnSideMenu setImage:sideImage forState:UIControlStateHighlighted];
    [btnSideMenu setFrame:CGRectMake(0, 0, sideImage.size.width, sideImage.size.height)];
    [btnSideMenu addTarget:self action:@selector(btnLeftMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sideMenuItem = [[UIBarButtonItem alloc] initWithCustomView:btnSideMenu];
    self.navigationItem.leftBarButtonItem = sideMenuItem;
}

- (void)btnLeftMenuClicked:(id)sender {
    [appDel.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

#pragma mark - LeaderBoard API

-(void)callLeaderBoardAPI
{
    [CommonMethods showGlobalHUDWithTitle:HUDTitle];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@",LEADERBOARD_URL] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
        [CommonMethods hideGlobalHUD];
        if (![[dict valueForKey:@"error"] boolValue])
        {
            arrayLeaders = [dict valueForKey:@"result"];
            [self createAnnotations];
        }
        else
        {
            [CommonMethods displayAlertwithTitle:AppName withMessage:[dict valueForKey:@"message"] withViewController:self andCompletion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonMethods hideGlobalHUD];
        NSLog(@"Error: %@", error);
        [CommonMethods displayAlertwithTitle:AppName withMessage:[NSString stringWithFormat:@"%@",error] withViewController:self andCompletion:nil];
    }];
}

#pragma mark - Map Annotations

-(void)createAnnotations
{
    for(int i = 0; i < [arrayLeaders count] ; i++)
    {
        CLLocationDegrees lati = [[[arrayLeaders objectAtIndex:i] valueForKey:@"latitude"] doubleValue];
        CLLocationDegrees longi = [[[arrayLeaders objectAtIndex:i] valueForKey:@"longitude"] doubleValue];
        
        CLLocation *locationValue = [[CLLocation alloc] initWithLatitude:lati longitude:longi];
        
        // Add an annotation
        MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
        
        point.coordinate = locationValue.coordinate;
        NSString *strUsername = [NSString stringWithFormat:@"%@ %@", [[arrayLeaders objectAtIndex:i] valueForKey:@"first_name"], [[arrayLeaders objectAtIndex:i] valueForKey:@"last_name"]];
        point.title = strUsername;
        point.subtitle = [NSString stringWithFormat:@"Score : %@", [[arrayLeaders objectAtIndex:i] valueForKey:@"user_score"]];
        [self.mapView addAnnotation:point];
    }
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{

    MKAnnotationView *annView=[[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
    NSString *strFullName = [NSString stringWithFormat:@"%@ %@", [appDel.dictUser valueForKey:@"first_name"], [appDel.dictUser valueForKey:@"last_name"]];
    if([[annotation title] isEqualToString:strFullName])
        annView.image = [UIImage imageNamed:@"pin2"];
    else
        annView.image = [UIImage imageNamed:@"pin1"];
    annView.canShowCallout = YES;
    return annView;
}

@end
