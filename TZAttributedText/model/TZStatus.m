//
//  TZStatus.m
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import "TZStatus.h"
#import <UIKit/UIKit.h>
#import "TZTextPart.h"
#import "TZEmotionTool.h"
#import "TZEmotion.h"
#import "TZSpecialPart.h"
#import <RegexKitLite-SDP/RegexKitLite.h>

@interface TZStatus()

@end

@implementation TZStatus

- (void)setContentText:(NSString *)contentText{
    
//    复制一份正文用于修改
    _contentText = [contentText copy];
    
    self.attributedText = [self attributedTextWithText:contentText];
}


- (NSAttributedString *)attributedTextWithText:(NSString *)contentText{
   
//    利用tex生成attributedText
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    
    
//    1.RegexKitLite正则表达方法
    
//     表情的规则
    NSString *emotionPattern = @"\\[[0-9a-zA-Z\\u4e00-\\u9fa5]+\\]";
//     @的规则
    NSString *atPattern = @"@[0-9a-zA-Z\\u4e00-\\u9fa5_-]+";
//     #话题#的规则
    NSString *topicPattern = @"#[0-9a-zA-Z\\u4e00-\\u9fa5]+#";
//     url链接的规则
    NSString *urlPattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    NSString *pattern = [NSString stringWithFormat:@"%@|%@|%@|%@", emotionPattern, atPattern, topicPattern, urlPattern];
    
//    各种文字段的内容
    NSMutableArray *parts = [NSMutableArray array];
    
//    2.遍历所有内容 选出特殊字段内容
    [contentText enumerateStringsMatchedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        
//        没有匹配的字段
        if ((*capturedRanges).length == 0) return;
        
//        收集特殊字段
        TZTextPart *part = [[TZTextPart alloc] init];
        part.partText = *capturedStrings;
        part.range = *capturedRanges;
        part.special = YES;
        part.emotion = [part.partText hasPrefix:@"["] && [part.partText hasSuffix:@"]"];
        
        [parts addObject:part];
        
    }];
    
//     3.遍历所有内容 选出普通字段内容
    [contentText enumerateStringsSeparatedByRegex:pattern usingBlock:^(NSInteger captureCount, NSString *const __unsafe_unretained *capturedStrings, const NSRange *capturedRanges, volatile BOOL *const stop) {
        //        没有匹配的字段
        if ((*capturedRanges).length == 0) return;
        
        //        收集普通字段
        TZTextPart *part = [[TZTextPart alloc] init];
        part.partText = *capturedStrings;
        part.range = *capturedRanges;
        
        [parts addObject:part];
        
    }];
    
//     4.将获得的所有字段按 range 排序
    [parts sortUsingComparator:^NSComparisonResult(TZTextPart  *_Nonnull part1, TZTextPart *_Nonnull part2) {//升序排列
        
        if (part1.range.location > part2.range.location) {

            return NSOrderedDescending;
        }
        return NSOrderedAscending;
    }];
    
     UIFont *font = [UIFont systemFontOfSize:15.0];
    
//      储存特殊属性数组
    NSMutableArray *specials = [NSMutableArray array];
    
//     5.分别处理各文字段 设置内容的属性
    for (TZTextPart *part in parts) {
        NSAttributedString *substr = nil;
        
        if (part.isEmotion) {//表情
            NSTextAttachment *attch = [[NSTextAttachment alloc] init];
            NSString *name = [TZEmotionTool emotionWithChs:part.partText].png;
            if (name) { // 能找到对应的图片
                attch.image = [UIImage imageNamed:name];
                attch.bounds = CGRectMake(0, -3, font.lineHeight, font.lineHeight);
                substr = [NSAttributedString attributedStringWithAttachment:attch];
            } else { // 表情图片不存在
                substr = [[NSAttributedString alloc] initWithString:part.partText];
            }
        }else if (part.special){//特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.partText attributes:@{
                                                                                           NSForegroundColorAttributeName:[UIColor blueColor]
                                                                                           }];
            //            将特殊文字段的 内容 和 位置 保存起来
            TZSpecialPart *specialPart = [[TZSpecialPart alloc] init];
            specialPart.specialText = part.partText;
            NSUInteger loc = part.range.location;
            NSUInteger len = part.range.length;
            specialPart.specialRange = NSMakeRange(loc, len);
            
            [specials addObject:specialPart];
            
        }else{//非特殊文字
            substr = [[NSAttributedString alloc] initWithString:part.partText];
        }
        
        [attributedText appendAttributedString:substr];
    }
    [attributedText addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, attributedText.length)];
    
//    把specials 添加到  0，1 的位置上（第一个字符的属性上）
    [attributedText addAttribute:@"specials" value:specials range:NSMakeRange(0, 1)];
    
    
    return attributedText;
}

@end
