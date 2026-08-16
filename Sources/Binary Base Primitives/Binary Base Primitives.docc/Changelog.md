# Changelog

All notable changes to `swift-binary-base-primitives` are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

- Initial public alpha.
- Closed-radix namespace `Binary.Base` with six nominal radix types: `\`16\``, `\`32\``, `\`58\``, `\`62\``, `\`64\``, `\`85\``.
- Phantom `Binary.Base.Encode` and `Binary.Base.Decode` tags + per-radix static accessors returning `Property<Tag, Self>`.
- Bit-packing encode/decode algorithms for power-of-2 radixes (16, 32, 64) — parameterized by alphabet.
- Integer-arithmetic encode/decode algorithms for non-power-of-2 radixes (58, 62, 85) — parameterized by alphabet.
- Three default alphabets shipped for `Binary.Base.\`62\``: `standard`, `gmp`, `inverted` — replacing the legacy `swift-base62-primitives` package.
