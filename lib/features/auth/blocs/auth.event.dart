part of 'auth.bloc.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class ChangeUid extends AuthEvent {
  final String uid;
  const ChangeUid(this.uid);
  @override
  List<Object> get props => [
        {uid: uid}
      ];
}

class ChangePhoneNumber extends AuthEvent {
  final String phoneNumber;
  const ChangePhoneNumber(this.phoneNumber);
  @override
  List<Object> get props => [
        {phoneNumber: phoneNumber}
      ];
}
