//
//  LeaderCell.h
//  WaterSavers
//
//  Created by Utsav Parikh on 10/7/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeaderCell : UITableViewCell

@property(strong, nonatomic) IBOutlet UILabel *lblLeaderRank;
@property(strong, nonatomic) IBOutlet UILabel *lblLeadername;
@property(strong, nonatomic) IBOutlet UILabel *lblLeaderScore;
@property(strong, nonatomic) IBOutlet UIImageView *imgBronze;
@property(strong, nonatomic) IBOutlet UIImageView *imgSilver;
@property(strong, nonatomic) IBOutlet UIImageView *imgGold;

@end
