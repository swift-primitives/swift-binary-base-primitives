import Binary_Base_Primitives
import Binary_Base_Primitives_Test_Support
import Byte_Primitives
import Testing

@Suite("Binary.Base.`62`.Alphabet")
struct BinaryBase62AlphabetTests {
    @Test("standard alphabet decodes digit 0–9 to value 0–9")
    func standardDigits() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        #expect(alphabet.decode(Byte(UInt8(ascii: "0"))) == 0)
        #expect(alphabet.decode(Byte(UInt8(ascii: "9"))) == 9)
    }

    @Test("standard alphabet decodes uppercase A–Z to 10–35")
    func standardUppercase() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        #expect(alphabet.decode(Byte(UInt8(ascii: "A"))) == 10)
        #expect(alphabet.decode(Byte(UInt8(ascii: "Z"))) == 35)
    }

    @Test("standard alphabet decodes lowercase a–z to 36–61")
    func standardLowercase() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        #expect(alphabet.decode(Byte(UInt8(ascii: "a"))) == 36)
        #expect(alphabet.decode(Byte(UInt8(ascii: "z"))) == 61)
    }

    @Test("decode returns nil for bytes outside the alphabet")
    func decodeRejectsInvalid() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        #expect(alphabet.decode(Byte(UInt8(ascii: "!"))) == nil)
        #expect(alphabet.decode(Byte(UInt8(ascii: " "))) == nil)
        #expect(alphabet.decode(0xFF) == nil)
    }

    @Test("isValid mirrors decode != nil")
    func isValidMirrorsDecode() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        #expect(alphabet.isValid(Byte(UInt8(ascii: "A"))) == true)
        #expect(alphabet.isValid(Byte(UInt8(ascii: "!"))) == false)
    }

    @Test("encode round-trips with decode for every digit")
    func encodeDecodeRoundTrip() {
        let alphabet = Binary.Base.`62`.Alphabet.standard
        for value: UInt8 in 0..<62 {
            let byte = alphabet.encode(value)
            #expect(alphabet.decode(byte) == value)
        }
    }

    @Test("gmp alphabet differs from standard")
    func gmpDiffers() {
        let standard = Binary.Base.`62`.Alphabet.standard
        let gmp = Binary.Base.`62`.Alphabet.gmp
        // 'A' is digit 10 in standard, digit 0 in gmp.
        #expect(standard.decode(Byte(UInt8(ascii: "A"))) == 10)
        #expect(gmp.decode(Byte(UInt8(ascii: "A"))) == 0)
        #expect(gmp.decode(Byte(UInt8(ascii: "0"))) == 52)
    }

    @Test("inverted alphabet differs from standard")
    func invertedDiffers() {
        let inverted = Binary.Base.`62`.Alphabet.inverted
        // digits → lowercase → uppercase: 'a' is 10, 'A' is 36.
        #expect(inverted.decode(Byte(UInt8(ascii: "a"))) == 10)
        #expect(inverted.decode(Byte(UInt8(ascii: "A"))) == 36)
    }

    @Test("default alphabet is standard")
    func defaultIsStandard() {
        #expect(Binary.Base.`62`.Alphabet.default == Binary.Base.`62`.Alphabet.standard)
    }

    @Test("custom alphabet round-trips")
    func customAlphabet() {
        let bytes = "ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba9876543210".utf8.map(Byte.init)
        let alphabet = Binary.Base.`62`.Alphabet(bytes)
        // 'Z' is now digit 0; '0' is now digit 61.
        #expect(alphabet.decode(Byte(UInt8(ascii: "Z"))) == 0)
        #expect(alphabet.decode(Byte(UInt8(ascii: "0"))) == 61)
        #expect(alphabet.decode(Byte(UInt8(ascii: "?"))) == nil)
        // round-trip
        for value: UInt8 in 0..<62 {
            #expect(alphabet.decode(alphabet.encode(value)) == value)
        }
    }

    @Test("Hashable equality holds for same alphabet")
    func hashableEquality() {
        let a = Binary.Base.`62`.Alphabet.standard
        let b = Binary.Base.`62`.Alphabet(
            "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz".utf8.map(Byte.init)
        )
        #expect(a == b)
        #expect(a.hashValue == b.hashValue)
    }
}
