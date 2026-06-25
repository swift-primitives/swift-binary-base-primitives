extension Binary.Base {
    /// Base-58 encoding.
    ///
    /// Variable-length integer arithmetic over a non-power-of-2 radix.
    ///
    /// Algorithm: integer arithmetic (repeated division). The canonical alphabet
    /// is the Bitcoin alphabet (digits + uppercase + lowercase, omitting `0OIl`
    /// to avoid visual ambiguity); spec / convention packages provide the named
    /// instances.
    public struct `58`: Sendable {
        /// Creates a base-58 radix marker.
        public init() {}
    }
}
