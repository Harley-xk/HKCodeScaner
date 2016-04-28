//
//  HKCodeScanView.h
//  HKCodeScanner-Sample
//
//  Created by Harley.xk on 16/4/28.
//  Copyright © 2016年 Harley.xk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HKCodeScannerDelegate;

@interface HKCodeScanView : UIView

// 传入扫描的目标编码类型，开始扫描，参见：AVMetadataObject.h
- (void)startWithTargetCodeTypes:(NSArray *)targetCodeTypes delegate:(id<HKCodeScannerDelegate>)delegate;

- (void)startScan;
- (void)stopScan;

// 扫描得到结果后继续扫描，默认为NO
@property (assign, nonatomic) BOOL continueWhenReceived;

@end

@protocol HKCodeScannerDelegate <NSObject>
// 回调扫描结果，如果有多个结果，会执行多次
- (void)codeScanView:(HKCodeScanView *)scanView didReceiveResult:(NSString *)result;
@end
