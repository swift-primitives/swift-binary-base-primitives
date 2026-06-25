public import Property_Primitives

extension Binary.Base.`16` {
    /// Decode-direction Property accessor for base-16.
    public static var decode: Property<Binary.Base.Decode, Self> {
        Property<Binary.Base.Decode, Self>(.init())
    }
}
