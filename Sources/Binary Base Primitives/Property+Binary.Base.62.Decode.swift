public import Byte_Primitives
public import Property_Primitives

extension Property where Tag == Binary.Base.Decode, Base == Binary.Base.`62` {
    /// Decode `text` as a base-62 unsigned integer against a pre-built alphabet.
    ///
    /// Returns `nil` on invalid character or numeric overflow beyond `UInt64.max`.
    public func callAsFunction(
        _ text: borrowing String,
        alphabet: Binary.Base.`62`.Alphabet
    ) -> UInt64? {
        var result: UInt64 = 0
        for codeUnit in text.utf8 {
            guard let digit = alphabet.decode(Byte(codeUnit)) else { return nil }
            let (mul, mulOverflow) = result.multipliedReportingOverflow(by: 62)
            if mulOverflow { return nil }
            let (add, addOverflow) = mul.addingReportingOverflow(UInt64(digit))
            if addOverflow { return nil }
            result = add
        }
        return result
    }

    /// Decode `text` as a base-62 unsigned integer using the supplied alphabet bytes.
    ///
    /// Returns `nil` on invalid character or numeric overflow beyond `UInt64.max`.
    ///
    /// - Precondition: `alphabet.count == 62`.
    public func callAsFunction(
        _ text: borrowing String,
        alphabet: [Byte]
    ) -> UInt64? {
        callAsFunction(text, alphabet: Binary.Base.`62`.Alphabet(alphabet))
    }

    /// Decode `text` as base-62 using the standard alphabet.
    public func callAsFunction(_ text: borrowing String) -> UInt64? {
        callAsFunction(text, alphabet: Binary.Base.`62`.Alphabet.standard)
    }

    /// Decode `text` as base-62 using the GNU MP alphabet.
    public func gmp(_ text: borrowing String) -> UInt64? {
        callAsFunction(text, alphabet: Binary.Base.`62`.Alphabet.gmp)
    }

    /// Decode `text` as base-62 using the inverted alphabet.
    public func inverted(_ text: borrowing String) -> UInt64? {
        callAsFunction(text, alphabet: Binary.Base.`62`.Alphabet.inverted)
    }

    /// Per-byte digit lookup against the standard alphabet.
    ///
    /// - Returns: The digit value (0–61), or `nil` if `byte` is not in the alphabet.
    @inlinable
    public func digit(_ byte: Byte) -> UInt8? {
        Binary.Base.`62`.Alphabet.standard.decode(byte)
    }

    /// Per-byte digit lookup against an arbitrary alphabet.
    @inlinable
    public func digit(_ byte: Byte, alphabet: Binary.Base.`62`.Alphabet) -> UInt8? {
        alphabet.decode(byte)
    }

    /// Per-byte alphabet membership against the standard alphabet.
    @inlinable
    public func isValid(_ byte: Byte) -> Bool {
        Binary.Base.`62`.Alphabet.standard.isValid(byte)
    }

    /// Per-byte alphabet membership against an arbitrary alphabet.
    @inlinable
    public func isValid(_ byte: Byte, alphabet: Binary.Base.`62`.Alphabet) -> Bool {
        alphabet.isValid(byte)
    }
}
