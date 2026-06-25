public import Property_Primitives

extension Binary.Base.`32` {
    /// Decode-direction Property accessor for base-32.
    public static var decode: Property<Binary.Base.Decode, Self> {
        Property<Binary.Base.Decode, Self>(.init())
    }
}
