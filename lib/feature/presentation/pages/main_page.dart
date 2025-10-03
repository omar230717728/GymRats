import 'package:flutter/material.dart';
import 'package:flutter_application_1/feature/presentation/pages/part_home.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    GymPartScreen(),
    Center(child: Text("🔍 Search Screen")),
    Center(child: Text("❤️ Favorites Screen")),
    Center(child: Text("👤 Profile Screen")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        children: [
          // Main content
          _screens[_selectedIndex],
          
          // Bottom Navigation Bar - positioned over content
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildTransparentNavBar(),
          ),
        ],
      ),
    );
  }

  Widget _buildTransparentNavBar() {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              blurRadius: 15,
              color: Colors.black.withOpacity(0.15),
              spreadRadius: 0,
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
          child: GNav(
            gap: 8,
            color: Theme.of(context).colorScheme.onSurface.withOpacity(0.8),
            activeColor: Colors.white,
            iconSize: 22,
            textSize: 14,
            tabBackgroundColor: Theme.of(context).colorScheme.primary,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            selectedIndex: _selectedIndex,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            tabs: const [
              GButton(icon: Icons.home, text: 'Home'),
              GButton(icon: Icons.search, text: 'Search'),
              GButton(icon: Icons.favorite, text: 'Favorites'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}