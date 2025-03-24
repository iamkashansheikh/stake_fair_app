import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:badges/badges.dart' as badges;

class InplayScreen extends StatefulWidget {
  const InplayScreen({super.key});

  @override
  State<InplayScreen> createState() => _InplayScreenState();
}

class _InplayScreenState extends State<InplayScreen> {
  final HomeController homeController = Get.put(HomeController());
  final InplayController inplayController = Get.put(InplayController());

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final double textScale = MediaQuery.of(context).textScaleFactor;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: _buildAppBar(context),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildContainer(
                    'In-Play',
                    const Icon(
                      Icons.timelapse,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.006,),
                  Row(
                    children: [
                      _buildShowMatches(
                        index: 0,
                        label: 'Soccer',
                        badge: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                              borderRadius: BorderRadius.circular(2),
                              badgeColor: const Color(0xff20A052),
                              shape: badges.BadgeShape.square,
                              padding: EdgeInsets.zero),
                          badgeContent: SizedBox(
                            width: 22,
                            height: 12,
                            child: Center(
                              child: Text('1',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9)),
                            ),
                          ),
                          child: const Icon(Icons.sports_soccer,
                              color: Colors.black),
                        ),
                        onTap: () => inplayController.selectedIndex.value = 0,
                      ),
                      _buildShowMatches(
                        index: 1,
                        label: 'Tennis',
                        badge: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            borderRadius: BorderRadius.circular(2),
                            badgeColor: const Color(0xff20A052),
                            shape: badges.BadgeShape.square,
                            padding: EdgeInsets.zero,
                          ),
                          badgeContent: SizedBox(
                            width: 22,
                            height: 12,
                            child: Center(
                              child: Text(
                                '2',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 9),
                              ),
                            ),
                          ),
                          child: const Icon(Icons.sports_tennis,
                              color: Colors.black),
                        ),
                        onTap: () => inplayController.selectedIndex.value = 1,
                      ),
                      _buildShowMatches(
                        index: 2,
                        label: 'Cricket',
                        badge: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                              borderRadius: BorderRadius.circular(2),
                              badgeColor: const Color(0xff20A052),
                              shape: badges.BadgeShape.square,
                              padding: EdgeInsets.zero),
                          badgeContent: SizedBox(
                            width: 22,
                            height: 12,
                            child: Center(
                              child: Text('5',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 9)),
                            ),
                          ),
                          child: const Icon(Icons.sports_cricket,
                              color: Colors.black),
                        ),
                        onTap: () => inplayController.selectedIndex.value = 2,
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.006,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        '1'.padLeft(78),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      Text(
                        'X'.padLeft(5),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                      Text(
                        '2'.padLeft(5),
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12),
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('South Korean Soccer'),
                        Icon(Icons.keyboard_arrow_right)
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                  Divider(
                    thickness: 0.5,
                    height:0,
                  ),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                  _buildOddsRow(),
                ],
              ),
            ),
            Obx(() => AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  top: homeController.isSearchFieldVisible.value ? 0 : -80,
                  left: 0,
                  right: 0,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 300),
                    opacity:
                        homeController.isSearchFieldVisible.value ? 1.0 : 0.0,
                    child: _buildSearchField(screenSize, textScale),
                  ),
                )),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return Container(
            color: const Color(0xff525252),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNavItem(
                    index: 0,
                    label: 'Home',
                    icon: Icons.home,
                    onTap: () => homeController.changeIndex(0)),
                _buildNavItem(
                    index: 1,
                    label: 'Menu',
                    icon: Icons.menu,
                    onTap: () => homeController.changeIndex(1)),
                _buildNavItem(
                    index: 2,
                    label: 'CashOut',
                    icon: Icons.account_balance_wallet,
                    onTap: () => homeController.changeIndex(2)),
                _buildNavItemWithAsset(
                    index: 3,
                    label: 'MyBets',
                    assetPath: 'assets/images/money.png',
                    onTap: () => homeController.changeIndex(3)),
                _buildNavItemWithAsset(
                    index: 4,
                    label: 'Casino',
                    assetPath: 'assets/images/casino-chip (1).png',
                    onTap: () => homeController.changeIndex(4)),
              ],
            ),
          );
        }),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    double appBarHeight = 50;
    double logoWidth = 133;
    double logoHeight = 18;
    double searchButtonWidth = 50;
    double loginButtonWidth = 66;

    return PreferredSize(
      preferredSize: Size.fromHeight(appBarHeight),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xffFFB300),
              Color(0xffFF8801),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: AppBar(
          toolbarHeight: appBarHeight,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: logoWidth,
                    height: logoHeight,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/stakefair.png'),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 34),
                    child: Text(
                      'EXCHANGE',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () => homeController.isSearchFieldVisible.toggle(),
                    child: _buildIconButton(
                      Icons.search_rounded,
                      'Search',
                      width: searchButtonWidth,
                    ),
                  ),
                  const SizedBox(width: 4),
                  InkWell(
                    onTap: () {
                      Get.toNamed('/login');
                    },
                    child: _buildIconButton(
                      Icons.person,
                      'Login / Join',
                      width: loginButtonWidth,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, String text, {double width = 85}) {
    return Container(
      width: width,
      height: 38,
      decoration: BoxDecoration(
          color: const Color(0xff424242),
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.white, size: 20),
          Text(text,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildSearchField(Size mediaQuery, double textScale, {Key? key}) {
    return Container(
      key: key,
      width: mediaQuery.width,
      height: 55 * textScale,
      color: const Color(0xff303030),
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 37,
              child: TextFormField(
                cursorColor: Colors.grey,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 5),
                  isDense: true,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(Icons.search, color: Colors.grey),
                  hintText: 'Search...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: AutoSizeText(
              "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 12 * textScale),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xff303030) : const Color(0xff525252),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.orange : Colors.white,
                size: 24,
              ),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 10,
                  height: 1.0,
                  color: Colors.white,
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItemWithAsset({
    required int index,
    required String label,
    required String assetPath,
    required VoidCallback onTap,
  }) {
    bool isSelected = (index == homeController.selectedIndex.value);
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 48,
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xff303030) : const Color(0xff525252),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  assetPath,
                  width: 28,
                ),
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 10,
                    height: 1.0,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(String title, Icon icon) {
    return Container(
      width: double.infinity,
      height: 31,
      color: const Color(0xff303030),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: AutoSizeText(
              title,
              style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShowMatches({
    required int index,
    required String label,
    required Widget badge,
    required VoidCallback onTap,
  }) {
    return Obx(() {
      bool select = (index == inplayController.selectedIndex.value);
      return Expanded(
        child: InkWell(
          onTap: onTap,
          child: Container(
            height: 60,
            decoration: BoxDecoration(
                color:
                    select ? const Color(0xffFFFFFF) : const Color(0xffF0F1F5),
                border: select
                    ? Border(top: BorderSide(color: Colors.black, width: 2))
                    : null),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                badge,
                const SizedBox(height: 1),
                Text(
                  label,
                  style:  TextStyle(
                    fontSize: 12,
                    height: 1.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildOddsRow() {
    inplayController.fetchOdds();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 40,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xff20A052),
                  border: Border(
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
                child: const Text(
                  'In-Play',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Hong Kong FC',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Wofoo Tai Po',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                width: 167,
                child: Obx(() {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const ClampingScrollPhysics(),
                    child: Row(
                      
                     // crossAxisAlignment: CrossAxisAlignment.center,
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? const Color(0xffA6D8FF)
                            : const Color(0xffFAC9D1);
                        return Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: _buildOddsBox(
                            backgroundColor: bgColor,
                            odds: '${item["odds"]}',
                            amount: '${item["price"]}',
                          ),
                        );
                      }).toList(),
                    ),
                  );
                }),
              ),
            ],
          ),
        ),
        const Divider(
          thickness: 0.5,
          height: 0.2,
        ),
      ],
    );
  }

  Widget _buildOddsBox({
    required Color backgroundColor,
    required String odds,
    required String amount,
  }) {
    return Container(
      width: 50,
      height: 40,
     // padding: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            odds,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              height: 1.0
            ),
          ),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 12,
              height: 1.0
            ),
          ),
        ],
      ),
    );
  }
}
