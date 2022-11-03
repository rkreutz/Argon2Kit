import XCTest
@testable import argon2

final class argon2Tests: XCTestCase {
    func testPerformance() throws {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        let encodedLen = argon2_encodedlen(3, 16_384, 1, UInt32(salt.count), 32, argon2_type(rawValue: 1))

        let hash = UnsafeMutablePointer<Int8>.allocate(capacity: 32)
        let encoded = UnsafeMutablePointer<Int8>.allocate(capacity: Int(encodedLen))

        defer {
            hash.deinitialize(count: Int(32))
            hash.deallocate()
            encoded.deinitialize(count: encodedLen)
            encoded.deallocate()
        }

        var rawErrorCode: Int32 = -36
        measure {
            rawErrorCode = argon2_hash(3, 16_384, 1, [UInt8](password.utf8), password.count, [UInt8](salt), salt.count, hash, Int(32), encoded, encodedLen, argon2_type(rawValue: 1), 0x13)
        }

        guard rawErrorCode == 0 else {
            XCTFail("Failed with error code: \(rawErrorCode)")
            return
        }

        let hashData = Data(bytes: hash, count: Int(32))
        XCTAssertEqual(hashData.count, 32)
    }

    func testPerformanceLongKey() {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        let encodedLen = argon2_encodedlen(3, 16_384, 1, UInt32(salt.count), 1_048_576, argon2_type(rawValue: 1))

        let hash = UnsafeMutablePointer<Int8>.allocate(capacity: 1_048_576)
        let encoded = UnsafeMutablePointer<Int8>.allocate(capacity: Int(encodedLen))

        defer {
            hash.deinitialize(count: Int(1_048_576))
            hash.deallocate()
            encoded.deinitialize(count: encodedLen)
            encoded.deallocate()
        }

        var rawErrorCode: Int32 = -36
        measure {
            rawErrorCode = argon2_hash(3, 16_384, 1, [UInt8](password.utf8), password.count, [UInt8](salt), salt.count, hash, Int(1_048_576), encoded, encodedLen, argon2_type(rawValue: 1), 0x13)
        }

        guard rawErrorCode == 0 else {
            XCTFail("Failed with error code: \(rawErrorCode)")
            return
        }

        let hashData = Data(bytes: hash, count: Int(1_048_576))
        XCTAssertEqual(hashData.count, 1_048_576)
    }
}
