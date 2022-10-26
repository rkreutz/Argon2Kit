import Foundation

public extension Argon2 {
    struct Digest: Hashable {
        let hash: Data
        let encoded: Data

        /// Output of the hashing function.
        public var rawData: Data { hash }
        /// Argon2 encoded output with `$type$version$memory,iterations,paralelism$saltAndHash`
        public var encodedData: Data { encoded }
        /// Argon2 encoded output string with `$type$version$memory,iterations,paralelism$saltAndHash`
        public var encodedString: String { String(data: encoded, encoding: .utf8).unsafelyUnwrapped }
    }
}

extension Argon2.Digest: CustomDebugStringConvertible {
    public var debugDescription: String { encodedString }
}
