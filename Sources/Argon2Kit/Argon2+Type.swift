import Foundation
import argon2

public extension Argon2 {
    enum `Type`: UInt32 {
        /// Argon2d is faster and is highly resistant against GPU cracking attacks, however has
        /// potential vulnerability to side-channel timing attacks.
        case d = 0

        /// Argon2i uses data-independent memory access, but it is slower as it makes
        /// more passes over the memory to protect from side-channel timing attacks.
        case i = 1

        /// Argon2id is a hybrid of Argon2i and Argon2d, which gives some of Argon2i's
        /// resistance to side-channel cache timing attacks and Argon2d's resistance to GPU cracking attacks.
        case id = 2

        var argon2type: argon2_type { argon2_type(rawValue: rawValue) }
    }
}

extension Argon2.`Type`: CustomDebugStringConvertible {
    public var debugDescription: String {
        String(cString: argon2_type2string(argon2type, 1))
    }
}
