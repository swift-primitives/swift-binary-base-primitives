extension Binary.Base {
    /// Phantom tag selecting the encode direction on `Property<Tag, Base>`.
    ///
    /// Spec packages and convention authorities extend
    /// `Property where Tag == Binary.Base.Encode, Base == Binary.Base.\`N\``
    /// with alphabet-bearing methods. The radix is encoded in `Base`; the
    /// direction is encoded in this tag.
    public enum Encode: Sendable {}
}
