import 'dart:io';

import 'package:child_care/screens/home_screen.dart';
import 'package:child_care/services/connection_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'bloc/articles/articles_bloc.dart';
import 'bloc/auth/auth_bloc.dart';
import 'components/dismiss_keyboard.dart';
import 'configs/base_url_config.dart';
import 'constants/injector.dart';
import 'screens/data/detail_screen.dart';
import 'screens/login_screen.dart';
import 'screens/regis_screen.dart';
import 'screens/splash/splash_screen.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await setupLocator();
    // await FlutterDownloader.initialize(
    //     debug: true // optional: set false to disable printing logs to console
    //     );

    // WidgetsFlutterBinding.ensureInitialized();
    // SystemChrome.setPreferredOrientations(
    //     [ArticlesOrientation.portraitUp, ArticlesOrientation.portraitDown]);

    // Directory _appDocsDir;
    // _appDocsDir = await getApplicationDocumentsDirectory();
    // Map appsFlyerOptions = {
    //   "afDevKey": BaseUrlConfig.appflyer_dev_key,
    //   "afAppId": BaseUrlConfig.appflyer_appid,
    //   "isDebug": true
    // };
    //
    // AppsflyerSdk appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
    //
    // appsflyerSdk.initSdk(
    //     registerConversionDataCallback: true,
    //     registerOnAppOpenAttributionCallback: true,
    //     registerOnDeepLinkingCallback: true
    // );

    //runApp(MyApp());

    runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ConnectionService()),
      ],
      child: MyApp(),
    ));

    /*try {
  aMethodThatMightFail();
} catch (exception, stackTrace) {
  await Sentry.captureException(
    exception,
    stackTrace: stackTrace,
  );
    //sample pasang untuk setiap method.
  */

  } catch (error, stacktrace) {
    print("ERROR!!!");
    print(error);
    print(stacktrace);
    print("ada error" + error.toString());
  }
  //   await setupLocator();
  // runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _permission();
  // }

  // void _permission() {
  //   setState(() async {
  //     Map<Permission, PermissionStatus> statuses = await [
  //       Permission.location,
  //       Permission.storage,
  //     ].request();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return ScreenUtilInit(
        designSize: const Size(360, 640),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return DismissKeyboard(
            child: GetMaterialApp(
              home: SplashScreen(),
              routes: {
                HomeScreen.routeName: (ctx) => MultiBlocProvider(providers: [
                      BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(),
                      ),
                      BlocProvider<ArticlesBloc>(
                        create: (context) => ArticlesBloc(),
                      ),
                    ], child: HomeScreen()),
                LoginScreen.routeName: (ctx) => MultiBlocProvider(providers: [
                      BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(),
                      ),
                    ], child: LoginScreen()),
                RegistScreen.routeName: (ctx) => MultiBlocProvider(providers: [
                      BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(),
                      ),
                    ], child: RegistScreen()),
                DataDetailScreen.routeName: (ctx) => MultiBlocProvider(
                  
                  providers: [
                     BlocProvider<AuthBloc>(
                        create: (context) => AuthBloc(),
                      ),
                      BlocProvider<ArticlesBloc>(
                        create: (context) => ArticlesBloc(),
                      ),
                  ],
                  child: DataDetailScreen()),
              },
            ),
          );
        });
  }
}
