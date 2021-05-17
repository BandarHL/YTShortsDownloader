//
//  BHVideoManager.h
//  BHVideoManager
//
//  Created by BandarHelal on 12/02/1441 AH.
//

#import <UIKit/UIKit.h>
#import <CoreMedia/CoreMedia.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface BHVideoManager : NSObject
+ (void)TrimVideoWithPath:(NSURL *)filepath StartTime:(CMTime)sTime EndTime:(CMTime)eTime SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
+ (void)TrimAudioWithPath:(NSURL *)filepath StartTime:(CMTime)sTime EndTime:(CMTime)eTime SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
+ (void)MergeVideo:(NSURL *)vURL WithAudio:(NSURL *)aURL SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
+ (void)ConvertVideoToAudioWithPath:(NSURL *)filePath SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
+ (void)ConvertAudioToVideoWithPath:(NSURL *)filePath SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
+ (void)ExportVideo:(NSURL *)filePath WithQuality:(NSString *)quality SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler;
@end
