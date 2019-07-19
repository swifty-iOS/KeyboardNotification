Pod::Spec.new do |s|
  s.name         = "KeyboardNotification"
  s.version      = "2.0.1"
  s.summary      = "KeyboardNotification protocol help you to manage Keyboard notification and more"
  s.homepage     = "https://github.com/swifty-iOS/KeyboardNotification"
  s.license      = "MIT"
  s.author       = { "Swifty-iOS" => "manishej004@gmail.com" }
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/swifty-iOS/KeyboardNotification.git", :tag =>s.version }
  s.source_files  = "Source/*.swift"
  s.swift_version = '5.0'
end
