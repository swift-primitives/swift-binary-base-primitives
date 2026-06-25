public import Byte_Primitives
public import Byte_Primitives_Standard_Library_Integration
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`58` {
    /// Encode a fixed-width unsigned integer as base-58 using the supplied alphabet.
    ///
    /// Variable-length output via repeated division by 58. Spec packages
    /// (e.g., a future `swift-base58-bitcoin`) provide alphabet-specific overloads.
    ///
    /// - Precondition: `alphabet.count == 58`.
    public func callAsFunction(
        _ value: UInt64,
        alphabet: borrowing [Byte]
    ) -> String {
        precondition(alphabet.count == 58, "Base 58 alphabet must contain exactly 58 bytes")
        if value == 0 { return String(decoding: [alphabet[0]], as: UTF8.self) }
        var v = value
        var out: [Byte] = []
        while v > 0 {
            out.append(alphabet[Int(v % 58)])
            v /= 58
        }
        out.reverse()
        return String(decoding: out, as: UTF8.self)
    }
}
