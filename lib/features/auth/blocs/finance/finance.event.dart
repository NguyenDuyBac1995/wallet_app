part of 'finance.bloc.dart';

class FinanceEvent extends Equatable {
  const FinanceEvent();

  @override
  List<Object> get props => [];
}

class GetFinance extends FinanceEvent {
  final BuildContext context;
  final List<dynamic> symbols;

  const GetFinance(this.context, this.symbols);

  @override
  List<Object> get props => [
        {symbols}
      ];
}
