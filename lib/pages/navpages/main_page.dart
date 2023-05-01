import 'package:flutter/material.dart';
import 'package:my_first_app/pages/navpages/bar_item_page.dart';
import 'package:my_first_app/pages/navpages/search_page.dart';

import 'home_page.dart';
import 'my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = const [HomePage(), BarItemPage(), SearchPage(), MyPage()];
  int currentIdx = 0;
  void onTap(int idx) {
    setState(() {
      currentIdx = idx;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIdx],
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        onTap: onTap,
        currentIndex: currentIdx,
        selectedItemColor: Colors.black,
        selectedFontSize: 0,
        showSelectedLabels: false,
        unselectedItemColor: Colors.grey,
        unselectedFontSize: 0,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.apps),
          ),
          BottomNavigationBarItem(
            label: "Bar",
            icon: Icon(Icons.bar_chart_sharp),
          ),
          BottomNavigationBarItem(
            label: "Search",
            icon: Icon(Icons.search),
          ),
          BottomNavigationBarItem(
            label: "My Page",
            icon: Icon(Icons.person),
          ),
        ],
      ),
    );
  }
}
