import Foundation
import argon2

public extension Argon2 {
    enum ErrorCode: Int32, CaseIterable {
        case ok = 0

        /// Output pointer is NULL
        case outputPointerNull = -1

        /// Output is too short
        case outputTooShort = -2
        /// Output is too long
        case outputTooLong = -3

        /// Password is too short
        case passwordTooShort = -4
        /// Password is too long
        case passwordTooLong = -5

        /// Salt is too short
        case saltTooShort = -6
        /// Salt is too long
        case saltTooLong = -7

        /// Associated data is too short
        case associatedDataTooShort = -8
        /// Associated data is too long
        case associatedDataTooLong = -9

        /// Secret is too short
        case secretTooShort = -10
        /// Secret is too long
        case secretTooLong = -11

        /// Time cost is too small
        case timeTooSmall = -12
        /// Time cost is too large
        case timeTooLarge = -13

        /// Memory cost is too small
        case memoryTooLittle = -14
        /// Memory cost is too large
        case memoryTooMuch = -15

        /// Too few lanes
        case lanesTooFew = -16
        /// Too many lanes
        case lanesTooMany = -17

        /// Password pointer is NULL, but password length is not 0
        case passwordPointerMismatch = -18
        /// Salt pointer is NULL, but salt length is not 0
        case saltPointerMismatch = -19
        /// Secret pointer is NULL, but secret length is not 0
        case secretPointerMismatch = -20
        /// Associated data pointer is NULL, but ad length is not 0
        case associatedDataPointerMismatch = -21

        /// Memory allocation error
        case memoryAllocationError = -22

        /// The free memory callback is NULL
        case freeMemoryCallbackNull = -23
        /// The allocate memory callback is NULL
        case allocateMemoryCallbackNull = -24

        /// Argon2 context is NULL
        case incorrectParameter = -25
        /// There is no such version of Argon2
        case incorrectType = -26

        /// Output pointer mismatch
        case outputPointerMismatch = -27

        /// Not enough threads
        case threadsTooFew = -28
        /// Too many threads
        case threadsTooMany = -29

        /// Missing arguments
        case missingArguments = -30

        /// Encoding failed
        case encodingFailed = -31

        /// Decoding failed
        case decodingFailed = -32

        /// Threading failure
        case threadingFailed = -33

        /// Some of encoded parameters are too long or too short
        case decodingLengthFailed = -34

        /// The password does not match the supplied hash
        case verifyMismatch = -35

        /// Unknown error code
        case unknown = -36

        public init(rawValue: Int32) {
            self = Self.allCases.first(where: { $0.rawValue == rawValue }) ?? .unknown
        }
    }
}

extension Argon2.ErrorCode: Error {
    public var localizedDescription: String {
        String(cString: argon2_error_message(rawValue))
    }
}

extension Argon2.ErrorCode: CustomDebugStringConvertible {
    public var debugDescription: String {
        "[\(rawValue)] \(localizedDescription)"
    }
}
