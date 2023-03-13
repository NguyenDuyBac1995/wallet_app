part of 'auth.bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class UidChanged extends AuthEvent {
  final String uid;
  const UidChanged(this.uid);
  @override
  List<Object> get props => [
        {uid: uid}
      ];
}

class PhoneNumberChanged extends AuthEvent {
  final String phoneNumber;
  const PhoneNumberChanged(this.phoneNumber);
  @override
  List<Object> get props => [
        {phoneNumber: phoneNumber}
      ];
}

class TokenChanged extends AuthEvent {
  final String token;
  const TokenChanged(this.token);
  @override
  List<Object> get props => [
        {token: token}
      ];
}

class ResetPassword extends AuthEvent {
  final BuildContext context;
  final ResetPasswordModal newPassword;
  const ResetPassword(this.newPassword, this.context);
  @override
  List<Object> get props => [
        {newPassword: newPassword}
      ];
}
