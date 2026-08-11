import 'package:flutter/material.dart';
import 'package:movie_app/screens/home_screen.dart';
import 'package:movie_app/screens/my_movies_screen.dart';
import 'package:movie_app/screens/profile_screen.dart';
import 'package:movie_app/screens/wishlist_screen.dart';

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int currentIndex = 0;

  late List<Widget> pages;

  @override
  void initState() {
    pages = [HomeScreen(), WishlistScreen(), MyMoviesScreen(), ProfileScreen()];
    super.initState();
  }

  static const List<String> _titles = [
    "Home",
    "Wishlist",
    "My Movies",
    "Profile",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),

      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        elevation: 0,
        automaticallyImplyLeading: false,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.menu, color: Color(0xFFF6C7C7), size: 28),
            ),

            Text(
              _titles[currentIndex],
              style: const TextStyle(
                color: Color(0xFFE50914),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Color(0xFFF6C7C7),
                size: 28,
              ),
            ),
          ],
        ),
      ),

      body: IndexedStack(index: currentIndex, children: pages),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,

        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },

        type: BottomNavigationBarType.fixed,
        backgroundColor: const Color(0xFF1E1E1E),

        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,

        selectedFontSize: 12,
        unselectedFontSize: 12,

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "Home",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            activeIcon: Icon(Icons.bookmark),
            label: "Wishlist",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            activeIcon: Icon(Icons.movie_creation),
            label: "My Movies",
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
