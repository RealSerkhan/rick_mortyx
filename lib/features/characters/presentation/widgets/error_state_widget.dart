import 'package:flutter/services.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/base/domain/errors/failure.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorStateWidget extends StatelessWidget {
  final Failure failure;
  final VoidCallback onRetry;

  const ErrorStateWidget({super.key, required this.failure, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.localizations;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: colors.cardBackground,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: Colors.black.withValues(alpha: .05), blurRadius: 20.r, offset: Offset(0, 8.h)),
                ],
              ),
              child: Icon(Icons.error_outline_rounded, size: 56.sp, color: colors.deadColor),
            ),
            SizedBox(height: 24.h),
            Text(l10n.oops, style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: colors.titleText)),
            SizedBox(height: 12.h),
            Text(
              failure.errorMessage ?? l10n.unexpectedError,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: colors.subtitleText, height: 1.5),
            ),
            SizedBox(height: 32.h),
            ElevatedButton.icon(
              onPressed: () {
                HapticFeedback.mediumImpact();
                onRetry();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primaryColor,
                foregroundColor: colors.primaryColor.computeLuminance() > 0.5 ? Colors.black : Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
                elevation: 0,
              ),
              icon: const Icon(Icons.refresh_rounded),
              label: Text(l10n.tryAgain, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
            ),
          ],
        ),
      ),
    );
  }
}
