Pod::Spec.new do |s|
  s.name             = "WSDownloader"
  s.version          = "1.0"
  s.summary          = "A tiny, one-liner networking library built on top of NSURLSession and AFNetworking."
  s.homepage         = "https://github.com/wandersiemers/WSDownloader"
  s.license          = 'MIT'
  s.author           = { "Wander Siemers" => "wandersiemers@me.com" }
  s.source           = { :git => "https://github.com/wandersiemers/WSDownloader.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/wandersiemers'

  s.platform     = :ios, '7.0'
  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'Classes/WSDownloader.{h,m}'

  s.public_header_files = 'Classes/WSDownloader/*.h'
  s.dependency 'AFNetworking', '~> 2.0'
  s.frameworks = 'UIKit'
end
