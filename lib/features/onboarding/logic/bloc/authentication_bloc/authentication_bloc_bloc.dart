import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:project_manager/core/services/authentication.dart';

part 'authentication_bloc_event.dart';
part 'authentication_bloc_state.dart';

class AuthenticationBlocBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBlocBloc(this._authenticationService)
      : super(AuthenticationInitial()) {
    on<SignInWithGoogleEvent>((event, emit) async {
      try {
        emit(AuthenticationLoadingState());
        final User? user = await _authenticationService.signInWithGoogle();

        if (user != null) {
          emit(AuthenticationSuccess(user));
        } else {
          emit(AuthenticationFailure('Google Sign-In Failed'));
        }
      } catch (e) {
        emit(AuthenticationFailure('Error: $e'));
      }
    });
    on<SignOutEvent>((event, emit) async {
      try {
        await _authenticationService.signOut();
        emit(AuthenticationInitial());
      } catch (e) {
        print('Error signing out: $e');
      }
    });
  }
}
