//
//  WSDownloader.m
//
//  Copyright (c) 2014 Wander Siemers. All rights reserved.
//

#import "WSDownloader.h"
#import "AFNetworking.h"

@implementation WSDownloader

+ (void)downloadJSONFromURL:(NSURL *)url parameters:(NSDictionary *)parameters completion:(WSDownloaderJSONCompletionBlock)completionBlock
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	[manager GET:[url absoluteString]
	  parameters:parameters
		 success:^(AFHTTPRequestOperation *operation, id responseObject) {
			 dispatch_async(dispatch_get_main_queue(), ^{
				 completionBlock(responseObject, nil);
			 });
		 } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			 completionBlock(nil, error);
		 }];
}

+ (void)downloadImageFromURL:(NSURL *)url completion:(WSDownloaderImageCompletionBlock)completionBlock
{
	NSError *error;
	if (!url) {
		completionBlock(nil, error);
	}
	
	NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
	request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
	AFHTTPRequestOperation *requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:[NSURLRequest requestWithURL:url]];
	requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
	[requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
		dispatch_async(dispatch_get_main_queue(), ^{
			completionBlock(responseObject, nil);
		});
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		dispatch_async(dispatch_get_main_queue(), ^{
			completionBlock(nil, error);
		});
	}];
	NSOperationQueue *queue = [[NSOperationQueue alloc] init];
	[queue addOperation:requestOperation];
}

+ (void)downloadBinaryDataFromURL:(NSURL *)url completion:(WSDownloaderDataCompletionBlock)completionBlock
{
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:[NSURLRequest requestWithURL:url] completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
		if (error) {
			dispatch_async(dispatch_get_main_queue(), ^{
				completionBlock(nil, error);
			});
			return;
		}
		
		dispatch_async(dispatch_get_main_queue(), ^{
			completionBlock(responseObject, nil);
		});
	}];
	[dataTask resume];
}

+ (void)uploadDictionary:(NSDictionary *)dictionary toURL:(NSURL *)url completion:(WSDownloadUploadCompletionBlock)completionBlock
{
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	[manager POST:[url absoluteString] parameters:dictionary
		  success:^(AFHTTPRequestOperation *operation, id responseObject) {
			  completionBlock(responseObject, nil);
		  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
			  completionBlock(nil, error);
		  }];
	
}

@end
