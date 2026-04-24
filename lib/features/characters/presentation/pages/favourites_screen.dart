import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/app/theme/app_colors.dart';
import 'package:rick_morty/base/di/di_entry_point.dart';
import 'package:rick_morty/features/characters/presentation/blocs/characters_cubit.dart';
import 'package:rick_morty/features/characters/presentation/blocs/favourites_cubit.dart';
import 'package:rick_morty/features/characters/presentation/widgets/character_card.dart';
import 'package:rick_morty/features/characters/presentation/widgets/character_detail_sheet.dart';
import 'package:rick_morty/features/characters/presentation/widgets/empty_state_widget.dart';
import 'package:rick_morty/features/characters/presentation/widgets/error_state_widget.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  late FavouritesCubit _cubit;
  late CharactersCubit _charactersCubit;

  @override
  void initState() {
    super.initState();
    _cubit = getIt<FavouritesCubit>();
    _charactersCubit = getIt<CharactersCubit>();
    Future.microtask(() => _cubit.loadFavourites());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: BlocBuilder<FavouritesCubit, FavouritesState>(
                bloc: _cubit,
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const Center(child: CircularProgressIndicator()),
                    loaded:
                        (characters) =>
                            characters.isEmpty
                                ? EmptyStateWidget(
                                  message: context.localizations.noFavouritesYet,
                                  icon: Icons.favorite_border_rounded,
                                )
                                : RefreshIndicator.adaptive(
                                  onRefresh: () => _cubit.loadFavourites(),
                                  child: ListView.builder(
                                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                                    itemCount: characters.length,
                                    itemBuilder: (_, index) {
                                      final character = characters[index];
                                      return CharacterCard(
                                        character: character,
                                        onTap:
                                            () => CharacterDetailSheet.show(context, character, () async {
                                              await _charactersCubit.toggleFavourite(character);
                                              await _cubit.loadFavourites();
                                            }),
                                        onFavouriteToggle: () async {
                                          await _charactersCubit.toggleFavourite(character);
                                          await _cubit.loadFavourites();
                                        },
                                      );
                                    },
                                  ),
                                ),
                    error: (failure) => ErrorStateWidget(failure: failure, onRetry: () => _cubit.loadFavourites()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final colors = context.appColors;
    final l10n = context.localizations;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 7.h),
            decoration: BoxDecoration(
              color: colors.cardBackground,
              borderRadius: BorderRadius.circular(100.r),
              border: Border.all(color: colors.divider),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite_rounded, color: colors.favouriteColor, size: 8.sp),
                SizedBox(width: 7.w),
                Text(
                  'SAVED COLLECTION',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    color: colors.subtitleText,
                    letterSpacing: 0.8,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 18.h),
          Text(
            l10n.favouritesTitle,
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
            l10n.yourSavedCharacters,
            style: TextStyle(fontSize: 14.sp, color: colors.subtitleText, fontWeight: FontWeight.w400, height: 1.5),
          ),
        ],
      ),
    );
  }
}
