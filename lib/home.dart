import 'package:flutter/material.dart';

import 'bottom_tab_bar.dart';
import 'floating_icon.dart';
import 'menu_icon_card.dart';
import 'modal_menu.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<IconData> icons = [
    Icons.home,
    Icons.search,
    Icons.message,
    Icons.person,
  ];

  List<IconData> dropIcons = [
    Icons.access_alarms,
    Icons.accessibility_new_sharp,
    Icons.account_balance_wallet_sharp,
    Icons.architecture,
    Icons.add_a_photo,
  ];

  bool isMenu = false;

  bool isSlide = false;

  double floatingIconPositionY = 0.0;
  double floatingIconPositionX = 0.0;
  bool isScroll = false;
  int? currentIndex;
  bool onLongPress = true;
  bool onIconDrag = false;
  double tabSize = 0.0;
  double translateX = 100;

  IconData? currentIconCard;

  double iconCardSize = 70.0;
  IconData newIcon = Icons.circle_outlined;
  IconData newTabIcon(IconData icon) {
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    tabSize = size.width / icons.length;
    double iconPosition = tabSize * (icons.length - 1);

    return Scaffold(
        backgroundColor: Colors.amber,
        body: Stack(
          children: [
            // --------- Menu modal ----------------------------------------------------------------
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              bottom: isMenu ? iconCardSize : -130,
              left: 0,
              right: 0,
              child: Container(
                height: 220,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                alignment: Alignment.centerRight,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Your Menu",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                "Drag and Drop options",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.amber,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              isMenu = !isMenu;
                              setState(() {});
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.amber,
                              padding: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            child: const Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: iconCardSize,
                      child: Listener(
                        onPointerUp: (details) {
                          setState(() {
                            onLongPress = true;

                            if (floatingIconPositionX >
                                    iconPosition -
                                        (translateX + iconCardSize) &&
                                floatingIconPositionX <
                                    iconPosition - translateX &&
                                floatingIconPositionY > size.height / 1.12) {
                              floatingIconPositionX = 0;
                              floatingIconPositionY = 0;

                              if (icons.contains(newIcon)) {
                                icons.remove(newIcon);
                                icons.insert(
                                  icons.length - 1,
                                  newTabIcon(currentIconCard!),
                                );
                              }
                            } else {
                              floatingIconPositionX = floatingIconPositionX / 2;
                              floatingIconPositionY = floatingIconPositionY / 2;
                            }
                          });
                        },
                        onPointerMove: onLongPress
                            ? null
                            : (details) {
                                floatingIconPositionX = details.position.dx;
                                floatingIconPositionY = details.position.dy;
                                setState(() {});
                              },
                        child: ListView.builder(
                          itemCount: dropIcons.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (_, index) {
                            final icon = dropIcons[index];

                            final isIconCard = currentIndex == index &&
                                floatingIconPositionY > size.height / 1.35;

                            return icons.contains(icon)
                                ? const SizedBox()
                                : MenuIconCard(
                                    icon: icon,
                                    iconCardSize: iconCardSize,
                                    isIconCard: isIconCard,
                                    onLongPress: () {
                                      setState(() {
                                        onLongPress = false;
                                        currentIndex = index;
                                        currentIconCard = icon;
                                      });
                                    },
                                  );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --------- Menu modal Button ----------------------------------------------------------------
            showMenuButton(
              onTap: () {
                isMenu = !isMenu;
                setState(() {});
              },
            ),

            // --------- Bottom tab bar navigation ----------------------------------------------------------------
            BottomTabBar(
              icons: icons,
              isSlide: isSlide,
              newIcon: newIcon,
              translateX: translateX,
              tabSize: tabSize,
              onHorizontalDragUpdate: (details) {
                if (details.primaryDelta! < -7) {
                  isSlide = true;
                  if (!icons.contains(newIcon)) {
                    icons.insert(icons.length - 1, newIcon);
                  }
                } else {
                  if (icons.contains(newIcon)) {
                    icons.remove(newIcon);
                  }
                  isSlide = false;
                }
                setState(() {});
              },
            ),

            // ----------- Floating icon -----------
            if (floatingIconPositionY > (size.height / 1.32))
              FloatingIcon(
                floatingIconPositionX: floatingIconPositionX,
                floatingIconPositionY: floatingIconPositionY,
                iconCardSize: iconCardSize,
                currentIcon: currentIconCard,
              ),
          ],
        ));
  }
}
