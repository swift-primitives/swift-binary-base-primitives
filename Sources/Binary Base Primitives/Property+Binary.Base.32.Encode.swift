public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`32` {
    /// Encode `bytes` as base-32 using the supplied 32-character alphabet.
    ///
    /// Output is padded to a multiple of 8 characters with `pad` (when non-nil).
    /// RFC 4648 §6 / §7 use `=` as pad; Crockford and z-base-32 are unpadded.
    ///
    /// - Parameters:
    ///   - bytes: Input byte array.
    ///   - alphabet: Exactly 32 ASCII bytes — index `i` is the digit value `i`.
    ///   - pad: Optional pad byte; output is right-padded to a multiple of 8.
    /// - Returns: The base-32 ASCII string, padded to a multiple of 8 characters when `pad` is supplied.
    /// - Precondition: `alphabet.count == 32`.
    public func callAsFunction(
        _ bytes: borrowing [Byte],
        alphabet: borrowing [Byte],
        pad: Byte? = nil
    ) -> String {
        precondition(alphabet.count == 32, "Base 32 alphabet must contain exactly 32 bytes")
        var out: [Byte] = []
        out.reserveCapacity(((bytes.count + 4) / 5) * 8)
        var buffer: UInt64 = 0
        var bits: Int = 0
        for i in 0..<bytes.count {
            buffer = (buffer << 8) | UInt64(bytes[i].underlying)
            bits += 8
            while bits >= 5 {
                bits -= 5
                out.append(alphabet[Int((buffer >> bits) & 0x1F)])
            }
        }
        if bits > 0 {
            out.append(alphabet[Int((buffer << (5 - bits)) & 0x1F)])
        }
        if let p = pad {
            while !out.count.isMultiple(of: 8) { out.append(p) }
        }
        return String(decoding: out.map(\.underlying), as: UTF8.self)
    }
}
