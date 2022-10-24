import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth.event.dart';
part 'auth.state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(const AuthState()) {
    on<ChangePhoneNumber>(onChangePhoneNumber);
    on<ChangeUid>(onChangeUid);
  }

  void onChangePhoneNumber(ChangePhoneNumber event, Emitter<AuthState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }

  FutureOr<void> onChangeUid(ChangeUid event, Emitter<AuthState> emit) {
    emit(state.copyWith(uid: event.uid));
  }
}
