part of 'primary.bloc.dart';

abstract class PrimaryState extends Equatable {
  const PrimaryState();

  List<Object> get props => [];
}

class PrimaryInitial extends PrimaryState {}

class PrimaryLoader extends PrimaryState {
  final PrimaryModel primaryData;
  const PrimaryLoader(this.primaryData);

  @override
  List<Object> get props => [primaryData];
}
