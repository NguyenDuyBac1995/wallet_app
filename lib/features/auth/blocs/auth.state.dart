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
    this.changePassWord = false,
  });

  AuthState copyWith({
    String uid = '',
    String phoneNumber = '',
    String token = '',
    bool changePassWord = false,
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

class AuthLoading extends AuthState {}

class UpdatePasswordLoaded extends AuthState {
  final bool success;

  const UpdatePasswordLoaded({required this.success});

  @override
  List<Object> get props => [success];
}
