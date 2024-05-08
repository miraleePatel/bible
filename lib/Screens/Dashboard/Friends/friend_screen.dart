// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:bible_app/widgets/custom_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../Api/api_manager.dart';
import '../../../Controller/friend_controller.dart';
import '../../../Utils/string_constant.dart';

class FriendScreen extends StatefulWidget {
  const FriendScreen({super.key});

  @override
  State<FriendScreen> createState() => _FriendScreenState();
}

class _FriendScreenState extends State<FriendScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    // TODO: implement initState
    callMethodOnInit();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  callMethodOnInit() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await friendController.getPublicData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return isInternetAvailable.value == true
          ? Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.MY_FRIENDS_SCREEN);
                        },
                        child: Container(
                          height: 5.5.h,
                          width: 33.w,
                          padding: EdgeInsets.only(left: 10),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: AppColors.texfeildColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 3.5.h,
                                width: 3.5.h,
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(5)),
                                alignment: Alignment.center,
                                child: Image.asset(
                                  Assets.iconIconFriends,
                                  scale: 3.w,
                                ),
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              CustomWidgets.text1(LanguageConstant.friends.tr,
                                  fontSize: 9.sp, fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 1.5.h,
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(Routes.ADD_FRIENDS_SCREEN);
                        },
                        child: Container(
                          height: 5.5.h,
                          // width: 44.w,
                          padding: EdgeInsets.only(left: 10, right: 10),
                          alignment: Alignment.center,

                          decoration: BoxDecoration(
                              color: AppColors.texfeildColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 3.5.h,
                                  width: 3.5.h,
                                  decoration: BoxDecoration(
                                      color:
                                          AppColors.blackColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(5)),
                                  alignment: Alignment.center,
                                  child: Icon(Icons.add)),
                              SizedBox(
                                width: 8,
                              ),
                              CustomWidgets.text1(
                                  LanguageConstant.addFriends.tr,
                                  height: 1,
                                  // textAlign: TextAlign.center,
                                  // maxLine: 1,
                                  // overflow: TextOverflow.ellipsis,
                                  fontSize: 9.sp,
                                  fontWeight: FontWeight.w500)
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                ///
                Expanded(
                    child: Obx(
                  () => LazyLoadScrollView(
                    onEndOfPage: () {
                      friendController.getPublicData(lazyLoad: true);
                    },
                    child: RefreshIndicator(
                      color: AppColors.aapbarColor,
                      onRefresh: () async {
                        friendController.getPublicData();
                      },
                      child: friendController.publicDataList.isNotEmpty
                          ? ListView.separated(
                              itemCount: friendController.publicDataList.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                var likeIndex = -1;
                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Container(
                                        height: 55.h,
                                        width: 100.w - 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.yellowColor,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8, top: 5),
                                              child: Row(
                                                children: [
                                                  friendController
                                                                  .publicDataList[
                                                                      index]
                                                                  .userId!
                                                                  .profileImage !=
                                                              null &&
                                                          friendController
                                                                  .publicDataList[
                                                                      index]
                                                                  .userId!
                                                                  .profileImage !=
                                                              ""
                                                      ? CustomWidgets.shimmerImage(
                                                          image: APIManager
                                                                  .baseUrl +
                                                              friendController
                                                                  .publicDataList[
                                                                      index]
                                                                  .userId!
                                                                  .profileImage
                                                                  .toString())
                                                      : CircleAvatar(
                                                          backgroundColor: AppColors
                                                              .texfeildColor,
                                                          radius: 20,
                                                          backgroundImage:
                                                              AssetImage(
                                                            Assets
                                                                .imagesDefaultUser,
                                                          )),
                                                  SizedBox(
                                                    width: 7,
                                                  ),
                                                  CustomWidgets.text1(
                                                      friendController
                                                          .publicDataList[index]
                                                          .userId!
                                                          .userName
                                                          .toString(),
                                                      fontSize: 10.sp,
                                                      fontWeight: FontWeight.w600)
                                                ],
                                              ),
                                            ),
                                            Divider(
                                              color: AppColors.blackColor
                                                  .withOpacity(0.3),
                                            ),
                                            // SizedBox(
                                            //   height: 7,
                                            // ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 30, left: 30),
                                              child: Container(
                                                height: 38.h,
                                                width: double.infinity,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                        image: AssetImage(Assets
                                                            .imagesVerseBgImage),
                                                        fit: BoxFit.fill)),
                                                child: Padding(
                                                    padding: const EdgeInsets.only(
                                                        right: 20,
                                                        left: 20,
                                                        top: 5),
                                                    child: Center(
                                                      child: CustomWidgets.text1(
                                                        friendController
                                                            .publicDataList[index]
                                                            .note
                                                            .toString(),
                                                        textAlign:
                                                            TextAlign.justify,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 8.sp,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 10,
                                              ),
                                              child: Row(
                                                children: [

                                                      GestureDetector(
                                                      onTap: () {
                                                        friendController.likeFrdNote(
                                                            noteId: friendController
                                                                .publicDataList[
                                                                    index]
                                                                .sId
                                                                .toString(),index: index);

                                                        likeIndex = index;

                                                      },
                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            height: 28,
                                                            width: 28,
                                                            decoration: BoxDecoration(
                                                                color: AppColors
                                                                    .texfeildColor,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8)),
                                                            alignment:
                                                                Alignment.center,
                                                            child: friendController
                                                                .publicDataList[
                                                            index].like != true
                                                                ? Icon(
                                                                    Icons
                                                                        .favorite_outline_rounded,
                                                                    size: 20,
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .favorite_outlined,
                                                                    size: 20,
                                                                    color:
                                                                        Colors.red,
                                                                  ),
                                                          ),
                                                          SizedBox(
                                                            width: 1.5.w,
                                                          ),
                                                          CustomWidgets.text1(
                                                            "${friendController.publicDataList[index].numberOfLikes.toString()} Like",
                                                            textAlign:
                                                                TextAlign.justify,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 8.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ),

                                                  SizedBox(
                                                    width: 8,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.toNamed(
                                                          Routes
                                                              .NOTE_COMMENT_SCREEN,
                                                          arguments: friendController
                                                                  .publicDataList[
                                                              index]);
                                                    },
                                                    child: Container(
                                                      height: 28,
                                                      width: 28,
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .texfeildColor,
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  8)),
                                                      alignment: Alignment.center,
                                                      child: Image.asset(
                                                        Assets.iconChat,
                                                        scale: 8.5,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    friendController.publicDataList.length - 1 == index ? SizedBox(height: 3.h,) :SizedBox()
                                  ],
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: 3.h,
                                );
                              },
                            )
                          : Center(
                              child: CustomWidgets.text1(
                              LanguageConstant.notFound.tr.tr,
                              textAlign: TextAlign.justify,
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            )),
                    ),
                  ),
                )),

                // SizedBox(
                //   height: 2.h,
                // )
              ],
            )
          : Image.asset(
              Assets.imagesNoIntenet,
              fit: BoxFit.cover,
            );
    });
  }
}
