//
//  ViewController.m
//  HKCodeScanner-Sample
//
//  Created by Harley.xk on 16/4/28.
//  Copyright © 2016年 Harley.xk. All rights reserved.
//

#import "ViewController.h"
#import "HKCodeScanner.h"

@interface ViewController ()
<HKCodeScannerDelegate>
@property (weak, nonatomic) IBOutlet HKCodeScanView *scanView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.scanView startWithTargetCodeTypes:@[AVMetadataObjectTypeQRCode] delegate:self];
    self.scanView.continueWhenReceived = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HKCodeScannerDelegate
- (void)codeScanView:(HKCodeScanView *)scanView didReceiveResult:(NSString *)result
{
    NSLog(@"扫描结果：%@",result);
}


@end
