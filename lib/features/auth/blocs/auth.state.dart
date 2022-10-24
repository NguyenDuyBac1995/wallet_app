part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String phoneNumber;
  final String uid;
  const AuthState({this.phoneNumber = '', this.uid = ''});

  AuthState copyWith({String phoneNumber = '', String uid = ''}) {
    return AuthState(
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber,
        uid: uid.isEmpty ? this.uid : uid);
  }

  @override
  List<Object> get props => [];
}
