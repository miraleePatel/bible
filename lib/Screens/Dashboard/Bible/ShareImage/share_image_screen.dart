// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'dart:developer';
import 'dart:io';

import 'package:bible_app/Controller/share_controller.dart';
import 'package:bible_app/Screens/Dashboard/Menu/Language/language_constant.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sizer/sizer.dart';
import '../../../../Utils/app_colors.dart';
import '../../../../Utils/constants.dart';
import '../../../../Utils/permission_service.dart';
import '../../../../Utils/static_list.dart';
import '../../../../generated/assets.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_widget.dart';

class ShareImageScreen extends StatefulWidget {
  const ShareImageScreen({super.key});

  @override
  State<ShareImageScreen> createState() => _ShareImageScreenState();
}

ShareController shareController = Get.put(ShareController());
ScreenshotController screenshotController = ScreenshotController();

class _ShareImageScreenState extends State<ShareImageScreen>
    with SingleTickerProviderStateMixin {

  String verseText = "hello";
  String verseKey = "dkchvjk";
  @override
  void initState() {
    super.initState();
    shareController.tabEditImageController =
        TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    shareController.imageIndex.value = -1;
    shareController.fontIndex.value = -1;
    shareController.imagePath.value = "";
    shareController.imageName.value = "";
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomWidgets.appBar(title: LanguageConstant.image.tr),
      body: Screenshot(verseText:verseText ,verseKey: verseKey),
      bottomNavigationBar: Container(
        height: 23.h,
        color: AppColors.aapbarColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 3.h,
            ),
            GestureDetector(
              onTap: () {
                editImageBottomSheet(
                    context, shareController.tabEditImageController,verseKey:verseKey ,verseText:verseText );
              },
              child: CustomWidgets.text1(LanguageConstant.editImage.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 13.sp,
                  color: AppColors.whiteColor),
            ),
            Divider(
              color: AppColors.whiteColor.withOpacity(0.13),
              thickness: 0.5,
              height: 5.h,
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                /// save to image gallary btn
                CustomSilverButton(
                  onTap: () {
                    var captureImage = Screenshot(verseText:verseText ,verseKey: verseKey);
                    showProgressIndicator();
                    screenshotController
                        .captureFromWidget(
                            InheritedTheme.captureAll(context, captureImage),
                            delay: const Duration(seconds: 1))
                        .then((capturedImage) async {
                      dismissProgressIndicator();
                      await PermissionHandlerPermissionService
                              .handlePhotosPermission(context)
                          .then((bool photoPermission) async {
                        if (photoPermission == true) {
                          // _saved(capturedImage);
                          final folderName =
                              "Bible"; // Change this to your desired folder name
                          _saveImageToGallery(capturedImage, folderName);
                        }
                      }).then((value) {
                        informationSnackBar(
                            message: 'Save Verse Image to Gallery');
                      });
                    });
                  },
                  text: LanguageConstant.save.tr,
                  
                  width: 27.w,
                ),

                SizedBox(
                  width: 3.w,
                ),

                /// share btn
                CustomSilverButton(
                  onTap: () {
                    var captureImage = Screenshot(verseText:verseText ,verseKey: verseKey);
                    showProgressIndicator();
                    screenshotController
                        .captureFromWidget(
                            InheritedTheme.captureAll(context, captureImage),
                            delay: const Duration(seconds: 1))
                        .then((capturedImage) async {
                      dismissProgressIndicator();
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final image = File('${directory.path}/verse.png');
                      image.writeAsBytesSync(capturedImage);
                      await Share.shareFiles([image.path]);
                    });
                  },
                  text: LanguageConstant.share.tr,
                    width: 27.w,
                ),
              ],
            ),
            SizedBox(
              height: 3.h,
            ),
          ],
        ),
      ),
    );
  }
}

_saveImageToGallery(Uint8List imageBytes, String folderName) async {
  final Directory newFolder;
  /*  final directory = (Platform.isIOS)
      ? await getApplicationDocumentsDirectory()
      : await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DCIM); */
  if (Platform.isIOS) {
    Directory dPath = await getApplicationDocumentsDirectory();
    newFolder = Directory("${dPath.path}/$folderName");
    // "/Users/ios/Library/Developer/CoreSimulator/Devices/FD8F73A0-23C2-4145-8520-D50EC70F03D9/data/Containers/Data/Application/02E54384-D63D-40EB-9E99-80DEEC6D4871/Documents/Bible")
  } else {
    final directory = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DCIM);
    newFolder = Directory('${directory}/$folderName');
  }

  /// save image to Gallary
  // final directory = await getExternalStorageDirectories(type: StorageDirectory.dcim);

/*   final newFolder = (Platform.isIOS)
      ? Directory("${dPath.path}/Bible")
      // "/Users/ios/Library/Developer/CoreSimulator/Devices/FD8F73A0-23C2-4145-8520-D50EC70F03D9/data/Containers/Data/Application/02E54384-D63D-40EB-9E99-80DEEC6D4871/Documents/Bible")
      : Directory('${directory}/$folderName'); */
  log("name directory ---------- $newFolder");

  if (!await newFolder.exists()) {
    await newFolder.create(recursive: true);
  }
  final fileName = DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
  final imageFile = File('${newFolder.path}/$fileName');
  await imageFile.writeAsBytes(imageBytes);

  // Optionally, you can save the image to the system's gallery using the `ImageGallerySaver` plugin
  // final result = await ImageGallerySaver.saveImage(imageBytes, name: fileName);
  final result = await ImageGallerySaver.saveImage(imageBytes, name: fileName);
  if (result['isSuccess'] == true) {
    print("Image saved to gallery.");
    print(result);
  } else {
    print("Failed to save image to gallery.");
  }
}
/*
/// save image to Gallary
_saved(image) async {
  final result = await ImageGallerySaver.saveImage(image , name: "Bible");

  if (kDebugMode) {
    print(result);
  }
  if (kDebugMode) {
    print("File Saved to Gallery");
  }
}
*/

/// screenshot image
class Screenshot extends StatelessWidget {
  final String? verseText;
  final String? verseKey;
  const Screenshot({
    super.key,this.verseText,this.verseKey
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 20),
      child: Obx(() {
        return Center(
          child: Container(
            height: shareController.isArrangeSize.value == false ? 55.h : 45.h,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                /*  image: shareController.imageIndex.value == -1
                    ? DecorationImage(
                        image: AssetImage(Assets.imagesVerseBgImage),
                        fit: BoxFit.fill)
                    : DecorationImage(
                        image: AssetImage(
                            imageList2[shareController.imageIndex.value]),
                        fit: BoxFit.fill)),*/
                image: shareController.imageIndex.value != -1
                    ? DecorationImage(
                        image: AssetImage(
                            imageList[shareController.imageIndex.value]),
                        fit: BoxFit.fill)
                    : shareController.imagePath.isNotEmpty
                        ? DecorationImage(
                            image:
                                FileImage(File(shareController.imagePath.value)),
                            fit: BoxFit.fill)
                        : DecorationImage(
                            image: AssetImage(Assets.imagesVerseBgImage),
                            fit: BoxFit.fill)),
            child: Padding(
              padding: shareController.isArrangeSize.value == false
                  ? EdgeInsets.only(right: 20, left: 20, top: 5)
                  : EdgeInsets.only(right: 20, left: 20, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Spacer(),
                  shareController.fontIndex.value == -1
                      ? CustomWidgets.text1(
                          "\"${verseText!}\" ",
                          textAlign: TextAlign.justify,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.5.sp,
                        )
                      : Text(
                          "\"${verseText.toString()}\" ",
                          style: GoogleFonts.getFont(
                            shareController
                                .fontList[shareController.fontIndex.value],
                            fontSize: 8.5.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                  SizedBox(
                    height: 2.h,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: shareController.fontIndex.value == -1
                          ? CustomWidgets.text1(
                              "- ${verseKey!}",
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.w600,
                              fontSize: 9.sp,
                            )
                          : Text(
                              "- ${verseKey!}",
                              style: GoogleFonts.getFont(
                                shareController
                                    .fontList[shareController.fontIndex.value],
                                fontSize: 9.sp,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.left,
                            ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 6.h,
                        width: 6.h,
                        decoration: BoxDecoration(
                            color: AppColors.bgColor,
                            borderRadius: BorderRadius.circular(8)),
                        alignment: Alignment.center,
                        child: CustomWidgets.text1(
                          "Icon",
                          textAlign: TextAlign.left,
                          fontWeight: FontWeight.w600,
                          fontSize: 7.5.sp,
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CustomWidgets.text1(
                        "bible",
                        textAlign: TextAlign.left,
                        fontWeight: FontWeight.w600,
                        fontSize: 9.sp,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

editImageBottomSheet(BuildContext context, TabController? controller,{required String verseText,required String verseKey}) {
  return showModalBottomSheet(
      context: context,
      elevation: 0,
      backgroundColor: AppColors.aapbarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(7),
        ),
      ),
      builder: (context) {
        return SizedBox(
          height: 24.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              DefaultTabController(
                length: 3,
                child: TabBar(
                  controller: controller,
                  indicator: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.whiteColor.withOpacity(0.10),
                        AppColors.whiteColor.withOpacity(0.0),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    // borderRadius: BorderRadius.circular(8),
                    border: Border(
                      top: BorderSide(color: AppColors.whiteColor, width: 3.0),
                    ),
                  ),
                  tabs: [
                    Tab(
                      child: CustomWidgets.text1(LanguageConstant.image.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                          letterSpacing: 0.5,
                          color: AppColors.whiteColor),
                    ),
                    Tab(
                      child: CustomWidgets.text1(LanguageConstant.arrange.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                          letterSpacing: 0.5,
                          color: AppColors.whiteColor),
                    ),
                    Tab(
                      child: CustomWidgets.text1(LanguageConstant.font.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 8.sp,
                          letterSpacing: 0.5,
                          color: AppColors.whiteColor,
                          height: 1.3),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: controller,
                  children: [
                    /// Tab 1 of Image
                    Container(
                      height: 6.h,
                      // width: 100.w,
                      alignment: Alignment.center,
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          /// image list
                          ListView.separated(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: imageList.length > 5 ? 5 : imageList.length ,
                            itemBuilder: (context, index) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      shareController.imageIndex.value = index;
                                    },
                                    child: Obx(() {
                                      return CustomWidgets.squreContainer(
                                          height: 6.h,
                                          width: 12.w,
                                          image: AssetImage(
                                            imageList[index],
                                          ),
                                          boxFit: BoxFit.fill,
                                          child: shareController
                                                      .imageIndex.value ==
                                                  index
                                              ? Icon(Icons.done)
                                              : Container());
                                    }),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 3.5.w,
                              );
                            },
                          ),

                          /// view image
                          GestureDetector(
                            onTap: () {
                              Get.back();
                              showImageBottomSheet(context);
                            },
                            child: Container(
                              height: 6.h,
                              width: 12.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.texfeildColor),
                              child: Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: AppColors.blackColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// Tab 2 of Arrange
                    // Text("Arrange"),
                    Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomLinearButton(
                            onTap: () {
                              shareController.isArrangeSize.value = false;
                            },
                            height: 5.h,
                            width: 5.h,
                            color: shareController.isArrangeSize.value == false
                                ? AppColors.bgColor
                                : AppColors.aapbarColor,
                            gradient: shareController.isArrangeSize.value ==
                                    false
                                ? LinearGradient(
                                    colors: [
                                      AppColors.whiteColor.withOpacity(0.50),
                                      AppColors.whiteColor.withOpacity(0.1),
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      AppColors.aapbarColor.withOpacity(0.50),
                                      AppColors.aapbarColor.withOpacity(0.1),
                                    ],
                                  ),
                            text: "1:1",
                            fontSize: 8.sp,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          CustomLinearButton(
                            onTap: () {
                              shareController.isArrangeSize.value = true;
                            },
                            color: shareController.isArrangeSize.value == true
                                ? AppColors.bgColor
                                : AppColors.aapbarColor,
                            height: 5.h,
                            width: 5.h,
                            gradient: shareController.isArrangeSize.value ==
                                    true
                                ? LinearGradient(
                                    colors: [
                                      AppColors.whiteColor.withOpacity(0.50),
                                      AppColors.whiteColor.withOpacity(0.1),
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      AppColors.aapbarColor.withOpacity(0.50),
                                      AppColors.aapbarColor.withOpacity(0.1),
                                    ],
                                  ),
                            text: "1:2",
                            fontSize: 8.sp,
                          ),
                        ],
                      );
                    }),

                    /// Tab 3 of Font
                    // Text("Font"),
                    Container(
                      height: 15.h,
                      width: 100.w,
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 10),
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: shareController.fontList.length,
                        itemBuilder: (context, index) {
                          return Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomLinearButton(
                                    onTap: () {
                                      shareController.fontIndex.value = index;
                                    },
                                    color:
                                        shareController.fontIndex.value == index
                                            ? AppColors.bgColor
                                            : AppColors.aapbarColor,
                                    height: 6.h,
                                    width: 12.w,
                                    gradient:
                                        (shareController.fontIndex.value ==
                                                index)
                                            ? LinearGradient(
                                                colors: [
                                                  AppColors.whiteColor
                                                      .withOpacity(0.50),
                                                  AppColors.whiteColor
                                                      .withOpacity(0.1),
                                                ],
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  AppColors.aapbarColor
                                                      .withOpacity(0.50),
                                                  AppColors.aapbarColor
                                                      .withOpacity(0.1),
                                                ],
                                              ),
                                    child: Center(
                                      child: Text("Aa",
                                          style: GoogleFonts.getFont(
                                              shareController.fontList[index],
                                              fontSize: 20,
                                              color: AppColors.whiteColor)),
                                    ),
                                    fontSize: 8.sp,
                                  ),
                                ],
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 2.5.w,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              // Spacer(),

              /// bottom btn
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  /// save btn
                  ///
                  CustomSilverButton(
                    onTap: () {
                      var captureImage = Screenshot(verseText:verseText ,verseKey: verseKey);
                      screenshotController
                          .captureFromWidget(
                              InheritedTheme.captureAll(context, captureImage),
                              delay: const Duration(seconds: 1))
                          .then((capturedImage) async {
                        dismissProgressIndicator();
                        await PermissionHandlerPermissionService
                                .handlePhotosPermission(context)
                            .then((bool photoPermission) async {
                          if (photoPermission == true) {
                            final folderName = "Bible"; // Change this to your desired folder name
                            _saveImageToGallery(capturedImage, folderName);
                          }
                        }).then((value) {
                          informationSnackBar(
                              message: 'Save Verse Image to Gallery');
                        });
                      });
                    },
                    text: LanguageConstant.save.tr,
                    width: 27.w,

                  ),
                  SizedBox(
                    width: 3.w,
                  ),

                  /// share btn
                  ///
                  CustomSilverButton(
                    onTap: () {
                      var captureImage = Screenshot(verseText:verseText ,verseKey: verseKey);
                      showProgressIndicator();
                      screenshotController
                          .captureFromWidget(
                              InheritedTheme.captureAll(context, captureImage),
                              delay: const Duration(seconds: 1))
                          .then((capturedImage) async {
                        dismissProgressIndicator();
                        final directory =
                            await getApplicationDocumentsDirectory();
                        final image = File('${directory.path}/verse.png');
                        image.writeAsBytesSync(capturedImage);
                        await Share.shareFiles([image.path]);
                      });
                    },
                    text: LanguageConstant.share.tr,
                      width: 27.w,
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
            ],
          ),
        );
      });
}

/// image bottom sheet
showImageBottomSheet(
  BuildContext context,
) {
  return showModalBottomSheet(
      context: context,
      elevation: 0,
      isScrollControlled: true,
      backgroundColor: AppColors.aapbarColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(7),
        ),
      ),
      builder: (BuildContext context1) {
        return Container(
          height: MediaQuery.of(context1).size.height / 1.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20, top: 20, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 4.h,
                        width: 9.w,
                        decoration: BoxDecoration(
                          color: AppColors.texfeildColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: GridView.builder(
                    itemCount: imageList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      crossAxisCount: 3,
                    ),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          shareController.imageIndex.value = index;
                          Get.back();
                        },
                        child: Obx(() {
                          return CustomWidgets.squreContainer(
                              height: 50,
                              width: 100,
                              image: AssetImage(imageList[index]),
                              boxFit: BoxFit.cover,
                              child: shareController.imageIndex.value == index
                                  ? Icon(Icons.done)
                                  : Container());
                        }),
                      );
                    },
                  ),
                ),
              ),

              /// upload Image btn
              ///

              CustomSilverButton(
                onTap: () {
                  Get.back();
                  uploadImagePicker(context1);
                  print("hello");
                },
                width: 41.w,
                
                height: 5.h,
                text: LanguageConstant.uploadImage.tr,
              ),
              SizedBox(
                height: 2.h,
              ),
            ],
          ),
        );
      });
}

/// upload Image
void uploadImagePicker(context) {
  showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.bgColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(7),
        ),
      ),
      builder: (BuildContext bc) {
        return Builder(builder: (context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(
                      Icons.photo_library,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomWidgets.text1('Photo Library',
                        color: AppColors.whiteColor),
                    onTap: () async {
                      await PermissionHandlerPermissionService
                              .handlePhotosPermission(context)
                          .then((bool galleryPermission) async {
                        if (galleryPermission == true) {
                          await shareController
                              .openImagePicker(ImageSource.gallery)
                              .then((value) async {
                            if (value.path.isNotEmpty || value.path != "") {
                              shareController.imageName.value =
                                  value.path.split("/").last;
                              shareController.imagePath.value = value.path;
                              shareController.imageIndex.value = -1;
                            }
                            print(
                                "Image Name :::: ${shareController.imageName}");
                            print(
                                "Image Path :::: ${shareController.imagePath}");
                          });
                        }
                      });
                      Get.back();
                    }),
                ListTile(
                    leading: const Icon(
                      Icons.photo_camera,
                      color: AppColors.whiteColor,
                    ),
                    title: CustomWidgets.text1('Camera',
                        color: AppColors.whiteColor),
                    onTap: () async {
                      Platform.isIOS
                          ? await shareController
                              .openImagePicker(ImageSource.camera)
                              .then((value) async {
                              if (value.path.isNotEmpty || value.path != "") {
                                shareController.imageName.value =
                                    value.path.split("/").last;
                                shareController.imagePath.value = value.path;
                                shareController.imageIndex.value = -1;
                              }
                              print(
                                  "Image Name :::: ${shareController.imageName}");
                              print(
                                  "Image Path :::: ${shareController.imagePath}");
                            })
                          : await PermissionHandlerPermissionService
                                  .handleCameraPermission(context)
                              .then((bool cameraPermission) async {
                              if (cameraPermission == true) {
                                await shareController
                                    .openImagePicker(ImageSource.camera)
                                    .then((value) async {
                                  if (value.path.isNotEmpty ||
                                      value.path != "") {
                                    shareController.imageName.value =
                                        value.path.split("/").last;
                                    shareController.imagePath.value =
                                        value.path;
                                    shareController.imageIndex.value = -1;
                                  }
                                  print(
                                      "Image Name :::: ${shareController.imageName}");
                                  print(
                                      "Image Path :::: ${shareController.imagePath}");
                                });
                              }
                            });
                      Get.back();
                    }),
              ],
            ),
          );
        });
      });
}
