#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "YTHeaders.h"

%config(generator=internal)

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
        
        [NSLayoutConstraint activateConstraints:@[
            [DownloadButton.trailingAnchor constraintEqualToAnchor:_view.trailingAnchor],
            [DownloadButton.bottomAnchor constraintEqualToAnchor:_view.playbackOverlay.overflowButton.topAnchor],
            [DownloadButton.heightAnchor constraintEqualToConstant:48],
            [DownloadButton.widthAnchor constraintEqualToConstant:64]
        ]];
    }
}
%new - (void)didPressDownloadButton {
    self.window2 = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window2.windowLevel = UIWindowLevelAlert;
    [self.window2 setRootViewController:[[UIViewController alloc] init]];
    [self.window2 makeKeyAndVisible];
    
    [self reelContentViewRequestsSuspendPlayback:self];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"hi" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    YTSingleVideoController *video = self.player.activeVideo;
    for (MLFormat *format in video.selectableVideoFormats) {
        if ([format.formatStream.mimeType containsString:@"video/mp4"]) {
            UIAlertAction *download = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%dx%d", format.formatStream.width, format.formatStream.height] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                BHDownload *DownloadManager = [[BHDownload alloc] initWithBackgroundSessionID:NSUUID.UUID.UUIDString];
                [DownloadManager downloadFileWithURL:[NSURL URLWithString:format.formatStream.URL]];
                [DownloadManager setDelegate:self];
                self.hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
                self.hud.textLabel.text = @"Downloading";
                [self.hud showInView:self.window2.rootViewController.view];
            }];
            [alert addAction:download];
        }
    }
    [alert addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self closeWindow];
    }]];
    [self.window2.rootViewController presentViewController:alert animated:true completion:nil];
}
%new - (void)closeWindow {
    self.window2.rootViewController.view = nil;
    self.window2.rootViewController = nil;
    self.window2.windowScene = nil;
    [self.window2 setHidden:true];
    [self reelContentViewRequestsResumePlayback:self];
}
%new - (void)downloadProgress:(float)progress {
    self.hud.detailTextLabel.text = [self getDownloadingPersent:progress];
}

%new - (void)downloadDidFinish:(NSURL *)filePath Filename:(NSString *)fileName {
    NSString *DocPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true).firstObject;
    NSFileManager *manager = [NSFileManager defaultManager];
    NSURL *newFilePath = [[NSURL fileURLWithPath:DocPath] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", NSUUID.UUID.UUIDString]];
    [manager moveItemAtURL:filePath toURL:newFilePath error:nil];
    
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:newFilePath];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        [self.hud dismiss];
        [self closeWindow];
    }];
}
%new - (void)downloadDidFailureWithError:(NSError *)error {
    if (error) {
        [self.hud dismiss];
        [self closeWindow];
    }
}
%new - (NSString *)getDownloadingPersent:(float)per {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSNumber *number = [NSNumber numberWithFloat:per];
    return [numberFormatter stringFromNumber:number];
}
%end
