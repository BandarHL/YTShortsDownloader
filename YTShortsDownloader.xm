#import <UIKit/UIKit.h>
#import "YTHeaders.h"

%config(generator=internal)

%hook YTAppDelegate
- (_Bool)application:(UIApplication *)application didFinishLaunchingWithOptions:(id)arg2 {
    %orig;
    [self cleanCache];
    return true;
}
%new - (void)cleanCache {
    NSArray <NSURL *> *DocumentFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL fileURLWithPath:NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject] includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    for (NSURL *file in DocumentFiles) {
        if ([file.pathExtension.lowercaseString isEqualToString:@"mp4"]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
    }
    
    NSArray <NSURL *> *TempFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:[NSURL fileURLWithPath:NSTemporaryDirectory()] includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    
    for (NSURL *file in TempFiles) {
        if ([file.pathExtension.lowercaseString isEqualToString:@"mp4"]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
        if ([file.pathExtension.lowercaseString isEqualToString:@"mov"]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
        if ([file.pathExtension.lowercaseString isEqualToString:@"m4a"]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
        if ([file.pathExtension.lowercaseString isEqualToString:@"tmp"]) {
            [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
        }
        if ([file hasDirectoryPath]) {
            if ([self isEmpty:file]) {
                [[NSFileManager defaultManager] removeItemAtURL:file error:nil];
            }
        }
    }
}
%new - (BOOL)isEmpty:(NSURL *)url {
    NSArray *FolderFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    if (FolderFiles.count == 0) {
        return true;
    } else {
        return false;
    }
}
%end

%hook YTReelPlayerViewController
%property (strong, nonatomic) UIWindow *window2;
%property (strong, nonatomic) JGProgressHUD *hud;
- (void)viewDidLoad {
    %orig;
    YTQTMButton *DownloadButton = [%c(YTQTMButton) buttonWithImage:[UIImage systemImageNamed:@"arrow.down"] accessibilityLabel:@"download fleet button" accessibilityIdentifier:@"download.fleet.button"];
    [DownloadButton setTranslatesAutoresizingMaskIntoConstraints:false];
    [DownloadButton addTarget:self action:@selector(didPressDownloadButton) forControlEvents:64];
    [DownloadButton.imageView setTintColor:UIColor.labelColor];
    if ([self.view isKindOfClass:NSClassFromString(@"YTReelContentView")]) {
        YTReelContentView *_view = self.view;
        [_view.playbackOverlay addSubview:DownloadButton];
        
        if (self.model.isShortVideo) {
            [NSLayoutConstraint activateConstraints:@[
                [DownloadButton.trailingAnchor constraintEqualToAnchor:_view.trailingAnchor],
                [DownloadButton.bottomAnchor constraintEqualToAnchor:_view.playbackOverlay.overflowButton.topAnchor],
                [DownloadButton.heightAnchor constraintEqualToConstant:48],
                [DownloadButton.widthAnchor constraintEqualToConstant:64]
            ]];
        } else {
            [NSLayoutConstraint activateConstraints:@[
                [DownloadButton.trailingAnchor constraintEqualToAnchor:_view.trailingAnchor],
                [DownloadButton.bottomAnchor constraintEqualToAnchor:_view.playbackOverlay.headerView.topAnchor],
                [DownloadButton.heightAnchor constraintEqualToConstant:48],
                [DownloadButton.widthAnchor constraintEqualToConstant:64]
            ]];
        }
    }
}
%new - (void)didPressDownloadButton {

    [self reelContentViewRequestsSuspendPlayback:self];

    YTSingleVideoController *video = self.player.activeVideo;
    id SingleVideo = [video valueForKey:@"_singleVideo"];
    id PlaybackData = [SingleVideo valueForKey:@"_playbackData"];
    id MLvideo = [PlaybackData valueForKey:@"_video"];
    id Streaming = [MLvideo valueForKey:@"_streamingData"];
    YTIStreamingData *StreamingData = [Streaming valueForKey:@"_streamingData"];
    
    
    NSMutableArray *LinksArray = [[NSMutableArray alloc] init];
    NSMutableArray *Qualities = [[NSMutableArray alloc] init];


    for (CFIndex Counter = 0; Counter < StreamingData.adaptiveFormatsArray.count; Counter ++) {
    if ([[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] mimeType] containsString:@"video/mp4"] && [[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] hasInitRange] && ![Qualities containsObject:[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] qualityLabel]]) {

    [LinksArray addObject:[NSString stringWithFormat:@"%@",[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] URL]]];
    [Qualities addObject:[NSString stringWithFormat:@"%@",[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] qualityLabel]]];
    }
    }

    [BHDownload InitAlertWithTitle:@"Hola" Message:@"" Buttons:Qualities CancelButtonTitle:@"Cancel" AlertStyle:UIAlertControllerStyleActionSheet OnViewController:topMostController() handler:^(NSString * _Nonnull ButtonTitle, NSUInteger index) {

        if (index >= 0) {

            BHDownload *DownloadManager = [[BHDownload alloc] init];
            [DownloadManager downloadFileWithURL:[NSURL URLWithString:LinksArray[index]]];
            [DownloadManager setDelegate:self];
            self.hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            self.hud.textLabel.text = @"Downloading";
            [self.hud showInView:topMostController().view];

        }
       }];
    
}
 
%new - (void)downloadProgress:(float)progress {
    self.hud.detailTextLabel.text = [self getDownloadingPersent:progress];
}

%new - (void)downloadDidFinish:(NSURL *)filePath Filename:(NSString *)fileName {
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *newFilePath = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", NSUUID.UUID.UUIDString]];
    [manager moveItemAtURL:filePath toURL:newFilePath error:nil];
    
    if ([self.player.activeVideo isKindOfClass:NSClassFromString(@"YTSingleVideoController")]) {
        YTSingleVideoController *video = self.player.activeVideo;
        [[[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:video.selectedAudioFormat.formatStream.URL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if (error) {
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.hud dismiss];

                    });
                });
            } else {
                // rename the audio file with .m4a extension and move it
                NSURL *newAudioFilePath = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", NSUUID.UUID.UUIDString]];
                [manager moveItemAtURL:location toURL:newAudioFilePath error:nil];
                // 1- cut video by half
                AVURLAsset *asset = [AVURLAsset URLAssetWithURL:newFilePath options:nil];
                [BHVideoManager TrimVideoWithPath:newFilePath StartTime:kCMTimeZero EndTime:CMTimeMake(asset.duration.value/2, asset.duration.timescale) SaveFileToPath:[NSURL fileURLWithPath:NSTemporaryDirectory()] TitleFile:NSUUID.UUID.UUIDString CompletionHandler:^(AVAssetExportSession *cutVideoSession) {
                    if (AVAssetExportSessionStatusCompleted == cutVideoSession.status) {
                        // 2- merge video with audio
                        [BHVideoManager MergeVideo:cutVideoSession.outputURL WithAudio:newAudioFilePath SaveFileToPath:[NSURL fileURLWithPath:NSTemporaryDirectory()] TitleFile:NSUUID.UUID.UUIDString CompletionHandler:^(AVAssetExportSession *audioSession) {
                            if (AVAssetExportSessionStatusCompleted == audioSession.status) {
                                // we MUST to get back to main queue so we can edit on the LAYOUT
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.hud dismiss];
                                        UIActivityViewController *acVC = [[UIActivityViewController alloc] initWithActivityItems:@[audioSession.outputURL] applicationActivities:nil];
                                        [acVC setCompletionWithItemsHandler:^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
//
                                        }];
                                        [topMostController() presentViewController:acVC animated:true completion:nil];
                                    });
                                });
                            }
                        }];
                    }
                }];
            }
        }] resume];
    } else {
        [self.hud dismiss];
        UIActivityViewController *acVC = [[UIActivityViewController alloc] initWithActivityItems:@[newFilePath] applicationActivities:nil];
        [acVC setCompletionWithItemsHandler:^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
//
        }];
        [topMostController() presentViewController:acVC animated:true completion:nil];
    }
}
%new - (void)downloadDidFailureWithError:(NSError *)error {
    if (error) {
        [self.hud dismiss];
 
    }
}
%new - (NSString *)getDownloadingPersent:(float)per {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSNumber *number = [NSNumber numberWithFloat:per];
    return [numberFormatter stringFromNumber:number];
}
%end


%hook YTImageZoomNode
- (void)displayDidFinish {
    %orig;
    if (self.view.subviews.count == 1) {
        UIButton *downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [downloadButton setImage:[UIImage systemImageNamed:@"arrow.down"] forState:UIControlStateNormal];
        [downloadButton addTarget:self action:@selector(saveHandler) forControlEvents:UIControlEventTouchUpInside];
        [downloadButton setTranslatesAutoresizingMaskIntoConstraints:false];
        if (self.animatedImage == nil) {
            [self.view addSubview:downloadButton];
            
            [NSLayoutConstraint activateConstraints:@[
                [downloadButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
                [downloadButton.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],
                [downloadButton.heightAnchor constraintEqualToConstant:25],
                [downloadButton.widthAnchor constraintEqualToConstant:25]
            ]];
        }
    }
}
%new - (void)saveHandler {
    if (self.image != nil) {
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else if (self.animatedImage != nil) {
        NSString *url = [NSString stringWithFormat:@"https://ezgif.com/webp-to-gif?url=%@", self.URL.absoluteString];
        SFSafariViewController *webVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [topMostController() presentViewController:webVC animated:true completion:nil];
    }
}
%new - (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"hi" message:error.localizedDescription preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [topMostController() presentViewController:alert animated:true completion:nil];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"hi" message:@"Image saved" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
        [topMostController() presentViewController:alert animated:true completion:nil];
    }
}
%end
