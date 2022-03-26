//
//  BHDownload.m
//  DIYTableView
//
//  Created by BandarHelal on 12/01/1442 AH.
//  Copyright © 1442 BandarHelal. All rights reserved.
//

#import "BHDownload.h"

@implementation BHDownload
- (instancetype )init {
    self = [super init];
    if (self) {
        self.Session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    }
    return self;
}


+(void) InitAlertWithTitle:(NSString *)Title Message:(NSString *)Message Buttons:(NSArray *)Buttons CancelButtonTitle:(NSString *)CancelButtonTitle AlertStyle:(UIAlertControllerStyle)AlertStyle OnViewController:(UIViewController *)OnViewController handler:(void(^)(NSString *  ButtonTitle, NSUInteger index))handler {

    UIAlertController *alert = [UIAlertController alertControllerWithTitle:Title message:Message preferredStyle:AlertStyle];
    NSUInteger Counter  = 0;
    for (NSString *EachButton in Buttons) {
    UIAlertAction *action = [UIAlertAction actionWithTitle:EachButton style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    handler(action.title,Counter);
    }];
    [alert addAction:action];
    Counter ++;
    }
    if (!(CancelButtonTitle == NULL)) {
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:CancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    [cancelAction setValue:UIColor.redColor forKey:@"titleTextColor"];
    [alert addAction:cancelAction];

    }
    [OnViewController presentViewController:alert animated:true completion:nil];
}

- (void)downloadFileWithURL:(NSURL *)url {
    if (url) {
        self.fileName = url.absoluteString.lastPathComponent;
        NSURLSessionDownloadTask *downloadTask = [self.Session downloadTaskWithURL:url];
        [downloadTask resume];
    }
}
- (void)setDelegate:(id)newDelegate {
    if (newDelegate) {
        delegate = newDelegate;
    }
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    float prog = (float)totalBytesWritten / (float)totalBytesExpectedToWrite;
    [delegate downloadProgress:prog];
}
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(nonnull NSURL *)location {
    [delegate downloadDidFinish:location Filename:self.fileName];
}
- (void)URLSession:(NSURLSession *)session didBecomeInvalidWithError:(NSError *)error {
    [delegate downloadDidFailureWithError:error];
}
- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    [delegate downloadDidFailureWithError:error];
    
   
}
@end
