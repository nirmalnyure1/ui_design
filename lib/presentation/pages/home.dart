import 'package:bottomnavbar/presentation/pages/home_page.dart';
import 'package:bottomnavbar/presentation/pages/item_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../core/constants/list.dart';
import '../../core/widgets/custom_item.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        isNavBarVisible.value = true;
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        isNavBarVisible.value = false;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      child: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                "Home",
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: Colors.black),
              ),
            ),
            GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 30,
                  mainAxisSpacing: 1,
                  // crossAxisSpacing: 20,
                  // mainAxisSpacing: 20,
                  childAspectRatio: 2 / 3.5,
                ),
                itemCount: items.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return CustomItem(
                    imageUrl:
                        "https://th.bing.com/th/id/OIG.vKLFI7Sx6L.WA6uUC.Bd",
                    itemName: items[index]["itemName"]!,
                    price: items[index]["price"]!,
                    location: items[index]["location"]!,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ItemPage(
                                  index: index,
                                )),
                      );
                    },
                  );
                })
          ],
        ),
      )),
    );
  }
}
