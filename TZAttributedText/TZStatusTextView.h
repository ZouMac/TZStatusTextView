//
//  TZStatusTextView.h
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TZStatusTextView : UITextView

/**  特殊部分数组 */
@property (strong, nonatomic) NSArray *specials;

@property (nonatomic, copy) void (^getSpecialtext)(NSString *specialtext);
@end
