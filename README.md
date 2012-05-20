Cocomotion
==

Example project for [RubyMotion](http://rubymotion.com) and [Cocos2d](http://cocos2d-iphone.org)

The following changes were made:

* Changed cocos2d-iphone 2.0-rc1 project's "Treat Compiler Warnings as Errors" to False
* Removed Resources/templates/tools folder to get the repo size down
* Recompiled the bridgesupport file manually:

`cd vendor/cocos2d-iphone/cocos2d`
`gen_bridge_metadata -F complete --no-64-bit -c '-D__CC_PLATFORM_IOS -I. -ISupport -IPlatforms -IPlatforms/iOS' *.h Platforms/*.h Platforms/iOS/*.h Support/*.h > ../cocos2d-iphone.bridgesupport`

Known Issues
==

* inline functions are not yet supported, such as `ccc4()` This is a known bug with RubyMotion and will be fixed in a patch soon
* definining shouldAutorotateToInterfaceOrientation crashes the app

## WHO IS RESPONSIBLE FOR THIS ATROCITY?

Sean Scally
[twitter](http://twitter.com/s_scally)
[github](http://github.com/anydiem)

The fine folks at Cocos2d-iPhone and RubyMotion!

## Discomfortingly Optimistic To-Do List

* Create CocoaPod

