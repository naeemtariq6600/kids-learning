import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn/cubit/index_cubit.dart';
import 'package:learn/pages/about.dart';
import 'package:learn/pages/explore/explore.dart';
import 'package:learn/pages/favorite.dart';
import 'package:learn/pages/home.dart';
import 'package:learn/widgets/navbar/navbar.dart';

class MainHome extends StatefulWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const MainHome({
    super.key,
    this.savedThemeMode,
  });

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  late PageController _pageController;
  DateTime? currentBackPressTime;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _handleBackPress() {
    // 1. If any dialog, bottom sheet, or subroute is on top, pop it first
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
      return;
    }

    // 2. If the user is on Explore (1), Favorite (2), or About (3), return to Home (0)
    final currentIndex = _pageController.hasClients
        ? (_pageController.page?.round() ?? 0)
        : 0;
    if (currentIndex != 0) {
      _pageController.animateToPage(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      return;
    }

    // 3. User is on Home tab (0): double back press to cleanly exit the app
    final DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      // Cleanly exit to Android home screen without leaving an empty blank Flutter route
      SystemNavigator.pop();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _handleBackPress();
      },
      child: AdaptiveTheme(
        light: ThemeData.light(),
        dark: ThemeData.dark(),
        initial: widget.savedThemeMode ?? AdaptiveThemeMode.light,
        builder: (theme, darkTheme) => BlocProvider(
          create: (context) => IndexCubit(),
          child: BlocBuilder<IndexCubit, int>(
            builder: (context, index) {
              return Scaffold(
                body: PageView(
                  controller: _pageController,
                  children: const [
                    MyHomePage(),
                    ExplorePage(),
                    FavoritePage(),
                    AboutPage(),
                  ],
                  onPageChanged: (index) {
                    context.read<IndexCubit>().changeIndex(index);
                  },
                ),
                bottomNavigationBar:
                    BottomNavBar(pageController: _pageController),
              );
            },
          ),
        ),
      ),
    );
  }
}
