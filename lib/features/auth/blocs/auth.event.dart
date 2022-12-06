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
