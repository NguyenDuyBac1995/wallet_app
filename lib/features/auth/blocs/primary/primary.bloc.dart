import 'package:big_wallet/features/auth/model/primary.model.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
part 'primary.state.dart';
part 'primary.event.dart';

class PrimaryBloc extends Bloc<PrimaryEvent, PrimaryState> {
  PrimaryBloc() : super(PrimaryState(primaryData: PrimaryModel())) {
    on<GetPrimary>(onChangePrimary);
  }

  void onChangePrimary(GetPrimary event, Emitter<PrimaryState> emit) async {
    final AuthRepository apiRepository = AuthRepository();
    final dataPrimary = await apiRepository.getPrimaryAsync(event.context);
    emit(PrimaryState(primaryData: dataPrimary));
  }
}
