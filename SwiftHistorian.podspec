#
# Be sure to run `pod lib lint SwiftHistorian.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "SwiftHistorian"
  s.version          = "0.1.0"
  s.summary          = "A short description of SwiftHistorian."
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/akuraru/SwiftHistorian"
  s.license          = 'MIT'
  s.author           = { "akuraru" => "akuraru@gmail.com" }
  s.source           = { :git => "https://github.com/akuraru/SwiftHistorian.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/akuraru'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.frameworks = 'UIKit', 'WebKit'
  s.dependency 'RealmSwift'
end
