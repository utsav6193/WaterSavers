//
//  MapViewController.h
//  WaterSavers
//
//  Created by Utsav Parikh on 10/7/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapViewController : UIViewController
{
    NSMutableArray *arrayLeaders;
}

@property (nonatomic, strong) IBOutlet MKMapView *mapView;


@end
