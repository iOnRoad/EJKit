Pod::Spec.new do |s|
        s.name             = "EJKit"
        s.version          = "1.0.1"
        s.summary          = "A Library used as iOS framework. Work, it's a easy thing."
        s.description      = <<-DESCRIPTION
                          This Library contains EJHttpKit,EJTools,EJBaseKit,EJExtension."
                          DESCRIPTION

        s.homepage         = "https://github.com/iOnRoad/EJKit"
        s.license          = 'MIT'
        s.author           = { "iOnRoad" => "xuwenchao_15@163.com" }
        s.source           = { :git => "https://github.com/iOnRoad/EJKit.git", :tag => s.version }
        s.source_files = 'Pod/Classes/EJKitHeader.h'
        s.resources = "Pod/Classes/Resource/***"
        s.public_header_files = 'Pod/Classes/EJKitHeader.h'

        s.platform     = :ios, '7.0'
        s.requires_arc = true

        s.subspec 'EJBase' do |ss|
                ss.source_files = 'Pod/Classes/EJBase/*'
                ss.public_header_files = 'Pod/Classes/EJBase/*.h'
                ss.frameworks = 'UIKit','QuartzCore'

                ss.dependency 'EJKit/EJManager'
        end

        s.subspec 'EJManager' do |ss|
                ss.source_files = 'Pod/Classes/EJManager/*'
                ss.public_header_files = 'Pod/Classes/EJManager/*.h'
                ss.frameworks = 'UIKit','QuartzCore'

                ss.dependency 'BaiduMapKit' , '~> 2.10.2'
                ss.dependency 'EJKit/EJTools'
        end

        s.subspec 'EJTools' do |ss|
                ss.source_files = 'Pod/Classes/EJTools/*'
                ss.public_header_files = 'Pod/Classes/EJTools/*.h'
                ss.frameworks = 'UIKit','QuartzCore','CoreLocation','AVFoundation','AssetsLibrary','Security','MapKit'

                ss.dependency 'KeychainItemWrapper', '~> 1.2'
                ss.dependency 'SDWebImage', '~> 3.7.6'
        end

        s.subspec 'EJDBKeyValue' do |ss|
                ss.source_files = 'Pod/Classes/EJDBKeyValue/*'
                ss.public_header_files = 'Pod/Classes/EJDBKeyValue/*.h'
                ss.frameworks = 'UIKit','QuartzCore'

                ss.dependency 'LKDBHelper' , '~> 2.2.1'
                ss.dependency 'FMDB' , '~> 2.6.2'
        end

        s.subspec 'EJHttpKit' do |ss|
                ss.subspec 'EJHttpRequest' do |sss|
                        sss.source_files = 'Pod/Classes/EJHttpKit/EJHttpRequest/*'
                        sss.public_header_files = 'Pod/Classes/EJHttpKit/EJHttpRequest/*.h'

                        sss.dependency 'EJKit/EJHttpKit/EJHttpClient'
                end

                ss.subspec 'EJHttpClient' do |sss|
                        sss.source_files = 'Pod/Classes/EJHttpKit/EJHttpClient/*'
                        sss.public_header_files = 'Pod/Classes/EJHttpKit/EJHttpClient/*.h'
                end

                ss.frameworks = 'UIKit'
                ss.dependency 'EJKit/EJBase'
                ss.dependency 'Reachability', '~> 3.2'
                ss.dependency 'AFNetworking', '~> 2.6.3'
                ss.dependency 'OpenUDID', '~> 1.0.0'
                ss.dependency 'AFgzipRequestSerializer', '~> 0.0.2'
                ss.dependency 'MJExtension', '~> 3.0.10'
                ss.dependency 'LKDBHelper' , '~> 2.2.1'
        end

end
