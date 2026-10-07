import 'package:flutter/material.dart';

/// A fluid, vertical odometer and slot-machine style rolling digit counter widget.
///
/// Smoothly animates numbers when [value] changes, rolling each numeric digit
/// vertically while keeping non-numeric symbols ([prefix], [suffix], commas, dots)
/// perfectly stable.
class RollingCounter extends StatefulWidget {
  const RollingCounter({
    super.key,
    required this.value,
    this.prefix = '',
    this.suffix = '',
    this.fractionDigits,
    this.useGrouping = true,
    this.textStyle,
    this.duration = const Duration(milliseconds: 650),
    this.curve = Curves.easeOutCubic,
    this.delayPerDigit = const Duration(milliseconds: 20),
  });

  /// The numerical value to display and animate.
  final num value;

  /// Optional prefix string (e.g. '$', '+').
  final String prefix;

  /// Optional suffix string (e.g. '%', ' USD').
  final String suffix;

  /// Optional fixed number of decimal places.
  final int? fractionDigits;

  /// Whether to format thousands with comma separators (e.g. 1,000).
  final bool useGrouping;

  /// Typography styling applied to all characters and digits.
  final TextStyle? textStyle;

  /// Duration of the roll animation.
  final Duration duration;

  /// Easing curve of the roll animation.
  final Curve curve;

  /// Delay duration added per digit for a subtle cascading effect.
  final Duration delayPerDigit;

  @override
  State<RollingCounter> createState() => _RollingCounterState();
}

class _RollingCounterState extends State<RollingCounter> {
  String _formatNumber(num val) {
    String formatted;
    if (widget.fractionDigits != null) {
      formatted = val.toStringAsFixed(widget.fractionDigits!);
    } else {
      formatted = val.toString();
    }

    if (widget.useGrouping) {
      final parts = formatted.split('.');
      final reg = RegExp(r'\B(?=(\d{3})+(?!\d))');
      parts[0] = parts[0].replaceAll(reg, ',');
      formatted = parts.join('.');
    }

    return formatted;
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.textStyle ?? DefaultTextStyle.of(context).style;
    final formatted = _formatNumber(widget.value);

    if (MediaQuery.disableAnimationsOf(context)) {
      return Text('${widget.prefix}$formatted${widget.suffix}', style: style);
    }

    final chars = formatted.split('');

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        if (widget.prefix.isNotEmpty) Text(widget.prefix, style: style),
        for (int i = 0; i < chars.length; i++)
          _isDigit(chars[i])
              ? _SingleRollingDigit(
                  key: ValueKey('roll_${chars.length - i}'),
                  digit: int.parse(chars[i]),
                  style: style,
                  duration: widget.duration,
                  delay: widget.delayPerDigit * (chars.length - 1 - i),
                  curve: widget.curve,
                )
              : Text(chars[i], style: style),
        if (widget.suffix.isNotEmpty) Text(widget.suffix, style: style),
      ],
    );
  }

  bool _isDigit(String s) => RegExp(r'^[0-9]$').hasMatch(s);
}

class _SingleRollingDigit extends StatefulWidget {
  const _SingleRollingDigit({
    super.key,
    required this.digit,
    required this.style,
    required this.duration,
    required this.delay,
    required this.curve,
  });

  final int digit;
  final TextStyle style;
  final Duration duration;
  final Duration delay;
  final Curve curve;

  @override
  State<_SingleRollingDigit> createState() => _SingleRollingDigitState();
}

class _SingleRollingDigitState extends State<_SingleRollingDigit>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;
  int _oldDigit = 0;

  @override
  void initState() {
    super.initState();
    _oldDigit = widget.digit;
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    );
    _controller.value = 1.0;
  }

  @override
  void didUpdateWidget(_SingleRollingDigit oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.digit != widget.digit) {
      _oldDigit = oldWidget.digit;
      _controller.duration = widget.duration;
      _animation = CurvedAnimation(
        parent: _controller,
        curve: widget.curve,
      );

      _controller.reset();
      if (widget.delay == Duration.zero) {
        if (mounted) _controller.forward();
      } else {
        Future.delayed(widget.delay, () {
          if (mounted) _controller.forward();
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final painter = TextPainter(
      text: TextSpan(text: '0', style: widget.style),
      textDirection: TextDirection.ltr,
    )..layout();

    final digitWidth = painter.width;
    final lineHeight = painter.height;

    return ClipRect(
      child: SizedBox(
        width: digitWidth,
        height: lineHeight,
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            final currentOffset =
                _oldDigit + (widget.digit - _oldDigit) * _animation.value;

            return OverflowBox(
              alignment: Alignment.topCenter,
              minWidth: digitWidth,
              maxWidth: digitWidth,
              minHeight: 0.0,
              maxHeight: double.infinity,
              child: Transform.translate(
                offset: Offset(0, -currentOffset * lineHeight),
                child: child,
              ),
            );
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (int d = 0; d <= 9; d++)
                SizedBox(
                  width: digitWidth,
                  height: lineHeight,
                  child: Center(
                    child: Text(
                      '$d',
                      style: widget.style,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Convenience extension on [num] to quickly build a [RollingCounter].
extension RollingCounterExtension on num {
  /// Builds a [RollingCounter] widget for this number.
  Widget rollingCounter({
    String prefix = '',
    String suffix = '',
    int? fractionDigits,
    bool useGrouping = true,
    TextStyle? textStyle,
    Duration duration = const Duration(milliseconds: 650),
    Curve curve = Curves.easeOutCubic,
    Duration delayPerDigit = const Duration(milliseconds: 20),
  }) =>
      RollingCounter(
        value: this,
        prefix: prefix,
        suffix: suffix,
        fractionDigits: fractionDigits,
        useGrouping: useGrouping,
        textStyle: textStyle,
        duration: duration,
        curve: curve,
        delayPerDigit: delayPerDigit,
      );
}
