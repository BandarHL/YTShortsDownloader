//
//  YTHeaders.h
//  YTShortsDownloader
//
//  Created by BandarHelal on 27/04/2021.
//

#import "BHDownload.h"
#import "JGProgressHUD/include/JGProgressHUD.h"
#import "BHVideoManager/BHVideoManager.h"
#import <Photos/Photos.h>
#import <SafariServices/SafariServices.h>


@interface YTQTMButton : UIButton
@property(readonly, nonatomic) long long pageStyle;
@property(nonatomic) CGFloat minHitTargetSize;
@property(nonatomic) CGFloat horizontalContentPadding;
@property(nonatomic) CGFloat verticalContentPadding;
@property(nonatomic) CGFloat buttonImageTitlePadding;
@property(nonatomic) long long buttonLayoutStyle;
+ (id)buttonWithImage:(id)arg1 accessibilityLabel:(id)arg2 accessibilityIdentifier:(id)arg3;
+ (id)barButtonWithImage:(id)arg1 accessibilityLabel:(id)arg2 accessibilityIdentifier:(id)arg3;
@end

@interface YTReelPlayerBottomButton : YTQTMButton
@end

@interface YTIFormatStream : NSObject
@property BOOL hasInitRange;
@property(copy, nonatomic) NSString *URL; // @dynamic URL;
@property(nonatomic) int fps; // @dynamic fps;
@property(nonatomic) int height; // @dynamic height;
@property(nonatomic) _Bool highReplication; // @dynamic highReplication;
@property(nonatomic) int itag; // @dynamic itag;
@property(nonatomic) long long lastModified; // @dynamic lastModified;
@property(nonatomic) float loudnessDb; // @dynamic loudnessDb;
@property(nonatomic) double maxDvrDurationSec; // @dynamic maxDvrDurationSec;
@property(copy, nonatomic) NSString *mimeType; // @dynamic mimeType;
@property(nonatomic) int projectionType; // @dynamic projectionType;
@property(copy, nonatomic) NSString *quality; // @dynamic quality;
@property(copy, nonatomic) NSString *qualityLabel; // @dynamic qualityLabel;
@property(copy, nonatomic) NSString *signatureCipher; // @dynamic signatureCipher;
@property(nonatomic) int spatialAudioType; // @dynamic spatialAudioType;
@property(nonatomic) int stereoLayout; // @dynamic stereoLayout;
@property(nonatomic) double targetDurationSec; // @dynamic targetDurationSec;
@property(nonatomic) int type; // @dynamic type;
@property(nonatomic) int width; // @dynamic width;
@property(copy, nonatomic) NSString *xtags; // @dynamic xtags;
@end

@interface MLFormat : NSObject
@property(readonly, nonatomic) int singleDimensionResolution;
@property(readonly, nonatomic) NSString *qualityLabel;
@property(readonly, nonatomic) int audioQuality;
@property(readonly, nonatomic) NSString *xtags;
@property(readonly, nonatomic) int itag;
@property(readonly, nonatomic) YTIFormatStream *formatStream;
@property(readonly, nonatomic) _Bool isVideo;
@property(readonly, nonatomic) _Bool isAudio;
@property(readonly, nonatomic) double FPS;
@property(readonly, nonatomic) int height;
@property(readonly, nonatomic) int width;
@property(readonly, nonatomic) NSString *ID;
@property(readonly, nonatomic) _Bool isText;
@property(readonly, nonatomic, getter=isLocalFile) _Bool localFile;
@property(readonly, nonatomic) NSString *debugIDForQOE;
@property(readonly, nonatomic) long long lastModifiedTimeMicroseconds;
@property(readonly, nonatomic) float aspectRatio;
@property(readonly, nonatomic) _Bool OTF;
@property(readonly, nonatomic) NSString *streamIdentifierTagsLabel;
@property(readonly, nonatomic) _Bool isDefaultAudio;
@property(readonly, nonatomic, getter=isVideoOnly) _Bool videoOnly;
@property(readonly, nonatomic, getter=isAudioOnly) _Bool audioOnly;
@property(readonly, nonatomic, getter=isVideoVertical) _Bool videoVertical;
@property(readonly, nonatomic, getter=isFairPlayFormat) _Bool fairPlayFormat;
@property(readonly, nonatomic, getter=isWebMFormat) _Bool webMFormat;
@property(readonly, nonatomic, getter=isMP4Format) _Bool MP4Format;
@property(readonly, nonatomic, getter=isHLSFormat) _Bool HLSFormat;
@end



@interface YTIStreamingData : NSObject
@property NSArray *adaptiveFormatsArray;
@end

@interface YTSingleVideoController : NSObject
@property(readonly, nonatomic) MLFormat *selectedAudioFormat;
@property(readonly, nonatomic) NSArray *selectableVideoFormats;
@property(readonly, nonatomic) NSArray *selectableAudioFormats;
@end

@interface YTLightweightPlayerViewController : UIViewController
@property(readonly, nonatomic) id /*<YTSingleVideoObservable>*/ contentVideo;
@property(readonly, nonatomic) id /*<YTSingleVideoObservable>*/ activeVideo;
@end

@interface YTReelWatchHeaderView : UIView
@end

@interface YTReelWatchPlaybackOverlayView : UIView
@property(readonly, nonatomic) YTQTMButton *overflowButton;
@property(strong, nonatomic, readwrite) YTReelWatchHeaderView *headerView;
@property(readonly, nonatomic) __weak id /*<YTResponder>*/ parentResponder;
// @property(readonly, nonatomic) NSArray *interactiveElements;
@end

@interface YTReelModel : NSObject
@property(readonly, nonatomic, getter=isShortVideo) _Bool shortVideo;
@end

@interface YTReelPlayerViewController : UIViewController
@property (strong, nonatomic) UIWindow *window2;
@property (strong, nonatomic) JGProgressHUD *hud;
@property (retain, nonatomic) YTLightweightPlayerViewController *player;
@property(readonly, nonatomic) YTReelModel *model;
- (void)pause;
- (void)play;
- (void)restart;
- (void)reelContentViewRequestsSuspendPlayback:(id)arg1;
- (void)reelContentViewRequestsResumePlayback:(id)arg1;
- (void)didPressDownloadButton;
- (void)closeWindow;
- (NSString *)getDownloadingPersent:(float)per;
@end

@interface YTReelPlayerViewController () <BHDownloadDelegate>
@end

@interface YTReelContentView : UIView
@property(readonly, nonatomic) YTReelWatchPlaybackOverlayView *playbackOverlay;
@property(readonly, nonatomic) __weak id parentResponder;
@end

@interface YTAppDelegate : UIResponder
- (void)cleanCache;
- (BOOL)isEmpty:(NSURL *)url;
@end

@interface PINCachedAnimatedImage : NSObject
@property(readonly, nonatomic) NSData *data;
@end

@interface ASDisplayNode: NSObject
@property (readonly) UIView *view;
@end

@interface ASImageNode: ASDisplayNode
@property (atomic, strong, readwrite) UIImage *image;
@property(retain) id /*<ASAnimatedImageProtocol>*/ animatedImage;
@end

@interface ASNetworkImageNode: ASImageNode
@property (atomic, copy, readwrite) NSURL *URL;
@end

@interface YTImageZoomNode: ASNetworkImageNode
- (void)saveHandler;
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
@end

static UIViewController *_topMostController(UIViewController *cont) {
    UIViewController *topController = cont;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }
    if ([topController isKindOfClass:[UINavigationController class]]) {
        UIViewController *visible = ((UINavigationController *)topController).visibleViewController;
        if (visible) {
            topController = visible;
        }
    }
    return (topController != cont ? topController : nil);
}
static UIViewController *topMostController() {
    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *next = nil;
    while ((next = _topMostController(topController)) != nil) {
        topController = next;
    }
    return topController;
}
