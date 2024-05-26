# `Mixtapes`

## Audio and Metadata

`Mixtapes` supports MP3 (`.mp3`) and AAC (`.m4a`) audio. Metadata for each podcast episode is derived from embedded [ID3 tags.](https://developer.apple.com/documentation/avfoundation/media_assets_and_metadata) Audio files are required to contain values for __title__, __artist__ and __album name__, as well as JPEG or PNG __embedded artwork__. Chapter markers are supported but optional.

Feeds are published in both [RSS](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed](https://jsonfeed.org) formats.

## Requirements

Targets [macOS](https://developer.apple.com/macos) 14 Sonoma. Written in [Swift](https://developer.apple.com/swift) 5.10, and builds with [Xcode](https://developer.apple.com/xcode) 15 or newer.
