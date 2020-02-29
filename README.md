# `Mixtapes`

`Mixtapes` is a Mac command-line utility that I wrote to publish my collection of personal mixtapes as a podcast:

[__Todd's Mixtapes__](https://s3.amazonaws.com/toddheasley/mixtapes/index.html)

![](Mixtapes.png)

## Audio and Metadata

`Mixtapes` supports AAC files with the `.m4a` file extension and pulls metadata for each podcast episode from [ID3](http://id3.org) tags. Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in JPEG format. Chapter markers are supported but optional.

Feeds are published in both [RSS](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed](https://jsonfeed.org) formats.

## Requirements

Targets [macOS](https://developer.apple.com/macos) 10.15 Catalina.

Written in [Swift](https://developer.apple.com/documentation/swift) 5.1 using the [Foundation](https://developer.apple.com/documentation/foundation) and [AVFoundation](https://developer.apple.com/documentation/avfoundation) frameworks and requires [Xcode](https://developer.apple.com/xcode) 11 or newer to build.

