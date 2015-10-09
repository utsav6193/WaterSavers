//
//  MenuViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/6/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "MenuViewController.h"
#import "CommonMethods.h"
#import "AppDelegate.h"
#import "SurveyViewController.h"
#import "LeaderBoardViewController.h"
#import "TipsViewController.h"
#import "MapViewController.h"
#import "GoalsViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = NAVIBARCOLOR;
    tblMenu.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    NSDictionary *dict1, *dict2, *dict3, *dict4, *dict5, *dict6;
    
    lblUserName.font = kProximaNovaRegularFont(20);
    lblUserName.textColor = kWhiteColor;
    dict1 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"My Usage", @"name",
             @"icon1", @"image", nil];
    dict2 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"LeaderBoard", @"name",
             @"icon2", @"image", nil];
    dict3 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"Map Me", @"name",
             @"icon3", @"image", nil];
    dict4 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"My Goals", @"name",
             @"icon5", @"image", nil];
    dict5 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"My Tips", @"name",
             @"icon6", @"image", nil];
    dict6 = [NSDictionary dictionaryWithObjectsAndKeys:
             @"LOGOUT", @"name",
             @"logout-btn", @"image", nil];
    
    arrMenu = [NSArray arrayWithObjects:dict1, dict2, dict3, dict4, dict5, dict6, nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSString *strFullName = [NSString stringWithFormat:@"%@ %@",[appDel.dictUser valueForKey:@"first_name"], [appDel.dictUser valueForKey:@"last_name"]];
    lblUserName.text = strFullName;
}
#pragma mark - Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableview Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrMenu count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UILabel *lblMenu = nil;
    UIImageView *imvIcon = nil;
    UIView *viewSep = nil;
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        lblMenu = [[UILabel alloc] init];
        lblMenu.frame = CGRectMake(40, 11, 200, 25);
        lblMenu.font = kCustomFont(kProximaNovaRegular, 17.0f);
        lblMenu.textColor = [UIColor whiteColor];
        lblMenu.textAlignment = NSTextAlignmentLeft;
        lblMenu.tag = 1001;
        
        viewSep = [[UIView alloc] init];
        viewSep.frame = CGRectMake(0, 49, tblMenu.frame.size.width, 0.5);
        viewSep.backgroundColor = [UIColor whiteColor];

        imvIcon = [[UIImageView alloc] init];
        if (indexPath.row == 5)
            imvIcon.frame = CGRectMake(13, 8, 25, 25);
        else
            imvIcon.frame = CGRectMake(10, 8, 25, 25);
        imvIcon.tag = 2001;
        imvIcon.backgroundColor = [UIColor clearColor];
        imvIcon.contentMode = UIViewContentModeScaleAspectFit;
        [cell.contentView addSubview:lblMenu];
        [cell.contentView addSubview:imvIcon];
        [cell.contentView addSubview:viewSep];

        cell.backgroundColor = [UIColor clearColor];
    }
    else {
        lblMenu = (UILabel *)[cell.contentView viewWithTag:1001];
    }
    
    if (indexPath.row == [arrMenu count] - 1) {
        [lblMenu setHidden:YES];
        [imvIcon setHidden:YES];
        [viewSep setHidden:YES];
        UIButton *btnLogout = [UIButton buttonWithType:UIButtonTypeCustom];
        btnLogout.frame = CGRectMake(15, 20, 250, 40);
        btnLogout.layer.cornerRadius = 7.0f;
        btnLogout.layer.masksToBounds = YES;
        
        btnLogout.titleLabel.font = kProximaNovaRegularFont(16);
        btnLogout.backgroundColor = [UIColor clearColor];
        btnLogout.layer.borderColor = [UIColor whiteColor].CGColor;
        btnLogout.layer.borderWidth = 1.0f;

        [btnLogout setTitle:@" LOGOUT" forState:UIControlStateNormal];
        [btnLogout setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -5, 0)];
        [btnLogout setImageEdgeInsets:UIEdgeInsetsMake(0, -5, 0, 0)];
        
        [btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnLogout addTarget:self action:@selector(btnLogoutAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:btnLogout];
        cell.separatorInset = UIEdgeInsetsMake(0.f, cell.bounds.size.width, 0.f, 0.f);
    }
    else {
        [lblMenu setHidden:NO];
        [imvIcon setHidden:NO];
        
        NSDictionary *dictData = [arrMenu objectAtIndex:indexPath.row];
        lblMenu.text = [dictData objectForKey:@"name"];
        UIImage *image = [UIImage imageNamed:[dictData objectForKey:@"image"]];
        imvIcon.image = image;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableview Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == [arrMenu count] - 1)
        return 80.0;
    
    return 50.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
    
        case 0: {
            // Survey
            SurveyViewController *viewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
            [self setCenterViewController:viewController];
            return;
        }
            break;
            
        case 1: {
            // Leaderboard
            LeaderBoardViewController *viewController = [[LeaderBoardViewController alloc] initWithNibName:@"LeaderBoardViewController" bundle:nil];
            [self setCenterViewController:viewController];
            return;
        }
            break;
       
        case 2: {
            // Map Me
            MapViewController *viewController = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
            [self setCenterViewController:viewController];
            return;
        }
            break;
            
        case 3: {
            // Goals
            GoalsViewController *viewController = [[GoalsViewController alloc] initWithNibName:@"GoalsViewController" bundle:nil];
            [self setCenterViewController:viewController];
            return;
        }
            break;
            
        case 4: {
            // Tips
            TipsViewController *viewController = [[TipsViewController alloc] initWithNibName:@"TipsViewController" bundle:nil];
            [self setCenterViewController:viewController];
            return;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - UIButton Methods

- (void)btnLogoutAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:AppName message:@"Are you sure want to logout ?" delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes, I am", nil];
    [alert show];
}

- (void)setCenterViewController:(UIViewController *)viewController {
    NSArray *controllers = [NSArray arrayWithObjects:[appDel.navigationController.viewControllers objectAtIndex:0], viewController, nil];
    appDel.navigationController.viewControllers = controllers;
    
    [appDel.drawerController setCenterViewController:appDel.navigationController withCloseAnimation:YES completion:nil];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"password"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
        [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
        [appDel.drawerController closeDrawerAnimated:NO completion: ^(BOOL finished) {
            [appDel.navigationController popToRootViewControllerAnimated:YES];
        }];
    }
}

@end
