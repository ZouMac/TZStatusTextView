//
//  TZStatusTextView.m
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import "TZStatusTextView.h"
#import "TZSpecialPart.h"

#define TZCoverTag 999


@implementation TZStatusTextView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textContainerInset = UIEdgeInsetsMake(10,10,10,10);
        self.editable = NO;
        self.scrollEnabled = NO;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


/**
 *  初始化特殊文字段的矩形框
 */
-(void)setupSpecialRects{
//    取出位于attributedText 中 （0，1）位置上的 specials
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:nil];
    
    
    for (TZSpecialPart *specialPart in specials) {
//        将特殊文字范围 赋值 给选中范围
        self.selectedRange = specialPart.specialRange;
//         selectedRange => 影响 selectedTextRange 通过selectedTextRange 获取 特殊文字所在的矩形框
        NSArray *Rects = [self selectionRectsForRange:self.selectedTextRange];
        
//         取消选中文字
        self.selectedRange = NSMakeRange(0, 0);
        
//        得到特殊部分矩形框
        NSMutableArray *rects = [NSMutableArray array];
        for (UITextSelectionRect *selectionRect in Rects) {
            CGRect selectedRect = selectionRect.rect;
            if (selectedRect.size.width == 0 || selectedRect.size.height == 0) continue;
            
            [rects addObject:[NSValue valueWithCGRect:selectedRect]];
        }
        specialPart.rects = rects;
    }
}

/**
 *  找出被触摸的特殊字符串
 */
-(TZSpecialPart *)touchingSpecialWithPoint:(CGPoint)point
{
    NSArray *specials = [self.attributedText attribute:@"specials" atIndex:0 effectiveRange:nil];
    for (TZSpecialPart *specialPart in specials){
        for (NSValue *rectValue in specialPart.rects) {
//            如果手指位置在 特定文字 位置
            if(CGRectContainsPoint(rectValue.CGRectValue,point)){
                return specialPart;
            }
        }
    }
    return nil;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    1.获取触摸位置
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    
//    2.初始化特殊文字段的矩形框
    [self setupSpecialRects];
    
//    3.根据触摸点获得被触摸的特殊字符串
    TZSpecialPart *specialPart = [self touchingSpecialWithPoint:point];
    
//    4.在被触摸的特殊字符串后面显示一段高亮的背景
    for (NSValue *rectValue in specialPart.rects) {
//      添加遮盖
        UIView *cover = [[UIView alloc] init];
        cover.backgroundColor = [UIColor greenColor];
        cover.frame = rectValue.CGRectValue;
        cover.tag = TZCoverTag;
        [self insertSubview:cover atIndex:0];
        
    }
    
    if (self.getSpecialtext) {
        self.getSpecialtext(specialPart.specialText);
    }

    
}




-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self touchesCancelled:touches withEvent:event];
    });
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    for (UIView *childView in self.subviews) {
        if (childView.tag == TZCoverTag) {
            [childView removeFromSuperview];
        }
    }
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    return [super hitTest:point withEvent:event];
}

/**
 告诉系统:触摸点point是否在这个UI控件身上
 */
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    [self setupSpecialRects];
    TZSpecialPart *specialPart = [self touchingSpecialWithPoint:point];
    if (specialPart) {
        return YES;
    }else{
        return NO;
    }
}


@end
