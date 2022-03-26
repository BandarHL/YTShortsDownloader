#line 1 "/Users/crazymind90/Downloads/YTShortsDownloader-main/YTShortsDownloader/YTShortsDownloader.xm"
#import <UIKit/UIKit.h>
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
@class YTAppDelegate; @class YTQTMButton; @class YTReelPlayerViewController; @class YTImageZoomNode; 
static Class _logos_superclass$_ungrouped$YTAppDelegate; static _Bool (*_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$)(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST, SEL, UIApplication *, id);static Class _logos_superclass$_ungrouped$YTReelPlayerViewController; static void (*_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad)(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST, SEL);static Class _logos_superclass$_ungrouped$YTImageZoomNode; static void (*_logos_orig$_ungrouped$YTImageZoomNode$displayDidFinish)(_LOGOS_SELF_TYPE_NORMAL YTImageZoomNode* _LOGOS_SELF_CONST, SEL);
static __inline__ __attribute__((always_inline)) __attribute__((unused)) Class _logos_static_class_lookup$YTQTMButton(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("YTQTMButton"); } return _klass; }
#line 6 "/Users/crazymind90/Downloads/YTShortsDownloader-main/YTShortsDownloader/YTShortsDownloader.xm"

static _Bool _logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIApplication * application, id arg2) {
    (_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$ ? _logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$ : (__typeof__(_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$))class_getMethodImplementation(_logos_superclass$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:)))(self, _cmd, application, arg2);
    [self cleanCache];
    return true;
}
 static void _logos_method$_ungrouped$YTAppDelegate$cleanCache(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
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
 static BOOL _logos_method$_ungrouped$YTAppDelegate$isEmpty$(_LOGOS_SELF_TYPE_NORMAL YTAppDelegate* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, NSURL * url) {
    NSArray *FolderFiles = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:@[] options:NSDirectoryEnumerationSkipsHiddenFiles error:nil];
    if (FolderFiles.count == 0) {
        return true;
    } else {
        return false;
    }
}



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
 static void _logos_method$_ungrouped$YTReelPlayerViewController$didPressDownloadButton(_LOGOS_SELF_TYPE_NORMAL YTReelPlayerViewController* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    self.window2 = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window2.windowLevel = UIWindowLevelAlert;
    [self.window2 setRootViewController:[[UIViewController alloc] init]];
    [self.window2 makeKeyAndVisible];
    
    [self reelContentViewRequestsSuspendPlayback:self];

    YTSingleVideoController *video = self.player.activeVideo;
    id SingleVideo = [video valueForKey:@"_singleVideo"];
    id PlaybackData = [SingleVideo valueForKey:@"_playbackData"];
    id MLvideo = [PlaybackData valueForKey:@"_video"];
    id Streaming = [MLvideo valueForKey:@"_streamingData"];
    YTIStreamingData *StreamingData = [Streaming valueForKey:@"_streamingData"];
    
    
    NSMutableArray *LinksArray = [[NSMutableArray alloc] init];
    NSMutableArray *Qualities = [[NSMutableArray alloc] init];

    NSString *AudioLink = nil;

    for (CFIndex Counter = 0; Counter < StreamingData.adaptiveFormatsArray.count; Counter ++) {
    if ([[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] mimeType] containsString:@"video/mp4"] && [[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] hasInitRange] && ![Qualities containsObject:[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] qualityLabel]]) {

    [LinksArray addObject:[NSString stringWithFormat:@"%@",[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] URL]]];
    [Qualities addObject:[NSString stringWithFormat:@"%@",[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] qualityLabel]]];
    }
    if ([[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] mimeType] containsString:@"audio/mp4"])
    AudioLink = [NSString stringWithFormat:@"%@",[[StreamingData.adaptiveFormatsArray objectAtIndex:Counter] URL]];
    }

    [Qualities addObject:@"Download Audio"];

    [BHDownload InitAlertWithTitle:@"Hola" Message:@"" Buttons:Qualities CancelButtonTitle:@"Cancel" AlertStyle:UIAlertControllerStyleActionSheet OnViewController:self.window2.rootViewController handler:^(NSString * _Nonnull ButtonTitle, NSUInteger index) {
           
        if (index >= 0 && ![ButtonTitle isEqual:@"Download Audio"]) {
            
            BHDownload *DownloadManager = [[BHDownload alloc] init];
            [DownloadManager downloadFileWithURL:[NSURL URLWithString:LinksArray[index]]];
            [DownloadManager setDelegate:self];
            self.hud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleDark];
            self.hud.textLabel.text = @"Downloading";
            [self.hud showInView:self.window2.rootViewController.view];
            
        }
       }];
    
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




static void _logos_method$_ungrouped$YTImageZoomNode$displayDidFinish(_LOGOS_SELF_TYPE_NORMAL YTImageZoomNode* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    (_logos_orig$_ungrouped$YTImageZoomNode$displayDidFinish ? _logos_orig$_ungrouped$YTImageZoomNode$displayDidFinish : (__typeof__(_logos_orig$_ungrouped$YTImageZoomNode$displayDidFinish))class_getMethodImplementation(_logos_superclass$_ungrouped$YTImageZoomNode, @selector(displayDidFinish)))(self, _cmd);
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
 static void _logos_method$_ungrouped$YTImageZoomNode$saveHandler(_LOGOS_SELF_TYPE_NORMAL YTImageZoomNode* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd) {
    if (self.image != nil) {
        UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    } else if (self.animatedImage != nil) {
        NSString *url = [NSString stringWithFormat:@"https://ezgif.com/webp-to-gif?url=%@", self.URL.absoluteString];
        SFSafariViewController *webVC = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:url]];
        [topMostController() presentViewController:webVC animated:true completion:nil];
    }
}
 static void _logos_method$_ungrouped$YTImageZoomNode$image$didFinishSavingWithError$contextInfo$(_LOGOS_SELF_TYPE_NORMAL YTImageZoomNode* _LOGOS_SELF_CONST __unused self, SEL __unused _cmd, UIImage * image, NSError * error, void * contextInfo) {
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

static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$YTAppDelegate = objc_getClass("YTAppDelegate"); _logos_superclass$_ungrouped$YTAppDelegate = class_getSuperclass(_logos_class$_ungrouped$YTAppDelegate); { _logos_register_hook(_logos_class$_ungrouped$YTAppDelegate, @selector(application:didFinishLaunchingWithOptions:), (IMP)&_logos_method$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$, (IMP *)&_logos_orig$_ungrouped$YTAppDelegate$application$didFinishLaunchingWithOptions$);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTAppDelegate, @selector(cleanCache), (IMP)&_logos_method$_ungrouped$YTAppDelegate$cleanCache, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(BOOL), strlen(@encode(BOOL))); i += strlen(@encode(BOOL)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSURL *), strlen(@encode(NSURL *))); i += strlen(@encode(NSURL *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTAppDelegate, @selector(isEmpty:), (IMP)&_logos_method$_ungrouped$YTAppDelegate$isEmpty$, _typeEncoding); }Class _logos_class$_ungrouped$YTReelPlayerViewController = objc_getClass("YTReelPlayerViewController"); _logos_superclass$_ungrouped$YTReelPlayerViewController = class_getSuperclass(_logos_class$_ungrouped$YTReelPlayerViewController); { objc_property_attribute_t _attributes[16]; unsigned int attrc = 0; _attributes[attrc++] = (objc_property_attribute_t) { "T", "@\"UIWindow\"" }; _attributes[attrc++] = (objc_property_attribute_t) { "&", "" }; _attributes[attrc++] = (objc_property_attribute_t) { "N", "" }; class_addProperty(_logos_class$_ungrouped$YTReelPlayerViewController, "window2", _attributes, attrc); char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(window2), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$window2, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(UIWindow *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(setWindow2:), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$setWindow2, _typeEncoding); } { objc_property_attribute_t _attributes[16]; unsigned int attrc = 0; _attributes[attrc++] = (objc_property_attribute_t) { "T", "@\"JGProgressHUD\"" }; _attributes[attrc++] = (objc_property_attribute_t) { "&", "" }; _attributes[attrc++] = (objc_property_attribute_t) { "N", "" }; class_addProperty(_logos_class$_ungrouped$YTReelPlayerViewController, "hud", _attributes, attrc); char _typeEncoding[1024]; sprintf(_typeEncoding, "%s@:", @encode(JGProgressHUD *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(hud), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$hud, _typeEncoding); sprintf(_typeEncoding, "v@:%s", @encode(JGProgressHUD *)); class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(setHud:), (IMP)&_logos_property$_ungrouped$YTReelPlayerViewController$setHud, _typeEncoding); } { _logos_register_hook(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(viewDidLoad), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$viewDidLoad, (IMP *)&_logos_orig$_ungrouped$YTReelPlayerViewController$viewDidLoad);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(didPressDownloadButton), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$didPressDownloadButton, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(closeWindow), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$closeWindow, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = 'f'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadProgress:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadProgress$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSURL *), strlen(@encode(NSURL *))); i += strlen(@encode(NSURL *)); memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadDidFinish:Filename:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFinish$Filename$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(downloadDidFailureWithError:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$downloadDidFailureWithError$, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; memcpy(_typeEncoding + i, @encode(NSString *), strlen(@encode(NSString *))); i += strlen(@encode(NSString *)); _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = 'f'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTReelPlayerViewController, @selector(getDownloadingPersent:), (IMP)&_logos_method$_ungrouped$YTReelPlayerViewController$getDownloadingPersent$, _typeEncoding); }Class _logos_class$_ungrouped$YTImageZoomNode = objc_getClass("YTImageZoomNode"); _logos_superclass$_ungrouped$YTImageZoomNode = class_getSuperclass(_logos_class$_ungrouped$YTImageZoomNode); { _logos_register_hook(_logos_class$_ungrouped$YTImageZoomNode, @selector(displayDidFinish), (IMP)&_logos_method$_ungrouped$YTImageZoomNode$displayDidFinish, (IMP *)&_logos_orig$_ungrouped$YTImageZoomNode$displayDidFinish);}{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTImageZoomNode, @selector(saveHandler), (IMP)&_logos_method$_ungrouped$YTImageZoomNode$saveHandler, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; memcpy(_typeEncoding + i, @encode(UIImage *), strlen(@encode(UIImage *))); i += strlen(@encode(UIImage *)); memcpy(_typeEncoding + i, @encode(NSError *), strlen(@encode(NSError *))); i += strlen(@encode(NSError *)); _typeEncoding[i] = '^'; _typeEncoding[i + 1] = 'v'; i += 2; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$YTImageZoomNode, @selector(image:didFinishSavingWithError:contextInfo:), (IMP)&_logos_method$_ungrouped$YTImageZoomNode$image$didFinishSavingWithError$contextInfo$, _typeEncoding); }} }
#line 250 "/Users/crazymind90/Downloads/YTShortsDownloader-main/YTShortsDownloader/YTShortsDownloader.xm"
