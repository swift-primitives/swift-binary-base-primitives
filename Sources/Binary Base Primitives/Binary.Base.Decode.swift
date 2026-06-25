extension Binary.Base {
    /// Phantom tag selecting the decode direction on `Property<Tag, Base>`.
    ///
    /// Counterpart to ``Encode``. Spec packages extend
    /// `Property where Tag == Binary.Base.Decode, Base == Binary.Base.\`N\``
    /// with alphabet-bearing decode methods.
    public enum Decode: Sendable {}
}
