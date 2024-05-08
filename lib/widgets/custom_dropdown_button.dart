import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../Utils/app_colors.dart';
import '../Widgets/custom_widget.dart';

class CustomDropDownButton extends StatefulWidget {
  final String? value;
  final List<String>? items;

  final  Function(String?)? onChanged;
  const CustomDropDownButton({super.key,this.value,this.items,this.onChanged});

  @override
  State<CustomDropDownButton> createState() => _CustomDropDownButtonState();
}

class _CustomDropDownButtonState extends State<CustomDropDownButton> {

  List<DropdownMenuItem<String>> _addDividersAfterItems(List<String> items) {
    final List<DropdownMenuItem<String>> menuItems = [];
    for (final String item in items) {
      menuItems.addAll(
        [
          DropdownMenuItem<String>(
            value: item,
            child: Center(
                child: CustomWidgets.text1(item,
                    fontWeight: FontWeight.w600,
                    color: AppColors.blackColor,
                    fontSize: 7.sp)),
          ),
          if (item != items.last)
            const DropdownMenuItem<String>(
              enabled: false,
              child: Divider(
                endIndent: 5,
                color: AppColors.blackColor,
                thickness: 1,
                indent: 5,
              ),
            ),
        ],
      );
    }
    return menuItems;
  }
  @override
  Widget build(BuildContext context) {
    return
        DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        alignment: Alignment.center,
        isDense: true,
        dropdownStyleData: DropdownStyleData(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.texfeildColor),
          offset: const Offset(0, -5),
          width: 35.w,
        ),
        iconStyleData: const IconStyleData(
          icon: Padding(
            padding: EdgeInsets.only(right: 5),
            child: Icon(
              Icons.arrow_drop_down,
            ),
          ),
          iconSize: 20,
          iconEnabledColor: AppColors.blackColor,
          iconDisabledColor: Colors.grey,
        ),
        menuItemStyleData: MenuItemStyleData(
          padding:
          const EdgeInsets.symmetric(horizontal: 7.0),
          customHeights: _getCustomItemsHeights(widget.items!),
        ),
        // style: GoogleFonts.poppins(fontWeight: FontWeight.w500, color: AppColors.blackColor, fontSize: 13.sp),
        value: widget.value,
        items:_addDividersAfterItems( widget.items!),
        onChanged:widget.onChanged
      ),
    );
  }

  List<double> _getCustomItemsHeights(List<String> items) {
    final List<double> itemsHeights = [];
    for (int i = 0; i < (items.length * 2) - 1; i++) {
      if (i.isEven) {
        itemsHeights.add(40);
      }

      if (i.isOdd) {
        itemsHeights.add(4);
      }
    }
    return itemsHeights;
  }
}
