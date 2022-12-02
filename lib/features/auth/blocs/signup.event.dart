part of 'signup.bloc.dart';

class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class ChangeUid extends SignUpEvent {
  final String uid;
  const ChangeUid(this.uid);
  @override
  List<Object> get props => [
        {uid: uid}
      ];
}

class ChangePhoneNumber extends SignUpEvent {
  final String phoneNumber;
  const ChangePhoneNumber(this.phoneNumber);
  @override
  List<Object> get props => [
        {phoneNumber: phoneNumber}
      ];
}
