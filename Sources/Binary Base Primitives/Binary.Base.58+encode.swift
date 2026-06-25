public import Property_Primitives

extension Binary.Base.`58` {
    /// Encode-direction Property accessor for base-58.
    public static var encode: Property<Binary.Base.Encode, Self> {
        Property<Binary.Base.Encode, Self>(.init())
    }
}
