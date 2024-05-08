import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../Api/api_manager.dart';
import '../../../Controller/friend_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/string_constant.dart';
import '../../../Widgets/custom_widget.dart';
import '../../../generated/assets.dart';
import '../../../widgets/custom_button.dart';
import '../Menu/Language/language_constant.dart';

class AddFacebookFriendsScreen extends StatefulWidget {
  const AddFacebookFriendsScreen({super.key});

  @override
  State<AddFacebookFriendsScreen> createState() => _AddFacebookFriendsScreenState();
}

class _AddFacebookFriendsScreenState extends State<AddFacebookFriendsScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    friendController.getFBFriendData(search: "");
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    friendController.addFBFrdSearchController.clear();
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
          title: LanguageConstant.addFriends.tr,
        ),
        body: Obx(() {
          return isInternetAvailable.value == true
              ? Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 5.h,
                ),
                TextFormField(
                  controller: friendController.addFBFrdSearchController,
                  onFieldSubmitted: (value) {
                    friendController.getFBFriendData(
                      search:
                      friendController.addFBFrdSearchController.text,);
                    print(friendController.addFBFrdSearchController.text);
                  },
                  onChanged: (value) {
                    // bibleController.getSearchVerseData(
                    //     book: bibleController.searchBook.value);
                    friendController.getFBFriendData(
                      search:
                      friendController.addFBFrdSearchController.text,isLoaderShow: false);
                    if (value.endsWith(' ')) {
                      friendController.addFBFrdSearchController.text =
                          value.trimRight();
                      friendController.addFBFrdSearchController.selection =
                          TextSelection.fromPosition(
                            TextPosition(
                                offset: friendController
                                    .addFBFrdSearchController.text.length),
                          );
                    }
                  },
                  cursorColor: AppColors.bgColor,
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: AppColors.blackColor),
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

                SizedBox(
                  height: 3.h,
                ),
                Obx(() {
                  return friendController.getFBFriendList.isNotEmpty
                      ? Expanded(
                    child: LazyLoadScrollView(
                      onEndOfPage: () {
                        friendController.getFBFriendData(search: "",isLazyLoad: true);
                      },
                      child: RefreshIndicator(
                        color: AppColors.aapbarColor,
                        onRefresh: () async {
                          await friendController.getFBFriendData(
                              search: "");
                        },
                        child: ListView.separated(
                          itemCount:
                          friendController.getFBFriendList.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                    backgroundColor:
                                    AppColors.texfeildColor,
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        APIManager.baseUrl +
                                            friendController
                                                .getFBFriendList[index]
                                                .profileImage
                                                .toString())),
                                SizedBox(
                                  width: 3.w,
                                ),
                                Container(
                                  width: 130,
                                  child: Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      CustomWidgets.text1(
                                          friendController
                                              .getFBFriendList[index]
                                              .userName
                                              .toString(),
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          color:
                                          AppColors.whiteColor),
                                      CustomWidgets.text1(
                                          friendController
                                              .getFBFriendList[index]
                                              .email
                                              .toString(),
                                          fontSize: 8.sp,
                                          overflow:
                                          TextOverflow.ellipsis,
                                          maxLine: 1,
                                          fontWeight: FontWeight.w300,
                                          color:
                                          AppColors.whiteColor),
                                    ],
                                  ),
                                ),
                                Spacer(),
                                friendController.getFBFriendList[index]
                                    .send ==
                                    true
                                    ? CustomeBorderButton(
                                  onTap: () {
                                    friendController.cancelRequest(
                                        friendId:
                                        friendController
                                            .getFBFriendList[
                                        index]
                                            .sId
                                            .toString());
                                  },
                                  btnColor: AppColors.bgColor,
                                  fontColor:
                                  AppColors.yellowColor,
                                  borderColor:
                                  AppColors.yellowColor,
                                  text: LanguageConstant.requested.tr,
                                )
                                    : CustomeBorderButton(
                                  onTap: () {
                                    friendController.sendRequest(
                                        friendId:
                                        friendController
                                            .getFBFriendList[
                                        index]
                                            .sId
                                            .toString());
                                  },
                                  text:  LanguageConstant.sendRequest.tr,
                                )
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 3.h,
                            );
                          },
                        ),
                      ),
                    ),
                  )
                      : Expanded(
                        child: Align(
                    alignment: Alignment.center,
                        child: CustomWidgets.text1(
                          LanguageConstant.notFound.tr.tr,
                          textAlign: TextAlign.justify,
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 11.sp,
                        )),
                      );
                })
              ],
            ),
          )
              : Image.asset(
            Assets.imagesNoIntenet,
            fit: BoxFit.cover,
          );
        }),
      ),
    );
  }
}
