//
//  CommonMethods.h
//  BME
//
//  Created by MAC on 01/10/13.
//  Copyright (c) 2013 Organization. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPRequestOperation.h"
#import "Reachability.h"
#import "Constant.h"
#import "SVProgressHUD.h"
#import "UIView+Toast.h"


@interface CommonMethods : NSObject {
	Reachability *internetReachability;
}
+ (instancetype)sharedInstance;
@property (nonatomic, readwrite) BOOL isConnected;

typedef void (^DownloadBlock)(BOOL success, float progress, NSError *error);
@property (nonatomic, readwrite, copy) DownloadBlock completionHandler;

NSString *DocumentsDirectoryPath();

+ (void)displayAlertwithTitle:(NSString *)title withMessage:(NSString *)msg withViewController:(UIViewController *)viewCtr;
+ (void)displayAlertwithTitle:(NSString *)title withMessage:(NSString *)msg withViewController:(UIViewController *)viewCtr andCompletion:(void (^)())completion ;

+ (void)showGlobalHUDWithTitle:(NSString *)title;
+ (void)hideGlobalHUD;
+ (void)disableMultipleTouch:(UIView *)selfView;
+ (BOOL)isObjectEmpty:(id)object;
+ (BOOL)NSStringIsValidEmail:(NSString *)checkString;
+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+ (CGFloat)findAttributedHeightForText:(NSAttributedString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font;
+ (CGFloat)findWidthForText:(NSString *)text havingMaximumHeight:(CGFloat)heightValue andFont:(UIFont *)font;
+ (NSDate *)nsDateFromString:(NSString *)string usingDateFormat:(NSString *)dateFormat;
+ (NSString *)nsStringFromDate:(NSDate *)date andToFormatString:(NSString *)formatString;
+ (NSString *)suffixNumber:(NSNumber *)number;
+ (NSString *)convertStringToPhoneNumber:(NSString *)phoneStr;
+ (NSString *)getPriceFromNumber:(NSString *)price;
+ (NSString *)getPriceFromNumberWithFraction:(NSNumber *)price;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;
+ (NSDictionary *)stripNulls:(NSDictionary *)dictionary;
+ (UIImage *)circularScaleAndCropImage:(UIImage *)image frame:(CGRect)frame;
+ (void)handleErrorOperation:(AFHTTPRequestOperation *)task withError:(NSError *)error;
+ (void)showToastWithMessage:(NSString *)message;
+ (void)showAlertWithMessage:(NSString *)message;
+ (void)printJson:(id)json;
+ (NSString *)jsonStringFromID:(id)object isPretty:(BOOL)prettyPrint;
+ (NSArray *)arrayAfterRemovingEmptyObjects:(NSArray *)array;
+ (NSMutableDictionary *)cleanUpXMLDictionary:(NSMutableDictionary *)XMLDictionary;
+ (void)rotateLayerInfinite:(CALayer *)layer;
+ (UIImage *)imageWithColor:(UIColor *)color;
+ (void)displayOverlay:(UIView *)viewOverlay;
+ (void)displayOverlay:(UIView *)viewOverlay aboveView:(UIView *)superView;
+ (void)removeOverlay:(UIView *)view;
+ (void)popToLast:(Class)aClass fromNavigationController:(UINavigationController *)navController;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
+ (UIImage *)imageRotatedByDegrees:(UIImage *)oldImage deg:(CGFloat)degrees;
+ (NSString *)encodeToBase64String:(UIImage *)image;
+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData;
@end
