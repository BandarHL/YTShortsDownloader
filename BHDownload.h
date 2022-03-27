//
//  BHDownload.h
//  DIYTableView
//
//  Created by BandarHelal on 12/01/1442 AH.
//  Copyright © 1442 BandarHelal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol BHDownloadDelegate <NSObject>
@optional
- (void)downloadProgress:(float)progress;
- (void)downloadDidFinish:(NSURL *)filePath Filename:(NSString *)fileName;
- (void)downloadDidFailureWithError:(NSError *)error;
@end

@interface BHDownload : NSObject
{
   id delegate;
}
- (void)setDelegate:(id)newDelegate;
- (instancetype)init;
- (void)downloadFileWithURL:(NSURL *)url;
@property (nonatomic, strong) NSString *fileName;

+(void) InitAlertWithTitle:(NSString *)Title Message:(NSString *)Message Buttons:(NSArray *)Buttons CancelButtonTitle:(NSString *)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle OnViewController:(UIViewController *)OnViewController handler:(void(^)(NSString *  ButtonTitle, NSUInteger index))handler;
@end

@interface BHDownload () <NSURLSessionDelegate, NSURLSessionDataDelegate, NSURLSessionDownloadDelegate, NSURLSessionStreamDelegate>
@property (nonatomic, strong) NSURLSession *Session;
@end

NS_ASSUME_NONNULL_END
