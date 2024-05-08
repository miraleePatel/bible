import 'package:bible_app/services/audio_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'image_model.dart';
import 'video_model.dart';



class VideoDatabaseHelper {
  static final VideoDatabaseHelper instance = VideoDatabaseHelper._init();
  static Database? _database;

  VideoDatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('videos.db');
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, dbName);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE videos(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT, verse_name TEXT)
    ''');
    await db.execute('''
      CREATE TABLE audios(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT, verse_name TEXT)
    '''); await db.execute('''
      CREATE TABLE images(id INTEGER PRIMARY KEY AUTOINCREMENT, path TEXT, verse_name TEXT)
    ''');
  }

  /// video
  Future<void> insertVideo(String path, String verseName) async {
    final db = await database;

    // final thumbnail = await VideoThumbnail.thumbnailFile(
    //   video: path,
    //   thumbnailPath: (await getTemporaryDirectory()).path,
    //   imageFormat: ImageFormat.JPEG,
    //   maxHeight: 64,
    //   quality: 25,
    // );

    await db.insert('videos', {'path': path, 'verse_name': verseName});

  }

  Future<List<VideoModel>> getVideosWithVerseNamesAndThumbnails() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('videos');

    return List.generate(maps.length, (index) {
      return VideoModel(
        id: maps[index]['id'],
        path: maps[index]['path'],
        verseName: maps[index]['verse_name'],

      );
    });
  }

  Future<void> deleteVideo(int id) async {
    final db = await database;
    await db.delete('videos', where: 'id = ?', whereArgs: [id]);
  }

  /// audio
  Future<void> insertAudio(String path, String verseName) async {
    final db = await database;

    await db.insert('audios', {'path': path, 'verse_name': verseName});

  }

  Future<List<AudioModel>> getAudiosWithVerseNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('audios');

    return List.generate(maps.length, (index) {
      return AudioModel(
        id: maps[index]['id'],
        path: maps[index]['path'],
        verseName: maps[index]['verse_name'],

      );
    });
  }

  Future<void> deleteAudio(int id) async {
    final db = await database;
    await db.delete('audios', where: 'id = ?', whereArgs: [id]);
  }


  /// images
 Future<void> insertImage(String path, String verseName) async {
    final db = await database;

    await db.insert('images', {'path': path, 'verse_name': verseName});

  }

  Future<List<ImageModel>> getImageWithVerseNames() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('images');

    return List.generate(maps.length, (index) {
      return ImageModel(
        id: maps[index]['id'],
        path: maps[index]['path'],
        verseName: maps[index]['verse_name'],

      );
    });
  }
/*  Future<List<ImageModel>> getImagesByVerseName(String verseName) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'images',
      where: 'verse_name = ?',
      whereArgs: [verseName],
    );

    return List.generate(maps.length, (index) {
      return ImageModel(
        id: maps[index]['id'],
        path: maps[index]['path'],
        verseName: maps[index]['verse_name'],
      );
    });
  }*/
  Future<void> deleteImage(int id) async {
    final db = await database;
    await db.delete('images', where: 'id = ?', whereArgs: [id]);
  }


}
