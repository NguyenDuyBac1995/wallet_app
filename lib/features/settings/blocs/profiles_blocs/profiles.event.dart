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
