import Foundation
import argon2

public enum Argon2 {
    /// Hashes a given password with Argon2.
    /// - Parameters:
    ///   - password: the password string to be hashed
    ///   - salt: the salt to be used, a minimum of 8 bytes should be provided. (defaults to 8 random bytes)
    ///   - iterations: the number of iterations (defaults to 3)
    ///   - memory: the memory cost to be used, denominated in kB (defaults to 4,096)
    ///   - threads: the number of parallel threads to use (defaults to 1)
    ///   - length: the number of bytes of the resulting hash (defaults to 32)
    ///   - type: the Argon2 type to be used (defaults to `i`)
    ///   - version: the Argon2 version to be used (defaults to `latest`)
    /// - Returns: a `Digest` containing the raw hash and the encoded hash.
    public static func hash(
        password: String,
        salt: Data = .random(bytes: 8),
        iterations: UInt32 = 3,
        memory: UInt32 = 4_096,
        threads: UInt32 = 1,
        length: UInt32 = 32,
        type: `Type` = .i,
        version: Version = .latest
    ) throws -> Digest {
        try hash(password: Data(password.utf8), salt: salt, iterations: iterations, memory: memory, threads: threads, length: length, type: type, version: version)
    }

    /// Hashes a given password with Argon2.
    /// - Parameters:
    ///   - password: the password data to be hashed
    ///   - salt: the salt to be used, a minimum of 8 bytes should be provided. (defaults to 8 random bytes)
    ///   - iterations: the number of iterations (defaults to 3)
    ///   - memory: the memory cost to be used, denominated in kB (defaults to 4,096)
    ///   - threads: the number of parallel threads to use (defaults to 1)
    ///   - length: the number of bytes of the resulting hash (defaults to 32)
    ///   - type: the Argon2 type to be used (defaults to `i`)
    ///   - version: the Argon2 version to be used (defaults to `latest`)
    /// - Returns: a `Digest` containing the raw hash and the encoded hash.
    public static func hash(
        password: Data,
        salt: Data = .random(bytes: 8),
        iterations: UInt32 = 3,
        memory: UInt32 = 4_096,
        threads: UInt32 = 1,
        length: UInt32 = 32,
        type: `Type` = .i,
        version: Version = .latest
    ) throws -> Digest {
        let encodedLen = argon2_encodedlen(iterations, memory, threads, UInt32(salt.count), length, type.argon2type)

        let hash = UnsafeMutablePointer<Int8>.allocate(capacity: Int(length))
        let encoded = UnsafeMutablePointer<Int8>.allocate(capacity: Int(encodedLen))

        defer {
            hash.deinitialize(count: Int(length))
            hash.deallocate()
            encoded.deinitialize(count: encodedLen)
            encoded.deallocate()
        }

        let rawErrorCode = argon2_hash(iterations, memory, threads, [UInt8](password), password.count, [UInt8](salt), salt.count, hash, Int(length), encoded, encodedLen, type.argon2type, version.rawValue)
        let errorCode = ErrorCode(rawValue: rawErrorCode)

        guard errorCode == .ok else { throw errorCode }

        let hashData = Data(bytes: hash, count: Int(length))
        let encodedData = Data(bytes: encoded, count: encodedLen)

        return Digest(hash: hashData, encoded: encodedData)
    }

    /// Verifies if a given password matches the given encoded hash.
    ///
    /// - Parameters:
    ///   - password: the password string
    ///   - encodedHash: the Argon2 encoded hash string to check against the password
    ///   - type: the Argon2 type to use (defaults to `i`).
    /// - Returns: A boolean indicating whether the password and encoded hash matches or not.
    public static func verify(
        password: String,
        encodedHash: String,
        type: `Type` = .i
    ) throws -> Bool {
        try verify(password: Data(password.utf8), encodedHash: Data(encodedHash.utf8), type: type)
    }

    /// Verifies if a given password matches the given encoded hash.
    ///
    /// - Parameters:
    ///   - password: the password data
    ///   - encodedHash: the Argon2 encoded hash to check against the password
    ///   - type: the Argon2 type to use (defaults to `i`).
    /// - Returns: A boolean indicating whether the password and encoded hash matches or not.
    public static func verify(
        password: Data,
        encodedHash: Data,
        type: `Type` = .i
    ) throws -> Bool {
        let encodedStr = String(data: encodedHash, encoding: .utf8)?.cString(using: .utf8)

        let rawErrorCode = argon2_verify(encodedStr, [UInt8](password), password.count, type.argon2type)
        let errorCode = ErrorCode(rawValue: rawErrorCode)

        guard errorCode == .ok || errorCode == .verifyMismatch else { throw errorCode }

        return errorCode == .ok
    }
}
