extension Binary.Base {
    /// Base-85 encoding.
    ///
    /// 5 digits encode 4 input bytes via integer arithmetic.
    ///
    /// Algorithm: integer arithmetic (radix-85 representation of 32-bit groups).
    /// Common alphabets: RFC 1924 (`swift-ietf/swift-rfc-1924`), ZeroMQ Z85
    /// (`swift-zmq/swift-z85`), Adobe Ascii85 (PDF / PostScript context).
    public struct `85`: Sendable {
        /// Creates a base-85 radix marker.
        public init() {}
    }
}
