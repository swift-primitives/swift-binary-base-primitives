import Binary_Base_Primitives
import Binary_Base_Primitives_Test_Support
import Byte_Primitives
import Testing

@Suite("Binary.Base.`62`")
struct BinaryBase62Tests {
    @Test("standard alphabet round-trips UInt64")
    func standardRoundTrip() {
        let encoded = Binary.Base.`62`.encode(UInt64(123_456_789))
        #expect(encoded == "8M0kX")

        let decoded = Binary.Base.`62`.decode(encoded)
        #expect(decoded == 123_456_789)
    }

    @Test("standard alphabet encodes zero as alphabet[0]")
    func zeroIsFirstChar() {
        let encoded = Binary.Base.`62`.encode(UInt64(0))
        #expect(encoded == "0")
    }

    @Test("gmp variant encodes value differently from standard")
    func gmpDiffersFromStandard() {
        let standard = Binary.Base.`62`.encode(UInt64(123_456_789))
        let gmp = Binary.Base.`62`.encode.gmp(UInt64(123_456_789))
        #expect(standard != gmp)
        #expect(gmp == "IWAuh")

        let decoded = Binary.Base.`62`.decode.gmp(gmp)
        #expect(decoded == 123_456_789)
    }

    @Test("inverted variant round-trips")
    func invertedRoundTrip() {
        let value = UInt64(987_654_321)
        let encoded = Binary.Base.`62`.encode.inverted(value)
        let decoded = Binary.Base.`62`.decode.inverted(encoded)
        #expect(decoded == value)
    }

    @Test("decode rejects invalid character")
    func decodeRejectsInvalid() {
        let result = Binary.Base.`62`.decode("8M0!X")
        #expect(result == nil)
    }

    @Test("custom alphabet path works")
    func customAlphabet() {
        let alphabet = "ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba9876543210".utf8.map(Byte.init)
        let encoded = Binary.Base.`62`.encode(UInt64(42), alphabet: alphabet)
        let decoded = Binary.Base.`62`.decode(encoded, alphabet: alphabet)
        #expect(decoded == 42)
    }

    @Test("decode.digit reads per-byte against standard alphabet")
    func decodeDigitStandard() {
        #expect(Binary.Base.`62`.decode.digit(Byte(UInt8(ascii: "A"))) == 10)
        #expect(Binary.Base.`62`.decode.digit(Byte(UInt8(ascii: "a"))) == 36)
        #expect(Binary.Base.`62`.decode.digit(Byte(UInt8(ascii: "!"))) == nil)
    }

    @Test("decode.digit honours alphabet parameter")
    func decodeDigitAlphabet() {
        #expect(Binary.Base.`62`.decode.digit(Byte(UInt8(ascii: "A")), alphabet: .gmp) == 0)
    }

    @Test("decode.isValid mirrors digit non-nil-ness")
    func decodeIsValid() {
        #expect(Binary.Base.`62`.decode.isValid(Byte(UInt8(ascii: "Z"))) == true)
        #expect(Binary.Base.`62`.decode.isValid(Byte(UInt8(ascii: " "))) == false)
    }
}
