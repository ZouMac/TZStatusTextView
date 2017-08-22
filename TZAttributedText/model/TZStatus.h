//
//  TZStatus.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZStatus : NSObject

/** 正文内容 */
@property (copy, nonatomic) NSString *contentText;

/** 带属性的微博信息内容 */
@property (strong, nonatomic) NSAttributedString *attributedText;

@end
