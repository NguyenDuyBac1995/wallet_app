import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/features/auth/model/ForgotPassword.model.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<UidChanged>(onChangeUid);
    on<PhoneNumberChanged>(onChangePhoneNumber);
    on<TokenChanged>(onChangeToken);
    on<ResetPassword>(onChangeRestPassword);
    on<ChangePassword>(onChangeChangePassword);
  }

  void onChangeUid(UidChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(uid: event.uid));
  }

  void onChangePhoneNumber(PhoneNumberChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  void onChangeToken(TokenChanged event, Emitter<AuthState> emit) async {
    String emailAddress = event.token;
    emit(state.copyWith(token: emailAddress));
  }

  void onChangeRestPassword(
      ResetPassword event, Emitter<AuthState> emit) async {
    final AuthRepository apiRepository = AuthRepository();
    await apiRepository.postResetPassword(event.context, event.newPassword);
  }

  void onChangeChangePassword(
      ChangePassword event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final AuthRepository apiRepository = AuthRepository();
      var changePassWord = await apiRepository.changePassword(
          event.context, event.changePassword);
      emit(UpdatePasswordLoaded(success: changePassWord));
    } on NetworkError {
      print("Error");
    }
  }
}
