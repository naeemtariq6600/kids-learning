import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn/cubit/index_cubit.dart';

class BottomNavBar extends StatelessWidget {
  final PageController pageController;

  const BottomNavBar({
    super.key,
    required this.pageController,
  });

  static const List<_NavItemData> _items = [
    _NavItemData(
      label: "Home",
      icon: Icons.cottage_outlined,
      activeIcon: Icons.cottage_rounded,
      gradient: [Color(0xFF6366F1), Color(0xFF4F46E5)],
      glowColor: Color(0xFF6366F1),
    ),
    _NavItemData(
      label: "Explore",
      icon: Icons.explore_outlined,
      activeIcon: Icons.explore_rounded,
      gradient: [Color(0xFFFF9800), Color(0xFFF57C00)],
      glowColor: Color(0xFFFF9800),
    ),
    _NavItemData(
      label: "Favorites",
      icon: Icons.favorite_border_rounded,
      activeIcon: Icons.favorite_rounded,
      gradient: [Color(0xFFEC4899), Color(0xFFE11D48)],
      glowColor: Color(0xFFEC4899),
    ),
    _NavItemData(
      label: "About",
      icon: Icons.auto_awesome_outlined,
      activeIcon: Icons.auto_awesome_rounded,
      gradient: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
      glowColor: Color(0xFF8B5CF6),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<IndexCubit, int>(
      builder: (context, currentIndex) {
        return SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Container(
              height: 68,
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E1E2E).withValues(alpha: 0.95)
                    : Colors.white.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(34),
                border: Border.all(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.1)
                      : const Color(0xFFE2E8F0),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.35 : 0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: List.generate(_items.length, (index) {
                  final item = _items[index];
                  final isSelected = index == currentIndex;

                  return Expanded(
                    flex: isSelected ? 3 : 2,
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {
                        if (currentIndex != index) {
                          HapticFeedback.lightImpact();
                          pageController.animateToPage(
                            index,
                            duration: const Duration(milliseconds: 320),
                            curve: Curves.easeOutCubic,
                          );
                          context.read<IndexCubit>().changeIndex(index);
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOutCubic,
                        padding: EdgeInsets.symmetric(
                          horizontal: isSelected ? 10 : 4,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: isSelected
                              ? LinearGradient(
                                  colors: item.gradient,
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : null,
                          borderRadius: BorderRadius.circular(26),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: item.glowColor.withValues(alpha: 0.38),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedScale(
                              scale: isSelected ? 1.1 : 1.0,
                              duration: const Duration(milliseconds: 250),
                              curve: Curves.easeOutBack,
                              child: Icon(
                                isSelected ? item.activeIcon : item.icon,
                                size: 21,
                                color: isSelected
                                    ? Colors.white
                                    : (isDark
                                        ? const Color(0xFF94A3B8)
                                        : const Color(0xFF64748B)),
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  item.label,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NavItemData {
  final String label;
  final IconData icon;
  final IconData activeIcon;
  final List<Color> gradient;
  final Color glowColor;

  const _NavItemData({
    required this.label,
    required this.icon,
    required this.activeIcon,
    required this.gradient,
    required this.glowColor,
  });
}
