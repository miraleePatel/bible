// ignore_for_file: must_be_immutable

import 'package:bible_app/Utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomIconButoon extends StatelessWidget {
  final String image;
 final double? size;
  double? height;
  double? width;
  Widget? child;
  CustomIconButoon({super.key, required this.image,this.size,this.height,this.width,this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 4.h,
      width: width ?? 9.w,
      decoration: BoxDecoration(
        color: AppColors.texfeildColor,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child:child?? Image.asset(image,scale: size,color: AppColors.blackColor,),
    );
  }
}