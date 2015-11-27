# Sometimes

[![GitHub license](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/alexito4/Sometimes/master/LICENSE.md) 
[![GitHub release](https://img.shields.io/github/release/alexito4/Sometimes.svg)](https://github.com/alexito4/Sometimes/releases)
[![Build Status](https://travis-ci.org/alexito4/Sometimes.svg?branch=master)](https://travis-ci.org/alexito4/Sometimes)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

This is a small Swift library that makes it easy to run code... sometimes. Well, actually, just once.

    Sometimes.execute(key) {
        // This will run just once
    } 
    
Inspired by [RateLimit](https://github.com/soffes/RateLimit) and [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults).
    
## Usage
    
Each block of code is associated to a `SometimesKey`. No stringly typed API here.

    let key = SometimesKey("test_key")
    
Then just execute it using the key.

    Sometimes.execute(key) {
        // This will run just once
    } 

Keys are persisted by default in the `NSUserDefaults.standardUserDefaults()`.

A function to remove all keys is also provided.

    Sometimes.reset()
    
## Integration
    
If you are using [Carthage](https://github.com/Carthage/Carthage) just add `github "alexito4/Sometimes”` to your `Cartfile`.

Then, just import it:

    import Sometimes

## Author

Alejandro Martinez, alexito4@gmail.com

## License

Available under the MIT license. See the LICENSE file for more info.