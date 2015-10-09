//
//  Question3ViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/6/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "Question3ViewController.h"
#import "Question4ViewController.h"
#import "Constant.h"

@interface Question3ViewController ()

@end

@implementation Question3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"3";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setSideMenuBarButtonItem];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    pickerData = [NSArray arrayWithObjects:@"5", @"10", @"15", @"20", @"25", @"30", @"35", @"40", @"45", @"50", nil];
    picker.layer.borderColor = [UIColor whiteColor].CGColor;
    picker.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return (int)pickerData.count;
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
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
    
    UIImage *sideImage1 = [UIImage imageNamed:@"hint"];
    UIButton *btnSideMenu1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSideMenu1 setImage:sideImage1 forState:UIControlStateNormal];
    [btnSideMenu1 setImage:sideImage1 forState:UIControlStateHighlighted];
    [btnSideMenu1 setFrame:CGRectMake(0, 0, sideImage1.size.width, sideImage1.size.height)];
    [btnSideMenu1 addTarget:self action:@selector(btnRightMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *sideMenuItem1 = [[UIBarButtonItem alloc] initWithCustomView:btnSideMenu1];
    self.navigationItem.rightBarButtonItem = sideMenuItem1;
}

- (void)btnLeftMenuClicked:(id)sender {
    [appDel.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)btnRightMenuClicked:(id)sender {
    [CommonMethods displayAlertwithTitle:AppName withMessage:@"On an average, a person takes a shower for 10 minutes." withViewController:self];
}

-(IBAction)btnNext:(id)sender
{
    NSString *title = [picker.delegate pickerView:picker titleForRow:[picker selectedRowInComponent:0] forComponent:0];
    [appDel.dictResults setObject:title forKey:@"shower_length"];
    Question4ViewController *viewController = [[Question4ViewController alloc] initWithNibName:@"Question4ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
