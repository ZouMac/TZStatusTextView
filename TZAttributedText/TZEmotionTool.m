//
//  TZStatusTextView.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//  表情存储工具

#import "TZEmotionTool.h"
#import "TZEmotion.h"

@implementation TZEmotionTool


+(TZEmotion *)emotionWithChs:(NSString *)chs
{
    NSArray *defaults = [self defaultEmotions];
    for (TZEmotion *emotion in defaults) {
        if ([emotion.chs isEqualToString:chs]) return emotion;
    }
    return nil;
}



static NSArray * _defaultEmotions, *_emojiEmotions;
+(NSArray *)defaultEmotions{
    if (_defaultEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"defaultInfo.plist" ofType:nil];
        _defaultEmotions = [MTLJSONAdapter modelsOfClass:[TZEmotion class] fromJSONArray:[NSArray arrayWithContentsOfFile:path] error:nil];
    }
    return _defaultEmotions;
}

+(NSArray *)emojiEmotions
{
    if (_emojiEmotions == nil) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"emojiInfo.plist" ofType:nil];
        _emojiEmotions = [MTLJSONAdapter modelsOfClass:[TZEmotion class] fromJSONArray:[NSArray arrayWithContentsOfFile:path] error:nil];
    }
    return _emojiEmotions;
}
@end
