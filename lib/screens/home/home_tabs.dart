import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../home/home_screen.dart';
import '../stores/stores_screen.dart';
import '../offers/offers_screen.dart';

class HomeTabs extends StatefulWidget {
  static const String routeName = '/home-tabs';

  const HomeTabs({Key? key}) : super(key: key);

  @override
  _HomeTabsState createState() => _HomeTabsState();
}

class _HomeTabsState extends State<HomeTabs> {
  final String _homeOutlineIcon = 'assets/icons/home-tab-outline-icon.svg';
  final String _offersOutlineIcon = 'assets/icons/offer-tab-outline-icon.svg';
  final String _storesOutlineIcon = 'assets/icons/stores-tab-outline-icon.svg';
  final String _homeFilledIcon = 'assets/icons/home-tab-filled-icon.svg';
  final String _offersFilledIcon = 'assets/icons/offer-tab-filled-icon.svg';
  final String _storesFilledIcon = 'assets/icons/stores-tab-filled-icon.svg';

  int _selectedIndex = 0;

  void _onPress(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = <Widget>[
    const HomeScreen(),
    OffersScreen(),
    StoresScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color.fromRGBO(33, 33, 33, 1),
        unselectedItemColor: const Color.fromRGBO(153, 153, 153, 1),
        selectedLabelStyle: const TextStyle(
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'SF-Pro-Display',
          fontWeight: FontWeight.w600,
          fontSize: 13,
        ),
        onTap: _onPress,
        items: [
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(_homeFilledIcon),
            icon: SvgPicture.asset(_homeOutlineIcon),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(_offersFilledIcon),
            icon: SvgPicture.asset(_offersOutlineIcon),
            label: 'Offers',
          ),
          BottomNavigationBarItem(
            activeIcon: SvgPicture.asset(_storesFilledIcon),
            icon: SvgPicture.asset(_storesOutlineIcon),
            label: 'Stores',
          ),
        ],
      ),
    );
  }
}
