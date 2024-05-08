import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../Api/api_manager.dart';
import '../../../Controller/friend_controller.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/string_constant.dart';
import '../../../widgets/custom_button.dart';
import '../Menu/Language/language_constant.dart';
import '../../../Utils/app_colors.dart';
import '../../../Widgets/custom_widget.dart';
import '../../../generated/assets.dart';

class MyFriendsScreen extends StatefulWidget {
  const MyFriendsScreen({super.key});

  @override
  State<MyFriendsScreen> createState() => _MyFriendsScreenState();
}

class _MyFriendsScreenState extends State<MyFriendsScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    friendController.getFriendData(search: "");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    friendController.myFrdSearchController.clear();

  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: AppColors.bgColor,
          appBar: CustomWidgets.appBar(
              title: LanguageConstant.myFriend.tr,
              actions: [
                InkWell(
                  onTap: () async {

                    final result = await  Get.toNamed(Routes.FRIEND_REQUEST_SCREEN);
                    if (result != null) {
                      print('Package returned: $result');
                      friendController.getFriendData(search: "");
                    }
                  },
                  child: Image.asset(
                    Assets.iconIconList,
                    scale: 5,
                  ),
                )
              ],
              isAction: true),
          body:
          Obx(() {
            return
              isInternetAvailable.value == true ?
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 3.h,
                      ),
                      /*     CustomWidgets.text1(LanguageConstant.seeWhich.tr,
                        color: AppColors.whiteColor, textAlign: TextAlign.center),
                    SizedBox(
                      height: 3.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 5.5.h,
                          // width: 57.w,
                          // alignment: Alignment.center,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                              color: AppColors.texfeildColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 30,
                                width: 32,
                                decoration: BoxDecoration(
                                    color: AppColors.blackColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  Assets.iconIconFriends,
                                  scale: 10,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomWidgets.text1(LanguageConstant.connectContect
                                  .tr,
                                  fontSize: 10.sp, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ],
                    ),*/

                      TextFormField(
                        controller: friendController.myFrdSearchController,
                        cursorColor: AppColors.bgColor,
                        keyboardType: TextInputType.text,
                        style: TextStyle(color: AppColors.blackColor),
                        onFieldSubmitted: (value) {
                          friendController.getFriendData(
                            search:
                            friendController.myFrdSearchController.text,);
                          print(friendController.myFrdSearchController.text);
                        },
                        onChanged: (value) {
                          friendController.getFriendData(
                            search:
                            friendController.myFrdSearchController.text,isLoaderShow: false);

                          if (value.endsWith(' ')) {
                            friendController.myFrdSearchController.text =
                                value.trimRight();
                            friendController.myFrdSearchController.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                      offset: friendController
                                          .myFrdSearchController.text.length),
                                );
                          }
                        },
                        decoration: InputDecoration(
                          hintText: LanguageConstant.search.tr,
                          hintStyle: GoogleFonts.poppins(
                              color: AppColors.blackColor,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600),
                          contentPadding:
                          EdgeInsets.only(top: 1.h, left: 8.w, right: 3.w),
                          hintTextDirection: TextDirection.ltr,
                          border: InputBorder.none,
                          fillColor: AppColors.texfeildColor,
                          filled: true,
                          prefixIcon: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.blackColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4)),
                                child: Image.asset(
                                  Assets.iconSearch,
                                  scale: 9,
                                  color: AppColors.blackColor,
                                ),
                              )),
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
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              height: 5.h,
                              color: AppColors.texfeildColor,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: CustomWidgets.text1(
                                LanguageConstant.inviteFriends.tr,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w400,
                                color: AppColors.whiteColor.withOpacity(0.3)),
                          ),
                          Expanded(
                            child: Divider(
                              height: 8.h,
                              color: AppColors.texfeildColor,
                            ),
                          ),
                        ],
                      ),
                      /*       CustomWidgets.text1(LanguageConstant.inviteFriends.tr,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.whiteColor.withOpacity(0.6)),*/

                      Container(
                        height: 5.8.h,
                        width: 32.w,
                        padding: EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                            color: AppColors.texfeildColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 30,
                              width: 32,
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                Assets.iconInviteG,
                                scale: 5,
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            CustomWidgets.text1(LanguageConstant.google.tr,
                                fontSize: 10.sp, fontWeight: FontWeight.w500)
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 3.h,
                      ),

                      Obx(() {
                        return friendController.getFriendList.isNotEmpty ?
                         Expanded(
                          child:LazyLoadScrollView(
                            onEndOfPage: () {
                              friendController.getFriendData(search: "",isLazyLoad: true);
                            },
                            child: RefreshIndicator(
                              color: AppColors.aapbarColor,
                              onRefresh: () async {
                                await friendController.getFriendData(
                                    search: "");
                              },
                              child: ListView.separated(
                                itemCount: friendController.getFriendList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      friendController
                                          .getFriendList[index]
                                          .profileImage != null && friendController
                                          .getFriendList[index]
                                          .profileImage != ""?CircleAvatar(
                                          backgroundColor: AppColors.texfeildColor,
                                          radius: 25,
                                          backgroundImage:NetworkImage(
                                              APIManager.baseUrl +
                                                  friendController
                                                      .getFriendList[index]
                                                      .profileImage
                                                      .toString())
                                      ): CircleAvatar(
                                          backgroundColor: AppColors.texfeildColor,
                                          radius: 25,
                                          backgroundImage: AssetImage(
                                            Assets.imagesDefaultUser,)
                                      ),
                                      SizedBox(
                                        width: 3.w,
                                      ),
                                      Container(
                                        width: 130,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomWidgets.text1(friendController
                                                .getFriendList[index].userName.toString(),
                                                fontSize: 11.sp,
                                                fontWeight: FontWeight.w600,
                                                color: AppColors.whiteColor),
                                            CustomWidgets.text1(friendController
                                                .getFriendList[index].email.toString(),
                                                fontSize: 8.sp,
                                                overflow:
                                                TextOverflow.ellipsis,
                                                maxLine: 1,
                                                fontWeight: FontWeight.w300,
                                                color: AppColors.whiteColor),
                                          ],
                                        ),
                                      ),
                                      Spacer(),
                                      CustomeBorderButton(
                                        onTap: () {
                                          friendController.removeFriend(friendId:friendController
                                              .getFriendList[index].sId.toString() );
                                        },
                                        text: LanguageConstant.removeFriend.tr,
                                      )
                                    ],
                                  );
                                }, separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 3.h,
                                );
                              },),
                            ),
                          ),
                        ) : Center(
                            child: CustomWidgets.text1(
                              LanguageConstant.notFound.tr,
                              textAlign: TextAlign.justify,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ));
                      })

                    ],
                  ),
                ),
              ) :
              Image.asset(Assets.imagesNoIntenet, fit: BoxFit.cover,);
          })

      ),
    );
  }
}
