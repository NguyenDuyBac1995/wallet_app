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

class ListProfilesLoaded extends ProfilesBlocsState {
  final List<PrimaryModel> dataProfiles;
  const ListProfilesLoaded({required this.dataProfiles});
  @override
  List<Object> get props => [dataProfiles];
}

class CreateProfileLoaded extends ProfilesBlocsState {
  final bool isSuccess;
  const CreateProfileLoaded({required this.isSuccess});
  @override
  List<Object> get props => [isSuccess];
}
