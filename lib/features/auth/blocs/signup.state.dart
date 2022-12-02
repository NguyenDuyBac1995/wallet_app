part of 'signup.bloc.dart';

class SignUpState extends Equatable {
  final String uid;
  final String phoneNumber;
  const SignUpState({this.uid = '', this.phoneNumber = ''});

  SignUpState copyWith({String uid = '', String phoneNumber = ''}) {
    return SignUpState(
        uid: uid.isEmpty ? this.uid : uid,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber);
  }

  @override
  List<Object> get props => [];
}
