# `Mixtapes`

`Mixtapes` is a Mac utility that I wrote to publish my collection of personal mixtapes as a podcast:

[__Todd's Mixtapes__](https://s3.amazonaws.com/toddheasley/mixtapes/index.html)

![](Mixtapes.png)

## Audio and Metadata

`Mixtapes` supports AAC files with the `.m4a` file extension and pulls metadata for each podcast episode from [ID3](http://id3.org) tags. Audio files are required to contain values for __title__, __artist__ and __album name__, as well as  __embedded artwork__ in JPEG format. Chapter markers are supported but optional.

## Example Usage

Fair warning, `Mixtapes` is weekend engineering at its finest. Podcast episodes can be added, removed and reordered without rebuilding in Xcode; everything else, including global podcast metadata and design templates, is hardcoded into the Swift source for now.

To modify the podcast metadata, open `Mixtapes.xcodeproj` and edit the `title`, `description`, `author` and `link` values in `Index.swift`:

```swift
import Foundation

public struct Index {
    public let title: String = "Todd's Mixtapes"
    public let description: String = "Love letters to my favorite music"
    public let author: (url: URL, description: String) = (URL(string: "https://twitter.com/toddheasley")!, "@toddheasley")
    public let link: URL = URL(string: "https://s3.amazonaws.com/toddheasley/mixtapes")!
    ...
}

```

### Standalone CLI App

In Xcode, archive the `mixtapes` target and move the archived `mixtapes` executable into an empty directory. In the Terminal, `cd` into the directory and run:

`./mixtapes init`

The formerly empty directory should now contain the following:

* `assets/`
* `index.txt`

To add a podcast episode, name the  `.m4a` file something URL-friendly and place it in the `assets` directory.  Then, open `index.txt` in any text editor and add the file name, omitting the file extension. Each episode name goes on a new line:

```
maury-povich
pump-up-the-volume
essential-primo
```

With audio file(s) in place and listed in `index.txt`, generate a new podcast feed  in the Terminal:

`./mixtapes`

If `mixtapes` doesn't barf on missing ID3 tag values, the directory now contains  the following:

* `artwork.jpg` 
* `assets/`
* `gaegu.woff` font by [jikji soft](http://jikjisoft.com)
* `index.css`
* `index.html`
* `index.rss` [RSS 2.0](https://cyber.harvard.edu/rss/rss.html) feed
* `index.txt`
* `rss.svg`

### Cocoa Framework

`Mixtapes` also builds as a Cocoa framework. I'm not sure why yet.

## Requirements

`Mixtapes` is written in [Swift 5](https://docs.swift.org/swift-book) and requires [Xcode](https://developer.apple.com/xcode) 10.2 or newer to build.
