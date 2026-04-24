import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class CharacterDetailSheet extends StatelessWidget {
  final Character character;
  final VoidCallback onFavouriteToggle;

  const CharacterDetailSheet({super.key, required this.character, required this.onFavouriteToggle});

  static void show(BuildContext context, Character character, VoidCallback onFavouriteToggle) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => CharacterDetailSheet(character: character, onFavouriteToggle: onFavouriteToggle),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Container(
      decoration: BoxDecoration(
        color: colors.cardBackground,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
      ),
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 24.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          _buildHandle(colors),
          SizedBox(height: 20.h),
          _buildImage(colors),
          SizedBox(height: 16.h),
          _buildName(colors),
          SizedBox(height: 8.h),
          _buildStatus(colors),
          SizedBox(height: 20.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                _buildDetailRow(context.localizations.species, character.species, colors),
                if (character.type != null && character.type!.isNotEmpty)
                  _buildDetailRow(context.localizations.type, character.type!, colors),
                _buildDetailRow(context.localizations.gender, character.gender, colors),
                _buildDetailRow(context.localizations.origin, character.originName, colors),
                _buildDetailRow(context.localizations.lastLocation, character.locationName, colors),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          _buildFavouriteButton(context, colors),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildHandle(AppColors colors) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(color: colors.divider, borderRadius: BorderRadius.circular(2.r)),
    );
  }

  Widget _buildImage(AppColors colors) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: character.image,
        width: 120.w,
        height: 120.w,
        fit: BoxFit.cover,
        placeholder:
            (_, __) => Shimmer.fromColors(
              baseColor: colors.shimmerBase,
              highlightColor: colors.shimmerHighlight,
              child: Container(width: 120.w, height: 120.w, color: Colors.white),
            ),
        errorWidget:
            (_, __, ___) => Container(
              width: 120.w,
              height: 120.w,
              color: colors.imagePlaceholder,
              child: Icon(Icons.person, size: 60.sp, color: colors.hintText),
            ),
      ),
    );
  }

  Widget _buildName(AppColors colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Text(
        character.name,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: colors.titleText),
      ),
    );
  }

  Widget _buildStatus(AppColors colors) {
    final color =
        character.isAlive
            ? colors.aliveColor
            : character.isDead
            ? colors.deadColor
            : colors.unknownStatusColor;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(color: color.withValues(alpha: .15), borderRadius: BorderRadius.circular(20.r)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 8.r, height: 8.r, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          SizedBox(width: 6.w),
          Text(character.status, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 14.sp)),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, AppColors colors) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(label, style: TextStyle(fontSize: 14.sp, color: colors.subtitleText, fontWeight: FontWeight.w500)),
          const Spacer(),
          Text(value, style: TextStyle(fontSize: 14.sp, color: colors.titleText, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildFavouriteButton(BuildContext context, AppColors colors) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            HapticFeedback.mediumImpact();
            onFavouriteToggle();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: character.isFavourite ? colors.favouriteColor.withValues(alpha: .12) : colors.primaryColor,
            foregroundColor:
                character.isFavourite
                    ? colors.favouriteColor
                    : colors.primaryColor.computeLuminance() > 0.5
                    ? Colors.black
                    : Colors.white,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100.r)),
            elevation: 0,
          ),
          icon: Icon(character.isFavourite ? Icons.favorite_rounded : Icons.favorite_border_rounded),
          label: Text(
            character.isFavourite ? context.localizations.removeFromFavourites : context.localizations.addToFavourites,
            style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
