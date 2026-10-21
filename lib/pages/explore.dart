import 'package:flutter/material.dart';
import 'package:learn/utils/route/route_constant.dart';

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  static const List<_ExploreModule> _modules = [
    _ExploreModule(
      title: "Alphabets",
      tagline: "Learn A to Z phonics, words & examples",
      image: "assets/images/home_alphabets.jpg",
      route: AllRoutesConstant.atozRoute,
      color: Color(0xFF4F46E5),
      category: "Basics",
      emoji: "🔤",
    ),
    _ExploreModule(
      title: "Numbers",
      tagline: "Count 1 to 10 with interactive fun",
      image: "assets/images/home_numbers.jpg",
      route: AllRoutesConstant.numberRoute,
      color: Color(0xFFD97706),
      category: "Math",
      emoji: "🔢",
    ),
    _ExploreModule(
      title: "Animals",
      tagline: "Discover wild animals & their sounds",
      image: "assets/images/home_animals.jpg",
      route: AllRoutesConstant.animalRoute,
      color: Color(0xFF059669),
      category: "Nature",
      emoji: "🦁",
    ),
    _ExploreModule(
      title: "Birds",
      tagline: "Meet flying feathered friends & chirps",
      image: "assets/images/home_birds.jpg",
      route: AllRoutesConstant.birdsRoute,
      color: Color(0xFF0284C7),
      category: "Nature",
      emoji: "🦜",
    ),
    _ExploreModule(
      title: "Body Parts",
      tagline: "Know about human anatomy & pronunciation",
      image: "assets/images/home_body_parts.jpg",
      route: AllRoutesConstant.partsRoute,
      color: Color(0xFFEA580C),
      category: "Science",
      emoji: "👋",
    ),
    _ExploreModule(
      title: "Colours",
      tagline: "Explore vibrant rainbow magic & paint",
      image: "assets/images/home_colors.jpg",
      route: AllRoutesConstant.colourRoute,
      color: Color(0xFF7C3AED),
      category: "Creativity",
      emoji: "🎨",
    ),
    _ExploreModule(
      title: "Flowers",
      tagline: "Walk through the blooming nature garden",
      image: "assets/images/home_flowers.jpg",
      route: AllRoutesConstant.flowerRoute,
      color: Color(0xFFDB2777),
      category: "Nature",
      emoji: "🌸",
    ),
    _ExploreModule(
      title: "Fruits & Veggies",
      tagline: "Tasty, fresh and healthy garden treats",
      image: "assets/images/home_fruits.jpg",
      route: AllRoutesConstant.fruitRoute,
      color: Color(0xFFDC2626),
      category: "Food",
      emoji: "🍎",
    ),
    _ExploreModule(
      title: "Shapes",
      tagline: "Circles, triangles, squares & patterns",
      image: "assets/images/shape.gif",
      route: AllRoutesConstant.shapesRoute,
      color: Color(0xFF0891B2),
      category: "Math",
      emoji: "🔺",
    ),
    _ExploreModule(
      title: "Solar System",
      tagline: "Travel to planets, stars & space orbit",
      image: "assets/images/solar/solar.gif",
      route: AllRoutesConstant.solarRoute,
      color: Color(0xFF4338CA),
      category: "Space",
      emoji: "🪐",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC),
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            // Header Bar
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 12),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF8B5CF6)],
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.explore_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Explore",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.3,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        Text(
                          "Discover fun learning adventures",
                          style: TextStyle(
                            fontSize: 12.5,
                            fontWeight: FontWeight.w500,
                            color: isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Top Featured Games Banner (Quiz & Drawing Board)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                child: Row(
                  children: [
                    // Quiz Feature Card
                    Expanded(
                      child: _FeatureActionCard(
                        title: "Play Quiz",
                        subtitle: "Test knowledge!",
                        emoji: "🎯",
                        gradient: const [Color(0xFFEC4899), Color(0xFFF43F5E)],
                        onTap: () {
                          Navigator.pushNamed(context, AllRoutesConstant.quizRoute);
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    // Drawing Board Feature Card
                    Expanded(
                      child: _FeatureActionCard(
                        title: "Drawing Board",
                        subtitle: "Doodle & create!",
                        emoji: "🎨",
                        gradient: const [Color(0xFF0D9488), Color(0xFF10B981)],
                        onTap: () {
                          Navigator.pushNamed(context, AllRoutesConstant.drawingboardRoute);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Section Header
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Row(
                  children: [
                    Text(
                      "Learning Adventures",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                        color: isDark ? Colors.white : const Color(0xFF0F172A),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF1E293B) : const Color(0xFFE2E8F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${_modules.length} Adventures",
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: isDark ? Colors.white70 : const Color(0xFF475569),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Module Cards List
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final item = _modules[index];
                    return _ExploreCard(
                      module: item,
                      isDark: isDark,
                    );
                  },
                  childCount: _modules.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExploreModule {
  final String title;
  final String tagline;
  final String image;
  final String route;
  final Color color;
  final String category;
  final String emoji;

  const _ExploreModule({
    required this.title,
    required this.tagline,
    required this.image,
    required this.route,
    required this.color,
    required this.category,
    required this.emoji,
  });
}

class _FeatureActionCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final String emoji;
  final List<Color> gradient;
  final VoidCallback onTap;

  const _FeatureActionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.emoji,
    required this.gradient,
    required this.onTap,
  }) : super(key: key);

  @override
  State<_FeatureActionCard> createState() => _FeatureActionCardState();
}

class _FeatureActionCardState extends State<_FeatureActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTapDown: (_) => _controller.forward(),
          onTapUp: (_) => _controller.reverse(),
          onTapCancel: () => _controller.reverse(),
          onTap: widget.onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: widget.gradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.first.withValues(alpha: 0.35),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      widget.emoji,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 10.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExploreCard extends StatefulWidget {
  final _ExploreModule module;
  final bool isDark;

  const _ExploreCard({
    Key? key,
    required this.module,
    required this.isDark,
  }) : super(key: key);

  @override
  State<_ExploreCard> createState() => _ExploreCardState();
}

class _ExploreCardState extends State<_ExploreCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.97).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.module;
    final isDark = widget.isDark;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTapDown: (_) => _controller.forward(),
            onTapUp: (_) => _controller.reverse(),
            onTapCancel: () => _controller.reverse(),
            onTap: () {
              Navigator.pushNamed(context, item.route);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: isDark ? const Color(0xFF1E293B) : Colors.white,
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF334155).withValues(alpha: 0.5)
                      : item.color.withValues(alpha: 0.15),
                  width: 1.2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : item.color)
                        .withValues(alpha: isDark ? 0.25 : 0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // 3D Image Thumbnail
                  Hero(
                    tag: "explore_${item.title}",
                    child: Container(
                      width: 95,
                      height: 95,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          item.image,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: item.color.withValues(alpha: 0.15),
                            child: Center(
                              child: Text(
                                item.emoji,
                                style: const TextStyle(fontSize: 36),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),

                  // Info & Action Button
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Pill
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: item.color.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                "${item.emoji} ${item.category}",
                                style: TextStyle(
                                  fontSize: 10.5,
                                  fontWeight: FontWeight.w700,
                                  color: item.color,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: isDark ? Colors.white : const Color(0xFF0F172A),
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          item.tagline,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 11.5,
                            fontWeight: FontWeight.w500,
                            color: isDark
                                ? const Color(0xFF94A3B8)
                                : const Color(0xFF64748B),
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Action Row
                        Row(
                          children: [
                            Text(
                              "Start Learning",
                              style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.w700,
                                color: item.color,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 13,
                              color: item.color,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
