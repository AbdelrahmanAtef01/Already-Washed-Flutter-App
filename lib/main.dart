import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '/home_layout.dart';
import '/login_screen.dart';
import '/maghsala_cubit/maghsala_cubit.dart';
import 'bloc_observer.dart';
import 'constants.dart';
import 'cubit/cubit.dart';
import 'cubit/state.dart';
import 'injection.dart';
import 'network/local/cache_helper.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  FirebaseMessaging.onMessage.listen((event) {
    Fluttertoast.showToast(msg: 'on message',backgroundColor: Colors.green);
  });
  bool? isDark = CacheHelper.getData(key: 'isDark');
  String? uid = CacheHelper.getData(key: 'UID');
  late Widget startingWidget;
  uid == null? startingWidget = LoginScreen() : startingWidget = HomeLayoutScreen();
  // await di.init();

  //FirebaseMessaging messaging = FirebaseMessaging.instance;

  //await messaging.requestPermission(
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }
  runApp( MyApp(isDark: isDark,uid: uid,startingWidget: startingWidget,));
}

class MyApp extends StatelessWidget {
  final String? uid ;
  final bool? isDark ;
  final Widget startingWidget;
  const MyApp({Key? key, required this.isDark ,required this.uid ,required this.startingWidget }) : super(key: key);
  static ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers:[
          BlocProvider(
          create: (BuildContext context) => AppBloc()
            ..changeAppMode(fromShared: isDark,)
            ..getContactingWays()
            ..getUsers()
            ..getUserDataWithoutLogin(uid: uid),
          ),
            BlocProvider(
               create: (BuildContext context) => maghsala_cubit(),
              ),
          ],
          child: BlocConsumer<AppBloc, AppState>(
            listener: (context, state) {},
              builder: (context, state) {
              AppBloc.get(context).isDark?
              themeNotifier = ValueNotifier(ThemeMode.dark)
                 :themeNotifier = ValueNotifier(ThemeMode.light);
                return ValueListenableBuilder<ThemeMode>(
                    valueListenable: themeNotifier,
                    builder: (_, ThemeMode currentMode, __) {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.teal,
                    scaffoldBackgroundColor: Colors.white,
                    colorScheme: const ColorScheme.light(primary:Colors.teal, ),
                    appBarTheme: const AppBarTheme(
                      titleSpacing: 20.0,

                      //backwardsCompatibility: false,
                      systemOverlayStyle: SystemUiOverlayStyle(
                        statusBarColor: Colors.teal,
                        statusBarIconBrightness: Brightness.dark,
                      ),
                      backgroundColor: Colors.teal,
                      elevation: 5.0,
                      titleTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.black,
                      ),
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                     // backgroundColor: Colors.teal[200],
                    ),
                    textTheme: const TextTheme(
                      bodyText1: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: Colors.teal,
                    focusColor: Colors.teal,
                    scaffoldBackgroundColor: Colors.black,
                    colorScheme: const ColorScheme.dark(primary:Colors.teal, ),
                    inputDecorationTheme: InputDecorationTheme(
                      floatingLabelStyle: const TextStyle(color: Colors.teal),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.teal),
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ),
                      ),
                    ),
                    appBarTheme: const AppBarTheme(
                      titleSpacing: 20.0,
                      backwardsCompatibility: false,
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Colors.teal,
                        statusBarIconBrightness: Brightness.light,
                      ),
                      backgroundColor: Colors.teal,
                      elevation: 0.0,
                      titleTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                      iconTheme: IconThemeData(
                        color: Colors.white,
                      ),
                    ),
                    floatingActionButtonTheme: const FloatingActionButtonThemeData(
                      backgroundColor: Colors.teal,
                    ),
                    textTheme: const TextTheme(
                      bodyText1: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    textSelectionColor: Colors.white,
                  ),
                  themeMode: currentMode ,
                  home: SplashscreenWidget(),
                );
                });
              }
          )
      );

  }


}

