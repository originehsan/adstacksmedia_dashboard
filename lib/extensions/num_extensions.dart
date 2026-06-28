extension NumExtensions on num {
  String toFormattedString({int decimalPlaces = 0}) {
    if (decimalPlaces == 0) return toInt().toString();
    return toStringAsFixed(decimalPlaces);
  }

  String toCompactString() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toInt().toString();
  }

  String toPercentage({int decimalPlaces = 1}) {
    return '${toStringAsFixed(decimalPlaces)}%';
  }

  double clampToDouble(double min, double max) {
    return clamp(min, max).toDouble();
  }

  bool get isPositive => this > 0;
  bool get isNegative => this < 0;
  bool get isZero => this == 0;
}