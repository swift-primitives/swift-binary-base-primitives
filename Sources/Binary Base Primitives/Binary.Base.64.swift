extension Binary.Base {
    /// Base-64 encoding.
    ///
    /// 6 bits per digit; 4 digits encode 3 input bytes.
    ///
    /// Algorithm: bit-packing. RFC 4648 defines two alphabets — §4 standard
    /// (`A-Za-z0-9+/`) and §5 URL-safe (`A-Za-z0-9-_`); both are available via
    /// `swift-ietf/swift-rfc-4648`. Padding is `=` when present.
    public struct `64`: Sendable {
        /// Creates a base-64 radix marker.
        public init() {}
    }
}
