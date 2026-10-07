# Rolling Counter 🎰

A fluid, vertical odometer and slot-machine style rolling digit counter widget for Flutter with **zero third-party dependencies**.

Whenever your values, stats, prices, or balances change, each digit rolls gracefully into its new place.

[![pub package](https://img.shields.io/badge/pub.dev-1.0.0-blue.svg)](https://github.com/Codes-of-NazmuL/rolling_counter)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?logo=flutter&logoColor=white)](https://flutter.dev)

---

## ✨ Features

- 🌿 **Zero Dependencies:** Pure Flutter SDK (`flutter/material.dart`).
- 🎰 **Odometer Motion:** Each numeric digit rolls independently with smooth `Curves.easeOutCubic` easing.
- 💵 **Fintech Ready:** Automatically handles thousand commas (e.g. `1,250,500`), currency symbols, decimals, and suffixes.
- 🌊 **Cascading Roll:** Subtle right-to-left digit delay creates a natural kinetic feel.
- ♿️ **Accessibility Ready:** Honors `MediaQuery.disableAnimationsOf` for instant static rendering when reduced motion is preferred.
- 🪄 **1-Line Extension:** Just call `42.rollingCounter()` on any number.

---

## 📦 Installation

Add `rolling_counter` via Git in your `pubspec.yaml`:

```yaml
dependencies:
  rolling_counter:
    git:
      url: https://github.com/Codes-of-NazmuL/rolling_counter.git
      ref: main
```

Or install from terminal:

```bash
flutter pub add 'rolling_counter:{"git":{"url":"https://github.com/Codes-of-NazmuL/rolling_counter.git"}}'
```

---

## 🚀 Quick Usage

### 1. Widget Wrapper

```dart
import 'package:flutter/material.dart';
import 'package:rolling_counter/rolling_counter.dart';

RollingCounter(
  value: 1250,
  prefix: '\$',
  suffix: ' /mo',
  textStyle: const TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: Color(0xFF131212),
  ),
)
```

### 2. Number Extension (Simplest)

```dart
// Using on double or int:
totalAmount.rollingCounter(
  prefix: '€',
  fractionDigits: 2,
  textStyle: TextStyle(fontSize: 24),
)
```

---

## ⚙️ Customization Options

| Property | Type | Default | Description |
|---|---|---|---|
| `value` | `num` | *required* | The numeric value to animate. |
| `prefix` | `String` | `''` | Static prefix symbol (e.g. `'$'`, `'+'`). |
| `suffix` | `String` | `''` | Static suffix symbol (e.g. `'%'`, `' users'`). |
| `fractionDigits` | `int?` | `null` | Optional decimal places (e.g. `2` for `12.50`). |
| `useGrouping` | `bool` | `true` | Formats thousands with commas (`1,000`). |
| `textStyle` | `TextStyle?` | `null` | Font styling for digits and symbols. |
| `duration` | `Duration` | `650ms` | Duration of the digit roll. |
| `curve` | `Curve` | `Curves.easeOutCubic` | Easing curve for the roll animation. |
| `delayPerDigit` | `Duration` | `20ms` | Cascade delay between adjacent digits. |

---

## 👨‍💻 Author & Maintainer

Created with ❤️ by **Nazmul Islam**

- **GitHub:** [@Codes-of-NazmuL](https://github.com/Codes-of-NazmuL)
- **Organization:** Softvence

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
