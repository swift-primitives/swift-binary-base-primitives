public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`16` {
    /// Encode `bytes` as base-16 (hex) using the supplied 16-character alphabet.
    ///
    /// Spec packages provide alphabet-specific overloads (e.g.,
    /// `swift-rfc-4648` adds `callAsFunction(_:)` selecting RFC 4648 §8).
    /// Direct callers supply their own alphabet via this method.
    ///
    /// - Parameters:
    ///   - bytes: Input byte array.
    ///   - alphabet: Exactly 16 ASCII bytes — index `i` is the digit value `i`.
    /// - Returns: A 2 · `bytes.count`-character ASCII string, big-endian within
    ///   each byte (high nibble first).
    /// - Precondition: `alphabet.count == 16`.
    public func callAsFunction(
        _ bytes: borrowing [Byte],
        alphabet: borrowing [Byte]
    ) -> String {
        precondition(alphabet.count == 16, "Base 16 alphabet must contain exactly 16 bytes")
        var out: [Byte] = []
        out.reserveCapacity(bytes.count * 2)
        for i in 0..<bytes.count {
            let raw = bytes[i].underlying
            out.append(alphabet[Int(raw >> 4)])
            out.append(alphabet[Int(raw & 0x0F)])
        }
        return String(decoding: out.map(\.underlying), as: UTF8.self)
    }
}
