import 'package:flutter/material.dart';
import 'package:logos/src/presenter/views/goals/goal_screen.dart';
import 'package:logos/src/presenter/views/wisdom/wisdom_screen.dart';

class HomeNav extends StatefulWidget {
  const HomeNav({super.key});

  @override
  State<HomeNav> createState() => _HomeNavState();
}

class _HomeNavState extends State<HomeNav> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _page = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(index) {
    setState(() {
      _page = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          GoalScreen(),
          WisdomScreen(),
          // if (Responsive.isDesktop(context)) const ContentScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
        ),
        child: NavigationBar(
          selectedIndex: _page,
          backgroundColor: Theme.of(context).colorScheme.background,
          onDestinationSelected: onPageChanged,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home,
                  color: _page == 0 ? Colors.blue : Colors.grey),
              label: "",
            ),
            NavigationDestination(
              icon: Icon(Icons.wordpress,
                  color: _page == 1 ? Colors.blue : Colors.grey),
              label: "",
            ),
            // if (Responsive.isDesktop(context))
            //     NavigationDestination(
            //       icon: Icon(Icons.question_mark_rounded,
            //           color: _page == 4 ? Colors.blue : Colors.grey),
            //       label: "",
            //     ),
          ],
        ),
      ),
    );
  }
}
