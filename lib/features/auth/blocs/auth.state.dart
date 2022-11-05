part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String uid;
  final String phoneNumber;
  final String verificationId;
  final String displayName;
  final String password;
  const AuthState(
      {this.uid = '',
      this.phoneNumber = '',
      this.verificationId = '',
      this.displayName = '',
      this.password = ''});

  AuthState copyWith(
      {String uid = '',
      String phoneNumber = '',
      String verificationId = '',
      String displayName = '',
      String password = ''}) {
    return AuthState(
        uid: uid.isEmpty ? this.uid : uid,
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber,
        verificationId:
            verificationId.isEmpty ? this.verificationId : verificationId,
        displayName: displayName.isEmpty ? this.displayName : displayName,
        password: password.isEmpty ? this.password : password);
  }

  @override
  List<Object> get props => [];
}
