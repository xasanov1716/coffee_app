import 'package:chandlier/data/models/category/category_model.dart';


abstract class CategoryEvent {}


class AddCategoryEvent extends CategoryEvent {
  final CategoryModel categoryModel;

  AddCategoryEvent({required this.categoryModel});
}


class UpdateCategoryEvent extends CategoryEvent {
  final CategoryModel categoryModel;

  UpdateCategoryEvent({required this.categoryModel});
}



class DeleteCategoryEvent extends CategoryEvent {
  final String id;

  DeleteCategoryEvent({required this.id});
}