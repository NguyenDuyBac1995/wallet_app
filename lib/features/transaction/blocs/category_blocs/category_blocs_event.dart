part of 'category_blocs_bloc.dart';

class CategoriesBlocsEvent extends Equatable {
  const CategoriesBlocsEvent();

  @override
  List<Object> get props => [];
}

class GetCategoriesIcon extends CategoriesBlocsEvent {
  final BuildContext context;
  final String search;
  const GetCategoriesIcon(this.context, this.search);

  @override
  List<Object> get props => [search];
}

class GetCategories extends CategoriesBlocsEvent {
  final BuildContext context;
  final String filterCategories;
  const GetCategories(this.context, this.filterCategories);

  @override
  List<Object> get props => [filterCategories];
}

class GetDetailCategories extends CategoriesBlocsEvent {
  final BuildContext context;
  final String idCategories;
  const GetDetailCategories(this.context, this.idCategories);

  @override
  List<Object> get props => [idCategories];
}

class CreateCategoriesState extends CategoriesBlocsEvent {
  final BuildContext context;
  final RequestCategories requestCategories;
  const CreateCategoriesState(this.context, this.requestCategories);

  @override
  List<Object> get props => [requestCategories];
}

class EditCategoriesState extends CategoriesBlocsEvent {
  final BuildContext context;
  final RequestPutCategories requestPutCategories;
  const EditCategoriesState(this.context, this.requestPutCategories);

  @override
  List<Object> get props => [requestPutCategories];
}

class DeleteCategoriesState extends CategoriesBlocsEvent {
  final BuildContext context;
  final String idCategories;
  const DeleteCategoriesState(this.context, this.idCategories);

  @override
  List<Object> get props => [idCategories];
}
