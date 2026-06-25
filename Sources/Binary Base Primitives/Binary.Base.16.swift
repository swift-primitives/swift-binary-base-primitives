extension Binary.Base {
    /// Base-16 encoding (hex).
    ///
    /// 4 bits per digit, two digits per input byte.
    ///
    /// Algorithm: bit-packing. The canonical alphabet is RFC 4648 §8 (`0-9A-F`),
    /// available via `swift-ietf/swift-rfc-4648`. Custom alphabets may be passed
    /// to ``Property/callAsFunction(_:alphabet:)`` directly.
    public struct `16`: Sendable {
        /// Creates a base-16 radix marker.
        public init() {}
    }
}
