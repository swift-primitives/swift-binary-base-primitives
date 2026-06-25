extension Binary {
    /// Namespace for binary↔text encoding by integer radix.
    ///
    /// Each radix is a distinct nominal type — `Binary.Base.\`16\`` (hex),
    /// `Binary.Base.\`32\``, `Binary.Base.\`58\``, `Binary.Base.\`62\``,
    /// `Binary.Base.\`64\``, `Binary.Base.\`85\``. The radix set is closed by
    /// encoding mathematics (~6 useful values capped by ~95 printable ASCII
    /// characters); arbitrary radixes are not addable without an explicit
    /// type declaration.
    ///
    /// Each radix exposes `encode` / `decode` static accessors returning
    /// `Property<Encode, Self>` / `Property<Decode, Self>`. Spec packages
    /// (e.g., `swift-rfc-4648`) extend the Property with named alphabet
    /// methods; the alphabet axis is open across packages.
    public enum Base: Sendable {}
}
