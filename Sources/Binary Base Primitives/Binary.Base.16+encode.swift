public import Property_Primitives

extension Binary.Base.`16` {
    /// Encode-direction Property accessor for base-16.
    ///
    /// Returns a fresh `Property<Binary.Base.Encode, Binary.Base.\`16\`>` whose
    /// methods (declared per spec / convention package) perform the encoding.
    /// Custom alphabets: `Binary.Base.\`16\`.encode(bytes, alphabet: [...])`.
    public static var encode: Property<Binary.Base.Encode, Self> {
        Property<Binary.Base.Encode, Self>(.init())
    }
}
