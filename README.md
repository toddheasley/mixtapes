# `Mixtapes`

`Mixtapes` is a Mac utility that I wrote to publish my collection of personal mixtapes as a podcast:

[__Todd's Mixtapes__](https://s3.amazonaws.com/toddheasley/mixtapes/index.html)

![](Mixtapes.png)

## Audio and Metadata

`Mixtapes` supports AAC files with the `.m4a` file extension and pulls metadata for each podcast episode from [ID3](http://id3.org) tags. Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in JPEG format. Chapter markers are supported but optional.

Feeds are published as both [RSS 2](https://validator.w3.org/feed/docs/rss2.html) and [JSON Feed.](https://jsonfeed.org)

## Requirements

`Mixtapes` is written in [Swift 5](https://docs.swift.org/swift-book) and requires [Xcode](https://developer.apple.com/xcode) 10.2 or newer to build.
