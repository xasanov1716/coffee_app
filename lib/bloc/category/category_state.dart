

abstract class CategoryState {}

class CategoryInitial extends CategoryState {}


class CategoryLoadingState extends CategoryState {}


class CategoryErrorState extends CategoryState {
  final String errorText;

  CategoryErrorState({required this.errorText});
}


class CategorySuccessState extends CategoryState {

  CategorySuccessState();
}