import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../../Controller/friend_controller.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/string_constant.dart';
import '../../../Widgets/custom_widget.dart';
import '../../../generated/assets.dart';
import '../../../widgets/custom_button.dart';
import '../Menu/Language/language_constant.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  State<FriendRequestScreen> createState() => _FriendRequestScreenState();
}

class _FriendRequestScreenState extends State<FriendRequestScreen> {
  FriendController friendController = Get.put(FriendController());

  @override
  void initState() {
    // TODO: implement initState
    friendController.getFriendRequest();
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomWidgets.appBar(
            // title: LanguageConstant.myFriend.tr,
          title: LanguageConstant.friendRequest.tr,

            isAction: true),
        body:
        Obx(() {
          return
            isInternetAvailable.value == true ?
            Padding(
              padding:  EdgeInsets.only(right: 20,left: 20,top: 20),
              child: friendController.getRequestList.isNotEmpty ?
              ListView.separated(
                itemCount:friendController.getRequestList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  return   Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                          backgroundColor: AppColors.texfeildColor,
                          radius:25,
                          backgroundImage: AssetImage(Assets.imagesDefaultUser,)
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
                            CustomWidgets.text1(friendController.getRequestList[index].senderId!.userName.toString(),
                                fontSize: 10.sp, fontWeight: FontWeight.w600,color: AppColors.whiteColor),
                            CustomWidgets.text1(friendController.getRequestList[index].senderId!.email.toString(),
                                overflow:
                                TextOverflow.ellipsis,
                                maxLine: 1, fontSize: 8.sp, fontWeight: FontWeight.w300,color: AppColors.whiteColor),
                          ],
                        ),
                      ),
                      Spacer(),
                      CustomeBorderButton(
                        onTap: (){
                          friendController.addFriend(friendId: friendController.getRequestList[index].senderId!.sId.toString());
                        },
                        // btnColor: AppColors.bgColor,
                        width:15.5.w,
                        fontColor: AppColors.yellowColor,
                        borderColor: AppColors.yellowColor,
                        text:LanguageConstant.accept.tr ,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomeBorderButton(
                        onTap: (){
                          friendController.deleteRequest(friendId:  friendController.getRequestList[index].senderId!.sId.toString());
                        },
                        width:15.5.w,
                        btnColor: AppColors.bgColor,

                        borderColor: AppColors.whiteColor,
                        text:LanguageConstant.delete.tr ,
                      ),
                    ],
                  );
                }, separatorBuilder: (context,index){
                return SizedBox(
                  height: 3.h,
                );
              }, ) : Center(
                  child: CustomWidgets.text1(
                    LanguageConstant.notFound.tr.tr,
                    textAlign: TextAlign.justify,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 11.sp,
                  )),
            ) :
            Image.asset(Assets.imagesNoIntenet,fit: BoxFit.cover,);
        })

    );
  }
}
