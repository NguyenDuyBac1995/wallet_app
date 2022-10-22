part of 'auth.bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ChangePhoneNumber extends AuthEvent {
  final String phoneNumber;
  const ChangePhoneNumber(this.phoneNumber);
  @override
  List<Object> get props => [
        {phoneNumber}
      ];
}

class SignInEvent extends AuthEvent {}

class SignUpEvent extends AuthEvent {}
