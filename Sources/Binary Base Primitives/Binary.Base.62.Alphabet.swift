public import Byte_Primitives
internal import Property_Primitives

extension Binary.Base.`62` {
    /// Base-62 alphabet with pre-computed encode and decode tables.
    ///
    /// Each alphabet defines a bijection between digit values 0–61
    /// (internal representation) and ASCII bytes (external representation).
    /// The decode table is built once at construction; per-byte lookups
    /// are O(1).
    ///
    /// ## Predefined alphabets
    ///
    /// - ``standard`` — digits → uppercase → lowercase (canonical)
    /// - ``gmp`` — uppercase → lowercase → digits (GNU MP convention)
    /// - ``inverted`` — digits → lowercase → uppercase
    /// - ``default`` — alias for ``standard``
    ///
    /// ## Custom alphabets
    ///
    /// ```swift
    /// let bytes = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".utf8)
    /// let custom = Binary.Base.`62`.Alphabet(bytes)
    /// ```
    public struct Alphabet: Sendable, Hashable {
        /// Forward lookup: index `i` (0–61) maps to the ASCII byte for digit `i`.
        @usableFromInline internal let encodeTable: [Byte]

        /// Inverse lookup: index `b` (0–255) maps to the digit value for byte `b`,
        /// or `0xFF` if `b` is not in the alphabet.
        ///
        /// `UInt8` is the arithmetic-domain digit value here (0–61 valid, 0xFF sentinel).
        @usableFromInline internal let decodeTable: [UInt8]

        /// Construct an alphabet from 62 unique ASCII bytes.
        ///
        /// - Precondition: `bytes.count == 62` and all bytes are unique.
        public init(_ bytes: [Byte]) {
            precondition(bytes.count == 62, "Base 62 alphabet must contain exactly 62 bytes")

            var inverse = [UInt8](repeating: 0xFF, count: 256)
            for (digit, codeUnit) in bytes.enumerated() {
                precondition(inverse[Int(codeUnit.underlying)] == 0xFF, "Base 62 alphabet must contain unique bytes")
                inverse[Int(codeUnit.underlying)] = UInt8(digit)
            }

            self.encodeTable = bytes
            self.decodeTable = inverse
        }

        /// Encode a digit value (0–61) to its ASCII byte representation.
        ///
        /// - Precondition: `value` is in `0...61`.
        @inlinable
        public func encode(_ value: UInt8) -> Byte {
            encodeTable[Int(value)]
        }

        /// Decode a byte to its digit value (0–61).
        ///
        /// - Returns: The digit value, or `nil` if `byte` is not in the alphabet.
        @inlinable
        public func decode(_ byte: Byte) -> UInt8? {
            let value = decodeTable[Int(byte.underlying)]
            return value == 0xFF ? nil : value
        }

        /// Returns `true` if `byte` is a valid digit in this alphabet.
        @inlinable
        public func isValid(_ byte: Byte) -> Bool {
            decodeTable[Int(byte.underlying)] != 0xFF
        }

        /// Standard alphabet — digits, then uppercase, then lowercase.
        public static let standard: Alphabet = .init(
            Property<Binary.Base.Encode, Binary.Base.`62`>.standardAlphabet
        )

        /// GNU MP alphabet — uppercase, then lowercase, then digits.
        public static let gmp: Alphabet = .init(
            Property<Binary.Base.Encode, Binary.Base.`62`>.gmpAlphabet
        )

        /// Inverted alphabet — digits, then lowercase, then uppercase.
        public static let inverted: Alphabet = .init(
            Property<Binary.Base.Encode, Binary.Base.`62`>.invertedAlphabet
        )

        /// Default alphabet (currently ``standard``).
        public static var `default`: Self { .standard }
    }
}
