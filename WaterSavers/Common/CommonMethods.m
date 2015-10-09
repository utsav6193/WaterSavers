//
//  CommonMethods.m
//  BME
//
//  Created by MAC on 01/10/13.
//  Copyright (c) 2013 Organization. All rights reserved.
//

#import "CommonMethods.h"
#include <math.h>
#include "Constant.h"

NSNumberFormatter *priceFormatter;

@implementation CommonMethods

- (void)initialize {
	[self setUpReachability];
}

+ (instancetype)sharedInstance {
	static CommonMethods *sharedInstance = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sharedInstance = [[super allocWithZone:NULL] init];
		[sharedInstance initialize];
	});
	return sharedInstance;
}

/**
 *  Shortcut method to get DocumentsDirectory Path
 *
 *  @return DocumentsDirectory Path
 */
NSString *DocumentsDirectoryPath() {
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectoryPath = [paths objectAtIndex:0];
	return documentsDirectoryPath;
}

#pragma mark - Prevent Multiple Touch Methods
/**
 *  Method used to recursively disable multiple touch events inside UIView especially designed for UIButton
 *
 *  @param selfView UIView object where you want to disable multiple touch recursively.
 */
+ (void)disableMultipleTouch:(UIView *)selfView {
	for (UIView *v in selfView.subviews) {
		if ([v isMemberOfClass:[UIView class]]) {
			[self disableMultipleTouch:v];
		}
		else if ([v isMemberOfClass:[UIButton class]]) {
			UIButton *btn = (UIButton *)v;
			[btn setExclusiveTouch:YES];
			[btn setMultipleTouchEnabled:NO];
		}
	}
}

#pragma mark - Global Indicator Methods

/**
 *  This method displays SVProgressHUD on top of window to perform synchronous tasks.
 *
 *  @param title Title of the indicator you want to display while performing any task.
 */
+ (void)showGlobalHUDWithTitle:(NSString *)title {
    [SVProgressHUD showWithStatus:title maskType:SVProgressHUDMaskTypeGradient];
}

/**
 *  Method will hide any hud currently visible on the window.
 */
+ (void)hideGlobalHUD {
    [SVProgressHUD dismiss];
}

+ (void)showToastWithMessage:(NSString *)message {
    [(UIView *)appDel.window makeToast:message duration:2.0 position:@"bottom"];
}

/**
 *  This method will check null validations for NSString, NSArray and Null class
 *
 *  @param thing Pass NSString, NSArray or NSNull class reference
 *
 *  @return YES/NO respectively
 */
+ (BOOL)isObjectEmpty:(id)object {
	if ([object isKindOfClass:[NSNull class]] || object == nil) {
		return YES;
	}
	if ([object isKindOfClass:[NSString class]]) {
		if (object == nil || ([object respondsToSelector:@selector(length)] && [(NSString *)object length] == 0)) {
			return YES;
		}
	}
	else if ([object isKindOfClass:[NSArray class]]) {
		if (object == nil || ([object respondsToSelector:@selector(count)] && [(NSArray *)object count] == 0)) {
			return YES;
		}
	}
	else if ([object isKindOfClass:[NSDictionary class]]) {
		if (object == nil || ([object respondsToSelector:@selector(count)] && [(NSDictionary *)object count] == 0)) {
			return YES;
		}
	}
	else if ([object isKindOfClass:[NSData class]]) {
		if (object == nil || ([object respondsToSelector:@selector(length)] && [(NSData *)object length] == 0)) {
			return YES;
		}
	}
	else if ([object isKindOfClass:[UIImage class]]) {
		if (object == nil) {
			return YES;
		}
	}
	return NO;
}

+ (NSArray *)arrayAfterRemovingEmptyObjects:(NSArray *)array {
	NSMutableArray *newArray = [array mutableCopy];
	NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
	for (NSInteger counter = 0; counter < [array count]; counter++) {
		BOOL isEmptyObject = [self isObjectEmpty:[array objectAtIndex:counter]];
		if (isEmptyObject)
			[indexSet addIndex:counter];
	}
	[newArray removeObjectsAtIndexes:indexSet];
	return [newArray copy];
}

#pragma mark - Height Width Calculation Methods

/**
 *  This method is used to calculate height of text given which fits in specific width having    font provided
 *
 *  @param text       Text to calculate height of
 *  @param widthValue Width of container
 *  @param font       Font size of text
 *
 *  @return Height required to fit given text in container
 */

+ (CGSize)findHeightForText:(NSString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
	CGSize size = CGSizeZero;
	if (text) {
#ifdef __IPHONE_7_0
		CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
		size = CGSizeMake(frame.size.width, frame.size.height + 1);
#else
		size = [text sizeWithFont:font constrainedToSize:CGSizeMake(widthValue, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#endif
	}
	return size;
}

/**
 *  This method is used to calculate height of attributed text given which fits in specific width having font provided
 *
 *  @param text       Attributed text to calculate height of
 *  @param widthValue Width of container
 *  @param font       Font size of text
 *
 *  @return Height required to fit given text in container
 */
+ (CGFloat)findAttributedHeightForText:(NSAttributedString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
	CGFloat result = font.pointSize + 4;
	//CGFloat width = widthValue;
	if (text)
		result = (ceilf(CGRectGetHeight([text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil])) + 1);

	return (result * FONTS_6_PLUS);
}

//+ (CGFloat)findAttributedHeightForText:(NSAttributedString *)text havingWidth:(CGFloat)widthValue andFont:(UIFont *)font {
//	CGFloat result = font.pointSize + 4;
//	//CGFloat width = widthValue;
//	if (text) {
//		//CGSize textSize = { width, CGFLOAT_MAX };       //Width and height of text area
//		CGSize size;
//		CGRect frame = [text boundingRectWithSize:CGSizeMake(widthValue, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading context:nil];
//		size = CGSizeMake(frame.size.width, frame.size.height + 1);
//		result = MAX(size.height, result); //At least one row
//	}
//	return result;
//}

+ (CGFloat)findWidthForText:(NSString *)text havingMaximumHeight:(CGFloat)heightValue andFont:(UIFont *)font {
	CGSize size = CGSizeZero;
	if (text) {
#ifdef __IPHONE_7_0
		CGRect frame = [text boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, heightValue) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:font } context:nil];
		size = CGSizeMake(frame.size.width, frame.size.height + 1);
#else
		size = [text sizeWithFont:font constrainedToSize:CGSizeMake(CGFLOAT_MAX, heightValue) lineBreakMode:NSLineBreakByWordWrapping];
#endif
	}
	return size.width;
}

#pragma mark - String-NSDate Conversion Methods

+ (NSDate *)nsDateFromString:(NSString *)string usingDateFormat:(NSString *)dateFormat {
	static NSDateFormatter *formatter = nil;
	if (formatter == nil) {
		formatter = [[NSDateFormatter alloc] init];
	}
	[formatter setDateFormat:dateFormat];
	NSDate *date = [formatter dateFromString:string];
	return date;
}

+ (NSString *)nsStringFromDate:(NSDate *)date andToFormatString:(NSString *)formatString {
	static NSDateFormatter *formatter = nil;
	if (formatter == nil) {
		formatter = [[NSDateFormatter alloc] init];
	}
	[formatter setDateFormat:formatString];
	NSString *dateString = [formatter stringFromDate:date];
	return dateString;
}

#pragma mark - Validation

+ (BOOL)NSStringIsValidEmail:(NSString *)checkString {
	BOOL stricterFilter = YES;
	NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
	NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
	NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
	NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
	return [emailTest evaluateWithObject:checkString];
}

#pragma mark - Reachability Methods

- (void)setUpReachability {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNetworkChange:) name:kReachabilityChangedNotification object:nil];
	internetReachability = [Reachability reachabilityForInternetConnection];
	[internetReachability startNotifier];

	NetworkStatus remoteHostStatus = [internetReachability currentReachabilityStatus];
	if (remoteHostStatus == NotReachable) {
		self.isConnected = NO;
	}
	else if (remoteHostStatus == ReachableViaWiFi) {
		self.isConnected = YES;
	}
	else if (remoteHostStatus == ReachableViaWWAN) {
		self.isConnected = YES;
	}
}

- (void)handleNetworkChange:(NSNotification *)notice {
	NetworkStatus remoteHostStatus = [internetReachability currentReachabilityStatus];
	if (remoteHostStatus == NotReachable) {
		self.isConnected = NO;
	}
	else if (remoteHostStatus == ReachableViaWiFi) {
		self.isConnected = YES;
	}
	else if (remoteHostStatus == ReachableViaWWAN) {
		self.isConnected = YES;
	}
}

+ (NSString *)suffixNumber:(NSNumber *)number {
	if (!number)
		return @"";
	long long num = [number longLongValue];
	if (num < 1000) {
		return [NSString stringWithFormat:@"%lld", num];
	}
	int exp = (int)(log(num) / log(1000));
	NSArray *units = @[@"k", @"m", @"g", @"t", @"p", @"e"];
	return [NSString stringWithFormat:@"%.0f%@", (num / pow(1000, exp)), [units objectAtIndex:(exp - 1)]];
}

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert {
	NSString *noHashString = [stringToConvert stringByReplacingOccurrencesOfString:@"#" withString:@""]; // remove the #
	NSScanner *scanner = [NSScanner scannerWithString:noHashString];
	[scanner setCharactersToBeSkipped:[NSCharacterSet symbolCharacterSet]]; // remove + and $
	unsigned hex;
	if (![scanner scanHexInt:&hex]) return nil;
	int r = (hex >> 16) & 0xFF;
	int g = (hex >> 8) & 0xFF;
	int b = (hex) & 0xFF;
	return [UIColor colorWithRed:r / 255.0f green:g / 255.0f blue:b / 255.0f alpha:1.0f];
}

+ (void)handleErrorOperation:(AFHTTPRequestOperation *)task withError:(NSError *)error {
	NSRange cancelRange = [[error localizedDescription] rangeOfString:@"cancelled"];
	if (![task isCancelled] && cancelRange.location == NSNotFound) {
		id errorBody = [error.userInfo valueForKey:@"body"];
		//NSLog(@"------------++++++++++----------Error Body %@",errorBody);
		if ([errorBody isKindOfClass:[NSArray class]]) {
			errorBody = errorBody[0];
		}
		if (errorBody != nil) {
			NSString *description = [NSString stringWithFormat:@"%@", [errorBody valueForKey:@"errorMessage"]];
			if ([description isEqualToString:@"(null)"]) {
				description = errorBody[@"error_description"];
			}
			[CommonMethods showToastWithMessage:description];
		}
		else {
			[CommonMethods showToastWithMessage:[error localizedDescription]];
			NSLog(@"-----------------Error %@", [error.userInfo valueForKey:@"NSLocalizedDescription"]);
		}
	}
}

+ (void)printJson:(id)json {
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
	                                                   options:0
	                                                     error:&error];
	if (!jsonData) {
		NSLog(@"\nJSON error: %@", error);
	}
	else {
		NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
		NSLog(@"\nJSON OUTPUT: %@", JSONString);
	}
}

+ (NSDictionary *)stripNulls:(NSDictionary *)dictionary {
	NSMutableDictionary *returnDict = [NSMutableDictionary new];
	NSArray *allKeys = [dictionary allKeys];
	NSArray *allValues = [dictionary allValues];
	for (int i = 0; i < [allValues count]; i++) {
		if ([allValues objectAtIndex:i] == (NSString *)[NSNull null]) {
			[returnDict setValue:@"" forKey:[allKeys objectAtIndex:i]];
		}
		else
			[returnDict setValue:[allValues objectAtIndex:i] forKey:[allKeys objectAtIndex:i]];
	}
	return returnDict;
}

+ (UIImage *)circularScaleAndCropImage:(UIImage *)image frame:(CGRect)frame {
	// This function returns a newImage, based on image, that has been:
	// - scaled to fit in (CGRect) rect
	// - and cropped within a circle of radius: rectWidth/2

	//Create the bitmap graphics context
	UIGraphicsBeginImageContextWithOptions(CGSizeMake(frame.size.width, frame.size.height), NO, 0.0);
	CGContextRef context = UIGraphicsGetCurrentContext();

	//Get the width and heights
	CGFloat imageWidth = image.size.width;
	CGFloat imageHeight = image.size.height;
	CGFloat rectWidth = frame.size.width;
	CGFloat rectHeight = frame.size.height;

	//Calculate the scale factor
	CGFloat scaleFactorX = rectWidth / imageWidth;
	CGFloat scaleFactorY = rectHeight / imageHeight;

	//Calculate the centre of the circle
	CGFloat imageCentreX = rectWidth / 2;
	CGFloat imageCentreY = rectHeight / 2;

	// Create and CLIP to a CIRCULAR Path
	// (This could be replaced with any closed path if you want a different shaped clip)
	CGFloat radius = rectWidth / 2;
	CGContextBeginPath(context);
	CGContextAddArc(context, imageCentreX, imageCentreY, radius, 0, 2 * M_PI, 0);
	CGContextClosePath(context);
	CGContextClip(context);

	//Set the SCALE factor for the graphics context
	//All future draw calls will be scaled by this factor
	CGContextScaleCTM(context, scaleFactorX, scaleFactorY);

	// Draw the IMAGE
	CGRect myRect = CGRectMake(1, 1, imageWidth, imageHeight);
	[image drawInRect:myRect];

	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return newImage;
}

/*----- alertview for iOS 7 & 8 -----*/
+ (void)displayAlertwithTitle:(NSString *)title withMessage:(NSString *)msg withViewController:(UIViewController *)viewCtr {
    if (IS_IOS_8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action)
                                        { [alert dismissViewControllerAnimated:YES completion:nil]; }];
        [alert addAction:defaultAction];
        [viewCtr presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

+ (void)displayAlertwithTitle:(NSString *)title withMessage:(NSString *)msg withViewController:(UIViewController *)viewCtr andCompletion:(void (^)())completion {
    if (IS_IOS_8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *defaultAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler: ^(UIAlertAction *action) { if(completion)completion(); }];
        [alert addAction:defaultAction];
        [viewCtr presentViewController:alert animated:YES completion:nil];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:msg delegate:viewCtr cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    }
}

+ (void)showAlertWithMessage:(NSString *)message {
    dispatch_after(0.4, dispatch_get_main_queue(), ^{
   
	if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"8")) {
		UIAlertController *alertController = [UIAlertController
		                                      alertControllerWithTitle:AppName
		                                                       message:message
		                                                preferredStyle:UIAlertControllerStyleAlert];
		UIAlertAction *okAction = [UIAlertAction
		                           actionWithTitle:@"OK"
		                                     style:UIAlertActionStyleDefault
		                                   handler: ^(UIAlertAction *action)
		{
		    NSLog(@"OK action");
		}];

		[alertController addAction:okAction];
		UIWindow *window;
		if ([UIApplication sharedApplication].windows.count > 0)
			window = [UIApplication sharedApplication].windows.lastObject;
		else
			window = [(AppDelegate *)[[UIApplication sharedApplication] delegate] window];

		[window.rootViewController presentViewController:alertController animated:YES completion:nil];
	}
	else {
		SHOW_ALERT(AppName, message);
	}
         });
}
                   

+ (NSString *)getPriceFromNumberWithFraction:(NSNumber *)price {
	if (priceFormatter == nil) {
		priceFormatter =  [[NSNumberFormatter alloc] init];
		[priceFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
		priceFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
	}
	[priceFormatter setMaximumFractionDigits:2];
	NSString *currencyNumb = [priceFormatter stringFromNumber:price];
	return currencyNumb;
}

+ (NSString *)getPriceFromNumber:(NSString *)price {
	if (priceFormatter == nil) {
		priceFormatter =  [[NSNumberFormatter alloc] init];
		[priceFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
		priceFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
		[priceFormatter setMaximumFractionDigits:0];
	}

	NSString *strTxt = [[price stringByReplacingOccurrencesOfString:@"," withString:@""] stringByTrimmingCharactersInSet:[NSCharacterSet symbolCharacterSet]];
	NSString *numberString = [priceFormatter stringFromNumber:@([strTxt longLongValue])];
	return numberString;
}

+ (NSString *)convertStringToPhoneNumber:(NSString *)phoneStr {
	if (phoneStr != nil && phoneStr.length >= 10) {
		phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d{4})"
		                                               withString:@"$1-$2-$3"
		                                                  options:NSRegularExpressionSearch
		                                                    range:NSMakeRange(0, [phoneStr length])];
	}
	return phoneStr;
}

+ (NSString *)jsonStringFromID:(id)object isPretty:(BOOL)prettyPrint {
	NSError *error;
	NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
	                                                   options:(NSJSONWritingOptions)(prettyPrint ? NSJSONWritingPrettyPrinted : 0)
	                                                     error:&error];

	if (!jsonData) {
		NSLog(@"Json Print: error: %@", error.localizedDescription);
		return @"{}";
	}
	else {
		return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
	}
}

+ (void)rotateLayerInfinite:(CALayer *)layer {
	CABasicAnimation *rotation;
	rotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	rotation.fromValue = [NSNumber numberWithFloat:0];
	rotation.toValue = [NSNumber numberWithFloat:(2 * M_PI)];
	rotation.duration = 0.7f; // Speed
	rotation.repeatCount = HUGE_VALF; // Repeat forever. Can be a finite number.
	[layer removeAllAnimations];
	[layer addAnimation:rotation forKey:@"Spin"];
}

#define kXMLDefaultKey @"temp"
/**
 *  This method is used to clean up dictionary which we get after XML parsing
 *
 *  @param XMLDictionary Dictionary on which we want to perform cleanup
 *
 *  @return Cleaned dictionary
 */
+ (NSMutableDictionary *)cleanUpXMLDictionary:(NSMutableDictionary *)XMLDictionary {
	for (NSString *key in[XMLDictionary allKeys]) {
		// get the current object for this key
		id object = [XMLDictionary objectForKey:key];

		if ([object isKindOfClass:[NSDictionary class]]) {
			if ([[object allKeys] count] == 1 &&
			    [[[object allKeys] objectAtIndex:0] isEqualToString:kXMLDefaultKey] &&
			    ![[object objectForKey:kXMLDefaultKey] isKindOfClass:[NSDictionary class]]) {
				// this means the object has the key "text" and has no node
				// or array (for multiple values) attached to it.
				[XMLDictionary setObject:[object objectForKey:kXMLDefaultKey] forKey:key];
			}
			else {
				// go deeper
				[self cleanUpXMLDictionary:object];
			}
		}
		else if ([object isKindOfClass:[NSArray class]]) {
			// this is an array of dictionaries, iterate
			for (id inArrayObject in (NSArray *)object) {
				if ([inArrayObject isKindOfClass:[NSDictionary class]]) {
					// if this is a dictionary, go deeper
					[self cleanUpXMLDictionary:inArrayObject];
				}
			}
		}
	}

	return XMLDictionary;
}

+ (void)displayOverlay:(UIView *)viewOverlay {
	viewOverlay.alpha = 1.0f;
	viewOverlay.frame = [[UIScreen mainScreen] bounds];
	[[[[UIApplication sharedApplication]delegate] window] addSubview:viewOverlay];

	viewOverlay.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.001, 0.001);
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3 / 1.5];
	[UIView setAnimationDelegate:self];
	[self performSelector:@selector(bounce1AnimationStoppedForView:) withObject:viewOverlay afterDelay:0.3 / 1.5];
	viewOverlay.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
	[UIView commitAnimations];
}

+ (void)displayOverlay:(UIView *)subView aboveView:(UIView *)superView {
	subView.translatesAutoresizingMaskIntoConstraints = NO;

	[superView addSubview:subView];
	[superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(subView)]];
	[superView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:kNilOptions metrics:nil views:NSDictionaryOfVariableBindings(subView)]];

	[superView layoutSubviews];
}

+ (void)bounce1AnimationStoppedForView:(UIView *)view {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3 / 2];
	[UIView setAnimationDelegate:self];
	[self performSelector:@selector(bounce2AnimationStoppedForView:) withObject:view afterDelay:0.3 / 2];
	view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.9, 0.9);
	[UIView commitAnimations];
}

+ (void)bounce2AnimationStoppedForView:(UIView *)view {
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:0.3 / 2];
	view.transform = CGAffineTransformIdentity;
	[UIView commitAnimations];
}

+ (void)removeOverlay:(UIView *)subView {
	[subView removeFromSuperview];
}

+ (UIImage *)imageWithColor:(UIColor *)color {
	CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
	UIGraphicsBeginImageContext(rect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();

	CGContextSetFillColorWithColor(context, [color CGColor]);
	CGContextFillRect(context, rect);

	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	return image;
}

+ (void)popToLast:(Class)aClass fromNavigationController:(UINavigationController *)navController {
	for (NSInteger i = navController.viewControllers.count - 1; i >= 0; i--) {
		UIViewController *vc = navController.viewControllers[i];
		if ([vc isKindOfClass:aClass]) {
			[navController popToViewController:vc animated:YES];
			break;
		}
	}
}

+ (UIImage *)imageRotatedByDegrees:(UIImage *)oldImage deg:(CGFloat)degrees {
	//Calculate the size of the rotated view's containing box for our drawing space
	UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0, 0, oldImage.size.width, oldImage.size.height)];
	CGAffineTransform t = CGAffineTransformMakeRotation(degrees * M_PI / 180);
	rotatedViewBox.transform = t;
	CGSize rotatedSize = rotatedViewBox.frame.size;

	//Create the bitmap context
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();

	//Move the origin to the middle of the image so we will rotate and scale around the center.
	CGContextTranslateCTM(bitmap, rotatedSize.width / 2, rotatedSize.height / 2);

	//Rotate the image context
	CGContextRotateCTM(bitmap, (degrees * M_PI / 180));

	//Now, draw the rotated/scaled image into the context
	CGContextScaleCTM(bitmap, 1.0, -1.0);
	CGContextDrawImage(bitmap, CGRectMake(-oldImage.size.width / 2, -oldImage.size.height / 2, oldImage.size.width, oldImage.size.height), [oldImage CGImage]);

	UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
	int kMaxResolution = 1242; // Or whatever
	CGImageRef imgRef = image.CGImage;
	CGFloat width = CGImageGetWidth(imgRef);
	CGFloat height = CGImageGetHeight(imgRef);

	CGAffineTransform transform = CGAffineTransformIdentity;
	CGRect bounds = CGRectMake(0, 0, width, height);
	if (width > kMaxResolution || height > kMaxResolution) {
		CGFloat ratio = width / height;
		if (ratio > 1) {
			bounds.size.width = kMaxResolution;
			bounds.size.height = bounds.size.width / ratio;
		}
		else {
			bounds.size.height = kMaxResolution;
			bounds.size.width = bounds.size.height * ratio;
		}
	}

	CGFloat scaleRatio = bounds.size.width / width;
	CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
	CGFloat boundHeight;
	UIImageOrientation orient = image.imageOrientation;
	switch (orient) {
		case UIImageOrientationUp: //EXIF = 1
			transform = CGAffineTransformIdentity;
			break;

		case UIImageOrientationUpMirrored: //EXIF = 2
			transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			break;

		case UIImageOrientationDown: //EXIF = 3
			transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
			transform = CGAffineTransformRotate(transform, M_PI);
			break;

		case UIImageOrientationDownMirrored: //EXIF = 4
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
			transform = CGAffineTransformScale(transform, 1.0, -1.0);
			break;

		case UIImageOrientationLeftMirrored: //EXIF = 5
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
			transform = CGAffineTransformScale(transform, -1.0, 1.0);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;

		case UIImageOrientationLeft: //EXIF = 6
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
			transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
			break;

		case UIImageOrientationRightMirrored: //EXIF = 7
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeScale(-1.0, 1.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;

		case UIImageOrientationRight: //EXIF = 8
			boundHeight = bounds.size.height;
			bounds.size.height = bounds.size.width;
			bounds.size.width = boundHeight;
			transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
			transform = CGAffineTransformRotate(transform, M_PI / 2.0);
			break;

		default:
			[NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
	}

	UIGraphicsBeginImageContext(bounds.size);

	CGContextRef context = UIGraphicsGetCurrentContext();

	if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
		CGContextScaleCTM(context, -scaleRatio, scaleRatio);
		CGContextTranslateCTM(context, -height, 0);
	}
	else {
		CGContextScaleCTM(context, scaleRatio, -scaleRatio);
		CGContextTranslateCTM(context, 0, -height);
	}

	CGContextConcatCTM(context, transform);

	CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
	UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();

	//[self setRotatedImage:imageCopy];
	return imageCopy;
}

+ (NSString *)encodeToBase64String:(UIImage *)image {
	return [UIImageJPEGRepresentation(image, 0.8) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

+ (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
	NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
	return [UIImage imageWithData:data];
}

@end
