import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:rick_morty/base/di/di_entry_point.dart';
import 'package:rick_morty/features/characters/presentation/blocs/characters_cubit.dart';
import 'package:rick_morty/features/characters/presentation/widgets/characters_header.dart';
import 'package:rick_morty/features/characters/presentation/widgets/characters_search_bar.dart';
import 'package:rick_morty/features/characters/presentation/widgets/characters_list_body.dart';
import 'package:rick_morty/features/characters/presentation/widgets/shimmer_character_card.dart';
import 'package:rick_morty/features/characters/presentation/widgets/empty_state_widget.dart';
import 'package:rick_morty/features/characters/presentation/widgets/error_state_widget.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late CharactersCubit _cubit;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _cubit = getIt<CharactersCubit>();
    _scrollController.addListener(_onScroll);
    Future.microtask(() => _cubit.loadCharacters());
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent - 200) {
      _cubit.loadMoreCharacters();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const CharactersHeader(),
            CharactersSearchBar(
              controller: _searchController,
              onChanged: _cubit.onSearchChanged,
              onClear: () {
                _searchController.clear();
                _cubit.onSearchChanged('');
              },
            ),
            Expanded(
              child: BlocBuilder<CharactersCubit, CharactersState>(
                bloc: _cubit,
                builder:
                    (context, state) => state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => _buildShimmer(),
                      loaded:
                          (characters, _, hasNextPage, isLoadingMore) =>
                              characters.isEmpty
                                  ? EmptyStateWidget(
                                    message: context.localizations.noCharactersFound,
                                    icon: Icons.search_off_rounded,
                                  )
                                  : CharactersListBody(
                                    characters: characters,
                                    hasNextPage: hasNextPage,
                                    isLoadingMore: isLoadingMore,
                                    scrollController: _scrollController,
                                    onRefresh: () => _cubit.loadCharacters(refresh: true),
                                    onToggleFavourite: _cubit.toggleFavourite,
                                  ),
                      error: (failure) => ErrorStateWidget(failure: failure, onRetry: () => _cubit.loadCharacters()),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      itemCount: 8,
      itemBuilder: (_, __) => const ShimmerCharacterCard(),
    );
  }
}
