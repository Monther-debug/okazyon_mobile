import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:okazyon_mobile/features/home/presentation/screens/home_screen.dart';
import 'package:okazyon_mobile/features/main_nav/presentation/widgets/bottom_nav_bar.dart';

class MainNavScreen extends ConsumerStatefulWidget {
  const MainNavScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends ConsumerState<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const Scaffold(body: Center(child: Text('Categories'))),
    const Scaffold(body: Center(child: Text('Favorites'))),
    const Scaffold(body: Center(child: Text('Orders'))),
    const Scaffold(body: Center(child: Text('Profile'))),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
