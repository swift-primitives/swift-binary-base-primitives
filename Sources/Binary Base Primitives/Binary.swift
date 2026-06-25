/// Re-exports the canonical `Binary` namespace from `swift-binary-primitives`'s
/// `Binary Namespace` product so consumers of this package see `Binary.Base.\`N\``
/// without needing a separate import.
///
/// The `Binary` namespace itself is owned by `swift-binary-primitives`; this package
/// extends it with the `Binary.Base` baseN encoding family. Per the institute's
/// namespace-anchor pattern, multiple sibling packages share one root.
@_exported public import Binary_Primitive
