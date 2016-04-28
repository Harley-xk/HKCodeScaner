//
//  HKCodeScanView.m
//  HKCodeScanner-Sample
//
//  Created by Harley.xk on 16/4/28.
//  Copyright © 2016年 Harley.xk. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "HKCodeScanView.h"

@interface HKCodeScanView ()
<AVCaptureMetadataOutputObjectsDelegate>
@property (strong,nonatomic)AVCaptureDevice *device;
@property (strong,nonatomic)AVCaptureDeviceInput *input;
@property (strong,nonatomic)AVCaptureMetadataOutput *output;
@property (strong,nonatomic)AVCaptureSession *session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer *previewLayer;

@property (assign, nonatomic) BOOL componentsSetuped;
@property (weak,   nonatomic) id<HKCodeScannerDelegate> delegate;
@end


@implementation HKCodeScanView

- (void)layoutSubviews
{
    self.previewLayer.frame = self.bounds;
    [super layoutSubviews];
}


- (BOOL)setupComponents
{
    if (self.componentsSetuped) {
        return YES;
    }
    
    // Device
    self.device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    NSError *error = nil;
    self.input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:&error];
    if (error) {
        NSLog(@"HKCodeScanner: 初始化输入设备失败!");
        return NO;
    }
    
    // Output
    self.output = [[AVCaptureMetadataOutput alloc] init];
    [self.output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    self.session = [[AVCaptureSession alloc] init];
    [self.session setSessionPreset:AVCaptureSessionPresetHigh];
   
    // 添加输入输出
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    if ([self.session canAddOutput:self.output]) {
        [self.session addOutput:self.output];
    }
    
    // Preview
    self.previewLayer =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [self.layer insertSublayer:self.previewLayer atIndex:0];
    
    return YES;
}

- (void)startWithTargetCodeTypes:(NSArray *)targetCodeTypes delegate:(id<HKCodeScannerDelegate>)delegate
{
    self.componentsSetuped = [self setupComponents];
    self.output.metadataObjectTypes = targetCodeTypes;
    self.delegate = delegate;
    [self startScan];
}

- (void)startScan
{
    if (!self.componentsSetuped) {
        NSLog(@"HKCodeScanner: 还未初始化控件!");
        return;
    }
    [self.session startRunning];
}

- (void)stopScan
{
    if (!self.componentsSetuped) {
        NSLog(@"HKCodeScanner: 还未初始化控件!");
        return;
    }
    [self.session stopRunning];
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate methods
// 扫到码之后，会通过这个代理方法告知扫码结果
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    if (!self.continueWhenReceived) {
        [self stopScan];
    }
    
    NSString *stringValue = nil;
    if ([metadataObjects count] >0)
    {
        for (AVMetadataMachineReadableCodeObject * metadataObject in metadataObjects) {
            stringValue = metadataObject.stringValue;
            if (self.delegate && [self.delegate respondsToSelector:@selector(codeScanView:didReceiveResult:)]) {
                [self.delegate codeScanView:self didReceiveResult:stringValue];
            }
        }
    }
}

@end
