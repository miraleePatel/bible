import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../Utils/app_colors.dart';
import 'custom_widget.dart';

class CustomGoldButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final double? height;
  final double? fontSize;
  final FontWeight? fontWeight;
  const CustomGoldButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.height});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height ?? 5.5.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.yellowColor,
            borderRadius: BorderRadius.circular(6)),
        child: CustomWidgets.text1(
          text!,
          fontSize: fontSize ?? 12.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    );
  }
}

class CustomSilverButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? btnColor;
  const CustomSilverButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.fontSize,
      this.fontWeight,
      this.height,
      this.width,
      this.btnColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width ?? 20.w,
        height: height ?? 5.h,
        decoration: BoxDecoration(
            color: btnColor ?? AppColors.texfeildColor,
            borderRadius: BorderRadius.circular(10)),
        alignment: Alignment.center,
        child: CustomWidgets.text1(
          text!,
          color: AppColors.blackColor,
          fontSize: 9.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class CustomLinearButton extends StatelessWidget {
  final Function()? onTap;
  final String? text;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Widget? child;
  final Color? color;
  final Gradient? gradient;
  const CustomLinearButton(
      {super.key,
      this.onTap,
      this.text,
      this.fontSize,
      this.width,
      this.color,
      this.fontWeight,
      this.height,
      this.child,
      this.gradient});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient ??
              LinearGradient(
                colors: [
                  AppColors.yellowColor.withOpacity(0.50),
                  AppColors.yellowColor.withOpacity(0.1),
                ],
              ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: const EdgeInsets.all(0.5),
          child: Container(
            height: height ?? 5.5.h,
            width: width ?? double.infinity,
            decoration: BoxDecoration(
              color: color ?? AppColors.bgColor,
              borderRadius: BorderRadius.circular(6),
            ),
            child: child ??
                Center(
                  child: CustomWidgets.text1(
                    text!,
                    fontSize: fontSize ?? 12.sp,
                    fontWeight: fontWeight ?? FontWeight.w600,
                    color: AppColors.whiteColor,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class CustomeBorderButton extends StatelessWidget {
  final String? text;
  final Color? btnColor;
  final Color? fontColor;
  final Color? borderColor;
  final double? fontSize;
  final double? width;
  final  Function() onTap;
  const CustomeBorderButton({super.key,this.text,this.btnColor,this.fontColor,this.fontSize,this.borderColor,this.width,required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        height: 5.h,
        width: width?? 30.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color:btnColor?? AppColors.aapbarColor,
            border: Border.all(color: borderColor?? AppColors.yellowColor.withOpacity(0.5))),
        alignment: Alignment.center,
        child: CustomWidgets.text1(
        text!,
          color:fontColor?? AppColors.whiteColor,
          fontWeight: FontWeight.w500,
          fontSize:fontSize?? 7.5.sp
        ),
      ),
    );
  }
}
