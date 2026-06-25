public import Property_Primitives

extension Binary.Base.`32` {
    /// Encode-direction Property accessor for base-32.
    public static var encode: Property<Binary.Base.Encode, Self> {
        Property<Binary.Base.Encode, Self>(.init())
    }
}
