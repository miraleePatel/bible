import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import '../../../Api/api_manager.dart';
import '../../../Controller/friend_controller.dart';
import '../../../Models/get_public_notes_model.dart';
import '../../../Models/signUp_model.dart' as userdata;
import '../../../Models/signUp_model.dart';
import '../../../Routes/routes.dart';
import '../../../Utils/app_colors.dart';
import '../../../Utils/string_constant.dart';
import '../../../Widgets/custom_widget.dart';
import '../../../generated/assets.dart';
import '../Menu/Language/language_constant.dart';


class NoteCommentScreen extends StatefulWidget {
  const NoteCommentScreen({super.key});

  @override
  State<NoteCommentScreen> createState() => _NoteCommentScreenState();
}

class _NoteCommentScreenState extends State<NoteCommentScreen> {
  FriendController friendController = Get.put(FriendController());
  PublicData? publicData = Get.arguments;
  userdata.Data currentUser = userdata.Data();
  @override
  void initState() {
    // TODO: implement initState
    friendController.getNoteCommentData(noteId: publicData!.sId.toString());
    currentUser = LoginSuccessModel.fromJson(GetStorage().read(userData)).data!;
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    friendController.commentDataList.clear();
    friendController.pageIndexComment = 0;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(
        title: LanguageConstant.comment.tr,
      ),
      body: Obx(() {
        return isInternetAvailable.value == true
            ? SingleChildScrollView(
          reverse: true,
                child: Column(
                  children: [
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        height: 55.h,
                        width: 100.w,
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        decoration: BoxDecoration(
                          color: AppColors.yellowColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Row(
                                children: [
                                  publicData!.userId!.profileImage != null &&
                                          publicData!.userId!.profileImage != ""
                                      ?
                                  CustomWidgets.shimmerImage( image:
                                  APIManager.baseUrl + publicData!.userId!.profileImage.toString())
                                      : CircleAvatar(
                                          backgroundColor:
                                              AppColors.texfeildColor,
                                          radius: 20,
                                          backgroundImage: AssetImage(
                                            Assets.imagesDefaultUser,
                                          ),
                                        ),
                                  SizedBox(
                                    width: 7,
                                  ),
                                  CustomWidgets.text1(
                                      publicData!.userId!.userName!,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400)
                                ],
                              ),
                            ),
                            Divider(
                              color: AppColors.blackColor.withOpacity(0.3),
                            ),
                            SizedBox(
                              height: 7,
                            ),
                            Container(
                              height: 38.h,
                              width: 80.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                      image:
                                          AssetImage(Assets.imagesVerseBgImage),
                                      fit: BoxFit.fill)),
                              child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 20, left: 20, top: 5),
                                  child: Center(
                                    child: CustomWidgets.text1(
                                      publicData!.note.toString(),
                                      textAlign: TextAlign.justify,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 8.sp,
                                    ),
                                  )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, top: 12),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // if (friendController.isLike.value) {
                                      //   // friendController.isLike.value =
                                      //   // !friendController.isLike.value;
                                      //   friendController.likeFrdNote(
                                      //       noteId: publicData!.sId.toString());
                                      // } else {
                                      //   // friendController.isLike.value =
                                      //   // !friendController.isLike.value;
                                      //   friendController.likeFrdNote(
                                      //       noteId: publicData!.sId.toString());
                                      // }
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 28,
                                          width: 28,
                                          decoration: BoxDecoration(
                                              color: AppColors.texfeildColor,
                                              borderRadius:
                                                  BorderRadius.circular(8)),
                                          alignment: Alignment.center,
                                          child: Icon(
                                            Icons.favorite_outline_rounded,
                                            size: 20,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 1.5.w,
                                        ),
                                        CustomWidgets.text1(
                                          "${publicData!.numberOfLikes.toString()} Like",
                                          textAlign: TextAlign.justify,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 8.sp,
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      height: 28,
                                      width: 28,
                                      decoration: BoxDecoration(
                                          color: AppColors.texfeildColor,
                                          borderRadius: BorderRadius.circular(8)),
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
                    LazyLoadScrollView(
                      onEndOfPage: () {
                        friendController.getNoteCommentData(noteId: publicData!.sId.toString());
                      },
                      child: ListView.builder(
                        itemCount: friendController.commentDataList.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        // physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          var comment = friendController.commentDataList[index];
                          return ListTile(
                            leading:
                            CircleAvatar(
                              backgroundColor: AppColors.whiteColor,
                              child:   comment.userId!.profileImage != null &&
                                  comment.userId!.profileImage != ""

                                  ? CustomWidgets.shimmerImage( image:
                              APIManager.baseUrl + comment.userId!.profileImage.toString())
                                  :  Image.asset(
                                Assets.iconPerson,
                                scale: 5,
                              ),
                            ),

                            title: CustomWidgets.text1(comment.comment.toString(),
                                fontSize: 8.sp, color: AppColors.whiteColor),
                            trailing: CustomWidgets.text1(friendController.formatTimeDifference(comment.createdAt.toString()),
                                fontSize: 7.sp, color: AppColors.whiteColor),
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
            : Image.asset(
                Assets.imagesNoIntenet,
                fit: BoxFit.cover,
              );
      }),
      bottomNavigationBar: Obx(() {
        return isInternetAvailable.value == true
            ? Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Container(
                  height: 70,
                  color: AppColors.aapbarColor,
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: friendController.commentController,
                    cursorColor: AppColors.bgColor,
                    keyboardType: TextInputType.text,
                    style: TextStyle(color: AppColors.whiteColor),
                    decoration: InputDecoration(
                      hintText: LanguageConstant.commentType.tr,
                      hintStyle: GoogleFonts.poppins(
                          color: AppColors.whiteColor, fontSize: 11.sp),
                      contentPadding:
                          EdgeInsets.only(top: 1.h, left: 8.w, right: 3.w),
                      hintTextDirection: TextDirection.ltr,
                      border: InputBorder.none,
                      fillColor: AppColors.aapbarColor,
                      filled: true,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                          backgroundColor: AppColors.whiteColor,
                          child:    currentUser.profileImage != null &&
                              currentUser.profileImage != ""
                              ?
                          CustomWidgets.shimmerImage( image:
                          APIManager.baseUrl + currentUser.profileImage.toString())
                              :  Image.asset(
                            Assets.iconPerson,
                            scale: 8,
                          ),
                        ),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // friendController.commentController.clear();

                            friendController.addComment(
                                noteId: publicData!.sId.toString());
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            height: 20,
                            width: 20,
                            decoration: BoxDecoration(
                                color: AppColors.texfeildColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Image.asset(
                                Assets.iconIconSend,
                                scale: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                ),
              )
            : SizedBox();
      }),
    );
  }
}
