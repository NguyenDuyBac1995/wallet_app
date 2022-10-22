part of 'auth.bloc.dart';

class AuthState extends Equatable {
  final String phoneNumber;
  const AuthState({this.phoneNumber = ''});

  AuthState copyWith({String phoneNumber = ''}) {
    return AuthState(
        phoneNumber: phoneNumber.isEmpty ? this.phoneNumber : phoneNumber);
  }

  @override
  List<Object> get props => [];
}
