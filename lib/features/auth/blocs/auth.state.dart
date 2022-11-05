part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String uid;
  final String phoneNumber;
  final String displayName;
  final String password;
  const AuthState(
      {this.uid = '',
      this.phoneNumber = '',
      this.displayName = '',
      this.password = ''});

  AuthState copyWith(
      {String uid = '',
      String phoneNumber = '',
      String displayName = '',
      String password = ''}) {
    return AuthState(
        uid: uid.isEmpty ? this.uid : uid,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber,
        displayName: displayName.isEmpty ? this.displayName : displayName,
        password: password.isEmpty ? this.password : password);
  }

  @override
  List<Object> get props => [];
}
