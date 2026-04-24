import 'package:intl/intl.dart';

/// Utility class for consistent number formatting across the app
class NumberFormatters {
  NumberFormatters._();

  /// Standard currency format with $ symbol and 2 decimal places
  /// Example: $1,234.56
  static final NumberFormat currency = NumberFormat.currency(symbol: '\$', decimalDigits: 2);

  /// Compact currency format for large numbers
  /// Example: $1.23M, $45.67B
  static final NumberFormat compactCurrency = NumberFormat.compactCurrency(symbol: '\$', decimalDigits: 2);

  /// Percentage format with sign and 2 decimal places
  /// Example: +12.34, -5.67
  static final NumberFormat percent = NumberFormat('+#,##0.00;-#,##0.00');

  /// Format a number as currency
  /// Example: formatCurrency(1234.56) -> "$1,234.56"
  static String formatCurrency(num value) => currency.format(value);

  /// Format a number as compact currency
  /// Example: formatCompactCurrency(1234567) -> "$1.23M"
  static String formatCompactCurrency(num value) => compactCurrency.format(value);

  /// Format a number as percentage with sign
  /// Example: formatPercent(12.34) -> "+12.34"
  static String formatPercent(num value) => percent.format(value);
}
