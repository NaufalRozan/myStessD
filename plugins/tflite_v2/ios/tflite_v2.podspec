#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'tflite_v2'
  s.version          = '1.0.0'
  s.summary          = 'A Flutter plugin for accessing TensorFlow Lite.'
  s.description      = <<-DESC
A Flutter plugin for accessing TensorFlow Lite. Supports both iOS and Android.
                       DESC
  s.homepage         = 'https://github.com/shaqian/flutter_tflite'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Qian Sha' => 'https://github.com/shaqian' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'TensorFlowLiteC', '2.12.0'
  s.weak_framework = 'Metal'
  
  s.pod_target_xcconfig = {
    'DEFINES_MODULE' => 'YES',
    'HEADER_SEARCH_PATHS' => [
      '"${PODS_ROOT}/TensorFlowLiteC/Frameworks/TensorFlowLiteCMetal.xcframework/ios-arm64_x86_64-simulator/TensorFlowLiteCMetal.framework/Headers"',
      '"${PODS_ROOT}/TensorFlowLiteC/Frameworks/TensorFlowLiteCMetal.xcframework/ios-arm64/TensorFlowLiteCMetal.framework/Headers"'
    ].join(' ')
  }
  
  s.swift_version = '5.0'
  s.ios.deployment_target = '12.0'
  s.static_framework = true
end

