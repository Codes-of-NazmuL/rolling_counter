## 1.0.0

- Initial release of `rolling_counter`.
- Fluid vertical odometer and slot-machine style rolling digit counter.
- Features:
  - `RollingCounter` widget and `.rollingCounter(...)` extension on `num`.
  - Independent vertical rolling per numeric digit with smooth easing.
  - Automatic thousand grouping with commas (e.g. `1,250,000`).
  - Prefix and suffix string support.
  - Optional `fractionDigits` formatting for fixed decimals.
  - Staggered cascading roll from right to left using `delayPerDigit`.
  - Zero external dependencies.
