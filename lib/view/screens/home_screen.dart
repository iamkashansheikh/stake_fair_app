import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/eventType_controller.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:badges/badges.dart' as badges;
import 'package:stake_fair_app/controllers/Home/popularbets_controller.dart';
import 'package:stake_fair_app/controllers/Home/sport_controler.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';
import 'package:stake_fair_app/view/screens/competiton_screen.dart';
import 'package:stake_fair_app/view/screens/inplay_screen.dart';
import 'package:stake_fair_app/view/screens/markets/market_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  final EventsTypeController eventsTypeController =
      Get.put(EventsTypeController());
  final SportsController sportsController = Get.put(SportsController());
  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
    final Size mediaQuery = MediaQuery.of(context).size;

    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          appBar: _buildAppBar(context),
          body: Stack(
            children: [
              NoBounceScrollWrapper(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildCategoryBar(),
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
                      _buildWarningText(),
                       SizedBox(height: 5.h),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(child: _buildSaferGamblingDropdown()),
                           SizedBox(height: 5.h),
                          Center(
                              child: _buildAboutStakefairDropdown()),
                           SizedBox(height: 5.h),
                          _buildText('Help', ),
                          _buildText('Affiliates', ),
                          _buildText('18+', ),
                          _buildText('Developers', ),
                          _buildText('StakeFair Exchange Sitemap', ),
                          _buildText('B2B Partnerships', ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Divider(thickness: 0.6),
                          ),
                           SizedBox(height: 10.h),
                          _buildText('Privacy Policy', ),
                          _buildText('Cookie Policy', ),
                          _buildText('Privacy Preference Centre', ),
                          _buildText('Rules & Regulations', ),
                          _buildText('Terms & Conditions', ),
                           SizedBox(height: 20.h),
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
                      child: _buildSearchField(mediaQuery),
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
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    double appBarHeight = 40.h;
    double logoWidth = 112.w;
    double logoHeight = 13.h;
    double searchButtonWidth = 45.w;
    double loginButtonWidth = 63.w;

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
                  Padding(
                    padding: EdgeInsets.only(left: 25.dm),
                    child: Text(
                      'EXCHANGE',
                      style: TextStyle(
                        fontSize: 12.sp,
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
                  SizedBox(width: 3.w), // Thoda zyada spacing
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

  Widget _buildIconButton(IconData icon, String text, {required double width}) {
    return Container(
      width: width,
      height: 31.h,
      decoration: BoxDecoration(
        color: AppColors.apbarbutonColor,
        borderRadius: BorderRadius.circular(2.r), // Responsive radius
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: AppColors.whiteColor,
            size: 15.r, // Responsive icon size
          ),
          Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.whiteColor,
              fontSize: 10.sp, // Responsive font
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField(Size mediaQuery, {Key? key}) {
    return Container(
      key: key,
      width: mediaQuery.width.w,
      height: 45.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 32.h,
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
              style: TextStyle(color: AppColors.whiteColor, fontSize: 10.sp),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInPlayContainer() {
    return InkWell(
      onTap: () => Get.to(() => InplayScreen()),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(color: AppColors.inplaybtnColor),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  Icons.timelapse,
                  color: Colors.white,
                  size: 19.r,
                ),
                // Position badge so it overlaps the icon similarly
                Positioned(
                  // bottom: 0,
                  right: -9.w,
                  child: badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      badgeColor: AppColors.whiteColor,
                      borderSide: BorderSide(
                        color: AppColors.inplaybtnColor,
                        width: 1.w,
                      ),
                     
                    ),
                    badgeContent: SizedBox(
                      width: 9.w,
                      height: 7.h,
                      child: Center(
                        child: Text(
                          '25',
                          style: TextStyle(
                            color: AppColors.inplaybtnColor,
                            fontSize: 5.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 1.h),
            Text(
              'In-Play',
              style: TextStyle(
                color: Colors.white,
                fontSize: 9.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryBar() {
    final controller = Get.put(SportsController());
    return Obx(() {
      final sport = controller.categoryList.data?.data ?? [];
      return Container(
        width: MediaQuery.of(Get.context!).size.width.w,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        color: AppColors.blackthemeColor,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 5,
            alignment: WrapAlignment.start,
            children: [
              _buildInPlayContainer(),
              ...sport.where((item) {
                final name = item.sportName?.toLowerCase();
                return name != 'casino' && name != 'lottery';
              }).map((item) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => CompetitonScreen(
                          categoryId: item.sportId ?? '',
                          eventName: item.sportName ?? '',
                          eventIcon: controller.getIconForSport(item.sportName),
                        ));
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.greyColor,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          controller.getIconForSport(item.sportName),
                          color: AppColors.whiteColor,
                          size: 19.r,
                        ),
                        const SizedBox(height: 1),
                        Text(
                          item.sportName ?? '',
                          style: TextStyle(
                            color: AppColors.whiteColor,
                            fontSize: 9.sp,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBanner(Size mediaQuery) {
    return Container(
      width: double.infinity.w,
      height: 054.h,
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
      width: double.infinity.w,
      height: 26.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AutoSizeText(
        title,
        style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
            color: AppColors.whiteColor),
        maxLines: 1,
      ),
    );
  }

  Widget _buildList(String leading, String label, String sub) {
    final PopularBetController controller = Get.put(PopularBetController());

    return Obx(() {
      final matches = controller.matchList;

      if (matches.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          final match = matches[index];
          var team = homeController.cricket[index];
          return InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MarketScreen()));
            },
            child: Container(
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
                      leading: Icon(team[leading], size: 16.r),
                      title: AutoSizeText(
                        "${match['competitionName'] ?? 'N/A'}",
                        style:  TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 11.sp,
                            height: 1.0,
                            color: Color(0xff212529)),
                        maxLines: 1,
                      ),
                      subtitle: AutoSizeText(
                        match['eventName'] ?? "No Event",
                        style:  TextStyle(
                            fontSize: 10.sp, color: Color(0xff7f7f7f)),
                        maxLines: 1,
                      ),
                      trailing:
                           Icon(Icons.keyboard_arrow_right, size: 15.r),
                    ),
                  ),
                  const Divider(height: 0.3, thickness: 0.3),
                ],
              ),
            ),
          );
        },
      );
    });
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
                            style:  TextStyle(
                                fontSize: 10.sp, color: Color(0xff212529)),
                            maxLines: 1,
                          ),
                        ),
                        trailing:
                             Icon(Icons.keyboard_arrow_right, size: 15.r),
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
    final PopularBetController controller = Get.put(PopularBetController());
    return Obx(() {
      final matches = controller.matchList;
      if (matches.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, index) {
          var links = homeController.quickLinks[index];
          final match = matches[index];
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
                  leading: Icon(links[leading], size: 16.r),
                  title: AutoSizeText(
                    match['eventName'] ?? "No Event",
                    style:
                         TextStyle(fontSize: 10.sp, color: Color(0xff212529)),
                    maxLines: 1,
                  ),
                  trailing:  Icon(Icons.keyboard_arrow_right, size: 15.r),
                ),
              ),
              const Divider(height: 0.3, thickness: 0.3),
            ],
          );
        },
      );
    });
  }

   Widget _buildFooter(Size mediaQuery, double textScale) {
    return Container(
      height: mediaQuery.height * 0.052.h,
      width: mediaQuery.width.w,
      color: const Color(0xff1E1E1E),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding:  EdgeInsets.all(8.0.r),
            child: Container(
              width: mediaQuery.width * 0.08.w,
              height: mediaQuery.height * 0.08.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xffFF0000), width: 1.8)),
              child: Center(
                  child: AutoSizeText(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 12.sp),
                maxLines: 1,
              )),
            ),
          ),
          SizedBox(width: 7.w),
          Text('Please Gamble Responsibly',
              style: TextStyle(
                  color: Color(0xffC4C4C4),
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w600),
              maxLines: 1),
          SizedBox(width: 8.w),
          Container(
            width: mediaQuery.width * 0.23.w,
            height: 29.h,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2.r),
            ),
            alignment: Alignment.center,
            child: Text(
              'More details',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 11.sp,
              ),
              maxLines: 1,
            ),
          )
        ],
      ),
    );
  }

 Widget _buildWarningText() {
 return Padding(
      padding:  EdgeInsets.all(10.0.r),
      child: RichText(
        textAlign: TextAlign.justify,
        text: TextSpan(
          style:  TextStyle(
            fontSize: 11.sp,
            color: Colors.black87,
            height: 1.4, 
            
          ),
          children:  [
            TextSpan(
              text: 'Warning: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp
              ),
            ),
            TextSpan(
              text:
                  'Although the current score, time elapsed, video and other data provided on this site is sourced from \'live\' '
                  'feeds provided by third parties, you should be aware that this data may be subject to a time delay and/or be inaccurate. '
                  'Please also be aware that other StakeFair customers may have access to data that is faster and/or more accurate than the '
                  'data shown on the StakeFair site. If you rely on this data to place bets, you do so entirely at your own risk. StakeFair '
                  'provides this data AS IS with no warranty as to the accuracy, completeness or timeliness of such data and accepts no '
                  'responsibility for any loss (direct or indirect) suffered by you as a result of your reliance on it.',
            ),
            
          ],
        ),
      ),
    );
}



  Widget _buildText(String title) {
    return AutoSizeText(
      title,
      style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
      maxLines: 1,
    );
  }

  Widget _buildSaferGamblingDropdown() {
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
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500),
                  maxLines: 1,
                ),
                Icon(
                  expanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
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
                              fontSize: 12.sp,
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

  Widget _buildAboutStakefairDropdown() {
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
                      fontSize: 12.sp,
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
                              fontSize: 12.sp,
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
          height: 40.h, // Fixed height; adjust if needed.
          decoration: BoxDecoration(
            color: isSelected ? AppColors.blackthemeColor : AppColors.greyColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: isSelected ? Colors.orange : Colors.white,
                size: 20.r,
              ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 10.sp,
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
          height: 40.h,
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
                  width: 22.r,
                ),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 10.sp,
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
