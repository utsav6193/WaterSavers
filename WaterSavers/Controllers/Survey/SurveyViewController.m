//
//  SurveyViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/6/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "SurveyViewController.h"
#import "Question1ViewController.h"
#import "Constant.h"

@interface SurveyViewController ()

@end

@implementation SurveyViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My Usage";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setSideMenuBarButtonItem];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
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

#pragma mark - UIButton Action Methods

-(IBAction)btnStart:(id)sender
{
    Question1ViewController *viewController = [[Question1ViewController alloc] initWithNibName:@"Question1ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
