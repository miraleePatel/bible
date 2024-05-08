import 'package:bible_app/Api/api_manager.dart';
import 'package:bible_app/Api/url_constant.dart';
import 'package:bible_app/Models/bible_model.dart';

import '../Models/add_notes_model.dart';
import '../Models/get_user_all_notes_model.dart';
import '../Models/get_verse_model.dart';
import '../Models/serach_verse_model.dart';
import '../Models/success_model.dart';

class NoteRepository {
  final APIManager apiManager;

  NoteRepository(this.apiManager);

  /// add notes on verse & comment
  Future<AddNoteModel> addNoteApiCall(Map<String, dynamic> params) async {
    var jsonData = await apiManager.postAPICall(
      URLConstanst.ADD_NOTE,
      params,
    );
    var response = AddNoteModel.fromJson(jsonData);
    return response;
  }

  /// get user all notes
  Future<GetUserAllNotesModel> getUserNotesApiCall({int? perPage = 10, int? page = 1}) async {
    // http://10.0.0.72:6001/api/users/get-user-all-note?perPage=10&page=1
    var jsonData = await apiManager.getAPICall("${URLConstanst.GET_USER_ALL_NOTE}perPage=$perPage&page=$page");
    var response = GetUserAllNotesModel.fromJson(jsonData);
    return response;
  }

  /// Delete Note
  Future<SuccessModel> deletNoteApiCall({required String noteId}) async {
    // http://10.0.0.72:6001/api/users/delete-note/:id
    var jsonData = await apiManager.deleteAPICall("${URLConstanst.DELETE_NOTE}$noteId");
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }

  /// Edit Note
  Future<SuccessModel> editNoteApiCall(Map<String, dynamic> params, {required String noteId}) async {
    // http://10.0.0.72:6001/api/users/delete-note/:id
    var jsonData = await apiManager.patchAPICall("${URLConstanst.EDIT_NOTE}$noteId", params);
    var response = SuccessModel.fromJson(jsonData);
    return response;
  }
}
