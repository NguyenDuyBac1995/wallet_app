part of 'auth.bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}
