//
//  AFAPIClient.h
//  Hubdin
//
//  Created by MAC237 on 5/1/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//
#import "AFHTTPRequestOperationManager.h"
#import "Constant.h"

@interface AFAPIClient : AFHTTPRequestOperationManager
+ (instancetype)sharedClient;
typedef void (^AFCompletionHandler)(BOOL success, id result, NSError *error);
@property (nonatomic, readwrite, copy) AFCompletionHandler completionHandler;
- (void)cancelAllHTTPOperationsWithPath:(NSString *)path;
@end
