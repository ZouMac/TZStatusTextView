//
//  ViewController.m
//  TZAttributedText
//
//  Created by 檀邹 on 2017/8/20.
//  Copyright © 2017年 Tanz. All rights reserved.
//

#import "ViewController.h"
#import "TZStatusTextView.h"
#import "TZStatus.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
   
    
    TZStatus *status = [[TZStatus alloc] init];
    status.contentText = @"@StephenCurry  “I'm Back”！https://bbs.hupu.com （使用#秒拍#录制，免流量看热门短视频！） #库里经典比赛# 去年季后赛次轮，伤愈复出的库里首战面对开拓者就拿下40分9篮板8助攻，加时赛疯砍17分，率队逆转获胜晋级西决。#StreeBall#  [吃元宵][吃元宵][吃元宵]";
    
    TZStatusTextView *statusView = [[TZStatusTextView alloc] init];
    statusView.frame = CGRectMake(0, 30, self.view.frame.size.width, 300);
    [self.view addSubview:statusView];
    statusView.attributedText = status.attributedText;
    
    statusView.getSpecialtext = ^(NSString *specialtext){
        if ([specialtext hasPrefix:@"@"]) {//@
            [self toastWithMessage:[NSString stringWithFormat:@"我在%@",specialtext]];
        }else if ([specialtext hasPrefix:@"#"]){//#
            [self toastWithMessage:[NSString stringWithFormat:@"话题%@",specialtext]];
        }else if ([specialtext containsString:@"https://"]){//链接
            [self toastWithMessage:[NSString stringWithFormat:@"打开链接%@",specialtext]];
        }
        
    

    };
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark - Public

- (void)startLoading {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
}

- (void)endLoading {
    [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

- (void)toastWithMessage:(NSString *)message {
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.8 * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
        
        [MBProgressHUD hideHUDForView:[UIApplication sharedApplication].keyWindow animated:YES];
    });
}



@end
