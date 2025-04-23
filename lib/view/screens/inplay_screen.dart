import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/scrollable.dart';

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
        backgroundColor: AppColors.whiteColor,
        appBar: _buildAppBar(context),
        body: Stack(
          clipBehavior: Clip.none,
          children: [
            NoBounceScrollWrapper(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildContainer(
                      'In-Play',
                      Icon(
                        Icons.timelapse,
                        color: AppColors.whiteColor,
                        size: 22,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006,
                    ),
                    Row(
                      children: [
                        _buildShowMatches(
                            index: 0,
                            label: 'Soccer',
                            badge: badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                  borderRadius: BorderRadius.circular(2),
                                  badgeColor: AppColors.inplaybtnColor,
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
                            onTap: () =>
                                inplayController.selectedIndex.value = 0),
                        _buildShowMatches(
                          index: 1,
                          label: 'Tennis',
                          badge: badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              borderRadius: BorderRadius.circular(2),
                              badgeColor: AppColors.inplaybtnColor,
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
                                badgeColor: AppColors.inplaybtnColor,
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.006,
                    ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            Text('1', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                            Text('X', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
                            Text('2', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Divider(
                      thickness: 0.5,
                      height: 0,
                    ),
                    Obx((){
                      if (inplayController.selectedIndex == 0) {
                        return Column(
                          children: [
                            _buildSoccerMarket(),
                            _buildSoccerMarket(),
                            _buildSoccerMarket(),
                            _buildSoccerMarket(),
                            _buildSoccerMarket(),
                          ],
                        );
                      }if (inplayController.selectedIndex == 1) {
                        return _buildTennisMarket();
                      }if (inplayController.selectedIndex == 2) {
                        return _buildCricketMarket();
                      }
                      return _buildCricketMarket();
                    }),
                    const SizedBox(height: 5),
                    _buildFooter(screenSize, textScale),
                    _buildWarningText(context),
                    const SizedBox(height: 5),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(child: _buildSaferGamblingDropdown(textScale)),
                        const SizedBox(height: 5),
                        Center(child: _buildAboutStakefairDropdown(textScale)),
                        const SizedBox(height: 5),
                        _buildText('Help', textScale),
                        _buildText('Affiliates', textScale),
                        _buildText('18+', textScale),
                        _buildText('Developers', textScale),
                        _buildText('StakeFair Exchange Sitemap', textScale),
                        _buildText('B2B Partnerships', textScale),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Divider(thickness: 0.6),
                        ),
                        const SizedBox(height: 10),
                        _buildText('Privacy Policy', textScale),
                        _buildText('Cookie Policy', textScale),
                        _buildText('Privacy Preference Centre', textScale),
                        _buildText('Rules & Regulations', textScale),
                        _buildText('Terms & Conditions', textScale),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ],
                ),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.baryelowColor, AppColors.barorngColor],
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
          color: AppColors.apbarbutonColor,
          borderRadius: BorderRadius.circular(2)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.whiteColor, size: 20),
          Text(text,
              style: TextStyle(
                  color: AppColors.whiteColor,
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
      color: AppColors.blackthemeColor,
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
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder()),
              ),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () => homeController.isSearchFieldVisible.value = false,
            child: AutoSizeText(
              "Cancel",
              style: TextStyle(
                  color: AppColors.whiteColor, fontSize: 12 * textScale),
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
          height: 48, // Fixed height; adjust if needed.
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blackthemeColor : AppColors.greyColor,
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
                  isSelected ? AppColors.blackthemeColor : AppColors.greyColor),
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
      color: AppColors.blackthemeColor,
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
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.whiteColor),
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
                  style: TextStyle(
                      fontSize: 12,
                      height: 1.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _buildTennisMarket() {
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
                  color: AppColors.inplaybtnColor,
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
                      'James Kent',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Viktor',
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
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
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

   Widget _buildCricketMarket() {
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
                  color: AppColors.inplaybtnColor,
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
                      'ICC Trophy',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Indian League',
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
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
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

   Widget _buildSoccerMarket() {
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
                  color: AppColors.inplaybtnColor,
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
                      'FiFa World Cup',
                      style: TextStyle(fontSize: 12),
                    ),
                    Text(
                      'Portugal Team',
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
                      children: inplayController.oddsList
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        final item = entry.value;
                        final Color bgColor = index < 3
                            ? AppColors.markitblueColor
                            : AppColors.markitpinkColor;
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
                fontWeight: FontWeight.w600, fontSize: 14, height: 1.0),
          ),
          Text(
            amount,
            style: const TextStyle(fontSize: 12, height: 1.0),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(Size mediaQuery, double textScale) {
    return Container(
      height: mediaQuery.height * 0.06,
      width: mediaQuery.width,
      color: const Color(0xff1E1E1E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: mediaQuery.width * 0.09,
              height: mediaQuery.height * 0.09,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xffFF0000), width: 1.8)),
              child: const Center(
                  child: AutoSizeText(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 15),
                maxLines: 1,
              )),
            ),
          ),
          const SizedBox(width: 7),
          const Text('Please Gamble Responsibly',
              style: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: 11,
                  fontWeight: FontWeight.w600),
              maxLines: 1),
          const SizedBox(width: 8),
          Container(
            width: mediaQuery.width * 0.26,
            height: 35,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2),
            ),
            alignment: Alignment.center,
            child: const Text(
              'More details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWarningText(BuildContext context) {
    double textScale = MediaQuery.of(context).textScaleFactor;
    double screenWidth = MediaQuery.of(context).size.width;

    // Optional: Make it more adaptive to small screens
    double baseFontSize = screenWidth < 360 ? 10 : 11;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Warning',
              style: TextStyle(
                fontSize: 12 * textScale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  " : Although the current score, time elapsed, video and other ",
              style: TextStyle(
                fontSize: 11.9 * textScale,
                color: Colors.black,
              ),
            ),
            _buildWidgetSpan(
                "data provided on this site is sourced from feeds provided by third",
                0,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                " parties, you should be aware that this data may be subject to a time",
                2,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                " delay and/or be inaccurate. Please also be aware that other",
                22,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                " StakeFair customers may have access to data that is faster and/or ",
                0,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                "more accurate than the data shown on the StakeFair site. If you rely",
                6,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                "on this data to place bets, you do so entirely at your own risk.",
                20,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                " StakeFair provides this data AS IS with no warranty as to the ,",
                0,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                "accuracy completeness or timeliness of such data and accepts no",
                10,
                baseFontSize,
                textScale),
            _buildWidgetSpan(
                " responsibility for any loss (direct or indirect) suffered by you as a",
                20,
                baseFontSize,
                textScale),
            _buildWidgetSpan(" result of your reliance on it.", 115,
                baseFontSize, textScale),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildWidgetSpan(String text, double horizontalPadding,
      double baseFontSize, double textScale) {
    return WidgetSpan(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Text(
          text,
          style: TextStyle(
            fontSize: baseFontSize * textScale,
            color: Colors.black,
          ),
          maxLines: 1,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  Widget _buildText(String title, double textScale) {
    return AutoSizeText(
      title,
      style: TextStyle(fontSize: 12 * textScale, fontWeight: FontWeight.w500),
      maxLines: 1,
    );
  }

  Widget _buildSaferGamblingDropdown(double textScale) {
    return Obx(() {
      bool expanded = homeController.isSaferGamblingExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isSaferGamblingExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  homeController.saferGambling[0],
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12 * textScale,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.saferGambling
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          item,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12 * textScale,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                        ),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

  Widget _buildAboutStakefairDropdown(double textScale) {
    return Obx(() {
      bool expanded = homeController.isAboutStakefairExpanded.value;
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: homeController.isAboutStakefairExpanded.toggle,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AutoSizeText(
                  homeController.aboutStakefair[0],
                  style: TextStyle(
                      decoration: TextDecoration.underline,
                      fontSize: 12 * textScale,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Icon(expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down),
              ],
            ),
          ),
          if (expanded)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: homeController.aboutStakefair
                  .skip(1)
                  .map((item) => Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: AutoSizeText(
                          item,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 12 * textScale,
                              fontWeight: FontWeight.w500),
                          maxLines: 1,
                        ),
                      ))
                  .toList(),
            ),
        ],
      );
    });
  }

 
}
