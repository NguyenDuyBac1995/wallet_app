part of 'primary.bloc.dart';

class PrimaryState extends Equatable {
  final PrimaryModel primaryData;
  const PrimaryState({required this.primaryData});

  @override
  List<Object> get props => [primaryData];
}

// class PrimaryInitial extends PrimaryState {}

// class PrimaryLoader extends PrimaryState {
//   final PrimaryModel primaryData;
//   const PrimaryLoader(this.primaryData);

//   @override
//   List<Object> get props => [primaryData];
// }
