import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final VoidCallback onTap;
  final VoidCallback onFavouriteToggle;

  const CharacterCard({super.key, required this.character, required this.onTap, required this.onFavouriteToggle});

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: colors.divider),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20.r),
          onTap: () {
            HapticFeedback.lightImpact();
            onTap();
          },
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildImage(colors),
                SizedBox(width: 14.w),
                Expanded(child: _buildInfo(colors)),
                SizedBox(width: 8.w),
                _buildRightColumn(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(AppColors colors) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14.r),
      child: CachedNetworkImage(
        imageUrl: character.image,
        width: 68.w,
        height: 68.w,
        fit: BoxFit.cover,
        placeholder:
            (context, url) => Shimmer.fromColors(
              baseColor: colors.shimmerBase,
              highlightColor: colors.shimmerHighlight,
              child: Container(width: 68.w, height: 68.w, color: Colors.white),
            ),
        errorWidget:
            (context, url, error) => Container(
              width: 68.w,
              height: 68.w,
              color: colors.imagePlaceholder,
              child: Icon(Icons.person, color: colors.hintText, size: 30.sp),
            ),
      ),
    );
  }

  Widget _buildInfo(AppColors colors) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          character.name,
          style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold, color: colors.titleText),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 2.h),
        Text(character.gender, style: TextStyle(fontSize: 12.sp, color: colors.subtitleText)),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 6.w,
          runSpacing: 4.h,
          children: [_buildChip(character.species, colors), _buildStatusChip(colors)],
        ),
      ],
    );
  }

  Widget _buildChip(String label, AppColors colors) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(color: colors.divider, borderRadius: BorderRadius.circular(100.r)),
      child: Text(label, style: TextStyle(fontSize: 11.sp, color: colors.titleText, fontWeight: FontWeight.w500)),
    );
  }

  Widget _buildStatusChip(AppColors colors) {
    final color =
        character.isAlive
            ? colors.aliveColor
            : character.isDead
            ? colors.deadColor
            : colors.unknownStatusColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(color: color.withValues(alpha: .12), borderRadius: BorderRadius.circular(100.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 5.r, height: 5.r, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 4.w),
          Text(character.status, style: TextStyle(fontSize: 11.sp, color: color, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildRightColumn(AppColors colors) {
    return SizedBox(
      height: 68.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: colors.badgeColor.withValues(alpha: .1),
              borderRadius: BorderRadius.circular(100.r),
            ),
            child: Text(
              '#${character.id}',
              style: TextStyle(fontSize: 11.sp, color: colors.badgeColor, fontWeight: FontWeight.w700),
            ),
          ),
          GestureDetector(
            onTap: () {
              HapticFeedback.mediumImpact();
              onFavouriteToggle();
            },
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                character.isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                key: ValueKey(character.isFavourite),
                color: character.isFavourite ? colors.favouriteColor : colors.hintText,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
