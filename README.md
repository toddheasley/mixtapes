# `Mixtapes`

`Mixtapes` is a Mac command-line utility that I wrote to publish [my collection of personal mixtapes](https://s3.amazonaws.com/toddheasley/mixtapes/index.html) as a podcast:

![](Mixtapes.png)

[![Todd's Mixtapes](Mixtapes.svg)](https://s3.amazonaws.com/toddheasley/mixtapes/index.html)

## Audio and Metadata

Supports AAC files with the `.m4a` file extension and pulls metadata for each podcast episode from ID3 tags. Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in JPEG format. Chapter markers are supported but optional.

Feeds are published in both [RSS](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed](https://jsonfeed.org) formats.

## Requirements

Targets [macOS](https://developer.apple.com/macos) 11 Big Sur. Written in [Swift](https://developer.apple.com/documentation/swift) 5.3 and requires [Xcode](https://developer.apple.com/xcode) 12 or newer to build. Command-line interface depends on [Swift Argument Parser.](https://github.com/apple/swift-argument-parser)
