import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/features/characters/domain/entities/character.dart';
import 'package:rick_morty/features/characters/presentation/widgets/character_card.dart';
import 'package:rick_morty/features/characters/presentation/widgets/character_detail_sheet.dart';
import 'package:rick_morty/features/characters/presentation/widgets/character_grid_card.dart';

class CharactersListBody extends StatelessWidget {
  const CharactersListBody({
    super.key,
    required this.characters,
    required this.hasNextPage,
    required this.isLoadingMore,
    required this.scrollController,
    required this.onRefresh,
    required this.onToggleFavourite,
  });

  final List<Character> characters;
  final bool hasNextPage;
  final bool isLoadingMore;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final void Function(Character) onToggleFavourite;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator.adaptive(
      onRefresh: onRefresh,
      child: LayoutBuilder(
        builder: (context, constraints) => constraints.maxWidth >= 600 ? _buildGrid(context) : _buildList(context),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: characters.length + (hasNextPage ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == characters.length) {
          return isLoadingMore
              ? Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h),
                child: const Center(child: CircularProgressIndicator()),
              )
              : const SizedBox.shrink();
        }
        final c = characters[index];
        return CharacterCard(
          character: c,
          onTap: () => CharacterDetailSheet.show(context, c, () => onToggleFavourite(c)),
          onFavouriteToggle: () => onToggleFavourite(c),
        );
      },
    );
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.72,
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 12.h,
      ),
      itemCount: characters.length + (hasNextPage && isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == characters.length) {
          return const Center(child: CircularProgressIndicator());
        }
        final c = characters[index];
        return CharacterGridCard(
          character: c,
          onTap: () => CharacterDetailSheet.show(context, c, () => onToggleFavourite(c)),
          onToggle: () => onToggleFavourite(c),
        );
      },
    );
  }
}
