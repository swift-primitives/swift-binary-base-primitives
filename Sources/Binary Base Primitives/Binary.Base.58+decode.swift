public import Property_Primitives

extension Binary.Base.`58` {
    /// Decode-direction Property accessor for base-58.
    public static var decode: Property<Binary.Base.Decode, Self> {
        Property<Binary.Base.Decode, Self>(.init())
    }
}
