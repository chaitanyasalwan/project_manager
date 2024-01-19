import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project_manager/core/services/authentication.dart';
import 'package:project_manager/features/onboarding/logic/bloc/authentication_bloc/authentication_bloc_bloc.dart';
import 'package:project_manager/features/onboarding/presentation/task_screen.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'O',
                  style: GoogleFonts.monoton(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  'versight',
                  style: GoogleFonts.ptSans(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Positioned(
              top: 50,
              left: 120,
              child: Text(
                '管理',
                style: GoogleFonts.zenMaruGothic(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.left,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
                onPressed: () {
                  // TODO: Implement the close button functionality
                },
                iconSize: 50,
              ),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Login',
                        style: GoogleFonts.ptSans(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 50),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 16),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // TODO: Implement login functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        fixedSize: Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: Text(
                        'Login',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // TODO: Implement forgot password functionality
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        fixedSize: Size(double.infinity, 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.0),
                        ),
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: GoogleFonts.ptSans(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'OR',
                      style: GoogleFonts.ptSans(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    BlocConsumer<AuthenticationBlocBloc, AuthenticationState>(
                      listener: (context, state) {
                        if (state is AuthenticationFailure) {
                          // final snackBar = SnackBar(
                          //   /// need to set following properties for best effect of awesome_snackbar_content
                          //   elevation: 0,
                          //   margin: EdgeInsets.only(left: 100),
                          //   behavior: SnackBarBehavior.floating,
                          //   backgroundColor: Colors.transparent,
                          //   content: AwesomeSnackbarContent(
                          //     title: 'On Snap!',
                          //     message:
                          //         'There was some Problem logging in ',

                          //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          //     contentType: ContentType.failure,

                          //   ),
                          // );

                          // ScaffoldMessenger.of(context)
                          //   ..hideCurrentSnackBar()
                          //   ..showSnackBar(snackBar);
                        } else if (state is AuthenticationSuccess) {
                          final uid = state.user.uid;
                          createUserFirstTime(uid, context);
                          //  final materialBanner = MaterialBanner(
                          //   /// need to set following properties for best effect of awesome_snackbar_content
                          //   elevation: 0,
                          //   backgroundColor: Colors.transparent,
                          //   forceActionsBelow: false,

                          //   content: AwesomeSnackbarContent(
                          //     title: 'Hi There ',
                          //     message: 'You were successfully Logined ',

                          //     /// change contentType to ContentType.success, ContentType.warning or ContentType.help for variants
                          //     contentType: ContentType.failure,
                          //     // to configure for material banner
                          //     inMaterialBanner: true,
                          //   ),
                          //   actions: const [SizedBox.shrink()],
                          // );

                          // ScaffoldMessenger.of(context)
                          //   ..hideCurrentMaterialBanner()
                          //   ..showMaterialBanner(materialBanner);
                      
                        }
                      },
                      builder: (context, state) {
                        if (state is AuthenticationLoadingState) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return OutlinedButton(
                          onPressed: () {
                            // Dispatch Google Sign-In Event
                            context.read<AuthenticationBlocBloc>().add(
                                  SignInWithGoogleEvent(),
                                );
                            // AuthenticationService _authenticationService =
                            //     AuthenticationService();
                            // _authenticationService.signInWithGoogle();
                          },
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.black),
                            fixedSize: Size(double.infinity, 40),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/icons/google_logo.png',
                                height: 18,
                                width: 18,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Sign in with Google',
                                  style: GoogleFonts.ptSans(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future createUserFirstTime(String uid,BuildContext context) async {
    final docUser =
        FirebaseFirestore.instance.collection('users').doc('googleusers');
    final listString = {
      'uid':FieldValue.arrayUnion([uid])
    };
    await docUser.set(listString, SetOptions(merge: true));
        Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskBoardPage(),
      ),
    );
  }
}
