//
//  TZTextPart.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZTextPart : NSObject

/** 文字段内容 */
@property (strong, nonatomic) NSString *partText;

/** 文字段范围 */
@property (assign, nonatomic) NSRange range;

/** 是否是特殊文字 */
@property (assign, nonatomic, getter=isSpecial) BOOL special;

/** 是否是表情文字 */
@property (assign, nonatomic, getter=isEmotion) BOOL emotion;

@end
