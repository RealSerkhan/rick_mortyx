import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';

class CharacterGridCard extends StatelessWidget {
  const CharacterGridCard({super.key, required this.character, required this.onTap, required this.onToggle});

  final Character character;
  final VoidCallback onTap;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final statusColor =
        character.isAlive
            ? colors.aliveColor
            : character.isDead
            ? colors.deadColor
            : colors.unknownStatusColor;

    return GestureDetector(
      onTap: () {
        HapticFeedback.lightImpact();
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: colors.cardBackground,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: colors.divider),
        ),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
                child: CachedNetworkImage(
                  imageUrl: character.image,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  placeholder:
                      (_, __) => Shimmer.fromColors(
                        baseColor: colors.shimmerBase,
                        highlightColor: colors.shimmerHighlight,
                        child: Container(color: Colors.white),
                      ),
                  errorWidget:
                      (_, __, ___) =>
                          Container(color: colors.imagePlaceholder, child: Icon(Icons.person, color: colors.hintText)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10.w, 8.h, 6.w, 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold, color: colors.titleText),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2.h),
                  Text(character.species, style: TextStyle(fontSize: 11.sp, color: colors.subtitleText)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 6.r,
                            height: 6.r,
                            decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            character.status,
                            style: TextStyle(fontSize: 11.sp, color: statusColor, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          onToggle();
                        },
                        child: Icon(
                          character.isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
                          size: 18.sp,
                          color: character.isFavourite ? colors.favouriteColor : colors.hintText,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
