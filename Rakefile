$:.unshift("/Library/RubyMotion/lib")
require 'motion/project'

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'cocomotion'
  app.provisioning_profile = '/Users/jacobodonnell/Library/MobileDevice/Provisioning Profiles/7CD5AEC7-711F-4B7B-9A3A-018967765BC2.mobileprovision'

  app.vendor_project( "vendor/cocos2d-iphone", :xcode,
    :xcodeproj => "cocos2d-ios.xcodeproj", :target => "cocos2d", :products => ["libcocos2d.a"],
    :headers_dir => "cocos2d")

  app.frameworks += ["OpenGLES", "OpenAL", "AVFoundation", "AudioToolbox", "QuartzCore"]
  app.libs << "/usr/lib/libz.dylib"
end
