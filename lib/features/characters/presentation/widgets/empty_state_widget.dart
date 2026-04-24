import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';

class EmptyStateWidget extends StatelessWidget {
  final String message;
  final IconData icon;

  const EmptyStateWidget({super.key, required this.message, required this.icon});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              shape: BoxShape.circle,
              border: Border.all(color: colors.divider),
            ),
            child: Icon(icon, size: 48, color: colors.emptyIcon),
          ),
          SizedBox(height: 24.h),
          Text(message, style: TextStyle(fontSize: 16.sp, color: colors.subtitleText, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
