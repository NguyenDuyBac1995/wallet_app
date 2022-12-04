import 'package:big_wallet/core/bloc/form.submission.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup.event.dart';
part 'signup.state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(const SignUpState()) {
    on<ChangeUid>(onChangeUid);
    on<ChangePhoneNumber>(onChangePhoneNumber);
  }

  void onChangeUid(ChangeUid event, Emitter<SignUpState> emit) {
    emit(state.copyWith(uid: event.uid));
  }

  void onChangePhoneNumber(ChangePhoneNumber event, Emitter<SignUpState> emit) {
    emit(state.copyWith(phoneNumber: event.phoneNumber));
  }
}
