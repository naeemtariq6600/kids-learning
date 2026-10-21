import 'package:flutter/material.dart';
import 'package:learn/theme_provider.dart';
import 'package:learn/utils/route/route_constant.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void _navigateTo(BuildContext context, String routeName) {
    Navigator.pop(context); // Close the drawer first for smooth transition
    Navigator.pushNamed(context, routeName);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return Drawer(
      backgroundColor: isDark ? const Color(0xFF1E1E2E) : const Color(0xFFF8FAFC),
      child: Column(
        children: [
          // Premium Curved Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              left: 20,
              right: 20,
              bottom: 24,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDark
                    ? [const Color(0xFF4338CA), const Color(0xFF312E81)]
                    : [const Color(0xFF6366F1), const Color(0xFF8B5CF6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
              boxShadow: [
                BoxShadow(
                  color: (isDark ? Colors.black : const Color(0xFF6366F1))
                      .withValues(alpha: 0.25),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.9),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/studying.png",
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Image.asset(
                            "assets/images/dp.png",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    // Quick Theme Toggle Button
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IconButton(
                        icon: Icon(
                          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                        tooltip: "Toggle Theme",
                        onPressed: () {
                          themeProvider.toggleTheme();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                const Text(
                  "Kids Learn",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.auto_awesome, color: Colors.amberAccent, size: 14),
                      SizedBox(width: 6),
                      Text(
                        "Fun & Playful Learning",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Drawer Scrollable Menu Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              children: [
                _buildSectionHeader("MAIN", isDark),
                _buildNavItem(
                  context: context,
                  title: "Home",
                  icon: Icons.home_rounded,
                  color: const Color(0xFF4F46E5),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.homeRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Play Quiz",
                  icon: Icons.psychology_rounded,
                  color: const Color(0xFFEC4899),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.quizRoute),
                ),

                const SizedBox(height: 12),
                _buildSectionHeader("LEARNING MODULES", isDark),
                _buildNavItem(
                  context: context,
                  title: "A - Z Alphabets",
                  icon: Icons.sort_by_alpha_rounded,
                  color: const Color(0xFF2563EB),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.atozRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "1 2 3 Numbers",
                  icon: Icons.format_list_numbered_rounded,
                  color: const Color(0xFFD97706),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.numberRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Animals",
                  icon: Icons.pets_rounded,
                  color: const Color(0xFF059669),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.animalRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Birds",
                  icon: Icons.flutter_dash_rounded,
                  color: const Color(0xFF0284C7),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.birdsRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Fruits",
                  icon: Icons.apple_rounded,
                  color: const Color(0xFFDC2626),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.fruitRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Colours",
                  icon: Icons.palette_rounded,
                  color: const Color(0xFFC026D3),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.colourRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Shapes",
                  icon: Icons.category_rounded,
                  color: const Color(0xFF7C3AED),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.shapesRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Body Parts",
                  icon: Icons.accessibility_new_rounded,
                  color: const Color(0xFFEA580C),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.partsRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Solar System",
                  icon: Icons.public_rounded,
                  color: const Color(0xFF4338CA),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.solarRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Seasons",
                  icon: Icons.wb_sunny_rounded,
                  color: const Color(0xFFCA8A04),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.seasonRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Flowers",
                  icon: Icons.local_florist_rounded,
                  color: const Color(0xFF0D9488),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.flowerRoute),
                ),
                _buildNavItem(
                  context: context,
                  title: "Occupations",
                  icon: Icons.business_center_rounded,
                  color: const Color(0xFF475569),
                  isDark: isDark,
                  onTap: () =>
                      _navigateTo(context, AllRoutesConstant.occupationRoute),
                ),

                const SizedBox(height: 12),
                _buildSectionHeader("APP", isDark),
                _buildNavItem(
                  context: context,
                  title: "About App",
                  icon: Icons.info_outline_rounded,
                  color: const Color(0xFF64748B),
                  isDark: isDark,
                  onTap: () => _navigateTo(context, AllRoutesConstant.aboutRoute),
                ),
              ],
            ),
          ),

          // Clean, modern footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF181825) : Colors.white,
              border: Border(
                top: BorderSide(
                  color: isDark ? const Color(0xFF2E2E3E) : const Color(0xFFE2E8F0),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.favorite_rounded,
                      color: Colors.pinkAccent,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Learning App for Kids",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white70 : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF27273A)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "v1.1.0",
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white60 : const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, top: 8, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.1,
          color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required Color color,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          splashColor: color.withValues(alpha: 0.12),
          highlightColor: color.withValues(alpha: 0.08),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: isDark
                  ? const Color(0xFF262638).withValues(alpha: 0.4)
                  : Colors.white,
              border: Border.all(
                color: isDark
                    ? const Color(0xFF33334A).withValues(alpha: 0.5)
                    : const Color(0xFFF1F5F9),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.transparent
                      : const Color(0xFF0F172A).withValues(alpha: 0.03),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    size: 20,
                    color: color,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.5,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 13,
                  color: isDark ? Colors.white24 : const Color(0xFF94A3B8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
