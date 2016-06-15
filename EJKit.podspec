#
# Be sure to run `pod lib lint EJKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "EJKit"
  s.version          = "1.0.0"
  s.summary          = "A Library used as iOS framework. Work, it's a easy thing."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESCRIPTION
                      This Library contains EJHttpKit,EJTools,EJBaseKit,EJExtension."
                      DESCRIPTION

  s.homepage         = "https://github.com/iOnRoad/EJKit"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "iOnRoad" => "xuwenchao_15@163.com" }
  s.source           = { :git => "https://github.com/iOnRoad/EJKit.git", :tag => s.version }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/EJKitHeader.h'
  s.resources = "Pod/Classes/Resource/***"
  s.public_header_files = 'Pod/Classes/EJKitHeader.h'
  # s.resource_bundles = {
  #   'LPKit' => ['Pod/Assets/*.png','Pod/Assets/***']
  # }

  # 若有mrc的文件，则打开此段代码。
  # non_arc_files = ''    #指定mrc的文件
  # s.exclude_files = non_arc_files

  # s.subspec 'no-arc' do |sna|
  #   sna.source_files = non_arc_files
  #   sna.requires_arc = false
  # end

  # 如果用到.a和.framework文件，使用如下代码
  # s.ios.vendored_frameworks = "xx/xx.framework"
  # s.ios.vendored_libraries = 'xx/xx.a'

  s.subspec 'EJBase' do |ss|

	ss.source_files = 'Pod/Classes/EJBase/*'
	ss.public_header_files = 'Pod/Classes/EJBase/*.h'
	ss.frameworks = 'UIKit','QuartzCore'

  end

  s.subspec 'EJManager' do |ss|

	ss.source_files = 'Pod/Classes/EJManager/*'
	ss.public_header_files = 'Pod/Classes/EJManager/*.h'
	ss.frameworks = 'UIKit','QuartzCore'

   	ss.dependency 'BaiduMapKit' 

  end

  s.subspec 'EJTools' do |ss|

    ss.source_files = 'Pod/Classes/EJTools/*'
    ss.public_header_files = 'Pod/Classes/EJTools/*.h'
    ss.frameworks = 'UIKit','QuartzCore','CoreLocation','AVFoundation','AssetsLibrary','Security','MapKit'
    
    ss.dependency 'KeychainItemWrapper'
    ss.dependency 'SDWebImage'

  end

   s.subspec 'EJDBKeyValue' do |ss|

   	ss.source_files = 'Pod/Classes/EJDBKeyValue/*'
	ss.public_header_files = 'Pod/Classes/EJDBKeyValue/*.h'
	ss.frameworks = 'UIKit','QuartzCore'

   	ss.dependency 'LKDBHelper' 
   	ss.dependency 'FMDB' 

   end

   s.subspec 'EJHttpKit' do |ss|
    
      ss.subspec 'EJHttpRequest' do |sss|
        sss.source_files = 'Pod/Classes/EJHttpKit/EJHttpRequest/*'
        sss.public_header_files = 'Pod/Classes/EJHttpKit/EJHttpRequest/*.h'
      end

      ss.subspec 'EJHttpClient' do |sss|
        sss.source_files = 'Pod/Classes/EJHttpKit/EJHttpClient/*'
        sss.public_header_files = 'Pod/Classes/EJHttpKit/EJHttpClient/*.h'
      end

      ss.frameworks = 'UIKit'

      ss.dependency 'Reachability'
      ss.dependency 'AFNetworking'
      ss.dependency 'OpenUDID'
      ss.dependency 'AFgzipRequestSerializer'
      ss.dependency 'MJExtension'
    
    end

end
