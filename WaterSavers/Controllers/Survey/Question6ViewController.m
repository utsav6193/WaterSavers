//
//  Question6ViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/7/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "Question6ViewController.h"
#import "Question7ViewController.h"
#import "Constant.h"

@interface Question6ViewController ()

@end

@implementation Question6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"6";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setSideMenuBarButtonItem];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    pickerData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", nil];
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
    [CommonMethods displayAlertwithTitle:AppName withMessage:@"On an average, a person uses the flush 5-8 times a day." withViewController:self];
}

-(IBAction)btnNext:(id)sender
{
    NSString *title = [picker.delegate pickerView:picker titleForRow:[picker selectedRowInComponent:0] forComponent:0];
    [appDel.dictResults setObject:title forKey:@"flush_frequency"];
    Question7ViewController *viewController = [[Question7ViewController alloc] initWithNibName:@"Question7ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

-(IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
