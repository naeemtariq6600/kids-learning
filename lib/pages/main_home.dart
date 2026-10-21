import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
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
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: "Press back again to exit",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    } else {
      Navigator.of(context).pop();
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
