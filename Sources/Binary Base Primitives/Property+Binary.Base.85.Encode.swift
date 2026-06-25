public import Byte_Primitives
public import Byte_Primitives_Standard_Library_Integration
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`85` {
    /// Encode a fixed-width unsigned integer as base-85 using the supplied alphabet.
    ///
    /// Variable-length output via repeated division by 85. Spec packages
    /// (RFC 1924, ZeroMQ Z85, Adobe Ascii85) provide alphabet-specific overloads.
    ///
    /// - Precondition: `alphabet.count == 85`.
    public func callAsFunction(
        _ value: UInt64,
        alphabet: borrowing [Byte]
    ) -> String {
        precondition(alphabet.count == 85, "Base 85 alphabet must contain exactly 85 bytes")
        if value == 0 { return String(decoding: [alphabet[0]], as: UTF8.self) }
        var v = value
        var out: [Byte] = []
        while v > 0 {
            out.append(alphabet[Int(v % 85)])
            v /= 85
        }
        out.reverse()
        return String(decoding: out, as: UTF8.self)
    }
}
