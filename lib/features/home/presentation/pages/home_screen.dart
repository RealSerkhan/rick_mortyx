import 'package:rick_morty/base/di/di_entry_point.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_morty/features/characters/presentation/blocs/favourites_cubit.dart';
import 'package:rick_morty/features/characters/presentation/pages/characters_screen.dart';
import 'package:rick_morty/features/characters/presentation/pages/favourites_screen.dart';
import 'package:rick_morty/l10n/app_localizations_extension.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  late FavouritesCubit _favouritesCubit;

  final List<Widget> _pages = [const CharactersScreen(), const FavouritesScreen()];

  @override
  void initState() {
    super.initState();
    _favouritesCubit = getIt<FavouritesCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        indicatorColor: Colors.transparent,
        onDestinationSelected: (index) {
          HapticFeedback.selectionClick();
          setState(() => _selectedIndex = index);
          if (index == 1) {
            _favouritesCubit.loadFavourites();
          }
        },
        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.people_outline_rounded),
            selectedIcon: const Icon(Icons.people_rounded),
            label: context.localizations.charactersTitle,
          ),
          NavigationDestination(
            icon: const Icon(Icons.favorite_border_rounded),
            selectedIcon: const Icon(Icons.favorite_rounded),
            label: context.localizations.favouritesTitle,
          ),
        ],
      ),
    );
  }
}
