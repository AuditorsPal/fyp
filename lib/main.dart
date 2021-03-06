import 'package:auditorpal/screens/SplashScreen.dart';
import 'package:auditorpal/screens/UserCheck.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:auditorpal/screens/login.dart';
import 'package:auditorpal/screens/AuditorsViews/signupaud.dart';
import 'package:auditorpal/screens/resetpass.dart';
import 'package:provider/provider.dart';
import 'controlller/authenticationService.dart';
import 'model/userModel.dart';
import 'firebase_options.dart';
import 'screens/AuditorsViews/profile.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserModel(email: "", userType: "")),
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(

        title: 'Auditorpal',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
