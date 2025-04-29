import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stake_fair_app/res/app_colors/app_colors.dart';
import 'package:stake_fair_app/res/responsive.dart';

// class PlaceBetOdds extends StatefulWidget {
//   const PlaceBetOdds({super.key});

//   @override
//   State<PlaceBetOdds> createState() => _PlaceBetOddsState();
// }

// class _PlaceBetOddsState extends State<PlaceBetOdds> {
//   @override
//   Widget build(BuildContext context) {
//     return BaseResponsiveScreen(
//       child: SafeArea(
//         child: Scaffold(
//           body: SizedBox(
//             height: 220.h,
//             child: Column(
//               children: [
//                 Container(
//                   width: double.infinity,
//                   padding: EdgeInsets.all(10.w),
//                   decoration: BoxDecoration(
//                     color: const Color(0xffDBEFFF),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Text(
//                             'Back',
//                             style: TextStyle(
//                               fontSize: 12.sp,
//                               color: AppColors.blackthemeColor,
//                             ),
//                           ),
//                           Text(
//                             ' (BetFor): ',
//                             style: TextStyle(fontSize: 12.sp),
//                           ),
//                           Expanded(
//                             child: Text(
//                               'Almeria - Match Odds',
//                               style: TextStyle(
//                                 fontSize: 12.sp,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                               overflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 5.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildValueSelector('-', "Stake", '+'),
//                           ),
//                           SizedBox(width: 5.w),
//                           Expanded(
//                             child: _buildValueSelector('-', "Odds", '+'),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10.h),
//                       Row(
//                         children: [
//                           Expanded(
//                             child: _buildActionButton('Cancel',
//                                 const Color(0xffDCDCDC), Colors.black),
//                           ),
//                           SizedBox(width: 5.w),
//                           Expanded(
//                             child: _buildActionButton('Place Bet',
//                                 const Color(0xffFFDC86), Colors.black87),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//                 Container(
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           _buildNumberButton('+25'),
//                           SizedBox(width: 1.w),
//                           _buildNumberButton('+50'),
//                           SizedBox(width: 1.w),
//                           _buildNumberButton('+100'),
//                           SizedBox(width: 1.w),
//                           _buildNumberButton('+125')
//                         ],
//                       ),
//                       SizedBox(height: 1.h),
//                       //_buildKeypadGrid(),
//                       CustomKeypad(
//                         onKeyTap: (val) => print('Tapped: $val'),
//                         onBackspace: () => print('Backspace pressed'),
//                       ),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildValueSelector(String dec, String label, String inc) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         children: [
//           _buildButton(dec),
//           Expanded(
//             child: Center(
//               child: Text(
//                 label,
//                 style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w500),
//               ),
//             ),
//           ),
//           _buildButton(inc),
//         ],
//       ),
//     );
//   }

//   Widget _buildButton(String label) {
//     return Container(
//       width: 28.w,
//       height: 25.h,
//       decoration: BoxDecoration(
//         color: const Color(0xffDCDCDC),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 14.sp,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildActionButton(String title, Color bgColor, Color textColor) {
//     return Container(
//       height: 25.h,
//       decoration: BoxDecoration(
//         color: bgColor,
//       ),
//       child: Center(
//         child: Text(
//           title,
//           style: TextStyle(
//             fontSize: 12.sp,
//             color: textColor,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildNumberButton(var label) {
//     return Container(
//       width: 89.w,
//       height: 35.h,
//       decoration: BoxDecoration(
//         color: const Color(0xffDCDCDC),
//       ),
//       child: Center(
//         child: Text(
//           label,
//           style: TextStyle(
//             fontSize: 12.sp,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildKeypadGrid() {
//     final List<String> buttons = [
//       '1',
//       '2',
//       '3',
//       '4',
//       '5',
//       '6',
//       '7',
//       '8',
//       '9',
//       '0',
//       '00',
//       '.',
//     ];

//     return Container(
//       padding: EdgeInsets.all(4.w),
//       decoration: BoxDecoration(color: Color(0xffDCDCDC)),
//       child: GridView.builder(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         itemCount: buttons.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 6,
//           mainAxisSpacing: 4.h,
//           crossAxisSpacing: 4.w,
//           childAspectRatio: 1.7,
//         ),
//         itemBuilder: (context, index) {
//           final label = buttons[index];

//           return Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(2.r),
//             ),
//             child: Center(
//               child: Text(
//                 label,
//                 style: TextStyle(
//                   fontSize: 10.sp,
//                   color: Colors.black,
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

class CustomKeypad extends StatelessWidget {
  final Function(String) onKeyTap;
  final VoidCallback onBackspace;

  const CustomKeypad({
    Key? key,
    required this.onKeyTap,
    required this.onBackspace,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff0DCDCDC),
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['1', '2', '3', '4', '5', '6']
                      .map((label) => _buildKey(label))
                      .toList(),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ['7', '8', '9', '0', '00', '.']
                      .map((label) => _buildKey(label))
                      .toList(),
                ),
              ],
            ),
          ),
          const SizedBox(width: 1),
          _buildBackspaceKey(),
        ],
      ),
    );
  }

  Widget _buildKey(String label) {
    return SizedBox(
      width: 55,
      height: 40,
      child: ElevatedButton(
        onPressed: () => onKeyTap(label),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        child: Text(label, style: const TextStyle(fontSize: 12)),
      ),
    );
  }

  Widget _buildBackspaceKey() {
    return SizedBox(
      width: 50,
      height: 84.7,
      child: ElevatedButton(
        onPressed: onBackspace,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          shadowColor: Colors.transparent,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(1),
          ),
        ),
        child: const Icon(Icons.clear),
      ),
    );
  }
}
