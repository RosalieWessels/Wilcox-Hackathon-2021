#ifndef MEDIA_ENGINE_IOS_AUDIO_TRACK
#define MEDIA_ENGINE_IOS_AUDIO_TRACK

#import <Foundation/Foundation.h>
#import <WebRTC/RTCMacros.h>

RTC_OBJC_EXPORT
@interface AudioTrack : NSObject

@property(nonatomic, readonly) NSString *trackId;

- (instancetype)initWithId:(NSString *)identifier;

@end

#endif // MEDIA_ENGINE_iOS_AUDIO_TRACK
