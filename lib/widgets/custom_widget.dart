import 'package:bible_app/Utils/app_colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class CustomWidgets {
  static Text text1(String content,
      {Color? color,
      double? fontSize = 13,
      FontWeight? fontWeight = FontWeight.normal,
      int? maxLine,
      double? letterSpacing = 0.0,
      TextAlign? textAlign,
      double? height,
      TextOverflow? overflow,
      TextDecoration? decoration,
      Color? backgroundColor,
        bool? softWrap = true,
      Paint? background}) {
    return Text(
      content,
      textAlign: textAlign,
      maxLines: maxLine,
      overflow: overflow,
      softWrap: softWrap,
      style: GoogleFonts.poppins(
          letterSpacing: letterSpacing,
          color: color,
          fontSize: fontSize!.sp,
          fontWeight: fontWeight,
          decoration: decoration,
          backgroundColor: backgroundColor,
          background: background,
          height: height,

      ),
    );
  }

  static GestureDetector container(
      {required Widget child, EdgeInsetsGeometry? padding, Function()? ontap,Color? color}) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 12),
        padding: padding,
        decoration: BoxDecoration(
            color: color ?? AppColors.yellowColor,
            borderRadius: BorderRadius.circular(10)),
        child: child,
      ),
    );
  }
  static Container linearBorderContainer(
      {required Widget child}) {
    return Container(
      // height: 23.5.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.whiteColor.withOpacity(0.50),
            AppColors.whiteColor.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(6),
      ),

      child: Padding(
        padding: const EdgeInsets.all(0.5),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.bgColor,
            // color: AppColors.aapbarColor,
            borderRadius: BorderRadius.circular(6),
          ),
          child:child
        ),
      ),
    );
  }
  static Container customIcon(
      {required IconData icon,
      double? size,
      double? height,
      double? width,
      BorderRadiusGeometry? borderRadius}) {
    return Container(
      height: height ?? 3.5.h,
      width: width ?? 3.5.h,
      decoration: BoxDecoration(
          color: AppColors.texfeildColor,
          borderRadius: borderRadius ?? BorderRadius.circular(7)),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: size ?? 17,
      ),
    );
  }

  static Container squreContainer(
      {Widget? child,
      double? height,
      double? width,
      ImageProvider<Object>? image,
      double size = 1.0,
      BoxFit? boxFit}) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          // color: AppColors.bgColor,
          image: DecorationImage(
              image: image!, scale: size, fit: boxFit),
          borderRadius: BorderRadius.circular(10)),
      child: child,
    );
  }

  static AppBar appBar(
      {required String title, List<Widget>? actions, bool isAction = false}) {
    return AppBar(
      backgroundColor: AppColors.aapbarColor,
      elevation: 3,
      centerTitle: true,
      title: CustomWidgets.text1(
        title,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        letterSpacing: 1,
      ),
      leading: IconButton(
        onPressed: () {
          Get.back(result: true,closeOverlays: true);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.whiteColor,
        ),
      ),
      actions: isAction == true ? actions : [],
    );
  }

  static shimmerImage({required String image, BoxFit? fit,double? height,double? width}) {
    return SizedBox(
      height:height?? 5.8.h,
      width: width ?? 5.8.h,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          50,
        ),
        child: CachedNetworkImage(
          imageUrl: image,
          fit: fit ?? BoxFit.cover,
          placeholder: (context, url) {
            return Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: AppColors.texfeildColor,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
