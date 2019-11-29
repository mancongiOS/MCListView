#
# Be sure to run `pod lib lint MCListView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MCListView'
  s.version          = '0.0.1'
  s.summary          = 'TableView&CollectionView的复用和空页面的处理'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/mancongiOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mccc' => '562863544@qq.com' }

  s.source           = { :git => 'https://github.com/mancongiOS/MCListView.git', :tag => s.version.to_s }
  s.source_files = 'MCListView/Classes/**/*'

  s.ios.deployment_target = '8.0'
  s.swift_version = '5.0'
  
   s.resource_bundles = {
     'MCListViewBundle' => ['MCListView/Assets/*.png']
   }

   s.dependency 'Then', '~> 2.5.0'

end
