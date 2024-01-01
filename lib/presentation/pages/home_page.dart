import 'package:bottomnavbar/core/constants/colors.dart';
import 'package:bottomnavbar/presentation/pages/cart.dart';
import 'package:bottomnavbar/presentation/pages/upload.dart';
import 'package:flutter/material.dart';

import '../widgets/nav_bar_button.dart';
import 'home.dart';

ValueNotifier<bool> isNavBarVisible = ValueNotifier(true);

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDashboardVisible = true;

  _updateDashboardVisibility(bool status) {
    setState(() {
      _isDashboardVisible = status;
    });
  }

  int pageIndex = 0;
  PageController pageController = PageController();
  final pages = [
    const Home(),
    const Upload(),
    const Cart(),
  ];

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    super.initState();
    pageController = PageController(initialPage: 0);
  }

  changePage() {
    pageController.animateToPage(pageIndex,
        duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: isNavBarVisible,
          builder: (context, value, child) {
            return Stack(
              children: [
                PageView(
                  children: pages,
                  controller: pageController,
                  onPageChanged: (int value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                ),
                AnimatedPositioned(
                  bottom: value ? 10 : 0,
                  left: 10,
                  right: 10,
                  duration: const Duration(milliseconds: 400),

                  // bottom: 10,

                  child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        final offsetAnimation = Tween(
                          begin: const Offset(0, 1),
                          end: const Offset(0.0, 0),
                        ).animate(animation);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                      child: value
                          ? SafeArea(
                              child: Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: [
                                    BoxShadow(
                                        offset: const Offset(0.0, 2.0),
                                        blurRadius: 4,
                                        spreadRadius: 1,
                                        color: Colors.grey.shade300),
                                  ],
                                ),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        NavBarButton(
                                          iconData: pageIndex == 0
                                              ? Icons.home
                                              : Icons.home_outlined,
                                          onPressed: () {
                                            setState(() {
                                              pageIndex = 0;
                                              changePage();
                                            });
                                          },
                                          color: pageIndex == 0
                                              ? buttonColor
                                              : Colors.grey,
                                        ),
                                        NavBarButton(
                                          iconData: pageIndex == 1
                                              ? Icons.camera_alt
                                              : Icons.camera_alt_outlined,
                                          onPressed: () {
                                            setState(() {
                                              pageIndex = 1;
                                              changePage();
                                            });
                                          },
                                          color: pageIndex == 1
                                              ? buttonColor
                                              : Colors.grey,
                                        ),
                                        NavBarButton(
                                          iconData: pageIndex == 2
                                              ? Icons.shopping_cart
                                              : Icons.shopping_cart_outlined,
                                          onPressed: () {
                                            setState(() {
                                              pageIndex = 2;
                                              changePage();
                                            });
                                          },
                                          color: pageIndex == 2
                                              ? buttonColor
                                              : Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Container()),
                ),
              ],
            );
          }),
    );
  }
}
