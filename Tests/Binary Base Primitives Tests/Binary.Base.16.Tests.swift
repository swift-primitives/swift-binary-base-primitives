import Binary_Base_Primitives
import Binary_Base_Primitives_Test_Support
import Byte_Primitives
import Testing

@Suite("Binary.Base.`16`")
struct BinaryBase16Tests {
    /// RFC 4648 §8 alphabet, available here as a local fixture; the canonical
    /// declaration ships in `swift-ietf/swift-rfc-4648` (Phase 2).
    static let hexAlphabet: [Byte] = "0123456789ABCDEF".utf8.map(Byte.init)

    @Test("hex round-trip on DEAD BE EF")
    func deadBeefRoundTrip() {
        let bytes: [Byte] = [0xDE, 0xAD, 0xBE, 0xEF]
        let encoded = Binary.Base.`16`.encode(bytes, alphabet: Self.hexAlphabet)
        #expect(encoded == "DEADBEEF")

        let decoded = Binary.Base.`16`.decode(encoded, alphabet: Self.hexAlphabet)
        #expect(decoded == bytes)
    }

    @Test("decode rejects odd-length input")
    func decodeRejectsOddLength() {
        let result = Binary.Base.`16`.decode("ABC", alphabet: Self.hexAlphabet)
        #expect(result == nil)
    }

    @Test("decode rejects invalid character")
    func decodeRejectsInvalid() {
        let result = Binary.Base.`16`.decode("DE!F", alphabet: Self.hexAlphabet)
        #expect(result == nil)
    }

    @Test("empty bytes encode to empty string")
    func emptyEncoding() {
        let encoded = Binary.Base.`16`.encode([] as [Byte], alphabet: Self.hexAlphabet)
        #expect(encoded.isEmpty)
    }
}
