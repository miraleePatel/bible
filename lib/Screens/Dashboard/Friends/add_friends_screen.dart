import 'package:bible_app/Utils/app_colors.dart';
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
import '../../../generated/assets.dart';
import '../../../widgets/custom_widget.dart';

class AddFriendsScreen extends StatefulWidget {
  const AddFriendsScreen({super.key});

  @override
  State<AddFriendsScreen> createState() => _AddFriendsScreenState();
}

class _AddFriendsScreenState extends State<AddFriendsScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    friendController.getUserData(search: "");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    friendController.addFrdSearchController.clear();
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
                        controller: friendController.addFrdSearchController,
                        onFieldSubmitted: (value) {
                          friendController.getUserData(
                              search:
                                  friendController.addFrdSearchController.text,);
                          print(friendController.addFrdSearchController.text);
                        },
                        onChanged: (value) {
                          // bibleController.getSearchVerseData(
                          //     book: bibleController.searchBook.value);
                          friendController.getUserData(
                            search:
                            friendController.addFrdSearchController.text,isLoaderShow: false);
                          if (value.endsWith(' ')) {
                            friendController.addFrdSearchController.text =
                                value.trimRight();
                            friendController.addFrdSearchController.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                  offset: friendController
                                      .addFrdSearchController.text.length),
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
                      Container(
                        height: 55,
                        width: 100.w - 20,
                        decoration: BoxDecoration(
                            color: AppColors.texfeildColor,
                            borderRadius: BorderRadius.circular(10)),
                        alignment: Alignment.center,
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                            backgroundImage:
                                AssetImage(Assets.imagesInviteDefaultUser),
                          ),
                          title: CustomWidgets.text1(
                              LanguageConstant.inviteFriendsTo.tr,
                              fontSize: 7.sp,
                              color: AppColors.blackColor),
                          trailing: Container(
                              height: 35,
                              width: 30,
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4)),
                              alignment: Alignment.center,
                              child: Image.asset(
                                Assets.iconMenuShare,
                                height: 17,
                                color: AppColors.blackColor,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Container(
                        // height: 55,
                        width: 100.w - 20,
                        decoration: BoxDecoration(
                            color: AppColors.texfeildColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            /*      ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 12),
                          leading: CircleAvatar(
                            backgroundColor: AppColors.whiteColor,
                          ),
                          title: CustomWidgets.text1(
                              LanguageConstant.connectContect.tr,
                              fontSize: 8.sp,
                              color: AppColors.blackColor),
                          trailing: Container(
                              height: 25,
                              width: 20,
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4)),
                              child: Icon(Icons.arrow_forward_ios_rounded,
                                size: 18,))
                      ),*/
                            /*  Divider(
                        height: 10,
                        color: AppColors.blackColor.withOpacity(0.3),
                      ),*/
                            ListTile(
                              onTap: (){
                                Get.toNamed(Routes.ADD_FACEBOOK_FRIEND_SCREEN);
                              },
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 12),
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.blackColor.withOpacity(0.10),
                                  radius: 20,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: AppColors.whiteColor,
                                    backgroundImage:
                                        AssetImage(Assets.iconInviteF),
                                  ),
                                ),
                                title: CustomWidgets.text1(
                                    LanguageConstant.addFaceFriend.tr,
                                    fontSize: 8.sp,
                                    color: AppColors.blackColor),
                                trailing: Container(
                                    height: 25,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        color:
                                            AppColors.blackColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(4)),
                                    alignment: Alignment.center,
                                    child: Icon(
                                      Icons.arrow_forward_ios_rounded,
                                      size: 18,
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 3.h,
                      ),
                      Obx(() {
                        return friendController.getUserList.isNotEmpty
                            ? Expanded(
                                child: LazyLoadScrollView(
                                  onEndOfPage: () async {
                                    await  friendController.getUserData(search: "",isLazyLoad: true);
                                  },
                                  child: RefreshIndicator(
                                    color: AppColors.aapbarColor,
                                    onRefresh: () async {
                                      await friendController.getUserData(
                                          search: "");
                                    },
                                    child: ListView.separated(
                                      itemCount:
                                          friendController.getUserList.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                friendController
                                                    .getUserList[index]
                                                    .profileImage != null && friendController
                                                    .getUserList[index]
                                                    .profileImage != ""?  CircleAvatar(
                                                    backgroundColor:
                                                        AppColors.texfeildColor,
                                                    radius: 25,
                                                    backgroundImage: NetworkImage(
                                                        APIManager.baseUrl +
                                                            friendController
                                                                .getUserList[index]
                                                                .profileImage
                                                                .toString())): CircleAvatar(
                                                    backgroundColor: AppColors.texfeildColor,
                                                    radius: 25,
                                                    backgroundImage: AssetImage(
                                                      Assets.iconPerson,)
                                                ),
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
                                                              .getUserList[index]
                                                              .userName
                                                              .toString(),
                                                          fontSize: 11.sp,
                                                          fontWeight: FontWeight.w500,
                                                          color:
                                                              AppColors.whiteColor),
                                                      CustomWidgets.text1(
                                                          friendController
                                                              .getUserList[index]
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
                                                friendController.getUserList[index]
                                                            .send ==
                                                        true
                                                    ? CustomeBorderButton(
                                                        onTap: () {
                                                          friendController.cancelRequest(
                                                              friendId:
                                                              friendController
                                                                  .getUserList[
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
                                                                      .getUserList[
                                                                          index]
                                                                      .sId
                                                                      .toString());
                                                        },
                                                        text:  LanguageConstant.sendRequest.tr,
                                                      )
                                              ],
                                            ),

                                            friendController.getUserList.length -1 == index ? SizedBox(
                                              height: 3.h,
                                            ):SizedBox()
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
                            : Center(
                                child: CustomWidgets.text1(
                                  LanguageConstant.notFound.tr.tr,
                                textAlign: TextAlign.justify,
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.w600,
                                fontSize: 11.sp,
                              ));
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
