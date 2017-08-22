//
//  TZStatusTextView.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TZEmotion;

@interface TZEmotionTool : NSObject

/**
 *  通过表情描述找到对应的表情
 *
 *  @param chs 表情描述
 */
+(TZEmotion *)emotionWithChs:(NSString *)chs;

@end
