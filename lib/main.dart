import 'dart:developer';
import 'dart:io';

import 'package:bible_app/Controller/language_controller.dart';
import 'package:bible_app/Screens/Dashboard/Bible/ShareImage/share_image_screen.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sizer/sizer.dart';

import 'Routes/router.dart';
import 'Screens/Dashboard/Menu/Language/language_translation.dart';
import 'Screens/Demo/tts_home_demo.dart';
import 'Screens/Demo/tts_new.dart';
import 'firebase_options.dart';
import 'hive_helper/register_adapters.dart';

var sdkInt;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // Get the initial locale values
  final Locale? defaultSystemLocale = Get.deviceLocale;
  log("Get device language ------ $defaultSystemLocale");

  if (Platform.isAndroid) {
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    sdkInt = androidInfo.version.sdkInt;
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  registerAdapters();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  LanguageController languageController = Get.put(LanguageController());

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          builder: EasyLoading.init(),
          // getPages: AppPages.routes,
          // initialRoute: AppPages.INITIAL_ROUTE,
          home: ShareImageScreen(),
          translations: LanguageTranslation(),
          locale: languageController.getSelectedLangValue(),
          fallbackLocale: const Locale('en', 'US'),
          debugShowCheckedModeBanner: false,
          // scrollBehavior: AppScrollBehavior(),
          // home:DashboardScreen(),
        );
      },
    );
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
