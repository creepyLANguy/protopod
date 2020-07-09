#
# Be sure to run `pod lib lint protopod.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'protopod'
  s.version          = '0.1.0'
  s.summary          = 'POC pod for OMDS.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'This is a POC for the OMDS project.'

  s.homepage         = 'https://github.com/creepylanguy/protopod'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Altamish Mahomed' => 'gambit318@gmail.com' }
  s.source           = { :git => 'https://github.com/creepyLANguy/protopod.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.3'

  s.source_files = 'protopod/Classes/**/*'

  # s.resource_bundles = {
  #   'protopod' => ['protopod/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'

  s.dependency 'MaterialComponents/TextFields'

  s.swift_version = '4.0'
end
