extension Binary.Base {
    /// Base-62 encoding.
    ///
    /// Variable-length integer arithmetic over a non-power-of-2 radix.
    ///
    /// Algorithm: integer arithmetic (repeated division). No RFC governs base62;
    /// this package ships three convention alphabets — ``standard`` (digits →
    /// upper → lower), ``gmp`` (upper → lower → digits, GNU MP convention), and
    /// ``inverted`` (digits → lower → upper).
    public struct `62`: Sendable {
        /// Creates a base-62 radix marker.
        public init() {}
    }
}
