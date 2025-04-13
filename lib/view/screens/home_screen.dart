import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/eventType_controller.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:stake_fair_app/controllers/Home/inplay_controller.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stake_fair_app/my_code/common_screen.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/view/screens/inplay_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final EventsTypeController eventsTypeController = Get.put(EventsTypeController());
  final InplayController inplayController = Get.put(InplayController());

  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
    final Size mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whiteColor,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategoryBar(textScale),
                  _buildBanner(mediaQuery),
                  Obx(() {
                    return homeController.isBannerVisible.value
                        ? _buildWhyWinBanner(mediaQuery)
                        : const SizedBox.shrink();
                  }),
                  _buildSection('Most Popular Bets', 'icon', 'label', 'sub'),
                  _buildHorseRacingSection('Horse Racing'),
                  _buildContainer('Quick Links'),
                  _buildQuickLinksSection('name', 'icon'),
                  _buildFooter(mediaQuery, textScale),
                  _buildWarningText(textScale),
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
                    child: _buildSearchField(mediaQuery, textScale),
                  ),
                )),
          ],
        ),
        bottomNavigationBar: Obx(() {
          return Container(
            color: AppColors.greyColor,
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

  Widget _buildInPlayContainer(int count, double textScale) {
    return InkWell(
      onTap: () {
        Get.to(() => InplayScreen());
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2.5),
        decoration: BoxDecoration(color: AppColors.inplaybtnColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(Icons.timelapse, color: Colors.white, size: 24),
                Positioned(
                  bottom: 5,
                  left: 16,
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      borderRadius: BorderRadius.circular(2.5),
                      borderSide:
                          BorderSide(color: AppColors.inplaybtnColor, width: 1),
                      badgeColor: AppColors.whiteColor,
                      shape: badges.BadgeShape.square,
                    ),
                    badgeContent: SizedBox(
                      width: 11,
                      height: 9,
                      child: Center(
                        child: Text(
                          '$count',
                          style: const TextStyle(
                            color: AppColors.inplaybtnColor,
                            fontSize: 7,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 1),
            Center(
              child: Text(
                'In-Play',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10 * textScale,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBar(double textScale) {
    return Obx(() => Container(
          width: MediaQuery.of(Get.context!).size.width, // Full width
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          color: AppColors.blackthemeColor,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
              spacing: 5,
              alignment: WrapAlignment.start, // Start alignment
              children: [
                _buildInPlayContainer(
                    inplayController.liveMatchesCount.value, textScale),
                ...eventsTypeController.categories.map((item) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(() => CommonScreen(
                            categoryId: item['id'],
                            eventName: item['label'],
                            eventIcon: item['icon'],
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.greyColor,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                              child: Icon(item['icon'],
                                  color: AppColors.whiteColor,
                                  size: 19 * textScale)),
                          const SizedBox(height: 1),
                          Center(
                            child: Text(
                              item['label'],
                              style: TextStyle(
                                  color: AppColors.whiteColor,
                                  fontSize: 10 * textScale),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ));
  }

  Widget _buildBanner(Size mediaQuery) {
    return Container(
      width: mediaQuery.width,
      height: mediaQuery.height * 0.081,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/top_banner.jpg'),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  Widget _buildWhyWinBanner(Size mediaQuery) {
    return Container(
      width: mediaQuery.width,
      color: AppColors.whybanColor,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: mediaQuery.height * 0.19,
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xffFFB80C),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
            ],
            image: const DecorationImage(
              image: AssetImage('assets/images/whywin.jpeg'),
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () => homeController.isBannerVisible.value = false,
                  child: const Icon(
                    Icons.close,
                    color: Color(0xff424242),
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String leading, String label, String sub) {
    return Column(
      children: [
        _buildContainer(title),
        _buildList(leading, label, sub),
      ],
    );
  }

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 31,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AutoSizeText(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: AppColors.whiteColor),
        maxLines: 1,
      ),
    );
  }

  Widget _buildList(String leading, String label, String sub) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.cricket.length,
          itemBuilder: (context, index) {
            var team = homeController.cricket[index];
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3),
                    child: ListTile(
                      dense: true,
                      minLeadingWidth: 0,
                      visualDensity:
                          const VisualDensity(horizontal: -4, vertical: -4),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 2),
                      leading: Icon(team[leading], size: 19),
                      title: AutoSizeText(
                        team[label],
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            height: 1.0,
                            color: Color(0xff212529)),
                        maxLines: 1,
                      ),
                      subtitle: AutoSizeText(
                        team[sub],
                        style: const TextStyle(
                            fontSize: 12, color: Color(0xff7f7f7f)),
                        maxLines: 1,
                      ),
                      trailing:
                          const Icon(Icons.keyboard_arrow_right, size: 18),
                    ),
                  ),
                  const Divider(height: 0.3, thickness: 0.3),
                ],
              ),
            );
          },
        ));
  }

  Widget _buildHorseRacingSection(String title) {
    return Column(
      children: [
        _buildContainer(title),
        Obx(() => ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeController.horseRacing.length,
              itemBuilder: (context, index) {
                String item = homeController.horseRacing[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ListTile(
                        dense: true,
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 0),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            item,
                            style: const TextStyle(
                                fontSize: 11, color: Color(0xff212529)),
                            maxLines: 1,
                          ),
                        ),
                        trailing:
                            const Icon(Icons.keyboard_arrow_right, size: 18),
                      ),
                    ),
                    const Divider(height: 0.3, thickness: 0.3),
                  ],
                );
              },
            )),
      ],
    );
  }

  Widget _buildQuickLinksSection(String title, String leading) {
    return Obx(() => ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: homeController.quickLinks.length,
          itemBuilder: (context, index) {
            var links = homeController.quickLinks[index];
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: ListTile(
                    dense: true,
                    minLeadingWidth: 0,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 0),
                    leading: Icon(links[leading], size: 19),
                    title: Text(
                      links[title].toString(),
                      style: const TextStyle(
                          fontSize: 11, color: Color(0xff212529)),
                      maxLines: 1,
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 18),
                  ),
                ),
                const Divider(height: 0.3, thickness: 0.3),
              ],
            );
          },
        ));
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

  Widget _buildWarningText(double textScale) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Warning',
              style: TextStyle(
                fontSize: 11 * textScale,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  " : Although the current score, time elapsed, video and other ",
              style: TextStyle(
                fontSize: 11 * textScale,
                color: Colors.black,
              ),
            ),
            _buildWidgetSpan(
                "data provided on this site is sourced from feeds provided by third",
                0),
            _buildWidgetSpan(
                " parties, you should be aware that this data may be subject to a time",
                2),
            _buildWidgetSpan(
                " delay and/or be inaccurate. Please also be aware that other",
                22),
            _buildWidgetSpan(
                " StakeFair customers may have access to data that is faster and/or ",
                0),
            _buildWidgetSpan(
                "more accurate than the data shown on the StakeFair site. If you rely",
                6),
            _buildWidgetSpan(
                "on this data to place bets, you do so entirely at your own risk.",
                20),
            _buildWidgetSpan(
                " StakeFair provides this data AS IS with no warranty as to the ,",
                0),
            _buildWidgetSpan(
                "accuracy completeness or timeliness of such data and accepts no",
                10),
            _buildWidgetSpan(
                " responsibility for any loss (direct or indirect) suffered by you as a",
                20),
            _buildWidgetSpan(" result of your reliance on it.", 115),
          ],
        ),
      ),
    );
  }

  InlineSpan _buildWidgetSpan(String text, double horizontalPadding) {
    return WidgetSpan(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 11,
            color: Colors.black,
            // fontWeight: FontWeight.w300
          ),
          maxLines: 1,
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
}
