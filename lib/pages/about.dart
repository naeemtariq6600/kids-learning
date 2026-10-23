import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF121212) : const Color(0xFFF7F6FC),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "About PlayLearn 🌟",
          style: TextStyle(fontWeight: FontWeight.w900, fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Card
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withValues(alpha: 0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.15),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          "assets/images/app_logo.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      "PlayLearn",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Kids Academy • Early Learning",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "Version 2.0.0",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Mission Card
              _buildCard(
                isDark: isDark,
                icon: Icons.lightbulb_rounded,
                iconColor: Colors.amber,
                title: "Our Mission",
                child: const Text(
                  "PlayLearn: Kids Academy is crafted to spark curiosity, build confidence, and make foundational learning delightful for young minds through vibrant visuals, voice pronunciations, and playful quizzes.",
                  style: TextStyle(fontSize: 14, height: 1.45),
                ),
              ),

              const SizedBox(height: 16),

              // Safety & Privacy
              _buildCard(
                isDark: isDark,
                icon: Icons.verified_user_rounded,
                iconColor: Colors.green,
                title: "Kid-Safe & Friendly",
                child: const Text(
                  "100% safe educational environment designed specifically for young learners with intuitive controls and offline readiness.",
                  style: TextStyle(fontSize: 14, height: 1.45),
                ),
              ),

              const SizedBox(height: 16),

              // Interactive Modules Grid
              _buildCard(
                isDark: isDark,
                icon: Icons.category_rounded,
                iconColor: Colors.blueAccent,
                title: "Explore Modules",
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildPill("🔤 Alphabets (A-Z)"),
                    _buildPill("🔢 Numbers (0-9)"),
                    _buildPill("🦁 Animals"),
                    _buildPill("🐦 Birds"),
                    _buildPill("🍂 Seasons"),
                    _buildPill("🔷 Shapes"),
                    _buildPill("🎨 Colours"),
                    _buildPill("🌸 Flowers"),
                    _buildPill("🍎 Fruits & Veggies"),
                    _buildPill("🪐 Solar System"),
                    _buildPill("🧠 Body Parts"),
                    _buildPill("👷 Occupations"),
                    _buildPill("🎨 Magic Canvas"),
                    _buildPill("🏆 Interactive Quiz"),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // FAQ Section
              _buildCard(
                isDark: isDark,
                icon: Icons.help_outline_rounded,
                iconColor: Colors.purpleAccent,
                title: "Frequently Asked Questions",
                child: Column(
                  children: [
                    _buildFaqItem(
                      "How do sounds and voice work?",
                      "Tap on the sound button on any flashcard to hear natural pronunciation and sound effects for words and animals.",
                    ),
                    const Divider(height: 20),
                    _buildFaqItem(
                      "Is the app free to use?",
                      "Yes! All learning activities, drawing canvas, and quizzes are freely accessible for all learners.",
                    ),
                    const Divider(height: 20),
                    _buildFaqItem(
                      "How do favorites work?",
                      "Tap the heart icon on cards in Explore to save activities directly to your Favorites tab for one-tap access.",
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCard({
    required bool isDark,
    required IconData icon,
    required Color iconColor,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E26) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 14,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: iconColor.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: iconColor, size: 22),
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.deepPurple.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.deepPurple.withValues(alpha: 0.2),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 4),
        Text(
          answer,
          style: const TextStyle(fontSize: 13, color: Colors.grey, height: 1.35),
        ),
      ],
    );
  }
}
