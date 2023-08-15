part of 'category_blocs_bloc.dart';

class CategoriesBlocsState extends Equatable {
  const CategoriesBlocsState();

  @override
  List<Object> get props => [];
}

class CategoriesBlocsInitial extends CategoriesBlocsState {}

class CategoriesLoading extends CategoriesBlocsState {}

class CategoriesIconLoaded extends CategoriesBlocsState {
  final List<ResponseCategoriesIcon> dataCategoriesIcon;
  const CategoriesIconLoaded({required this.dataCategoriesIcon});

  @override
  List<Object> get props => [dataCategoriesIcon];
}

class CategoriesLoaded extends CategoriesBlocsState {
  final List<ResponseCategories> dataCategories;
  const CategoriesLoaded({required this.dataCategories});

  @override
  List<Object> get props => [dataCategories];
}

class CategoriesDetailLoaded extends CategoriesBlocsState {
  final ResponseCategories dataCategoriesDetail;
  const CategoriesDetailLoaded({required this.dataCategoriesDetail});

  @override
  List<Object> get props => [dataCategoriesDetail];
}

class CreateCategoriesLoaded extends CategoriesBlocsState {
  final bool isSuccess;
  const CreateCategoriesLoaded({required this.isSuccess});
  @override
  List<Object> get props => [isSuccess];
}

class EditCategoriesLoaded extends CategoriesBlocsState {
  final bool isSuccess;
  const EditCategoriesLoaded({required this.isSuccess});
  @override
  List<Object> get props => [isSuccess];
}

class DeleteCategoriesLoaded extends CategoriesBlocsState {
  final bool isSuccess;
  const DeleteCategoriesLoaded({required this.isSuccess});
  @override
  List<Object> get props => [isSuccess];
}
