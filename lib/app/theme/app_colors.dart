import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.cardBackground,
    required this.titleText,
    required this.subtitleText,
    required this.locationText,
    required this.hintText,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.imagePlaceholder,
    required this.divider,
    required this.emptyIcon,
    required this.primaryColor,
    required this.aliveColor,
    required this.deadColor,
    required this.unknownStatusColor,
    required this.favouriteColor,
    required this.badgeColor,
  });

  final Color cardBackground;
  final Color titleText;
  final Color subtitleText;
  final Color locationText;
  final Color hintText;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color imagePlaceholder;
  final Color divider;
  final Color emptyIcon;
  final Color primaryColor;
  final Color aliveColor;
  final Color deadColor;
  final Color unknownStatusColor;
  final Color favouriteColor;
  final Color badgeColor;

  static const light = AppColors(
    cardBackground: Colors.white,
    titleText: Color(0xFF0F0F0F),
    subtitleText: Color(0xFF6B7280),
    locationText: Color(0xFF9CA3AF),
    hintText: Color(0xFF9CA3AF),
    shimmerBase: Color(0xFFE5E7EB),
    shimmerHighlight: Color(0xFFF3F4F6),
    imagePlaceholder: Color(0xFFF3F4F6),
    divider: Color(0xFFE5E7EB),
    emptyIcon: Color(0xFF0F0F0F),
    primaryColor: Color(0xFF0F0F0F),
    aliveColor: Color(0xFF22C55E),
    deadColor: Color(0xFFEF4444),
    unknownStatusColor: Color(0xFF9CA3AF),
    favouriteColor: Color(0xFFEF4444),
    badgeColor: Color(0xFF7C3AED),
  );

  static const dark = AppColors(
    cardBackground: Color(0xFF1A1A1A),
    titleText: Colors.white,
    subtitleText: Color(0xFF9CA3AF),
    locationText: Color(0xFF6B7280),
    hintText: Color(0xFF6B7280),
    shimmerBase: Color(0xFF262626),
    shimmerHighlight: Color(0xFF333333),
    imagePlaceholder: Color(0xFF262626),
    divider: Color(0xFF2A2A2A),
    emptyIcon: Color(0xFF22C55E),
    primaryColor: Colors.white,
    aliveColor: Color(0xFF22C55E),
    deadColor: Color(0xFFEF4444),
    unknownStatusColor: Color(0xFF9CA3AF),
    favouriteColor: Color(0xFFEF4444),
    badgeColor: Color(0xFF7C3AED),
  );

  @override
  AppColors copyWith({
    Color? cardBackground,
    Color? titleText,
    Color? subtitleText,
    Color? locationText,
    Color? hintText,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? imagePlaceholder,
    Color? divider,
    Color? emptyIcon,
    Color? primaryColor,
    Color? aliveColor,
    Color? deadColor,
    Color? unknownStatusColor,
    Color? favouriteColor,
    Color? badgeColor,
  }) => AppColors(
    cardBackground: cardBackground ?? this.cardBackground,
    titleText: titleText ?? this.titleText,
    subtitleText: subtitleText ?? this.subtitleText,
    locationText: locationText ?? this.locationText,
    hintText: hintText ?? this.hintText,
    shimmerBase: shimmerBase ?? this.shimmerBase,
    shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
    imagePlaceholder: imagePlaceholder ?? this.imagePlaceholder,
    divider: divider ?? this.divider,
    emptyIcon: emptyIcon ?? this.emptyIcon,
    primaryColor: primaryColor ?? this.primaryColor,
    aliveColor: aliveColor ?? this.aliveColor,
    deadColor: deadColor ?? this.deadColor,
    unknownStatusColor: unknownStatusColor ?? this.unknownStatusColor,
    favouriteColor: favouriteColor ?? this.favouriteColor,
    badgeColor: badgeColor ?? this.badgeColor,
  );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      cardBackground: Color.lerp(cardBackground, other.cardBackground, t)!,
      titleText: Color.lerp(titleText, other.titleText, t)!,
      subtitleText: Color.lerp(subtitleText, other.subtitleText, t)!,
      locationText: Color.lerp(locationText, other.locationText, t)!,
      hintText: Color.lerp(hintText, other.hintText, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(shimmerHighlight, other.shimmerHighlight, t)!,
      imagePlaceholder: Color.lerp(imagePlaceholder, other.imagePlaceholder, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      emptyIcon: Color.lerp(emptyIcon, other.emptyIcon, t)!,
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      aliveColor: Color.lerp(aliveColor, other.aliveColor, t)!,
      deadColor: Color.lerp(deadColor, other.deadColor, t)!,
      unknownStatusColor: Color.lerp(unknownStatusColor, other.unknownStatusColor, t)!,
      favouriteColor: Color.lerp(favouriteColor, other.favouriteColor, t)!,
      badgeColor: Color.lerp(badgeColor, other.badgeColor, t)!,
    );
  }
}

extension AppTheme on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}
