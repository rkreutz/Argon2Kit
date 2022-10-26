import Foundation

public extension Data {
    static func random(bytes: Int) -> Data {
        Data(Array((0 ..< bytes).map { _ in UInt8.random(in: 0...255) }))
    }
}
