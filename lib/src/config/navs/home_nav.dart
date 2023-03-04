import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:logos/src/presenter/views/goals/goal_complete_screen.dart';
import 'package:logos/src/presenter/views/goals/goal_screen.dart';
import 'package:logos/src/presenter/views/wisdom/wisdom_screen.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void onPageChanged(index) {
    setState(() {
      _page = index;
    });
  }

  // static const optionStyle = TextStyle(
  //   fontSize: 30,
  //   fontWeight: FontWeight.bold,
  // );

  static const List<Widget> _widgetOptions = <Widget>[
    GoalCompleteScreen(),
    GoalScreen(),
    WisdomScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: _widgetOptions.elementAt(_page),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        index: _page,
        buttonBackgroundColor: Theme.of(context).colorScheme.primary,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        color: Theme.of(context).colorScheme.primary,
        onTap: onPageChanged,
        items: [
          Icon(Icons.check_rounded,
              color: _page == 0 ? Colors.white : Colors.white),
          Icon(Icons.home, color: _page == 1 ? Colors.white : Colors.white),
          Icon(Icons.emoji_objects_rounded, color: _page == 2 ? Colors.white : Colors.white),
          // if (Responsive.isDesktop(context))
          // if (Responsive.isDesktop(context))
          //     NavigationDestination(
          //       icon: Icon(Icons.question_mark_rounded,
          //           color: _page == 4 ? Colors.blue : Colors.black),
          //       label: "",
          //     ),
        ],
      ),
    );
  }
}
