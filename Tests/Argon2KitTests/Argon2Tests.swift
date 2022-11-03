import XCTest
@testable import Argon2Kit

final class Argon2Tests: XCTestCase {
    func testPasswordHashingWithArgon2i() throws {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        let digest = try Argon2.hash(password: password, salt: salt, iterations: 3, memory: 12, threads: 1, length: 64, type: .i)
        XCTAssertEqual(digest.rawData.count, 64)
        XCTAssertEqual(digest.rawData, Data([32, 83, 150, 236, 159, 75, 47, 222, 21, 156, 181, 19, 174, 236, 88, 115, 247, 39, 68, 194, 53, 26, 19, 225, 150, 224, 80, 66, 187, 236, 50, 12, 125, 37, 245, 9, 29, 81, 3, 169, 78, 13, 44, 127, 224, 128, 244, 162, 190, 20, 28, 195, 184, 225, 107, 134, 97, 193, 166, 139, 12, 171, 195, 92]))
        XCTAssertEqual(digest.encodedString, "$argon2i$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$IFOW7J9LL94VnLUTruxYc/cnRMI1GhPhluBQQrvsMgx9JfUJHVEDqU4NLH/ggPSivhQcw7jha4ZhwaaLDKvDXA\0")
    }

    func testVerifyWithArgon2i() throws {
        let password = "Password123"
        let encoded = "$argon2i$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$IFOW7J9LL94VnLUTruxYc/cnRMI1GhPhluBQQrvsMgx9JfUJHVEDqU4NLH/ggPSivhQcw7jha4ZhwaaLDKvDXA\0"
        let invalidEncoded = "$argon2i$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$CPE/z99vpcB96RKd+mQ/YfNPSS/Pj26BRnbzrJti1UpTe8nUs6dqWVtX2f8NQVvSoBdVUp5JAYAGTU2Dc5vZGg\0"

        XCTAssertTrue(try Argon2.verify(password: password, encodedHash: encoded, type: .i))
        XCTAssertFalse(try Argon2.verify(password: password, encodedHash: invalidEncoded, type: .i))
    }

    func testPasswordHashingWithArgon2d() throws {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        let digest = try Argon2.hash(password: password, salt: salt, iterations: 3, memory: 12, threads: 1, length: 64, type: .d)
        XCTAssertEqual(digest.rawData.count, 64)
        XCTAssertEqual(digest.rawData, Data([69, 188, 211, 73, 76, 41, 83, 202, 198, 216, 134, 71, 127, 105, 125, 104, 21, 22, 220, 176, 196, 217, 68, 142, 81, 6, 106, 169, 191, 86, 170, 31, 223, 145, 89, 10, 114, 217, 167, 7, 76, 19, 204, 104, 252, 145, 110, 70, 9, 231, 213, 144, 19, 95, 202, 66, 64, 35, 56, 179, 137, 34, 148, 20]))
        XCTAssertEqual(digest.encodedString, "$argon2d$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$RbzTSUwpU8rG2IZHf2l9aBUW3LDE2USOUQZqqb9Wqh/fkVkKctmnB0wTzGj8kW5GCefVkBNfykJAIziziSKUFA\0")
    }

    func testVerifyWithArgon2d() throws {
        let password = "Password123"
        let encoded = "$argon2d$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$RbzTSUwpU8rG2IZHf2l9aBUW3LDE2USOUQZqqb9Wqh/fkVkKctmnB0wTzGj8kW5GCefVkBNfykJAIziziSKUFA\0"
        let invalidEncoded = "$argon2d$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$Y4BEJeKQENPQPGVR27W2hCtKCg7XUL+sey9rIApqqyx8Dw5491Ke+mL/gZr9qBXY1QxW5qNhlHbZaylih0k6lA"

        XCTAssertTrue(try Argon2.verify(password: password, encodedHash: encoded, type: .d))
        XCTAssertFalse(try Argon2.verify(password: password, encodedHash: invalidEncoded, type: .d))
    }

    func testPasswordHashingWithArgon2id() throws {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        let digest = try Argon2.hash(password: password, salt: salt, iterations: 3, memory: 12, threads: 1, length: 64, type: .id)
        XCTAssertEqual(digest.rawData.count, 64)
        XCTAssertEqual(digest.rawData, Data([207, 139, 12, 45, 144, 72, 154, 22, 5, 202, 76, 225, 209, 95, 167, 248, 60, 246, 93, 17, 51, 23, 15, 30, 165, 126, 74, 84, 87, 199, 223, 55, 171, 31, 14, 10, 175, 49, 64, 93, 161, 220, 92, 144, 89, 185, 71, 117, 83, 232, 121, 67, 90, 255, 149, 158, 19, 178, 126, 114, 243, 98, 182, 203]))
        XCTAssertEqual(digest.encodedString, "$argon2id$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$z4sMLZBImhYFykzh0V+n+Dz2XREzFw8epX5KVFfH3zerHw4KrzFAXaHcXJBZuUd1U+h5Q1r/lZ4Tsn5y82K2yw\0")
    }

    func testVerifyWithArgon2id() throws {
        let password = "Password123"
        let encoded = "$argon2id$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$z4sMLZBImhYFykzh0V+n+Dz2XREzFw8epX5KVFfH3zerHw4KrzFAXaHcXJBZuUd1U+h5Q1r/lZ4Tsn5y82K2yw\0"
        let invalidEncoded = "$argon2id$v=19$m=12,t=3,p=1$BQUFBQUFBQUFBQUFBQUFBQ$+h/J9XRwCD+XiHgiPvq+SSyW/1p7bbzDAsJvCK8UOFN2tfx6HHLqjWE1AKxAdkA86Dd0duXVhoIM2ERTgIbuGw"

        XCTAssertTrue(try Argon2.verify(password: password, encodedHash: encoded, type: .id))
        XCTAssertFalse(try Argon2.verify(password: password, encodedHash: invalidEncoded, type: .id))
    }

    func testPerformance() {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        measure {
            let digest = try? Argon2.hash(
                password: password,
                salt: salt,
                iterations: 3,
                memory: 16_384,
                threads: 1,
                length: 32,
                type: .i,
                version: .latest
            )
            XCTAssertEqual(digest?.rawData.count, 32)
        }
    }

    func testPerformanceSmallerKey() {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        measure {
            let digest = try? Argon2.hash(
                password: password,
                salt: salt,
                iterations: 3,
                memory: 16_384,
                threads: 1,
                length: 24,
                type: .i,
                version: .latest
            )
            XCTAssertEqual(digest?.rawData.count, 24)
        }
    }

    func testPerformanceLongKey() {
        let password = "Password123"
        let salt = Data([UInt8](repeating: 5, count: 16))

        measure {
            let digest = try? Argon2.hash(
                password: password,
                salt: salt,
                iterations: 3,
                memory: 16_384,
                threads: 1,
                length: 1_048_576,
                type: .i,
                version: .latest
            )
            XCTAssertEqual(digest?.rawData.count, 1_048_576)
        }
    }
}
