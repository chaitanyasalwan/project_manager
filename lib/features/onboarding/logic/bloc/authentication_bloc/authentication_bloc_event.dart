part of 'authentication_bloc_bloc.dart';

@immutable
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
  @override
  List<Object> get props => [];
}

final class SignInWithGoogleEvent extends AuthenticationEvent {}


final class SignOutEvent extends AuthenticationEvent {}
