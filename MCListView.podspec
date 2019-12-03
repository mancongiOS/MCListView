#
# Be sure to run `pod lib lint MCListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html


Pod::Spec.new do |s|
  s.name             = 'MCListView'
  s.version          = '0.0.2'
  s.summary          = 'Cell的复用和列表空页面的处理'
  s.description      = "列表页面的复用和对空页面的封装"
  s.homepage         = 'https://github.com/mancongiOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mccc' => '562863544@qq.com' }
  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  

  
  s.source           = { :git => 'https://github.com/mancongiOS/MCListView.git', :tag => s.version.to_s }
  s.source_files = 'MCListView/Classes/**/*'

   s.resource_bundles = {
     'MCListViewBundle' => ['MCListView/Assets/*.png']
   }

end
