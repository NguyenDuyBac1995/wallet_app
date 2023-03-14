part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String uid;
  final String phoneNumber;
  final String token;
  final bool changePassWord;
  const AuthState({
    this.uid = '',
    this.phoneNumber = '',
    this.token = '',
    this.changePassWord = true,
  });

  AuthState copyWith({
    String uid = '',
    String phoneNumber = '',
    String token = '',
    bool changePassWord = true,
  }) {
    return AuthState(
        uid: uid.isEmpty ? this.uid : uid,
        token: token.isEmpty ? this.token : token,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber,
        changePassWord: changePassWord ? this.changePassWord : changePassWord);
  }

  @override
  List<Object> get props => [phoneNumber, uid, token, changePassWord];
}
