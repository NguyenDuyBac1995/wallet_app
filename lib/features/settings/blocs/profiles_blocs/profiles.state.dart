part of 'profiles.bloc.dart';

class ProfilesBlocsState extends Equatable {
  final PrimaryModel profileDetail;

  const ProfilesBlocsState({required this.profileDetail});

  @override
  List<Object> get props => [profileDetail];
}
