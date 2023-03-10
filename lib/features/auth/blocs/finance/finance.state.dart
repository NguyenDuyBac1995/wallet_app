part of 'finance.bloc.dart';

class FinanceState extends Equatable {
  final ExchangeRates exchangeRates;

  const FinanceState({required this.exchangeRates});
  // FinanceState copyWith({
  //   ExchangeRates? newData,
  // }) {
  //   return FinanceState(
  //     exchangeRates: newData ?? this.exchangeRates,
  //   );
  // }

  @override
  List<Object> get props => [exchangeRates];
}
