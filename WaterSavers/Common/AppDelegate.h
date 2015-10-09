//
//  AppDelegate.h
//  Water Savers
//
//  Created by Utsav Parikh on 10/3/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "MMExampleDrawerVisualStateManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, strong) MMDrawerController *drawerController;
@property (nonatomic, strong) NSMutableDictionary *dictResults;
@property (nonatomic, strong) NSString *strLatitude;
@property (nonatomic, strong) NSString *strLongitude;
@property (nonatomic, strong) NSMutableDictionary *dictUser;
@property (nonatomic, strong) NSMutableArray *arrayTips;
@property (nonatomic, assign) float myScore;
@property (nonatomic, assign) float myWaterUsage;




@end

