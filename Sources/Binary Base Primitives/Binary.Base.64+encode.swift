public import Property_Primitives

extension Binary.Base.`64` {
    /// Encode-direction Property accessor for base-64.
    public static var encode: Property<Binary.Base.Encode, Self> {
        Property<Binary.Base.Encode, Self>(.init())
    }
}
