part of 'primary.bloc.dart';

abstract class PrimaryEvent extends Equatable {
  const PrimaryEvent();

  List<Object> get props => [];
}

class GetPrimary extends PrimaryEvent {
  final BuildContext context;
  const GetPrimary(
    this.context,
  );
  @override
  List<Object> get props => [];
}
