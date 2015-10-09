//
//  LeaderBoardViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/6/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "LeaderBoardViewController.h"
#import "LeaderCell.h"
#import "Constant.h"

@interface LeaderBoardViewController ()

@end

@implementation LeaderBoardViewController

#pragma mark - View Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setSideMenuBarButtonItem];
    self.title = @"LeaderBoard";
    [self callLeaderBoardAPI];
    arrayLeaders = [[NSMutableArray alloc] init];

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

#pragma mark - Table View Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [arrayLeaders count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LeaderCell";
    
    LeaderCell *cell = (LeaderCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:simpleTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }

    cell.lblLeadername.text = [NSString stringWithFormat:@"%@ %@",[[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"first_name"], [[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"last_name"]];
    cell.lblLeaderScore.text = [NSString stringWithFormat:@"%@", [[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"user_score"]];
    cell.lblLeaderRank.text = [NSString stringWithFormat:@"%ld.", indexPath.row + 1];
    if([[[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"badge_status"] integerValue] == 3)
    {
        cell.imgBronze.hidden = NO;
        cell.imgSilver.hidden = NO;
        cell.imgGold.hidden = NO;
    }
    else if([[[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"badge_status"] integerValue] == 2)
    {
        cell.imgBronze.hidden = NO;
        cell.imgSilver.hidden = NO;
        cell.imgGold.hidden = YES;
    }
    else if([[[arrayLeaders objectAtIndex:indexPath.row] valueForKey:@"badge_status"] integerValue] == 1)
    {
        cell.imgBronze.hidden = NO;
        cell.imgSilver.hidden = YES;
        cell.imgGold.hidden = YES;
    }
    else
    {
        cell.imgBronze.hidden = YES;
        cell.imgSilver.hidden = YES;
        cell.imgGold.hidden = YES;
    }


    
    cell.layer.borderWidth = 0.5f;
    cell.layer.borderColor = RGB(240, 240, 240).CGColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0f;
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
            [tblLeaderBoard reloadData];
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

@end
