import 'package:bible_app/Repository/note_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Api/api_manager.dart';
import '../Models/add_notes_model.dart';
import '../Models/get_user_all_notes_model.dart';
import '../Models/success_model.dart';
import '../Utils/constants.dart';

class NotesController extends GetxController {

  NoteRepository noteRepository = NoteRepository(APIManager());

  TextEditingController noteDescController = TextEditingController();
  RxString selectedNOte = "Private Note".obs;
  TextEditingController onTapNotesController = TextEditingController();
  TextEditingController onTapCommentNoteController = TextEditingController();
  int pageIndex = 1;
  List<UserNotesData> getAllNoteList = <UserNotesData>[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    getUserNotes();
    super.onInit();
  }
  /// Addnote
  addNote(
      { String? bookId,
       String? chapter,
       String? verse,
       String? bookName,
      required String noteText,
      required bool private,
        String? commentId}) async {
    AddNoteModel addNoteModel = await noteRepository.addNoteApiCall({
      "book_id": bookId,
      "chapter": chapter,
      "verse": verse,
      "book_name": bookName,
      "note": noteText,
      "private": private,
      "comment_id": commentId
    });

    if (addNoteModel.status == 1) {
      /// success message & navigation
      successSnackBar(message: addNoteModel.message);
      onTapNotesController.clear();
      onTapCommentNoteController.clear();
    } else {
      errorSnackBar(message: addNoteModel.message);
    }
  }

  /// get user all Notes
  getUserNotes({bool lazyLoad = false}) async {
    if (lazyLoad == true) {
      pageIndex = pageIndex + 1;
      if (getAllNoteList.isEmpty ||
          (getAllNoteList.length >= 10 && getAllNoteList.length % 10 == 0 && getAllNoteList.length == 0)) {
        GetUserAllNotesModel getUserAllNotesModel =
            await noteRepository.getUserNotesApiCall(page: pageIndex);
        if (getUserAllNotesModel.status == 1) {
          getAllNoteList.addAll(getUserAllNotesModel.data!);
        }
      }
    } else {
      getAllNoteList.clear();
      GetUserAllNotesModel getUserAllNotesModel =
          await noteRepository.getUserNotesApiCall(page: 1);
      if (getUserAllNotesModel.status == 1) {
        getAllNoteList.addAll(getUserAllNotesModel.data!);
      }
    }
  }

  /// Delete Note

  deleteNote({required String noteId})async{
    SuccessModel successModel = await noteRepository.deletNoteApiCall(noteId: noteId);
    if(successModel.status == 1){
      successSnackBar(message: successModel.message);
      /// calling get user all note api bcz delete after refresh a data
    }else{
      errorSnackBar(message: successModel.message);
    }
    getUserNotes(lazyLoad : false);
  }

  /// edit note
  editNote({required String noteId,required String noteText,required bool private, })async{
    SuccessModel successModel = await noteRepository.editNoteApiCall({
      "note": noteText,
      "private": private
    },noteId: noteId);

    if(successModel.status == 1){
      successSnackBar(message: successModel.message);
      /// calling get user all note api bcz delete after refresh a data
      Get.back(
          closeOverlays: true, result: true
      );
      getUserNotes();
    }else{
      errorSnackBar(message: successModel.message);
    }
  }

}
