public import Property_Primitives

extension Binary.Base.`62` {
    /// Encode-direction Property accessor for base-62.
    ///
    /// Default `callAsFunction(_:)` uses the ``standard`` alphabet. Variants:
    /// ``Property/gmp(_:)``, ``Property/inverted(_:)``. Custom alphabets:
    /// `Binary.Base.\`62\`.encode(value, alphabet: [...])`.
    public static var encode: Property<Binary.Base.Encode, Self> {
        Property<Binary.Base.Encode, Self>(.init())
    }
}
