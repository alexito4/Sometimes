# Sometimes

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

This is a small Swift library that makes it easy to run code... sometimes. Well, actually, just once.

    Sometimes.execute(key) {
        // This will run just once
    } 

Inspired by [RateLimit](https://github.com/soffes/RateLimit) and [SwiftyUserDefaults](https://github.com/radex/SwiftyUserDefaults).
    
## Integration
    
If you are using [Carthage](https://github.com/Carthage/Carthage) just add `github "alexito4/Sometimes”` to your `Cartfile`.

Then, just import it:

    import Sometimes

## Author

Alejandro Martinez, alexito4@gmail.com

## License

Available under the MIT license. See the LICENSE file for more info.