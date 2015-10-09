//
//  LeaderBoardViewController.h
//  WaterSavers
//
//  Created by Utsav Parikh on 10/6/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderBoardViewController : UIViewController
{
    NSMutableArray *arrayLeaders;
    IBOutlet UITableView *tblLeaderBoard;
}

@end
