import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_space/view/constants/app_colors.dart';

class SvgIconButton extends StatelessWidget {
  
  final String svgPath;
  final String text;
  final double iconSize;
  final double iconSpace;
  final VoidCallback onTap;
  const SvgIconButton({
    super.key,
    required this.svgPath,
    required this.text,
    this.iconSize = 30,
    this.iconSpace = 15,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: const WidgetStatePropertyAll(Size(210, 45)),
        elevation: const WidgetStatePropertyAll(0),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: AppColors.seedColor),
          ),
        ),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: 210,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(svgPath, width: iconSize),
            SizedBox(width: iconSpace),
            Text(text),
          ],
        ),
      ),
    );
  }
}