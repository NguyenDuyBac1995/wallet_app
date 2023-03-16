part of 'profiles.bloc.dart';

class ProfilesBlocsEvent extends Equatable {
  const ProfilesBlocsEvent();

  @override
  List<Object> get props => [];
}

class IdProfile extends ProfilesBlocsEvent {
  final BuildContext context;
  final String id;
  const IdProfile(
    this.context,
    this.id,
  );
  @override
  List<Object> get props => [
        {id: id}
      ];
}

class ListProfiles extends ProfilesBlocsEvent {
  final BuildContext context;
  const ListProfiles(this.context);
  @override
  List<Object> get props => [];
}

class CreateProfile extends ProfilesBlocsEvent {
  final BuildContext context;
  final CreateProfilesRequest data;
  const CreateProfile(this.context, this.data);
  @override
  List<Object> get props => [data];
}
