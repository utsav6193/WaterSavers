//
//  AFAPIClient.m
//  Hubdin
//
//  Created by MAC237 on 5/1/14.
//  Copyright (c) 2014 MAC. All rights reserved.
//

#import "AFAPIClient.h"

static NSString *const AFAppDotNetAPIBaseURLString = MAIN_URL;

@implementation AFAPIClient

+ (instancetype)sharedClient {
	static AFAPIClient *_sharedClient = nil;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	    _sharedClient = [[AFAPIClient alloc] initWithBaseURL:[NSURL URLWithString:AFAppDotNetAPIBaseURLString]];
	    _sharedClient.requestSerializer = [AFJSONRequestSerializer serializer];
	    //_sharedClient.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
	    _sharedClient.securityPolicy.allowInvalidCertificates = YES;
	    _sharedClient.requestSerializer.timeoutInterval = 60;
	    [_sharedClient.requestSerializer setValue:@"multipart/form-data" forHTTPHeaderField:@"Content-Type"];
	    _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];


	});
	return _sharedClient;
}

- (void)cancelAllHTTPOperationsWithPath:(NSString *)path {
	NSArray *operations = self.operationQueue.operations;
	for (AFHTTPRequestOperation *operation in operations) {
		NSString *urlString = [operation.request.URL path];
		if ([urlString isEqualToString:path]) {
			NSLog(@"---------------- Cancelled Path %@", path);
			[operation cancel];
		}
	}
}

@end
