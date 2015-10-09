//
//  Constant.h
//  BAMA
//
//  Created by MAC on 12/23/13.
//  Copyright (c) 2013 MAC. All rights reserved.
//

#import "AFAPIClient.h"
#import "AppDelegate.h"
#import "CommonMethods.h"

#define AppName @"Water Savers"
#define NAVIBARCOLOR    RGB(1, 174, 240)

#define appDel ((AppDelegate *)[[UIApplication sharedApplication] delegate])

//Singleton constants
#define kAFClient [AFAPIClient sharedClient]
#define kUserDetails [UserDetailsModal sharedUserDetails]

/*
 * IOS Version and Device Macros
 */

#define SYSTEM_SCREEN_SIZE [[UIScreen mainScreen] bounds].size
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE_5 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)
#define IS_IPHONE_6_PLUS (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)
#define IS_IPHONE_4 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 480.0f)
#define FONTS_6_PLUS ((IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f) ? 1.05 : 1)
#define IS_IOS_7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IOS_8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SYSTEM_VERSION_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
/*
 * UIImage Macros
 */

#define IMAGE_NAMED(img)  [UIImage imageNamed : img]

/*
 * NSString Macros
 */

#define NSSTRING_WITH_FORMAT(string) [NSString stringWithFormat : @"%@", string]
#define allTrim(object) [object stringByTrimmingCharactersInSet :[NSCharacterSet whitespaceAndNewlineCharacterSet]]

/*
 * UIColor RGB Macros
 */

#define CLRCOLOR [UIColor clearColor]
#define RGB(r, g, b)     [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]
#define RGBA(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define NAVIBARTINTCOLOR RGB(178, 121, 172)
#define kLightGrayColor  RGB(65, 65, 66)
#define kWhiteColor      RGB(255, 255, 255)
#define TIME_FORMAT @"hh:mm a"
#define DATE_FORMAT @"MMMM dd, yyyy"
#define ASPECT_RATIO 0.66f

/*
 * UIFont Macros
 */

#define kProximaNovaRegularFont(fontSize)     [UIFont fontWithName : kProximaNovaRegular size : (fontSize * FONTS_6_PLUS)]
#define kProximaNovaLightFont(fontSize)       [UIFont fontWithName : kProximaNovaLight size : (fontSize * FONTS_6_PLUS)]
#define kProximaNovaSemiBoldFont(fontSize)    [UIFont fontWithName : kProximaNovaSemiBold size : (fontSize * FONTS_6_PLUS)]
#define kProximaNovaBoldFont(fontSize)        [UIFont fontWithName : kProximaNovaBold size : (fontSize * FONTS_6_PLUS)]

#define kCustomFont(fontName, fontSize) [UIFont fontWithName : fontName size : (fontSize * FONTS_6_PLUS)]

#define kProximaNovaRegular    @"ProximaNova-Regular"
#define kProximaNovaLight      @"ProximaNova-Light"
#define kProximaNovaSemiBold   @"ProximaNova-Semibold"
#define kProximaNovaBold       @"ProximaNova-Bold"



/*
 * GCD Macros
 */

#define ASYNC_BACK(...) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{ __VA_ARGS__ })
#define ASYNC_MAIN(...) dispatch_async(dispatch_get_main_queue(), ^{ __VA_ARGS__ })


/*
 * UIAlertView Macros
 */

#define SHOW_ALERT(TITLE, MSG) [[[UIAlertView alloc] initWithTitle:(TITLE) \
	                                                       message:(MSG) \
	                                                      delegate:nil \
	                                             cancelButtonTitle:@"OK" \
	                                             otherButtonTitles:nil] show]




/*
 * Enums

 */
typedef NS_ENUM (NSUInteger, USER_STATE) {
	NOT_LOGGED_IN,
	LOGGED_IN,
};

#define HUDTitle @"Loading..."
#define NO_INTERNET @"Internet connection appears to be offline. Please check your connection."
#define CommonSingleton [CommonMethods sharedInstance]

//Webservice URLs

#define MAIN_URL  @"http://watersavers.iosnewbies.com/v1"

#define LOGIN_URL          MAIN_URL@"/login"
#define REGISTRATION_URL   MAIN_URL@"/register"
#define LEADERBOARD_URL    MAIN_URL@"/leaderboard"
#define SUBMIT_URL         MAIN_URL@"/storescore"


//Company Keys
#define HSP                             @"EE3E9DE465D66D38DA6437A76DBB3DB3"
#define COMPANY_ID                      @"demo"

#define CLIENT_TEMPID_LOGIN             @"1234"
#define CLIENT_TEMPID_FIRST_TIME_LOGIN  @"1234"
#define CLIENT_TEMPID_CHECK_LEAVE       @"1234"

#define EMPLOYEE                        @"Employee"

//Validations
#define STR_OK                          @"OK"
#define STR_CANCEL                      @"Cancel"
#define STR_SUBMIT                      @"Submit"
#define STR_VALIDATION_ALL              @"Please enter all details."
#define STR_VALIDATION_UID              @"Please enter the User ID."
#define STR_VALIDATION_PASS             @"Please enter the password."
#define STR_VALIDATION_CID              @"Please enter the Company ID."
#define STR_VALIDATION_FRGT_PSWRD       @"Forgot Password"
#define STR_VALIDATION_EMPTY_MAIL       @"Email address must not be empty."
#define STR_FORGOT_PASSWORD_INSTRUCTION @"Insert your email and click the button below."
