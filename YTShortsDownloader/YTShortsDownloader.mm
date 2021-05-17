#line 1 "/Users/bandarhelal/Documents/GitHub/YTShortsDownloader/YTShortsDownloader/YTShortsDownloader.xm"
#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
#import "YTHeaders.h"




#include <objc/message.h>
#if defined(__clang__)
#if __has_feature(objc_arc)
#define _LOGOS_SELF_TYPE_NORMAL __unsafe_unretained
#define _LOGOS_SELF_TYPE_INIT __attribute__((ns_consumed))
#define _LOGOS_SELF_CONST const
#define _LOGOS_RETURN_RETAINED __attribute__((ns_returns_retained))
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif
#else
#define _LOGOS_SELF_TYPE_NORMAL
#define _LOGOS_SELF_TYPE_INIT
#define _LOGOS_SELF_CONST
#define _LOGOS_RETURN_RETAINED
#endif

__attribute__((unused)) static void _logos_register_hook(Class _class, SEL _cmd, IMP _new, IMP *_old) {
unsigned int _count, _i;
Class _searchedClass = _class;
Method *_methods;
while (_searchedClass) {
_methods = class_copyMethodList(_searchedClass, &_count);
for (_i = 0; _i < _count; _i++) {
if (method_getName(_methods[_i]) == _cmd) {
if (_class == _searchedClass) {
*_old = method_getImplementation(_methods[_i]);
*_old = method_setImplementation(_methods[_i], _new);
} else {
class_addMethod(_class, _cmd, _new, method_getTypeEncoding(_methods[_i]));
}
free(_methods);
return;
}
}
free(_methods);
_searchedClass = class_getSuperclass(_searchedClass);
}
}
@class YTReelPlayerViewController; @class YTQTMButton; 
static Class _logos_superclass$_ungrouped$YTReelPlayerViewController; static void (*_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST, SEL);
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$YTQTMButton(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("YTQTMButton"); } return _klass; }
#line 7 "/Users/bandarhelal/Documents/GitHub/YTShortsDownloader/YTShortsDownloader/YTShortsDownloader.xm"

__attribute__((used)) static UIWindow * _logos_property$_ungrouped$YTReelPlayerViewController$window2(YTReelPlayerViewController * __unused self, SEL __unused _cmd) { return (UIWindow *)objc_getAssociatedObject(self, (void *)_logos_property$_ungrouped$YTReelPlayerViewController$window2); };
__attribute__((used)) static void _logos_property$_ungrouped$YTReelPlayerViewController$setWindow2(YTReelPlayerViewController * __unused self, SEL __unused _cmd, UIWindow * rawValue) { objc_setAssociatedObject(self, (void *)_logos_property$_ungrouped$YTReelPlayerViewController$window2, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
__attribute__((used)) static JGProgressHUD * _logos_property$_ungrouped$YTReelPlayerViewController$hud(YTReelPlayerViewController * __unused self, SEL __unused _cmd) { return (JGProgressHUD *)objc_getAssociatedObject(self, (void *)_logos_property$_ungrouped$YTReelPlayerViewController$hud); };
__attribute__((used)) static void _logos_property$_ungrouped$YTReelPlayerViewController$setHud(YTReelPlayerViewController * __unused self, SEL __unused _cmd, JGProgressHUD * rawValue) { objc_setAssociatedObject(self, (void *)_logos_property$_ungrouped$YTReelPlayerViewController$hud, rawValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC); }
static void _logos_method$_ungrouped$YTReelPlayerViewController$viewDidLoad(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    (_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad ? _logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad : (__typeof__(_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad))class_getMethodImplementation(_logos_superclass$_ungrouped$YTReelPlayerViewController, @selector(viewDidLoad)))(self, _cmd);
    YTQTMButton *DownloadButton = [_logos_static_class_lookup$YTQTMButton() buttonWithImage:[UIImage systemImageNamed:@"arrow.down"] accessibilityLabel:@"download fleet button" accessibilityIdentifier:@"download.fleet.button"];
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
 static void _logos_method$_ungrouped$YTReelPlayerViewController$didPressDownloadButton(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    self.window2 = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window2.windowLevel = UIWindowLevelAlert;
    [self.window2 setRootViewController:[[UIViewController alloc] init]];
    [self.window2 makeKeyAndVisible];
    
    [self reelContentViewRequestsSuspendPlayback:self];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"hi" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    YTSingleVideoController *video = self.player.activeVideo;
    for (MLFormat *format in video.selectableVideoFormats) {
        if ([format.formatStream.mimeType containsString:@"video/mp4"]) {
            UIAlertAction *download = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%dx%d", format.formatStream.height, format.formatStream.width] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
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
 static void _logos_method$_ungrouped$YTReelPlayerViewController$closeWindow(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    self.window2.rootViewController.view = nil;
    self.window2.rootViewController = nil;
    self.window2.windowScene = nil;
    [self.window2 setHidden:true];
    [self reelContentViewRequestsResumePlayback:self];
}
 static void _logos_method$_ungrouped$YTReelPlayerViewController$downloadProgress$(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, float progress) {
    self.hud.detailTextLabel.text = [self getDownloadingPersent:progress];
}

 static void _logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFinish$Filename$(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * filePath, NSString * fileName) {
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
                        [self closeWindow];
                    });
                });
            } else {
                
                NSURL *newAudioFilePath = [[NSURL fileURLWithPath:NSTemporaryDirectory()] URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", NSUUID.UUID.UUIDString]];
                [manager moveItemAtURL:location toURL:newAudioFilePath error:nil];
                
                AVURLAsset *asset = [AVURLAsset URLAssetWithURL:newFilePath options:nil];
                [BHVideoManager TrimVideoWithPath:newFilePath StartTime:kCMTimeZero EndTime:CMTimeMake(asset.duration.value/2, asset.duration.timescale) SaveFileToPath:[NSURL fileURLWithPath:NSTemporaryDirectory()] TitleFile:NSUUID.UUID.UUIDString CompletionHandler:^(AVAssetExportSession *cutVideoSession) {
                    if (AVAssetExportSessionStatusCompleted == cutVideoSession.status) {
                        
                        [BHVideoManager MergeVideo:cutVideoSession.outputURL WithAudio:newAudioFilePath SaveFileToPath:[NSURL fileURLWithPath:NSTemporaryDirectory()] TitleFile:NSUUID.UUID.UUIDString CompletionHandler:^(AVAssetExportSession *audioSession) {
                            if (AVAssetExportSessionStatusCompleted == audioSession.status) {
                                
                                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        [self.hud dismiss];
                                        UIActivityViewController *acVC = [[UIActivityViewController alloc] initWithActivityItems:@[audioSession.outputURL] applicationActivities:nil];
                                        [acVC setCompletionWithItemsHandler:^(UIActivityType _Nullable activityType, BOOL completed, NSArray * _Nullable returnedItems, NSError * _Nullable activityError) {
                                            [self closeWindow];
                                        }];
                                        [self.window2.rootViewController presentViewController:acVC animated:true completion:nil];
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
            [self closeWindow];
        }];
        [self.window2.rootViewController presentViewController:acVC animated:true completion:nil];
    }
}
 static void _logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFailureWithError$(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSError * error) {
    if (error) {
        [self.hud dismiss];
        [self closeWindow];
    }
}
 static NSString * _logos_method$_ungrouped$YTReelPlayerViewController$getDownloadingPersent$(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, float per) {
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterPercentStyle];
    NSNumber *number = [NSNumber numberWithFloat:per];
    return [numberFormatter stringFromNumber:number];
}

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTReelPlayerViewController = objc_getClass("YTReelPlayerViewController"); _logos_superclass$_ungrouped$YTReelPlayerViewController = class_getSuperclass(_logos_class$_ungrouped$YTReelPlayerViewController); { objc_property_attribute_t _attributes[16]; unsigned int attrc = 0; _attributes[attrc++] = (objc_property_attribute_t) { "T", "@\"UIWindow\"" }; _attributes[attrc++] = (objc_property_attribute_t) { "&", "" }; _attributes[attrc++] = (objc_property_attribute_t) { "N", "" }; class_addProperty(_logos_class$_ungrouped$YTReelPlayerViewController, "window2", _attributes, attrc); char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(window2), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$window2, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(setWindow2:), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$setWindow2, _typeEncoding); } { objc_property_attribute_t _attributes[16]; unsigned int attrc = 0; _attributes[attrc++] = (objc_property_attribute_t) { "T", "@\"JGProgressHUD\"" }; _attributes[attrc++] = (objc_property_attribute_t) { "&", "" }; _attributes[attrc++] = (objc_property_attribute_t) { "N", "" }; class_addProperty(_logos_class$_ungrouped$YTReelPlayerViewController, "hud", _attributes, attrc); char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(JGProgressHUD *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(hud), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$hud, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(JGProgressHUD *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(setHud:), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$setHud, _typeEncoding); } { _logos_register_hook(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$viewDidLoad, (IMP *)&_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(didPressDownloadButton), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$didPressDownloadButton, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(closeWindow), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$closeWindow, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = 'f'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadProgress:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadProgress$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSURL *), strlen(@encode(NSURL *))); i += strlen(@encode(NSURL *)); memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadDidFinish:Filename:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFinish$Filename$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadDidFailureWithError:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFailureWithError$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = 'f'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(getDownloadingPersent:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$getDownloadingPersent$, _typeEncoding); }} }
#line 132 "/Users/bandarhelal/Documents/GitHub/YTShortsDownloader/YTShortsDownloader/YTShortsDownloader.xm"
