//
//  SignUpViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/4/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "SignUpViewController.h"
#import "SurveyViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "RegisterCell.h"
#import "Constant.h"

@interface SignUpViewController ()

@end

@implementation SignUpViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign Up";
    [self setSideMenuBarButtonItem];
    placeHolderArray = @[@"First Name", @"Last Name", @"Username", @"Password", @"Confirm Password", @"Email Address"];
    valuesArray = [[NSMutableArray alloc] initWithArray:@[@"",@"",@"",@"", @"", @""]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Set up Navibar BarButtonItem

- (void)setSideMenuBarButtonItem
{
    UIImage *sideImage = [UIImage imageNamed:@"back"];
    UIButton *btnSideMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnSideMenu setImage:sideImage forState:UIControlStateNormal];
    [btnSideMenu setImage:sideImage forState:UIControlStateHighlighted];
    [btnSideMenu setFrame:CGRectMake(0, 0, sideImage.size.width, sideImage.size.height)];
    [btnSideMenu addTarget:self action:@selector(btnLeftMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *sideMenuItem = [[UIBarButtonItem alloc] initWithCustomView:btnSideMenu];
    self.navigationItem.leftBarButtonItem = sideMenuItem;
    
    UIImage *doneImage = [UIImage imageNamed:@"register-arrow"];
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    [btnDone setImage:doneImage forState:UIControlStateNormal];
    [btnDone setImage:doneImage forState:UIControlStateHighlighted];
    [btnDone setFrame:CGRectMake(0, 0, doneImage.size.width, doneImage.size.height)];
    [btnDone addTarget:self action:@selector(btnRightMenuClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightSide = [[UIBarButtonItem alloc] initWithCustomView:btnDone];
    self.navigationItem.rightBarButtonItem = rightSide;
}

-(void)btnLeftMenuClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)btnRightMenuClicked:(id)sender
{
    [self.view endEditing:YES];
    if([self validate])
        [self callRegistrationAPI];
}

#pragma mark - Validation Method

-(BOOL)validate
{
    if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:0]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter First Name." withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:1]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter Last Name."withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:2]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter User Name."withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:3]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter the Password."withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:4]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please confirm the Password."withViewController:self andCompletion:nil];
        return NO;
    }
    else if (![[valuesArray objectAtIndex:3] isEqualToString:[valuesArray objectAtIndex:4]])
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Passwords does not match"withViewController:self andCompletion:nil];
        return NO;
    }
    else if ([CommonMethods isObjectEmpty:[valuesArray objectAtIndex:5]] || (![CommonMethods NSStringIsValidEmail:[valuesArray objectAtIndex:5]]))
    {
        [CommonMethods displayAlertwithTitle:AppName withMessage:@"Please enter your valid email address."withViewController:self andCompletion:nil];
        return NO;
    }
    return YES;
}

#pragma mark - UITextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string]; //this is what will happen if you return yes to this method
    [valuesArray replaceObjectAtIndex:textField.tag-10 withObject:textField.text];
    return NO;
}


#pragma mark - UITableView Datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return placeHolderArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"RegisterCell";
    
    RegisterCell *cell = (RegisterCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    cell.txtValues.placeholder = [placeHolderArray objectAtIndex:indexPath.row];
    cell.txtValues.font = kCustomFont(kProximaNovaRegular, 15);
    cell.txtValues.tag = 10+indexPath.row;

    UITextField *textField = (UITextField *) [cell.contentView viewWithTag:10+indexPath.row];
    textField.text = valuesArray[indexPath.row];
    textField.textAlignment = NSTextAlignmentCenter;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.autocorrectionType = NO;
    
    switch (textField.tag) {
        case 10:
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.autocapitalizationType = YES;
            break;
        }
        case 11:
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.autocapitalizationType = YES;

            break;
        }
        case 12:
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.autocapitalizationType = NO;

            break;
        }
        case 13:
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.autocapitalizationType = NO;
            textField.secureTextEntry = YES;
            break;
        }
        case 14:
        {
            textField.keyboardType = UIKeyboardTypeDefault;
            textField.autocapitalizationType = NO;
            textField.secureTextEntry = YES;
            break;
        }
        case 15:
        {
            textField.keyboardType = UIKeyboardTypeEmailAddress;
            textField.autocapitalizationType = NO;
            break;
        }
            
        default:
            break;
        
    }
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

#pragma mark - Registration API

-(void)callRegistrationAPI
{
    [CommonMethods showGlobalHUDWithTitle:HUDTitle];
    NSString *strFirstName  = [[valuesArray objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strLastName  = [[valuesArray objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strUsername  = [[valuesArray objectAtIndex:2] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    NSString *strPassword  = [valuesArray objectAtIndex:3];
    NSString *strEmailAddress  = [valuesArray objectAtIndex:5];

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@/%@/%@/%@/%@/%@/%@/%@",REGISTRATION_URL, strUsername, strEmailAddress, strPassword, strFirstName, strLastName, appDel.strLatitude, appDel.strLongitude] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
        [CommonMethods hideGlobalHUD];
        if ([[dict valueForKey:@"status"] boolValue])
        {
            appDel.dictUser = [dict mutableCopy];
            [CommonMethods displayAlertwithTitle:AppName withMessage:[dict valueForKey:@"message"] withViewController:self andCompletion:^{
                SurveyViewController *viewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
                [self.navigationController pushViewController:viewController animated:YES];
            }];
        }
        else
        {
            [CommonMethods displayAlertwithTitle:AppName withMessage:[dict valueForKey:@"message"]withViewController:self andCompletion:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonMethods hideGlobalHUD];
        NSLog(@"Error: %@", error);
    }];
}

#pragma mark - UIAlertView Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (alertView.tag == 1)
    {
        SurveyViewController *viewController = [[SurveyViewController alloc] initWithNibName:@"SurveyViewController" bundle:nil];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
