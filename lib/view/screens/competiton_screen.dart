import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stake_fair_app/controllers/Home/competitions_controller.dart';
import 'package:stake_fair_app/controllers/Home/home_controller.dart';

class CompetitonScreen extends StatefulWidget {
  final dynamic categoryId; // Adjust type as needed (int or String)
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
    //Fetch competitions dynamically based on event type
    WidgetsBinding.instance.addPostFrameCallback((_) {
      competitionController.fetchCategoryData();
    });

    Size mediaQuery = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xffFFFFFF),
        appBar: _buildAppBar(context),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: mediaQuery.width * 0.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildContainer(widget.eventName),
                _buildTimeSection('Time'),
                _buildHorseRacingSection('Competitions'),
                _buildContainer('Popular Sports'),
                const SizedBox(height: 5),
                _buildFooter(mediaQuery, textScale),
                _buildWarningText(textScale),
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
          ),
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

  // **Dynamic Title Instead of Hardcoded "Cricket"**
  Widget _buildContainer(String title) {
    return Container(
      width: double.infinity,
      height: 31,
      color: const Color(0xff303030),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: AutoSizeText(
        title, // Now event type will be shown dynamically
        style: const TextStyle(
            fontWeight: FontWeight.w600, fontSize: 14, color: Colors.white),
        maxLines: 1,
      ),
    );
  }

  Widget _buildHorseRacingSection(String title) {
    final CompetitonController competitionController =
        Get.find<CompetitonController>();
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
                                "Unknown Competition",
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
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
              style: TextStyle(color: Colors.white, fontSize: 12 * textScale),
              maxLines: 1,
            ),
          ),
        ],
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
                    title: Text('InPlay'),
                    trailing: const Icon(Icons.arrow_forward_ios,
                        size: 14, color: Colors.grey),
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
}
