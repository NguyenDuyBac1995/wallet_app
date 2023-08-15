import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/features/wallet/model/wallets_model.dart';
import 'package:big_wallet/features/wallet/repositories/requests/wallets_requests.dart';
import 'package:big_wallet/features/wallet/repositories/wallet.repositories.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletInitial()) {
    on<GetListWalletEvent>(onGetWallet);
    on<GetByIdWalletEvent>(onGetByIdWallet);
    on<CreateWalletEvent>(onCreateWallet);
    on<UpdateWalletEvent>(onUpdateWallet);
  }
}

void onGetWallet(GetListWalletEvent event, Emitter<WalletState> emit) async {
  try {
    final WalletRepository walletRepository = WalletRepository();
    emit(WalletLoading());
    final dataResponseWallet = await walletRepository.getListWalletsAsync(
        event.context, event.filterWallet);
    emit(WalletLoaded(responseWallet: dataResponseWallet));
  } on NetworkError {
    print("Error");
  }
}

void onGetByIdWallet(
    GetByIdWalletEvent event, Emitter<WalletState> emit) async {
  try {
    final WalletRepository walletRepository = WalletRepository();
    emit(WalletLoading());
    final dataResponseWallet = await walletRepository.getWalletByIdAsync(
        event.context, event.idWallet);
    emit(WalletByIdLoaded(responseWalletById: dataResponseWallet));
  } on NetworkError {
    print("Error");
  }
}

void onCreateWallet(CreateWalletEvent event, Emitter<WalletState> emit) async {
  try {
    final WalletRepository walletRepository = WalletRepository();
    emit(WalletLoading());
    final dataResponseWallet = await walletRepository.createWalletAsync(
        event.context, event.requestCreateWallet);
    emit(CreateWalletLoaded(isSuccess: dataResponseWallet));
  } on NetworkError {
    print("Error");
  }
}

void onUpdateWallet(UpdateWalletEvent event, Emitter<WalletState> emit) async {
  try {
    final WalletRepository walletRepository = WalletRepository();
    emit(WalletLoading());
    final dataResponseWallet = await walletRepository.updateWalletAsync(
        event.context, event.requestUpdateWallet);
    emit(UpdateWalletLoaded(isSuccess: dataResponseWallet));
  } on NetworkError {
    print("Error");
  }
}
