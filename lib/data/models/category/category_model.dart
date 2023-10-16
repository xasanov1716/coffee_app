class CategoryModel {
  final String categoryName;
  final String categoryId;
  final String createdAt;

  CategoryModel(
      {required this.categoryName,
      required this.createdAt,
      required this.categoryId});

  CategoryModel copyWith({
    String? categoryName,
    String? createdAt,
    String? categoryId,
  }) =>
      CategoryModel(
          categoryName: categoryName ?? this.categoryName,
          createdAt: createdAt ?? this.createdAt,
          categoryId: categoryId ?? this.categoryId);

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
      categoryName: json['categoryName'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      categoryId: json['categoryId'] as String? ?? '');

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryName': categoryName,
        'createdAt': createdAt,
      };
}
