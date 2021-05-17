//
//  BHVideoManager.m
//  BHVideoManager
//
//  Created by BandarHelal on 12/02/1441 AH.
//

#import "BHVideoManager.h"


@implementation BHVideoManager

+ (void)TrimVideoWithPath:(NSURL *)filepath StartTime:(CMTime)sTime EndTime:(CMTime)eTime SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:filepath options:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", title]];
    
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    
    CMTimeRange range = CMTimeRangeMake(sTime, eTime);
    
    exportSession.timeRange = range;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        handler(exportSession);
    }];
    
}

+ (void)TrimAudioWithPath:(NSURL *)filepath StartTime:(CMTime)sTime EndTime:(CMTime)eTime SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    
    AVMutableComposition *newAudioAsset = [AVMutableComposition composition];
    AVMutableCompositionTrack *dstCompositionTrack;
    dstCompositionTrack = [newAudioAsset addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    AVAsset *srcAsset = [AVURLAsset URLAssetWithURL:filepath options:nil];
    AVAssetTrack *srcTrack = [[srcAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    CMTimeRange exportTimeRange = CMTimeRangeFromTimeToTime(sTime, eTime);
    NSError *error;
    
    if (NO == [dstCompositionTrack insertTimeRange:exportTimeRange ofTrack:srcTrack atTime:kCMTimeZero error:&error]) {
        NSLog(@"track insert failed: %@\n", error);
        return;
    }
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:newAudioAsset presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputFileType = AVFileTypeAppleM4A;
    exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", title]];
    
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        handler(exportSession);
    }];
    
}

+ (void)MergeVideo:(NSURL *)vURL WithAudio:(NSURL *)aURL SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    
//    NSString *documentsDirectoryPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, true)[0];
    
    AVURLAsset *audioAsset = [[AVURLAsset alloc]initWithURL:aURL options:nil];
    AVURLAsset *videoAsset = [[AVURLAsset alloc]initWithURL:vURL options:nil];
    
    AVMutableComposition *mixComposition = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *compositionCommentaryTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [compositionCommentaryTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:[[audioAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    AVMutableCompositionTrack *compositionVideoTrack = [mixComposition addMutableTrackWithMediaType:AVMediaTypeVideo preferredTrackID:kCMPersistentTrackID_Invalid];
    
    [compositionVideoTrack insertTimeRange:CMTimeRangeMake(kCMTimeZero, audioAsset.duration) ofTrack:[[videoAsset tracksWithMediaType:AVMediaTypeVideo] objectAtIndex:0] atTime:kCMTimeZero error:nil];
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:mixComposition presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",title]];
    exportSession.shouldOptimizeForNetworkUse = YES;
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        handler(exportSession);
    }];
}

+ (void)ConvertVideoToAudioWithPath:(NSURL *)filePath SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    
    AVMutableComposition *newAudioAsset = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *dstCompositionTrack;
    dstCompositionTrack = [newAudioAsset addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    AVAsset *srcAsset = [AVURLAsset URLAssetWithURL:filePath options:nil];
    AVAssetTrack *srcTrack = [[srcAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    
    CMTimeRange timeRange = srcTrack.timeRange;
    
    NSError *error;
    
    if (NO == [dstCompositionTrack insertTimeRange:timeRange ofTrack:srcTrack atTime:kCMTimeZero error:&error]) {
        NSLog(@"track insert failed: %@\n", error);
        return;
    }
    
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:newAudioAsset presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputFileType = AVFileTypeAppleM4A;
    exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.m4a", title]];
    
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        handler(exportSession);
    }];
    
}

+ (void)ConvertAudioToVideoWithPath:(NSURL *)filePath SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    AVMutableComposition *newAudioAsset = [AVMutableComposition composition];
    
    AVMutableCompositionTrack *dstCompositionTrack;
    dstCompositionTrack = [newAudioAsset addMutableTrackWithMediaType:AVMediaTypeAudio preferredTrackID:kCMPersistentTrackID_Invalid];
    
    
    AVAsset *srcAsset = [AVURLAsset URLAssetWithURL:filePath options:nil];
    AVAssetTrack *srcTrack = [[srcAsset tracksWithMediaType:AVMediaTypeAudio] objectAtIndex:0];
    
    
    CMTimeRange timeRange = srcTrack.timeRange;
    
    NSError *error;
    
    if (NO == [dstCompositionTrack insertTimeRange:timeRange ofTrack:srcTrack atTime:kCMTimeZero error:&error]) {
        NSLog(@"track insert failed: %@\n", error);
        return;
    }
    
    
    AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:newAudioAsset presetName:AVAssetExportPresetPassthrough];
    
    exportSession.outputFileType = AVFileTypeQuickTimeMovie;
    exportSession.shouldOptimizeForNetworkUse = true;
    exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", title]];
    
    
    [exportSession exportAsynchronouslyWithCompletionHandler:^{
        handler(exportSession);
    }];
    
}

+ (void)ExportVideo:(NSURL *)filePath WithQuality:(NSString *)quality SaveFileToPath:(NSURL *)savepath TitleFile:(NSString *)title CompletionHandler:(void (^)(AVAssetExportSession *exportsession))handler {
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:filePath options:nil];
    
    if (![quality containsString:@"AVAssetExportPreset"]) {
        NSLog(@"please select right quality from (AVAssetExportPreset)");
    } else {
        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:asset presetName:quality];
        
        exportSession.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMake(asset.duration.value, asset.duration.timescale));
        exportSession.shouldOptimizeForNetworkUse = true;
        
        exportSession.outputFileType = AVFileTypeQuickTimeMovie;
        exportSession.outputURL = [savepath URLByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4", title]];
        
        [exportSession exportAsynchronouslyWithCompletionHandler:^{
            handler(exportSession);
        }];
    }
    
}

@end
