#
#  Be sure to run `pod spec lint MvvmForIOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name          = "MvvmForIOS"
  s.version       = "0.1"
  s.summary       = "Framework for using Mvvm Pattern in OBJ-C and Swift with iOS"
  s.description   = <<-DESC
  Framework for using Mvvm Pattern in OBJ-C and Swift with iOS
  Compatible Swift 4 and OBJ-C
                   DESC

  s.homepage      = "https://github.com/frankois944/MvvmForIOS"
  s.license       = "MIT"
  s.author        = { "Francois Dabonot" => "frankois@azodus.fr.nf" }
  s.platform      = :ios, "8.0"
  s.source        = { :git => "https://github.com/frankois944/MvvmForIOS.git", :tag => "#{s.version}" }
  s.source_files  = "MvvmForIOS/MvvmForIOS/**/*.{h,m}"
  s.exclude_files = "MvvmForIOS/MvvmForIOS/**/*.{swift}"
  s.requires_arc  = true
end
