//
//  ResultViewController.m
//  WaterSavers
//
//  Created by Utsav Parikh on 10/8/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import "ResultViewController.h"
#import "Constant.h"

@interface ResultViewController ()

@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSideMenuBarButtonItem];
    self.title = @"Results";
    float final_score = 0.0f;
    float shower = 0.0f;
    float toilet = 0.0f;
    float washing_machine = 0.0f;
    float dishwasher = 0.0f;
    float consumption = 0.0f;
    float avg_consumption = 0.0f;
    float water_saved = 0.0f;
    
    float family_size = [[appDel.dictResults valueForKey:@"family_size"] floatValue];
    float dishwasher_frequency = [[appDel.dictResults valueForKey:@"dishwasher_frequency"] floatValue];
    float sprinkler_frequency = [[appDel.dictResults valueForKey:@"sprinkler_frequency"] floatValue];
    float sprinkler_operation_time = [[appDel.dictResults valueForKey:@"sprinkler_operation_time"] floatValue];
    float misc = [[appDel.dictResults valueForKey:@"misc"] floatValue];
    BOOL low_flow_showerhead = [[appDel.dictResults valueForKey:@"low_flow_showerhead"] boolValue];
    float shower_length = [[appDel.dictResults valueForKey:@"shower_length"] floatValue];
    float shower_frequency = [[appDel.dictResults valueForKey:@"shower_frequency"] floatValue];
    BOOL flush_type = [[appDel.dictResults valueForKey:@"flush_type"] boolValue];
    float flush_frequency = [[appDel.dictResults valueForKey:@"flush_frequency"] floatValue];
    NSString *machine_type = [appDel.dictResults valueForKey:@"machine_type"];
    float machine_loads = [[appDel.dictResults valueForKey:@"machine_loads"] floatValue];
    BOOL dishwasher_type = [[appDel.dictResults valueForKey:@"dishwasher_type"] boolValue];
    
    float shower_consumption_low = (shower_frequency * shower_length * 1.6 * family_size * 30);
    
    float shower_consumption_high = (shower_frequency * shower_length * 3 * family_size * 30);
    
    float shower_consumption_avg = (2 * 8 * 2 * family_size * 30);
    
    float toilet_consumption_low = (flush_frequency * 1.8 * family_size * 30);
    
    float toilet_consumption_high = (flush_frequency * 3 * family_size * 30);
    
    float toilet_consumption_avg = (5 * 2 * family_size * 30);
    
    float washingmachine_consumption_low = (machine_loads * 25 * 4);
    
    float washingmachine_consumption_high = (machine_loads * 40 * 4);
    
    float washingmachine_consumption_avg = (30 * 30);
    
    float dishwasher_consumption_low = (dishwasher_frequency * 10 * 30);
    
    float dishwasher_consumption_high = (dishwasher_frequency * 18 * 30);
    
    float dishwasher_consumption_avg = (2 * 12 * 30);
    
    float sprinkler_consumption = (sprinkler_frequency * sprinkler_operation_time * 7 * 8);
    
    float sprinkler_consumption_avg = (sprinkler_frequency * 12 * 6 * 8);
    
    float misc_consumption = (misc * family_size * 30);
    
    float misc_consumption_avg = (45 * family_size * 30);
    
    if (low_flow_showerhead) {
        shower = shower_consumption_low;
    }
    else
        shower = shower_consumption_high;
    
    if(shower_consumption_avg > shower){
        final_score = final_score + (shower_consumption_avg - shower);
    }
    else
    {
        [appDel.arrayTips addObject:@"Take shorter showers."];
        [appDel.arrayTips addObject:@"Replace your shower head with a ultra low-flow version."];
    }
    
    
    if (flush_type) {
        toilet = toilet_consumption_low;
    }
    else
        toilet = toilet_consumption_high;
    
    if(toilet_consumption_avg > toilet){
        final_score = final_score + (toilet_consumption_avg - toilet);
    }
    else
    {
        [appDel.arrayTips addObject:@"Replace your toilet flush with dual or pressure assist flush."];
        [appDel.arrayTips addObject:@"Don't flush things down the toilet to dispose of them."];
    }
    
    
    if ([machine_type isEqualToString:@"Front Load"]) {
        washing_machine = washingmachine_consumption_low;
    }
    else
        washing_machine = washingmachine_consumption_high;
    
    if(washingmachine_consumption_avg > washing_machine){
        final_score = final_score + (washingmachine_consumption_avg - washing_machine);
    }
    else
    {
        [appDel.arrayTips addObject:@"Do full loads or select appropriate water level settings."];
    }

    
    if (dishwasher_type) {
        dishwasher = dishwasher_consumption_low;
    }
    else
        dishwasher = dishwasher_consumption_high;
    
    if(dishwasher_consumption_avg > dishwasher){
        final_score = final_score + (dishwasher_consumption_avg - dishwasher);
    }
    else
    {
        [appDel.arrayTips addObject:@"Operate dishwasher only when they are fully loaded."];
        [appDel.arrayTips addObject:@"Avoid pre-rinsing of dishes."];
    }

    if(sprinkler_consumption_avg > sprinkler_consumption)
    {
        final_score = final_score + (sprinkler_consumption_avg - sprinkler_consumption);
    }
    else
    {
        [appDel.arrayTips addObject:@"Water early in the morning to reduce the evaporation rate."];
        [appDel.arrayTips addObject:@"Make sure you set automatic sprinklers correctly that adjust as conditions change."];
    }

    
    if(misc_consumption_avg > misc_consumption){
        final_score = final_score + (misc_consumption_avg - misc_consumption);
    }
    else
    {
        [appDel.arrayTips addObject:@"Install low flow faucet aerators in your sink."];
        [appDel.arrayTips addObject:@"Check water bills for any instance of high water use as this may be an indication of leak."];
    }

    consumption = shower + toilet + washing_machine + dishwasher + sprinkler_consumption + misc_consumption;
    
    avg_consumption = shower_consumption_avg + toilet_consumption_avg + washingmachine_consumption_avg + dishwasher_consumption_avg + sprinkler_consumption_avg + misc_consumption_avg;
    
   water_saved = avg_consumption - consumption;
    float new_score = 0.0f;
    if(water_saved > 0)
        new_score = water_saved * 3;
    appDel.myScore = new_score;
    appDel.myWaterUsage = water_saved;
    
    lblMyScore.text = [NSString stringWithFormat:@"%d", (int)appDel.myScore];
    
    if(water_saved < 0)
        lblWaterSaved.text = [NSString stringWithFormat:@"You have used %d gallons of water more than the average this month.", abs((int)water_saved)];
    else
        lblWaterSaved.text = [NSString stringWithFormat:@"You have saved %d gallons of water this month.", (int)water_saved];
    
    //Initialize rate view with stars
    DYRateView *rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, 30, [[UIScreen mainScreen] bounds].size.width, 150) fullStar:[UIImage imageNamed:@"star_full"] emptyStar:[UIImage imageNamed:@"star_empty"]];
    rateView.alignment = RateViewAlignmentCenter;
    rateView.delegate = self;
    rateView.padding = 10.f;
    if(new_score < 200)
        rateView.rate = 0.0f;
    else if(new_score < 400)
        rateView.rate = 0.5f;
    else if(new_score < 600)
        rateView.rate = 1.0f;
    else if(new_score < 800)
        rateView.rate = 1.5f;
    else if(new_score < 1000)
        rateView.rate = 2.0f;
    else if(new_score < 1200)
        rateView.rate = 2.5f;
    else if(new_score < 1400)
        rateView.rate = 3.0f;
    else if(new_score < 1600)
        rateView.rate = 3.5f;
    else if(new_score < 1800)
        rateView.rate = 4.0f;
    else if(new_score < 2000)
       rateView.rate = 4.5f;
    else
        rateView.rate = 5.0f;
    [self.view addSubview:rateView];
    
    [self callSubmitAPI];
    if(appDel.myWaterUsage <= 0)
    {
        btnTwitter.enabled = FALSE;
        btnFacebook.enabled = FALSE;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)postToTwitter:(id)sender {
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:[NSString stringWithFormat:@"Hey I just scored %d points by saving %d gallons of water on the WaterSavers App.....!!!!", (int)appDel.myScore, (int)appDel.myWaterUsage]];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}

- (IBAction)postToFacebook:(id)sender {
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [controller setInitialText:[NSString stringWithFormat:@"Hey I just scored %d points by saving %d gallons of water on the WaterSavers App.....!!!!", (int)appDel.myScore, (int)appDel.myWaterUsage]];
            
        [controller addImage:[UIImage imageNamed:@"WaterSaverslogo"]];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

#pragma mark - Submit API

-(void)callSubmitAPI
{
    [CommonMethods showGlobalHUDWithTitle:HUDTitle];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:@"%@/%@/%d/%d/0",SUBMIT_URL, [appDel.dictUser valueForKey:@"username"], (int)appDel.myWaterUsage, (int)appDel.myScore] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:kNilOptions error:nil];
        [CommonMethods hideGlobalHUD];
        if ([[dict valueForKey:@"status"] boolValue])
        {
            NSLog(@"Data submitted");
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [CommonMethods hideGlobalHUD];
        NSLog(@"Error: %@", error);
    }];
}

@end
