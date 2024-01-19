import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_manager/core/services/authentication.dart';
import 'package:project_manager/features/onboarding/logic/bloc/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:project_manager/features/onboarding/presentation/screens/login_screen.dart';
import 'package:project_manager/features/onboarding/presentation/task_screen.dart';
import 'package:project_manager/features/onboarding/presentation/testui.dart';
import 'package:project_manager/firebase_options.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthenticationBlocBloc>(
          create: (context) => AuthenticationBlocBloc(
            AuthenticationService(),
          ),
        ),
      ],
      child: Sizer(
        builder: (context, orientation, deviceType) {
         return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
              brightness: Brightness.light,
              // visualDensity: VisualDensity.adaptivePlatformDensity,
              textSelectionTheme: TextSelectionThemeData(
                  cursorColor: Colors.black, selectionColor: Colors.black),
              shadowColor: Colors.black,

              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(
                  fontFamily:
                      'PTSans', // Assuming 'PTSans' is the font family name
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedErrorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
                errorBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
              ),

              // This is the theme of your application.
              //
              // TRY THIS: Try running your application with "flutter run". You'll see
              // the application has a purple toolbar. Then, without quitting the app,
              // try changing the seedColor in the colorScheme below to Colors.green
              // and then invoke "hot reload" (save your changes or press the "hot
              // reload" button in a Flutter-supported IDE, or press "r" if you used
              // the command line to start the app).
              //
              // Notice that the counter didn't reset back to zero; the application
              // state is not lost during the reload. To reset the state, use hot
              // restart instead.
              //
              // This works for code too, not just values: Most code changes can be
              // tested with just a hot reload.
              colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.black, outline: Colors.black),
              useMaterial3: false,
            ),
            home: TestUi(),
          );
        },
      ),
    );
  }
}
