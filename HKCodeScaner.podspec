#
# Be sure to run `pod lib lint HKProjectBase.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "HKCodeScaner"
  s.version          = "1.0.0"
  s.summary          = "基于系统 AVFoundation 的扫码框架，支持各类条码、二维码。"
  s.description      = <<-DESC
                       An optional longer description of HKProjectBase

                       * Markdown format.
                       * Don't worry about the indent, we strip it!
                       DESC
  s.homepage         = "https://github.com/Harley-xk/HKCodeScaner"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Harley.xk" => "harley.gb@foxmail.com" }
  s.source           = { :git => "https://github.com/Harley-xk/HKCodeScaner.git"}
  s.social_media_url = 'http://weibo.com/u/1161848005'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'HKCodeScaner' => ['Pod/Assets/**/*']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation', 'MobileCoreServices', 'AVFoundation'

end
