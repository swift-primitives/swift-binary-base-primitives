public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`16` {

    public func callAsFunction(
        _ bytes: borrowing [Byte],
        alphabet: borrowing [Byte]
    ) -> String {
        precondition(alphabet.count == 16, "Base 16 alphabet must contain exactly 16 bytes")
        var out: [Byte] = []
        out.reserveCapacity(bytes.count * 2)
        for i in bytes.indices {
            let raw = bytes[i].underlying
            out.append(alphabet[Int(raw >> 4)])
            out.append(alphabet[Int(raw & 0x0F)])
        }
        return String(decoding: out.map(\.underlying), as: UTF8.self)
    }
}
