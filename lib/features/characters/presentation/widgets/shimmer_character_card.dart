import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rick_morty/app/theme/app_colors.dart';

class ShimmerCharacterCard extends StatelessWidget {
  const ShimmerCharacterCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.divider),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Row(
          children: [
            Shimmer.fromColors(
              baseColor: colors.shimmerBase,
              highlightColor: colors.shimmerHighlight,
              child: Container(
                width: 72.w,
                height: 72.w,
                decoration: BoxDecoration(color: colors.shimmerBase, borderRadius: BorderRadius.circular(12.r)),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Shimmer.fromColors(
                baseColor: colors.shimmerBase,
                highlightColor: colors.shimmerHighlight,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 16.h,
                      width: double.infinity,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                    ),
                    SizedBox(height: 8.h),
                    Container(
                      height: 13.h,
                      width: 120.w,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                    ),
                    SizedBox(height: 6.h),
                    Container(
                      height: 12.h,
                      width: 80.w,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8.r)),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
