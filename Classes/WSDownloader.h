//
//  WSDownloader.h
//
//  Copyright (c) 2014 Wander Siemers. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WSDownloaderJSONCompletionBlock)(id JSON, NSError *error);
typedef void (^WSDownloaderDataCompletionBlock)(NSData *binaryData, NSError *error);
typedef void (^WSDownloaderImageCompletionBlock)(UIImage *image, NSError *error);
typedef void (^WSDownloadUploadCompletionBlock)(id responseObject, NSError *error);


@interface WSDownloader : NSObject

/** Downloads JSON from the passed in string, adds the parameters to the url and calls block on completion
 @param URLString The base string from where to download the JSON data
 @param parameters Optional parameters to the URL; may be nil
 @param block The callback block, which is called on completion and contains the JSON (as an NSArray or dictionary) or an error object. Will be called on main queue.
 */

+ (void)downloadJSONFromURL:(NSURL *)url parameters:(NSDictionary *)parameters completion:(WSDownloaderJSONCompletionBlock)completionBlock;

/** Downloads binary data (able to be initialized by NSData) from url and calls block on completion
 @param url The url from where to download the NSData
 @param block The callback block, which is called on completion and contains the response data (as NSData if possible) or an error object. Will be called
 on main queue.
 */
+ (void)downloadBinaryDataFromURL:(NSURL *)url completion:(WSDownloaderDataCompletionBlock)completionBlock;

/** Downloads an image from the passed NSURL and calls the completion block when done
 
 @param url The URL to download the image from
 @param block Callback block returning the UIImage downloaded from url, or nil in case of an error. Will be called on main queue.
 */
+ (void)downloadImageFromURL:(NSURL *)url completion:(WSDownloaderImageCompletionBlock)completionBlock;

/** Sends a PUT HTTP request to the passed passed URL with the contents of dictionary as parameters and calls the completion block on completion
 
 @param dictionary The data to upload to the passed url
 @param url The URL to upload the data to
 @param completionBlock The callback block, which is called on completion of the upload (whether failed or succesful).
 
 @note If the completion block's error parameter is non-nil, the download was unsuccessful and responseObject will be nil.
 */
+ (void)uploadDictionary:(NSDictionary *)dictionary toURL:(NSURL *)url completion:(WSDownloadUploadCompletionBlock)completionBlock;

@end

