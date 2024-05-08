
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../../Utils/app_colors.dart';
import '../../../../Widgets/custom_widget.dart';
import '../../../../generated/assets.dart';


class ShowNoteScreen extends StatelessWidget {
  const ShowNoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 10),

          child:  ListView.separated(
            itemCount: 4,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return CustomWidgets.linearBorderContainer(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 10, left: 10, top: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Image.asset(
                              Assets.iconPerson,
                              scale: 9,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomWidgets.text1("Alex",
                                    letterSpacing: 0.5,
                                    fontSize: 13,
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.w700),
                                CustomWidgets.text1(
                                  "\"For God so loved the world, that he "
                                      "gave his only Son,that whoever believes in him shoul\”",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whiteColor,
                                  height: 1.3,
                                  fontSize: 8.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Image.asset(
                            Assets.iconShare,
                            scale: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 1.h,
              );
            },
          )

    );
  }
}



/* class ShowAllNotes extends StatefulWidget {
  const ShowAllNotes({super.key});

  @override
  State<ShowAllNotes> createState() => _ShowAllNotesState();
}

class _ShowAllNotesState extends State<ShowAllNotes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: " Genesis 1:1 ${LanguageConstant.notes}"),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CustomWidgets.container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 35,
                            width: 35,
                            decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                shape: BoxShape.circle),
                            alignment: Alignment.center,
                            child: Image.asset(
                              Assets.iconPerson,
                              scale: 9,
                            ),
                          ),
                          SizedBox(
                            width: 3.w,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,

                              children: [
                                CustomWidgets.text1("Alex",
                                    letterSpacing: 0.5,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700),
                                CustomWidgets.text1(
                                  "\"For God so loved the world, that he"
                                      "gave his only Son,that whoever believes in him shoul\”",
                                  textAlign: TextAlign.start,
                                  fontWeight: FontWeight.w500,
                                  height: 1.3,
                                  fontSize: 7.sp,
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Image.asset(
                          Assets.iconShare,
                          scale: 2,
                        ),
                      )
                    ],
                  )),

              /// LIST LENGHT - 1
              2 - 1 == index
                  ?  SizedBox(
                height: 1.h,
              )
                  : const SizedBox(),
            ],
          );
        },
      ),
    );
  }
}
 */

