# `Mixtapes`

## Audio and Metadata

Supports AAC files with `.m4a` file extensions and MP3 files with `.mp3` file extensions. Metadata for each podcast episode is derived automatically from embedded [ID3 tags.](https://developer.apple.com/documentation/avfoundation/media_assets_and_metadata) Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in PNG or JPEG format. Chapter markers are supported but optional.

Feeds are published in both [RSS](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed](https://jsonfeed.org) formats.

## Requirements

Targets [macOS](https://developer.apple.com/macos) 14 Sonoma. Written in [Swift](https://developer.apple.com/swift) 5.10, and builds with [Xcode](https://developer.apple.com/xcode) 15 or newer.
