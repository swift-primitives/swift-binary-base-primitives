public import Byte_Primitives
public import Byte_Primitives_Standard_Library_Integration
public import Property_Primitives

extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`62` {
    /// Encode a fixed-width unsigned integer as base-62 using the supplied alphabet.
    ///
    /// Variable-length output via repeated division by 62. The package ships
    /// three named alphabet variants — ``callAsFunction(_:)`` (standard), ``gmp(_:)``,
    /// and ``inverted(_:)``. This signature is the open-axis path for custom alphabets.
    ///
    /// - Precondition: `alphabet.count == 62`.
    public func callAsFunction(
        _ value: UInt64,
        alphabet: borrowing [Byte]
    ) -> String {
        precondition(alphabet.count == 62, "Base 62 alphabet must contain exactly 62 bytes")
        if value == 0 { return String(decoding: [alphabet[0]], as: UTF8.self) }
        var v = value
        var out: [Byte] = []
        while v > 0 {
            out.append(alphabet[Int(v % 62)])
            v /= 62
        }
        out.reverse()
        return String(decoding: out, as: UTF8.self)
    }

    /// Encode `value` as base-62 using the standard alphabet (digits → upper → lower).
    public func callAsFunction(_ value: UInt64) -> String {
        callAsFunction(value, alphabet: Self.standardAlphabet)
    }

    /// Encode `value` as base-62 using the GNU MP convention (upper → lower → digits).
    public func gmp(_ value: UInt64) -> String {
        callAsFunction(value, alphabet: Self.gmpAlphabet)
    }

    /// Encode `value` as base-62 using the inverted convention (digits → lower → upper).
    public func inverted(_ value: UInt64) -> String {
        callAsFunction(value, alphabet: Self.invertedAlphabet)
    }

    /// Standard base-62 alphabet — digits, then uppercase, then lowercase.
    public static var standardAlphabet: [Byte] {
        "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".utf8.map(Byte.init)
    }

    /// GNU MP base-62 alphabet — uppercase, then lowercase, then digits.
    public static var gmpAlphabet: [Byte] {
        "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".utf8.map(Byte.init)
    }

    /// Inverted base-62 alphabet — digits, then lowercase, then uppercase.
    public static var invertedAlphabet: [Byte] {
        "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ".utf8.map(Byte.init)
    }
}
