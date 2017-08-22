//
//  TZSpecialPart.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TZSpecialPart : NSObject

/** 特殊段内容 */
@property (strong, nonatomic) NSString *specialText;

/** 特殊段范围 */
@property (assign, nonatomic) NSRange specialRange;

/** 特殊文字的矩形框 数组 */
@property (strong, nonatomic) NSArray *rects;

@end
