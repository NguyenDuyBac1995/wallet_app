part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final ResponseWallet responseWallet;
  const WalletLoaded({required this.responseWallet});

  @override
  List<Object> get props => [responseWallet];
}

class WalletByIdLoaded extends WalletState {
  final ResponseWalletById responseWalletById;
  const WalletByIdLoaded({required this.responseWalletById});

  @override
  List<Object> get props => [responseWalletById];
}

class CreateWalletLoaded extends WalletState {
  final bool isSuccess;
  const CreateWalletLoaded({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}

class UpdateWalletLoaded extends WalletState {
  final bool isSuccess;
  const UpdateWalletLoaded({required this.isSuccess});

  @override
  List<Object> get props => [isSuccess];
}
