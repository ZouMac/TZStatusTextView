//
//  TZEmotion.h
//  0401TZSina微博
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <COCommonUtils/ERPModel.h>

@interface TZEmotion : ERPModel<ERPJSONSerializing>

//emotion名称
@property (copy, nonatomic) NSString *chs;

//emotion图片
@property (copy, nonatomic) NSString *png;

//emoji编码
@property (copy, nonatomic) NSString *code;


@end
