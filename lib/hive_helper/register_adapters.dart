import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../Models/bible_model.dart';


void registerAdapters() {

  Hive.registerAdapter(BibleModelAdapter()); //0
  Hive.registerAdapter(BibleDataAdapter()); //1
   Hive.registerAdapter(OldTestamentAdapter()); //2
  Hive.registerAdapter(ChaptersAdapter()); //3
  Hive.registerAdapter(VerseAdapter()); //4
  Hive.registerAdapter(CommentAdapter()); //5
  Hive.registerAdapter(VideoCommentAdapter()); //6


  // Hive.registerAdapter(RxBoolAdapter()); //10
  //-----AUDIT/HISTORY-----//

}

class RxBoolAdapter extends TypeAdapter<RxBool> {
  @override
  final typeId = 10; // unique identifier for this adapter

  @override
  RxBool read(BinaryReader reader) {
    final value = reader.readBool();
    return RxBool(value);
  }

  @override
  void write(BinaryWriter writer, RxBool obj) {
    writer.writeBool(obj.value);
  }
}
