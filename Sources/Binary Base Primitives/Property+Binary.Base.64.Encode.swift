public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`64` {
    /// Encode `bytes` as base-64 using the supplied 64-character alphabet.
    ///
    /// Output is padded to a multiple of 4 characters with `pad` (when non-nil).
    /// RFC 4648 §4 standard uses `=`; §5 URL-safe is conventionally unpadded.
    ///
    /// - Precondition: `alphabet.count == 64`.
    public func callAsFunction(
        _ bytes: borrowing [Byte],
        alphabet: borrowing [Byte],
        pad: Byte? = nil
    ) -> String {
        precondition(alphabet.count == 64, "Base 64 alphabet must contain exactly 64 bytes")
        var out: [Byte] = []
        out.reserveCapacity(((bytes.count + 2) / 3) * 4)
        var i = 0
        while i + 3 <= bytes.count {
            let a = bytes[i].underlying
            let b = bytes[i + 1].underlying
            let c = bytes[i + 2].underlying
            out.append(alphabet[Int(a >> 2)])
            out.append(alphabet[Int(((a & 0x03) << 4) | (b >> 4))])
            out.append(alphabet[Int(((b & 0x0F) << 2) | (c >> 6))])
            out.append(alphabet[Int(c & 0x3F)])
            i += 3
        }
        let leftover = bytes.count - i
        if leftover == 1 {
            let a = bytes[i].underlying
            out.append(alphabet[Int(a >> 2)])
            out.append(alphabet[Int((a & 0x03) << 4)])
            if let p = pad {
                out.append(p)
                out.append(p)
            }
        } else if leftover == 2 {
            let a = bytes[i].underlying
            let b = bytes[i + 1].underlying
            out.append(alphabet[Int(a >> 2)])
            out.append(alphabet[Int(((a & 0x03) << 4) | (b >> 4))])
            out.append(alphabet[Int((b & 0x0F) << 2)])
            if let p = pad { out.append(p) }
        }
        return String(decoding: out.map(\.underlying), as: UTF8.self)
    }
}
