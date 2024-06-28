import 'package:flutter/material.dart';
import 'package:flutter_template/generic/view/navigation_button.dart';
import 'package:flutter_template/generic/view/navigation_drawer.dart';
import 'package:flutter_template/generic/view/primary_buttons.dart';
import 'package:flutter_template/generic/view/secondary_buttons.dart';
import 'package:flutter_template/generic/view/standard_horizontal_padding.dart';
import 'package:gap/gap.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationButton(
            title: "Foo",
            isCurrentItem: false,
            layoutAxis: Axis.horizontal,
            onPressed: () {},
          ),
          NavigationButton(
            title: "Foo",
            isCurrentItem: false,
            layoutAxis: Axis.horizontal,
            onPressed: () {},
          ),
          NavigationButton(
            title: "Foo",
            isCurrentItem: false,
            layoutAxis: Axis.horizontal,
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppNavigationDrawer(
        navigationItemTitles: const [
          "Home",
          "Page 1",
          "Page 2",
        ],
        currentNavigationItemIndex: 0,
        onNavigationItemIndexPressed: (index) {},
      ),
      body: CustomScrollView(
        slivers: [
          const SliverAppBar.medium(
            title: Text("Home"),
          ),
          SliverToBoxAdapter(
            child: SafeArea(
              child: StandardHorizontalPadding(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 4, bottom: 16),
                      child: Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                    const Gap(20),
                    Row(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              onPressed: () {},
                              title: "Primary Button",
                            ),
                            PrimaryTextButton(
                              onPressed: () {},
                              title: "Primary Text Button",
                            ),
                          ],
                        ),
                        const Gap(20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SecondaryButton(
                              onPressed: () {},
                              title: "Secondary Button",
                            ),
                            SecondaryTextButton(
                              onPressed: () {},
                              title: "Secondary Text Button",
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
