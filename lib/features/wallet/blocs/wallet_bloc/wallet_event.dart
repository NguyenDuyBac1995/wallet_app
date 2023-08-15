part of 'wallet_bloc.dart';

class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object> get props => [];
}

class GetListWalletEvent extends WalletEvent {
  final BuildContext context;
  final String filterWallet;
  const GetListWalletEvent(this.context, this.filterWallet);

  @override
  List<Object> get props => [filterWallet];
}

class GetByIdWalletEvent extends WalletEvent {
  final BuildContext context;
  final String idWallet;
  const GetByIdWalletEvent(this.context, this.idWallet);

  @override
  List<Object> get props => [idWallet];
}

class CreateWalletEvent extends WalletEvent {
  final BuildContext context;
  final RequestCreateWallet requestCreateWallet;
  const CreateWalletEvent(this.context, this.requestCreateWallet);

  @override
  List<Object> get props => [requestCreateWallet];
}

class UpdateWalletEvent extends WalletEvent {
  final BuildContext context;
  final RequestUpdateWallet requestUpdateWallet;
  const UpdateWalletEvent(this.context, this.requestUpdateWallet);

  @override
  List<Object> get props => [requestUpdateWallet];
}
