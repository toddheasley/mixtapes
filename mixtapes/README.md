# `Mixtapes`

## Audio and Metadata

Supports AAC files with the `.m4a` file extension and MP3 files with the `.mp3` file extension. Metadata for each podcast episode is derived automatically from embedded [ID3 tags.](https://developer.apple.com/documentation/avfoundation/media_assets_and_metadata) Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in PNG or JPEG format. Chapter markers are supported but optional.

Feeds are published in both [RSS](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed](https://jsonfeed.org) formats.

## Requirements

Targets [iOS](https://developer.apple.com/ios)/[iPadOS](https://developer.apple.com/ipad) 14 and [macOS](https://developer.apple.com/macos) 11 Big Sur. Written in [Swift](https://developer.apple.com/documentation/swift) 5.3 and requires [Xcode](https://developer.apple.com/xcode) 12 or newer to build.
