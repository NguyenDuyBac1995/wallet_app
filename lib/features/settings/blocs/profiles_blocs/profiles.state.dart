part of 'profiles.bloc.dart';

class ProfilesBlocsState extends Equatable {
  const ProfilesBlocsState();

  @override
  List<Object?> get props => [];
}

class ProfilesInitial extends ProfilesBlocsState {}

class ProfilesLoading extends ProfilesBlocsState {}

class ProfilesLoaded extends ProfilesBlocsState {
  final PrimaryModel profileDetail;

  const ProfilesLoaded({required this.profileDetail});

  @override
  List<Object> get props => [profileDetail];
}
