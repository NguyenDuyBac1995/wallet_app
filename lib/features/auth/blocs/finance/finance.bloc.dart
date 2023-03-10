import 'package:big_wallet/features/auth/model/exchangeRates.model.dart';
import 'package:big_wallet/features/auth/repositories/auth.repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'finance.event.dart';
part 'finance.state.dart';

class FinanceBloc extends Bloc<FinanceEvent, FinanceState> {
  FinanceBloc()
      : super(FinanceState(
          exchangeRates: ExchangeRates(),
        )) {
    on<GetFinance>(onFinance);
  }
  void onFinance(GetFinance event, Emitter<FinanceState> emit) async {
    final AuthRepository apiRepository = AuthRepository();
    final finance = await apiRepository.getExchangeRatesAsync(event.context);
    emit(FinanceState(
      exchangeRates: finance,
    ));
  }
}
