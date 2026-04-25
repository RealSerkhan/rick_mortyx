import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/app/theme/locale_cubit.dart';
import 'package:rick_morty/app/theme/theme_cubit.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class CharactersHeader extends StatelessWidget {
  const CharactersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.localizations;
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _LivePillBadge(colors: colors),
              const Spacer(),
              BlocBuilder<LocaleCubit, Locale>(
                builder: (context, locale) {
                  return _NavPill(
                    label: locale.languageCode == 'en' ? 'AR' : 'EN',
                    onTap: () => context.read<LocaleCubit>().toggle(),
                    colors: colors,
                  );
                },
              ),
              SizedBox(width: 8.w),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) {
                  final isDark =
                      mode == ThemeMode.dark ||
                      (mode == ThemeMode.system && MediaQuery.platformBrightnessOf(context) == Brightness.dark);
                  return _IconNavPill(
                    icon: isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                    onTap: () => context.read<ThemeCubit>().toggle(),
                    colors: colors,
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 18.h),
          Text(
            l10n.charactersTitle,
            style: TextStyle(
              fontSize: 38.sp,
              fontWeight: FontWeight.w900,
              color: colors.titleText,
              letterSpacing: -1.2,
              height: 1.05,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            l10n.rickAndMortyUniverse,
            style: TextStyle(fontSize: 14.sp, color: colors.subtitleText, fontWeight: FontWeight.w400, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _LivePillBadge extends StatelessWidget {
  final AppColors colors;
  const _LivePillBadge({required this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(100.r),
        border: Border.all(color: colors.divider),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7.r,
            height: 7.r,
            decoration: BoxDecoration(
              color: colors.aliveColor,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: colors.aliveColor.withValues(alpha: .5), blurRadius: 6, spreadRadius: 1)],
            ),
          ),
          SizedBox(width: 7.w),
          
          Text(
            'RICK & MORTY UNIVERSE',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: colors.subtitleText,
              letterSpacing: 0.8,
            ),
          ),
        ],
      ),
    );
  }
}

class _NavPill extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final AppColors colors;

  const _NavPill({required this.label, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: colors.divider),
        ),
        child: Text(label, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: colors.subtitleText)),
      ),
    );
  }
}

class _IconNavPill extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final AppColors colors;

  const _IconNavPill({required this.icon, required this.onTap, required this.colors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: Container(
        padding: EdgeInsets.all(9.r),
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: colors.divider),
        ),
        child: Icon(icon, size: 17.sp, color: colors.subtitleText),
      ),
    );
  }
}
