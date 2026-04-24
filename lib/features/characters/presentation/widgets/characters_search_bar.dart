import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class CharactersSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const CharactersSearchBar({super.key, required this.controller, required this.onChanged, required this.onClear});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.localizations;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(100.r),
          border: Border.all(color: colors.divider),
        ),
        child: TextField(
          controller: controller,
          style: TextStyle(color: colors.titleText, fontSize: 15.sp, fontWeight: FontWeight.w500),
          decoration: InputDecoration(
            hintText: l10n.searchCharacters,
            hintStyle: TextStyle(color: colors.hintText, fontWeight: FontWeight.normal),
            prefixIcon: Icon(Icons.search_rounded, color: colors.hintText, size: 22.sp),
            suffixIcon:
                controller.text.isNotEmpty
                    ? IconButton(icon: Icon(Icons.clear_rounded, color: colors.hintText), onPressed: onClear)
                    : null,
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          ),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
