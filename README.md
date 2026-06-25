# Binary Base Primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Closed-radix, open-alphabet binary↔text encoding family — `Binary.Base.\`16\`` (hex), `Binary.Base.\`32\``, `Binary.Base.\`58\``, `Binary.Base.\`62\``, `Binary.Base.\`64\``, `Binary.Base.\`85\``. Each radix is a distinct nominal type; only declared radixes exist (the compiler rejects `Binary.Base.\`23456789\``). Alphabets are open across packages — spec packages add named alphabet methods via `Property` extensions on a phantom `Encode` / `Decode` tag.

---

## Key Features

- **Closed-radix vocabulary** — `Binary.Base.\`16\``, `\`32\``, `\`58\``, `\`62\``, `\`64\``, `\`85\`` are the entire family. The radix axis is closed by encoding mathematics; arbitrary integers are not addable. Mirrors the `Windows.\`32\`` precedent for backticked-digit nested types.
- **Open alphabet axis** — alphabets are not part of the type. Spec packages (e.g., `swift-ietf/swift-rfc-4648`) extend `Property where Tag == Binary.Base.Encode, Base == Binary.Base.\`N\`` with named alphabet methods. Custom alphabets are passed as `[UInt8]` parameters at the call site.
- **Property-based call sites** — `Binary.Base.\`62\`.encode(value)` works directly via `Property.callAsFunction(_:)`; variants chain through (`Binary.Base.\`62\`.encode.gmp(value)`). Built on `swift-property-primitives`'s `Property<Tag, Base>` per the `[API-NAME-008]` Property.View pattern.
- **Two algorithm classes** — bit-packing for power-of-2 radixes (16, 32, 64) and integer arithmetic for non-power-of-2 radixes (58, 62, 85). Algorithm dispatch is per-radix; both classes are publicly callable with custom alphabets.
- **Zero-cost dispatch** — `Property` instances are `~Copyable` with `@inlinable` accessors. Release-mode codegen elides the Property construction at call sites.

---

## Quick Start

### Base62 (no spec authority — alphabets ship in this package)

```swift
import Binary_Base_Primitives

let encoded = Binary.Base.`62`.encode(UInt64(123456789))
// "8M0kX"

let decoded = Binary.Base.`62`.decode(encoded)
// Optional(123456789)

// Variants:
Binary.Base.`62`.encode.gmp(UInt64(123456789))         // "IWAuh"
Binary.Base.`62`.encode.inverted(UInt64(123456789))
```

The standard alphabet (digits → uppercase → lowercase) is the default callable on `encode`. The GMP convention (uppercase → lowercase → digits) and inverted convention (digits → lowercase → uppercase) are sibling methods on the same `Property`.

### Base16 (RFC 4648 §8 — alphabet from `swift-ietf/swift-rfc-4648`)

```swift
import Binary_Base_Primitives
// Until swift-rfc-4648 ships, supply the alphabet directly:
let hex = Array("0123456789ABCDEF".utf8)

let encoded = Binary.Base.`16`.encode([0xDE, 0xAD, 0xBE, 0xEF], alphabet: hex)
// "DEADBEEF"

let decoded = Binary.Base.`16`.decode(encoded, alphabet: hex)
// Optional([0xDE, 0xAD, 0xBE, 0xEF])
```

Once `swift-ietf/swift-rfc-4648` lands, the canonical-alphabet path becomes:

```swift
import RFC_4648
Binary.Base.`16`.encode([0xDE, 0xAD, 0xBE, 0xEF])
// "DEADBEEF"
Binary.Base.`64`.encode([0xDE, 0xAD, 0xBE, 0xEF])
// "3q2+7w=="
Binary.Base.`64`.encode.url([0xDE, 0xAD, 0xBE, 0xEF])
// "3q2-7w" (URL-safe, RFC 4648 §5)
```

### Custom alphabet for any radix

```swift
import Binary_Base_Primitives

// 32-byte custom alphabet (e.g., Crockford base32 — would otherwise live in
// a hypothetical swift-crockford-base32 spec package)
let crockford = Array("0123456789ABCDEFGHJKMNPQRSTVWXYZ".utf8)

let encoded = Binary.Base.`32`.encode([0xDE, 0xAD, 0xBE, 0xEF], alphabet: crockford)
let decoded = Binary.Base.`32`.decode(encoded, alphabet: crockford)
```

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-binary-base-primitives.git", branch: "main"),
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Binary Base Primitives", package: "swift-binary-base-primitives")
    ]
)
```

---

## Architecture

`Binary.Base` is a closed namespace of nominal radix types. Each radix exposes two static accessors:

```swift
extension Binary.Base.`62` {
    public static var encode: Property<Binary.Base.Encode, Self>
    public static var decode: Property<Binary.Base.Decode, Self>
}
```

The `Encode` / `Decode` phantom tags are package-level. Algorithm methods live on `Property` constrained by both the tag and the radix:

```swift
// In this package — parameterized algorithm:
extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`62` {
    public func callAsFunction(_ value: UInt64, alphabet: borrowing [UInt8]) -> String
}

// In a spec / convention package — alphabet-bearing variants:
extension Property where Tag == Binary.Base.Encode, Base == Binary.Base.`62` {
    public func callAsFunction(_ value: UInt64) -> String         // standard (this package)
    public func gmp(_ value: UInt64) -> String                    // GMP variant (this package)
    // future swift-base62-something can add more variants here without coordination
}
```

Open extension across packages is the design's load-bearing property: any package can add a new alphabet to the same `Encode` / `Decode` tag without modifying this package or coordinating with siblings.

For the architectural rationale, see the research document at [`swift-institute/Research/binary-base-n-encoding-family-architecture.md`](https://github.com/swift-institute/swift-institute/blob/main/Research/binary-base-n-encoding-family-architecture.md).

Foundation-free — depends only on the `Property`, `Binary`, and `Byte` primitives.

---

## What this package ships

For v0.1.0:

| Radix | Algorithm | Alphabets shipped here |
|-------|-----------|------------------------|
| `Binary.Base.\`16\`` | Bit-pack (4 bits/digit) | None — RFC 4648 §8 ships in `swift-ietf/swift-rfc-4648` |
| `Binary.Base.\`32\`` | Bit-pack (5 bits/digit) | None — RFC 4648 §6/§7 ship in `swift-ietf/swift-rfc-4648`; Crockford / z-base-32 in their respective convention packages |
| `Binary.Base.\`58\`` | Integer arithmetic | None — Bitcoin / Ripple / Flickr ship in their respective convention packages |
| `Binary.Base.\`62\`` | Integer arithmetic | **`standard`** (default), **`gmp`**, **`inverted`** |
| `Binary.Base.\`64\`` | Bit-pack (6 bits/digit) | None — RFC 4648 §4/§5 ship in `swift-ietf/swift-rfc-4648` |
| `Binary.Base.\`85\`` | Integer arithmetic | None — RFC 1924 / Z85 / Ascii85 ship in their respective convention packages |

base62 ships canonical alphabets because no spec authority owns them. Other radixes' alphabets ship in the package owning that spec.

---

## Related packages

- [`swift-property-primitives`](https://github.com/swift-primitives/swift-property-primitives) — the `Property<Tag, Base>` mechanism; required dependency.
- [`swift-tagged-primitives`](https://github.com/swift-primitives/swift-tagged-primitives) — phantom-typed value wrappers (sibling primitive).

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |

Requires Swift 6.3.1 (or the matching Linux / Windows toolchain).

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
