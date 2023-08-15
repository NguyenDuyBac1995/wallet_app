import 'package:big_wallet/core/repositories/base.repository.dart';
import 'package:big_wallet/features/transaction/model/categorys_model.dart';
import 'package:big_wallet/features/transaction/repositories/category.repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'category_blocs_event.dart';
part 'category_blocs_state.dart';

class CategoriesBlocsBloc
    extends Bloc<CategoriesBlocsEvent, CategoriesBlocsState> {
  CategoriesBlocsBloc() : super(CategoriesBlocsInitial()) {
    on<GetCategoriesIcon>(onGetCategoriesIcon);
    on<GetCategories>(onGetCategories);
    on<GetDetailCategories>(onGetCategoriesDetail);
    on<CreateCategoriesState>(onCreateCategories);
    on<EditCategoriesState>(onEditCategories);
    on<DeleteCategoriesState>(onDeleteCategories);
  }
}

void onGetCategoriesIcon(
    GetCategoriesIcon event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCategoriesIcon = await categoryRepository.getListCategoryIcon(
        event.context, event.search);
    emit(CategoriesIconLoaded(dataCategoriesIcon: dataCategoriesIcon));
  } on NetworkError {
    print("Error");
  }
}

void onGetCategories(
    GetCategories event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCategories = await categoryRepository.getListCategory(
        event.context, event.filterCategories);
    emit(CategoriesLoaded(dataCategories: dataCategories));
  } on NetworkError {
    print("Error");
  }
}

void onGetCategoriesDetail(
    GetDetailCategories event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCategoriesDetail = await categoryRepository.getCategoryDetail(
        event.context, event.idCategories);
    emit(CategoriesDetailLoaded(dataCategoriesDetail: dataCategoriesDetail));
  } on NetworkError {
    print("Error");
  }
}

void onCreateCategories(
    CreateCategoriesState event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCreateCategories = await categoryRepository.postListCategory(
        event.context, event.requestCategories);
    emit(CreateCategoriesLoaded(isSuccess: dataCreateCategories));
  } on NetworkError {
    print("Error");
  }
}

void onEditCategories(
    EditCategoriesState event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCreateCategories = await categoryRepository.putListCategory(
        event.context, event.requestPutCategories);
    emit(EditCategoriesLoaded(isSuccess: dataCreateCategories));
  } on NetworkError {
    print("Error");
  }
}

void onDeleteCategories(
    DeleteCategoriesState event, Emitter<CategoriesBlocsState> emit) async {
  try {
    final CategoryRepository categoryRepository = CategoryRepository();
    emit(CategoriesLoading());
    final dataCreateCategories = await categoryRepository.deleteListCategory(
        event.context, event.idCategories);
    emit(DeleteCategoriesLoaded(isSuccess: dataCreateCategories));
  } on NetworkError {
    print("Error");
  }
}
