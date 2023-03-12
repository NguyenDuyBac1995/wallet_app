import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/features/auth/model/primary.model.dart';
import 'package:big_wallet/features/settings/repositories/profile.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

part 'profiles.event.dart';
part 'profiles.state.dart';

class ProfilesBloc extends Bloc<ProfilesBlocsEvent, ProfilesBlocsState> {
  ProfilesBloc() : super(ProfilesInitial()) {
    on<IdProfile>(onGetDetailProfile);
  }
}

void onGetDetailProfile(
    IdProfile event, Emitter<ProfilesBlocsState> emit) async {
  try {
    emit(ProfilesLoading());
    final ProfileRepository profileRepository = ProfileRepository();
    final dataDetailProfile =
        await profileRepository.detailProfileAsync(event.context, event.id);
    emit(ProfilesLoaded(profileDetail: dataDetailProfile));
  } on NetworkError {
    print("Error");
  }
}
