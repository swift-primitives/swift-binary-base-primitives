extension Binary.Base {
    /// Base-32 encoding.
    ///
    /// 5 bits per digit; 8 digits encode 5 input bytes.
    ///
    /// Algorithm: bit-packing. RFC 4648 defines two alphabets — §6 standard
    /// (`A-Z2-7`) and §7 extended-hex (`0-9A-V`); both are available via
    /// `swift-ietf/swift-rfc-4648`. Crockford and z-base-32 alphabets may
    /// be added by their respective convention packages.
    public struct `32`: Sendable {
        /// Creates a base-32 radix marker.
        public init() {}
    }
}
