import 'package:admin_bottle_cash_app/Screen/home.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:flutter/cupertino.dart';

class Persistent_navbar extends StatelessWidget {
  const Persistent_navbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);
    List<Widget> _buildScreens() {
      return [home()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          title: ("Home"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.rosette),
          title: ("Achievement"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.chat_bubble_text),
          title: ("Bantuan"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
        PersistentBottomNavBarItem(
          icon: Icon(CupertinoIcons.location),
          title: ("Lokasi"),
          activeColorPrimary: CupertinoColors.activeGreen,
          inactiveColorPrimary: CupertinoColors.systemGrey,
        ),
      ];
    }

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      hideNavigationBar: false,
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style9, // Choose the nav bar style with this property.
    );
  }
}
