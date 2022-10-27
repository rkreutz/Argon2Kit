# Argon2Kit

![Swift 5.2](https://img.shields.io/badge/Swift-5.5-orange.svg)
[![Swift Package Manager](https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat)](https://swift.org/package-manager)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![GitHub tag](https://img.shields.io/github/tag/rkreutz/Argon2Kit.svg)](https://GitHub.com/rkreutz/Argon2Kit/tags/)
![Run Tests](https://github.com/rkreutz/Argon2Kit/workflows/Run%20Tests/badge.svg?branch=main&event=push)

Swift wrapper for the C implementation of [Argon2](https://github.com/P-H-C/phc-winner-argon2), the winner of the [Password Hash Competition](https://www.password-hashing.net).

# Installation (SPM)

Argon2Swift can be installed via SPM (Swift Package Manger) by adding the following to your depencencies:

```swift
.package(url: "https://github.com/rkreutz/Argon2Kit.git", .upToNextMajor(from: "0.1.0"))
```

# Usage

High-level hashing and verification:

```swift
import Argon2Kit

let password = "password"
let salt = Data.random(bytes: 16)

let digest = try! Argon2.hash(password: password, salt: salt)

let rawData = digest.rawData // 32 bytes of the hash
let encodedData = digest.encodedData // the Argon2 encoded data
let encodedString = digest.encodedString // the Argon2 encoded string

let isVerified = try! Argon2.verify(password: password, encodedHash: encodedString)
```

# Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/rkreutz/Argon2Kit/issues).

# Licensing

- Argon2Kit is Licensed under the [MIT License](https://github.com/rkreutz/Argon2Kit/blob/main/LICENSE)
- The C implementation of [Argon2](https://github.com/P-H-C/phc-winner-argon2) is licensed under a dual [Apache and CC0 License](https://github.com/P-H-C/phc-winner-argon2/blob/master/LICENSE)
