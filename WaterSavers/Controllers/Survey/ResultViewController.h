//
//  ResultViewController.h
//  WaterSavers
//
//  Created by Utsav Parikh on 10/8/15.
//  Copyright © 2015 HackathonSDSU. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import "DYRateView.h"


@interface ResultViewController : UIViewController<DYRateViewDelegate>
{
    IBOutlet UILabel *lblMyScore;
    IBOutlet UILabel *lblWaterSaved;
    IBOutlet UIButton *btnFacebook;
    IBOutlet UIButton *btnTwitter;

}

@end
