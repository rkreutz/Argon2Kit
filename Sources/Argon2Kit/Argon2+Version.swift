import Foundation
import argon2

public extension Argon2 {
    enum Version: UInt32 {
        /// Hash using Argon2  version 13
        case v13 = 0x13

        /// Hash using Argon2 version 10
        case v10 = 0x10

        /// Hash using latest Argon2 version
        public static var latest: Version { .v13 }

        var argon2version: argon2_version { argon2_version(rawValue: rawValue) }
    }
}
