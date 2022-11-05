import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<ChangeUid>(onChangeUid);
    on<ChangePhoneNumber>(onChangePhoneNumber);
    on<ChangeVerificationId>(onChangeVerificationId);
    on<ChangeDisplayName>(onChangeDisplayName);
    on<ChangePassword>(onChangePassword);
  }

  void onChangeUid(ChangeUid event, Emitter<AuthState> emit) {
    emit(state.copyWith(uid: event.uid));
  }

  void onChangePhoneNumber(ChangePhoneNumber event, Emitter<AuthState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void onChangeVerificationId(
      ChangeVerificationId event, Emitter<AuthState> emit) {
    emit(state.copyWith(verificationId: event.verificationId));
  }

  void onChangeDisplayName(ChangeDisplayName event, Emitter<AuthState> emit) {
    emit(state.copyWith(displayName: event.displayName));
  }

  void onChangePassword(ChangePassword event, Emitter<AuthState> emit) {
    emit(state.copyWith(password: event.password));
  }
}
