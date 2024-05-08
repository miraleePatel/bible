// ignore_for_file: prefer_const_constructors

import 'package:bible_app/Controller/notes_controller.dart';
import 'package:bible_app/Routes/routes.dart';
import 'package:bible_app/Utils/app_colors.dart';
import 'package:bible_app/generated/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:sizer/sizer.dart';

import '../../../../Utils/string_constant.dart';
import '../Language/language_constant.dart';
import '../../../../Utils/myicon_icons.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_widget.dart';

class NoteListScreen extends StatefulWidget {
  const NoteListScreen({super.key});

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  NotesController notesController = Get.put(NotesController());

  @override
  void initState() {
    // TODO: implement initState
    notesController.getUserNotes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.bgColor,
        appBar: CustomAppbar.appbar(
          title: LanguageConstant.notes.tr,
          scaffoldKey: _scaffoldKey,
          isBackIcon: true,
        ),
        body: Obx(() {
          return isInternetAvailable.value == true
              ? notesController.getAllNoteList.isNotEmpty
                  ? LazyLoadScrollView(
                      onEndOfPage: () {
                        notesController.getUserNotes(lazyLoad: true);
                      },
                      child: RefreshIndicator(
                        color: AppColors.aapbarColor,
                        onRefresh: () async {
                          await notesController.getUserNotes();
                        },
                        child: Obx(() {
                          return ListView.builder(
                            itemCount: notesController.getAllNoteList.length,
                            itemBuilder: (context, index) {
                              var noteData =
                                  notesController.getAllNoteList[index];
                              return Column(
                                children: [
                                  Slidable(
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(),
                                      children: [
                                        /*    SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFFFE4A49),
                                          foregroundColor: Colors.white,
                                          icon: Icons.delete,
                                          label: 'Delete',
                                        ),
                                        SlidableAction(
                                          onPressed: doNothing,
                                          backgroundColor: Color(0xFF21B7CA),
                                          foregroundColor: Colors.white,
                                          icon: Icons.share,
                                          label: 'Share',
                                        ),*/
                                        Container(
                                          height: 13.h,
                                          width: 44.w,
                                          margin: EdgeInsets.only(top: 12),
                                          decoration: BoxDecoration(
                                              color: AppColors.yellowColor,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          alignment: Alignment.center,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  /// argument ..... verseData, isEdit, UserNotesData(get a default edit note data)
                                                  Get.toNamed(
                                                      Routes.ADD_NOTE_SCREEN,
                                                      arguments: [
                                                        null,
                                                        true,
                                                        notesController
                                                                .getAllNoteList[
                                                            index]
                                                      ]);
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, left: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Assets.iconIconEdit,
                                                        scale: 11,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      CustomWidgets.text1(
                                                        LanguageConstant
                                                            .edit.tr,
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 7.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: AppColors.blackColor
                                                    .withOpacity(0.2),
                                                width: 0.5,
                                                thickness: 0.5,
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  notesController.deleteNote(
                                                      noteId: noteData.sId
                                                          .toString());
                                                },
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 10, left: 10),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Image.asset(
                                                        Assets.iconDelete,
                                                        scale: 8,
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      CustomWidgets.text1(
                                                        LanguageConstant
                                                            .delete.tr,
                                                        textAlign:
                                                            TextAlign.start,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 7.sp,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    key: Key('item ${index}'),
                                    child: CustomWidgets.container(
                                        padding: EdgeInsets.all(10),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomWidgets.customIcon(
                                              icon: Myicon.note,
                                            ),
                                            SizedBox(
                                              width: 3.w,
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [

                                                  CustomWidgets.text1(
                                                     noteData.verseKey.toString(),
                                                      letterSpacing: 0.5,
                                                      fontSize: 13,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                  CustomWidgets.text1(
                                                    noteData.note.toString(),
                                                    textAlign: TextAlign.start,
                                                    fontWeight: FontWeight.w500,
                                                    height: 1.3,
                                                    fontSize: 7.sp,
                                                  ),
                                                  SizedBox(
                                                    height: 1.h,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 2.w,
                                            ),
                                            noteData.private == true
                                                ? Image.asset(
                                                    Assets.iconPrivate,
                                                    scale: 8,
                                                  )
                                                : SizedBox()
                                          ],
                                        )),
                                  ),
                                  notesController.getAllNoteList.length - 1 ==
                                          index
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(top: 10),
                                          child: CustomWidgets.text1(
                                            "Swipe to edit or delete your note!",
                                            textAlign: TextAlign.center,
                                            color: AppColors.whiteColor,
                                            fontWeight: FontWeight.w500,
                                            height: 1.3,
                                            fontSize: 7.sp,
                                          ),
                                        )
                                      : const SizedBox(),
                                ],
                              );
                            },
                          );
                        }),
                      ),
                    )
                  : Center(
                      child: CustomWidgets.text1(
                        "Not Found",
                        textAlign: TextAlign.center,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                        fontSize: 10.sp,
                      ),
                    )
              : Image.asset(
                  Assets.imagesNoIntenet,
                  fit: BoxFit.cover,
                );
        }),
        floatingActionButton: Obx(() {
          return isInternetAvailable.value == true
              ? InkWell(
                  onTap: () async {
                    /// argument ..... verseData, isEdit, UserNotesData(get a default edit note data)
                    final result = await Get.toNamed(Routes.ADD_NOTE_SCREEN,
                        arguments: [null, false, null]);
                    if (result != null) {
                      print('add note returned: $result');
                      notesController.getUserNotes();
                    }
                  },
                  child: Image.asset(
                    Assets.iconAdd,
                    scale: 5.5,
                  ))
              : Image.asset(
                  Assets.imagesNoIntenet,
                  fit: BoxFit.cover,
                );
        }));
  }
}
