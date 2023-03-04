part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String uid;
  final String phoneNumber;
  const AuthState({this.uid = '', this.phoneNumber = ''});

  AuthState copyWith({String uid = '', String phoneNumber = ''}) {
    return AuthState(
        uid: uid.isEmpty ? this.uid : uid,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber);
  }

  @override
  List<Object> get props => [phoneNumber, uid];
}
