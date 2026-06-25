public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Decode, Base == Binary.Base.`16` {
    /// Decode `text` as base-16 (hex) using the supplied 16-character alphabet.
    ///
    /// Returns `nil` if `text` contains an invalid character or has odd length.
    /// Decoding is case-sensitive against `alphabet`; case-insensitive decode
    /// requires constructing the alphabet's lowercase + uppercase pairs and
    /// passing that combined alphabet (or pre-uppercasing input).
    ///
    /// - Parameters:
    ///   - text: Input ASCII text.
    ///   - alphabet: Exactly 16 ASCII bytes — index `i` is the digit value `i`.
    /// - Returns: Decoded byte array, or `nil` on invalid input.
    /// - Precondition: `alphabet.count == 16`.
    public func callAsFunction(
        _ text: borrowing String,
        alphabet: borrowing [Byte]
    ) -> [Byte]? {
        precondition(alphabet.count == 16, "Base 16 alphabet must contain exactly 16 bytes")
        let textBytes = Array(text.utf8)
        guard textBytes.count.isMultiple(of: 2) else { return nil }

        // Build inverse table at function scope (16-byte alphabet, sparse 256-entry inverse).
        var inverse: [UInt8] = Array(repeating: 0xFF, count: 256)
        for (digit, codeUnit) in alphabet.enumerated() {
            inverse[Int(codeUnit.underlying)] = UInt8(digit)
        }

        var out: [Byte] = []
        out.reserveCapacity(textBytes.count / 2)
        var i = 0
        while i < textBytes.count {
            let high = inverse[Int(textBytes[i])]
            let low = inverse[Int(textBytes[i + 1])]
            if high == 0xFF || low == 0xFF { return nil }
            out.append(Byte((high << 4) | low))
            i += 2
        }
        return out
    }
}
