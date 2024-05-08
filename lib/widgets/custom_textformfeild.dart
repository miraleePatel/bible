// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../Screens/Dashboard/Menu/Language/language_constant.dart';
import '../Utils/app_colors.dart';

class CustomTextformFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  bool? obscureText = true;
  Widget? image;

  TextInputType? keyboardType;
  bool readOnly;
  BoxConstraints? suffixIconConstraints;



  String? Function(String?)? validator;
  void Function()? onTap;
  void Function(String)? onChanged;
   CustomTextformFeild({super.key,required this.controller,
     required this.hintText,
     this.image,
     this.obscureText,
     this.validator,

     this.keyboardType,

     this.onTap,
     this.readOnly = false,
     this.onChanged,

     this.suffixIconConstraints});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller:controller,
         onChanged: onChanged,
                      onTap: onTap,
                      validator: validator,
                      cursorColor: AppColors.aapbarColor,
                      keyboardType: keyboardType,

      decoration: InputDecoration(
        hintText: hintText,

        hintStyle:GoogleFonts.poppins(
          color: AppColors.blackColor,fontSize: 10.sp
        ),
        contentPadding: EdgeInsets.only(
          top: 1.h,
          left: 4.w,
        ),
        hintTextDirection: TextDirection.ltr,
        border: InputBorder.none,
        fillColor: AppColors.texfeildColor,
        filled: true,
        // prefixIcon: prefixIcon,
        prefixIcon: SizedBox(
          height: 4,
          width: 4,
          child: Center(
            child: Container(
              margin: EdgeInsets.only(
                left: 1.w,
              ),
              height: 4.h,
              // width: 5.5.w,
              child: image,

            ),
          ),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
               6
            ),
            borderSide: BorderSide.none
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                6
            ),
            borderSide: BorderSide.none

        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                6
            ),
            borderSide: BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(
                6
            ),
            borderSide: BorderSide.none
        ),
      ),
      obscureText: obscureText ?? false,
      readOnly: readOnly,
    );
  }
}


class CustomeNoteTextfeildWidget extends StatelessWidget {
  final TextEditingController? controller;
  const CustomeNoteTextfeildWidget({super.key,this.controller});

  @override
  Widget build(BuildContext context) {
    return     TextFormField(
      controller:controller,
      cursorColor: AppColors.bgColor,
      keyboardType: TextInputType.text,
      maxLines: 5,
      style: TextStyle(color: AppColors.whiteColor),
      decoration: InputDecoration(
        hintText: LanguageConstant.giveTitle.tr,
        hintStyle: GoogleFonts.poppins(
            color: AppColors.whiteColor, fontSize: 11.sp),
        contentPadding:
        EdgeInsets.only(top: 1.h, left: 8.w, right: 3.w),
        hintTextDirection: TextDirection.ltr,
        border: InputBorder.none,
        fillColor: AppColors.aapbarColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: BorderSide.none),
      ),
    );
  }
}
