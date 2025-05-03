import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/competitions_controller.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';
import 'package:stake_fair_app/scrollable.dart';

class CompetitonScreen extends StatefulWidget {
  final dynamic categoryId;
  final String eventName;
  final IconData eventIcon;

  const CompetitonScreen({
    Key? key,
    required this.categoryId,
    required this.eventName,
    required this.eventIcon,
  }) : super(key: key);

  @override
  State<CompetitonScreen> createState() => _CompetitonScreenState();
}

class _CompetitonScreenState extends State<CompetitonScreen> {
  final CompetitonController competitionController =
      Get.put(CompetitonController());
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final double textScale = MediaQuery.of(context).textScaleFactor;
    final Size screenSize = MediaQuery.of(context).size;

    //Fetch competitions dynamically based on event type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      competitionController.fetchCategoryData();
    });

    Size mediaQuery = MediaQuery.of(context).size;

    return BaseResponsiveScreen(
      child: SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffFFFFFF),
          appBar: _buildAppBar(context),
          body: Stack(
            clipBehavior: Clip.none,
            children: [
              NoBounceScrollWrapper(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildContainer(widget.eventName),
                      _buildTimeSection('Time'),
                      _buildHorseRacingSection('Competitions'),
                      _buildTimeSection('Popular Sports'),
                      const SizedBox(height: 5),
                      _bettingInfoTile(),
                      const SizedBox(height: 5),
                      _buildFooter(mediaQuery, textScale),
                      _buildWarningText(),
                      Center(child: _buildSaferGamblingDropdown()),
                      const SizedBox(height: 5),
                      Center(child: _buildAboutStakefairDropdown()),
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 10),
                      _buildText('Privacy Policy', ),
                      _buildText('Cookie Policy', ),
                      _buildText('Privacy Preference Centre', ),
                      _buildText('Rules & Regulations', ),
                      _buildText('Terms & Conditions', ),
                      const SizedBox(height: 20),
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
                      child: _buildSearchField(screenSize, ),
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
      ),
    );
  }

  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 28.h,
      color: AppColors.blackthemeColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      child: Row(
        children: [
          
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: AutoSizeText(
              title,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12.sp,
                  color: AppColors.whiteColor),
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHorseRacingSection(String title) {
    final CompetitonController competitionController =
        Get.put(CompetitonController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildContainer(title),
        // Sample code snippet in CompetitonScreen widget
        Obx(() {
          if (competitionController.categoryListModel.value == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final competitions = competitionController
                .categoryListModel.value?.data?.competitions;

            // Yahan hum optional chaining use kar rahe hain for lowerCase
            final filteredCompetitions = (competitions ?? [])
                .where((comp) =>
                    comp.eventType?.name?.toLowerCase() ==
                    widget.eventName.toLowerCase())
                .toList();

            if (filteredCompetitions.isEmpty) {
              return Center(
                  child: Text("No Competitions Found for ${widget.eventName}"));
            }

            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredCompetitions.length,
              itemBuilder: (context, index) {
                var competition = filteredCompetitions[index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ListTile(
                        visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 0),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Text(
                            competition.competition?.name ??
                                "Unknown Competition",style: TextStyle(fontSize: 11.sp),
                          ),
                        ),
                        trailing:  Icon(
                          Icons.arrow_forward_ios,
                          size: 12.r,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const Divider(height: 0.3, thickness: 0.3),
                  ],
                );
              },
            );
          }
        })
      ],
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
                  padding: EdgeInsets.only(left: 28.w),
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
          size: 15.sp, // Responsive icon size
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

  Widget _buildTimeSection(String title) {
    return Column(
      children: [
        _buildContainer(title),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: ListTile(
                    dense: true,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 0),
                    title: Text('InPlay',style: TextStyle(fontSize: 10.sp),),
                    trailing:  Icon(Icons.arrow_forward_ios,
                        size: 12.r, color: Colors.grey),
                  ),
                ),
                const Divider(height: 0.3, thickness: 0.3),
              ],
            );
          },
        )
      ],
    );
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
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: mediaQuery.width * 0.07.w,
              height: mediaQuery.height * 0.07.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      Border.all(color: const Color(0xffFF0000), width: 1.8)),
              child: Center(
                  child: AutoSizeText(
                '18+',
                style: TextStyle(color: Colors.white, fontSize: 13.sp),
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
            width: mediaQuery.width * 0.22.w,
            height: 31.h,
            decoration: BoxDecoration(
              color: const Color(0xffD4D4D4),
              borderRadius: BorderRadius.circular(2),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Warning',
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextSpan(
              text:
                  " : Although the current score, time elapsed, video and other ",
              style: TextStyle(
                fontSize: 11.sp,
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
            fontSize: 11.sp,
            color: Colors.black,
          ),
          maxLines: 1,
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
 
  Widget _bettingInfoTile() {
    return Container(
      color: Colors.black,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          listTileTheme: const ListTileThemeData(
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
        ),
        child: ExpansionTile(
          key: const Key('betting_info_tile'),
          backgroundColor: Colors.white,
          collapsedBackgroundColor: Colors.white,
          tilePadding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
          childrenPadding: const EdgeInsets.fromLTRB(12, 0, 12, 8),
          title:  Text(
            'Soccer Betting Explained',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          trailing:  Icon(
            Icons.keyboard_arrow_down,
            color: Colors.black54,size: 20.r,
          ),
          children:  [
            Divider(
              height: 2,
              thickness: 0.7,
              color: Colors.grey,
            ),
            SizedBox(height: 2),
            Text(
              "Betting on Soccer is simple on the StakeFair Exchange. You can bet for or against an outcome – e.g. if you're betting on Brisbane Roar v Macarthur FC, you can place a lay bet if you think Brisbane Roar will lose, or you can place a back bet if you think Brisbane Roar will win.",
              style: TextStyle(
                fontSize: 11.sp,
                color: Colors.black87,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
