import 'package:flutter/material.dart';
import 'package:learn/pages/explore/quiz.dart';
import 'package:learn/pages/modules/atoz.dart';
import 'package:learn/pages/modules/birds.dart';
import 'package:learn/pages/modules/colours.dart';
import 'package:learn/pages/modules/planets.dart';
import 'package:learn/pages/modules/shapes.dart';
import 'package:learn/utils/constants.dart';
import 'package:learn/utils/route/route_constant.dart';
import 'package:provider/provider.dart';
import '../favorite_page_provider.dart';
import '../theme_provider.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    await Provider.of<FavouriteScreenProvider>(context, listen: false).loadFromPrefs();
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _navigateToModule(int index) {
    Widget page;
    switch (index) {
      case 0:
        page = const Quiz();
        break;
      case 1:
        page = const AtoZ();
        break;
      case 2:
        page = const BirdsPage();
        break;
      case 3:
        page = const ColoursPage();
        break;
      case 4:
        page = const BirdsPage();
        break;
      case 5:
        page = const ShapesPage();
        break;
      case 6:
        page = const PlanetsPage();
        break;
      default:
        return;
    }
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final favProvider = Provider.of<FavouriteScreenProvider>(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<int> favItems = favProvider.selectedItemList;
    final bool hasDrawingBoard = favProvider.drawingBoard;
    final bool isEmpty = favItems.isEmpty && !hasDrawingBoard;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF9F7FD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "My Favorites ❤️",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              icon: Icon(
                themeProvider.themeMode == ThemeMode.dark ? Icons.dark_mode : Icons.light_mode,
              ),
              onPressed: () => themeProvider.toggleTheme(),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : isEmpty
                ? _buildEmptyState(isDark)
                : _buildFavoritesList(isDark, favProvider, favItems, hasDrawingBoard),
      ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(28),
              decoration: BoxDecoration(
                color: Colors.redAccent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.favorite_rounded,
                size: 72,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "No Favorites Yet!",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: isDark ? Colors.white : Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Tap the heart icon on any activity in Explore to add it to your personal favorites collection.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? Colors.white60 : Colors.black54,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 28),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF673AB7),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                elevation: 3,
              ),
              onPressed: () {
                Navigator.pushNamed(context, AllRoutesConstant.mainhomeRoute);
              },
              icon: const Icon(Icons.explore_rounded),
              label: const Text(
                "Explore Activities",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoritesList(
    bool isDark,
    FavouriteScreenProvider favProvider,
    List<int> favItems,
    bool hasDrawingBoard,
  ) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      children: [
        if (hasDrawingBoard) ...[
          _buildFavoriteCard(
            title: "Drawing Board",
            subtitle: "Express creativity & sketch fun art!",
            gradientColors: const [Color(0xFFE91E63), Color(0xFFFF4081)],
            icon: Icons.palette_rounded,
            onTap: () => Navigator.pushNamed(context, AllRoutesConstant.drawingboardRoute),
            onRemove: () => favProvider.setDrawingBoard(),
            isDark: isDark,
          ),
          const SizedBox(height: 14),
        ],
        ...favItems.map((index) {
          if (index < 0 || index >= AppConstants.modules.length) {
            return const SizedBox.shrink();
          }
          final module = AppConstants.modules[index];
          final gradientColors = _getModuleGradient(index);

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _buildFavoriteCard(
              title: module.name,
              subtitle: module.description,
              gradientColors: gradientColors,
              icon: Icons.auto_awesome_rounded,
              imagePath: module.thumbnailPath,
              onTap: () => _navigateToModule(index),
              onRemove: () => favProvider.removeList(index),
              isDark: isDark,
            ),
          );
        }),
      ],
    );
  }

  List<Color> _getModuleGradient(int index) {
    switch (index % 6) {
      case 0:
        return const [Color(0xFF7E57C2), Color(0xFF5C6BC0)];
      case 1:
        return const [Color(0xFF26A69A), Color(0xFF42A5F5)];
      case 2:
        return const [Color(0xFFFFA726), Color(0xFFFF7043)];
      case 3:
        return const [Color(0xFFEC407A), Color(0xFFAB47BC)];
      case 4:
        return const [Color(0xFF29B6F6), Color(0xFF26C6DA)];
      default:
        return const [Color(0xFF66BB6A), Color(0xFF26A69A)];
    }
  }

  Widget _buildFavoriteCard({
    required String title,
    required String subtitle,
    required List<Color> gradientColors,
    required IconData icon,
    String? imagePath,
    required VoidCallback onTap,
    required VoidCallback onRemove,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E26) : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: gradientColors[0].withValues(alpha: 0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: gradientColors[0].withValues(alpha: 0.12),
              blurRadius: 12,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            // Left color accent / image
            Container(
              width: 100,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(22),
                  bottomLeft: Radius.circular(22),
                ),
              ),
              child: imagePath != null
                  ? ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(22),
                        bottomLeft: Radius.circular(22),
                      ),
                      child: Image.asset(imagePath, fit: BoxFit.cover),
                    )
                  : Icon(icon, color: Colors.white, size: 40),
            ),
            const SizedBox(width: 14),
            // Text info
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: isDark ? Colors.white60 : Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            // Unfavorite action button
            IconButton(
              icon: const Icon(Icons.favorite_rounded, color: Colors.redAccent, size: 28),
              tooltip: "Remove from favorites",
              onPressed: onRemove,
            ),
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
