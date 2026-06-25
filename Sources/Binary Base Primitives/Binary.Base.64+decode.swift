public import Property_Primitives

extension Binary.Base.`64` {
    /// Decode-direction Property accessor for base-64.
    public static var decode: Property<Binary.Base.Decode, Self> {
        Property<Binary.Base.Decode, Self>(.init())
    }
}
