part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String uid;
  final String phoneNumber;
  final String token;
  const AuthState({this.uid = '', this.phoneNumber = '', this.token = ''});

  AuthState copyWith(
      {String uid = '', String phoneNumber = '', String token = ''}) {
    return AuthState(
        uid: uid.isEmpty ? this.uid : uid,
        token: token.isEmpty ? this.token : token,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber);
  }

  @override
  List<Object> get props => [phoneNumber, uid, token];
}
