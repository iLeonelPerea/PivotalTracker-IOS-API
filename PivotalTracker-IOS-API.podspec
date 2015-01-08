#
# Be sure to run `pod lib lint PivotalTracker-IOS-API.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PivotalTracker-IOS-API"
  s.version          = "0.1.0"
  s.summary          = "Make Call to Privotal Tracker API V5."
  s.description      = <<-DESC
                       Use this framework to do make call at Pivotal Tracker Api V5.
                       Features:
                       1. A small non intrucive library that makes it easy to authenticate and authorize against Pivotal track usin basic aouth.
                       DESC
  s.homepage         = "https://github.com/ileonelperea/PivotalTracker-IOS-API"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Leonel Perea" => "iticleonel.len@gmail.com" }
  s.source           = { :git => "https://github.com/iLeonelPerea/PivotalTracker-IOS-API.git", :tag => "pivotal-api-v0.1.0" }
  s.social_media_url = 'https://twitter.com/ileonelperea'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.resource_bundles = {
    'PivotalTracker-IOS-API' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
