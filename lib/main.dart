import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_config/flutter_config.dart';
import 'firebase_options.dart';

import './providers/authentication_provider.dart';

import 'screens/home/home_screen.dart';
import 'screens/home/home_tabs.dart';
import 'screens/offers/offers_screen.dart';
import 'screens/signin/signin_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/password_recovery/password_recovery_screen.dart';
import 'screens/stores/stores_screen.dart';
import 'screens/camera/camera_screen.dart';
import 'screens/digiceipts_details/digiceipts_details_screen.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error in fetching the cameras: $e');
  }

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await FlutterConfig.loadEnvVariables();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthenticationProvider(),
        ),
      ],
      child: Consumer<AuthenticationProvider>(
        builder: (ctx, auth, _) {
          return MaterialApp(
            key: Key('auth_${auth.isAuthenticated}'),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primaryColor: const Color.fromRGBO(33, 33, 33, 1),
                textTheme: const TextTheme(
                  headline1: TextStyle(
                    fontSize: 30,
                    color: Color.fromRGBO(33, 33, 33, 1),
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.bold,
                  ),
                  headline2: TextStyle(
                    fontSize: 26,
                    color: Color.fromRGBO(33, 33, 33, 1),
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.bold,
                  ),
                  headline3: TextStyle(
                    fontSize: 17,
                    color: Color.fromRGBO(33, 33, 33, 1),
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.w600,
                  ),
                  bodyText1: TextStyle(
                    color: Color.fromRGBO(33, 33, 33, 1),
                    fontSize: 15,
                    fontFamily: 'SF-Pro-Display',
                    fontWeight: FontWeight.normal,
                  ),
                )),
            home:
                auth.isAuthenticated ? const HomeTabs() : const SignUpScreen(),
            routes: {
              SignInScreen.routeName: (ctx) => const SignInScreen(),
              SignUpScreen.routeName: (ctx) => const SignUpScreen(),
              HomeTabs.routeName: (ctx) => const HomeTabs(),
              PasswordRecoverScreen.routeName: (ctx) =>
                  const PasswordRecoverScreen(),
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              OffersScreen.routeName: (ctx) => OffersScreen(),
              StoresScreen.routeName: (ctx) => StoresScreen(),
              CameraScreen.routeName: (ctx) =>
                  CameraScreen(cameras: cameras),
              DigiceiptsDetailScreen.routeName: (ctx) =>
                  const DigiceiptsDetailScreen(),
            },
          );
        },
      ),
    );
  }
}
