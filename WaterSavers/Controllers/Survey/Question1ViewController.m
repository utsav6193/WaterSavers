//
//  Question1ViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/7/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "Question1ViewController.h"
#import "Question2ViewController.h"
#import "Constant.h"

@interface Question1ViewController ()

@end

@implementation Question1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"1";
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self setSideMenuBarButtonItem];
    [appDel.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    pickerData = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", nil];
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
}

- (void)btnLeftMenuClicked:(id)sender {
    [appDel.drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

-(IBAction)btnNext:(id)sender
{
    NSString *title = [picker.delegate pickerView:picker titleForRow:[picker selectedRowInComponent:0] forComponent:0];
    [appDel.dictResults setObject:title forKey:@"family_size"];
    Question2ViewController *viewController = [[Question2ViewController alloc] initWithNibName:@"Question2ViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}

@end
