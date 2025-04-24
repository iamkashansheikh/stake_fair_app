import 'package:flutter/material.dart';

class BackLayInfoBar extends StatelessWidget {
  final String matched;
  final String min;
  final String max;

  const BackLayInfoBar({
    Key? key,
    required this.matched,
    required this.min,
    required this.max,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: double.infinity,
      height: screenWidth * 0.1,
      color: const Color(0xffF0F1F5),
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
      child: Row(
        children: [
          _buildTextBlock('Matched : ', matched),
          SizedBox(width: screenWidth * 0.03),
          _buildTextBlock('Min : ', min),
          SizedBox(width: screenWidth * 0.03),
          _buildTextBlock('Max : ', max),
          Spacer(),
          Text(
            'Back',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035,
            ),
          ),
          SizedBox(width: screenWidth * 0.07),
          Text(
            'Lay',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.035,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextBlock(String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(value),
      ],
    );
  }
}
