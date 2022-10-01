import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'splash.event.dart';
part 'splash.state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final ConfigurationRepository configurationRepository;
  SplashBloc(
    this.configurationRepository,
  ) : super(const SplashState()) {
    on<LoadConfigurationEvent>(onLoadConfiguration);
  }

  void onLoadConfiguration(
      LoadConfigurationEvent event, Emitter<SplashState> emit) async {
    List<Configuration>? configurations =
        await configurationRepository.getConfigurationsAsync();
    Logger().i(configurations);
    emit(state.copy(loadingPercent: 100));
  }
}
