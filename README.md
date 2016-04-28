# HKCodeScaner
基于系统 **AVFoundation** 中 ***AVCaptureSession*** 的扫码框架，支持各类条码、二维码。

在保证系统框架的清洁、高效、低能耗的优势下，大大简化了集成步骤，提高开发效率。

### 通过 Cocoapods 引入
将以下代码加入到 podfile 中：
```
pod 'HKCodeScaner',  :git => 'https://github.com/Harley-xk/HKCodeScaner.git'
```

### 集成步骤
1、创建 HKCodeScanView ，并为其设定适当的位置和大小。

HKCodeScanView 是 UIView 的子类，你可以使用任何你熟悉的方式创建它（代码、IB等等），并为它设置好尺寸和位置，这里跟其它任何 View 的使用都没有区别。

2、设置目标编码格式，开始扫码：

通过 ***startWithTargetCodeTypes: delegate:*** 方法，设置好需要扫描的编码格式并指定代理后，就可以开始扫码了！

```
[self.scanView startWithTargetCodeTypes:@[AVMetadataObjectTypeQRCode] delegate:self];
```
***codeTypes*** 

目标编码格式，以数组的方式传入，可以同时支持多种格式，示例中的 *AVMetadataObjectTypeQRCode* 表示扫描的目标编码为二维码。

更多格式请参见 **AVFoundation** 在 *AVMetadataObject.h* 头文件中的声明。

***delegate*** 

扫码结果通过 delegate 返回，如果同时扫描多个编码，有可能会返回多个结果，这时候 delegate 方法会执行多次，对应每一个编码的结果:

```
- (void)codeScanView:(HKCodeScanView *)scanView didReceiveResult:(NSString *)result
{
    [self checkCode:result];
}
```

3、自动停止扫描

默认情况下，当扫描获得结果后会自动停止扫描，可以满足大多数使用场景的需求。特殊情况下需要支持连续扫描，这时候只要将 *continueWhenReceived* 属性设置为 YES 即可：

```
self.scanView.continueWhenReceived = YES;
```


