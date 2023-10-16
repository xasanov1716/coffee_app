import 'package:chandlier/data/models/category/category_model.dart';
import 'package:flutter/material.dart';


class CategoryItemView extends StatelessWidget {
  const CategoryItemView({super.key, required this.categoryModel, required this.onTap, required this.selectedId});

  final CategoryModel categoryModel;
  final VoidCallback onTap;
  final String selectedId;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFF594A47)),
          borderRadius: BorderRadius.circular(4),
          color: const Color(0xFF0C0F14)
        ),
        height: 50,
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Text(
            categoryModel.categoryName,
            style: TextStyle(
              color: selectedId ==
                  categoryModel.categoryId
                  ? const Color(0xFFEFE3C8)
                  : const Color(0xFFEFE3C8).withOpacity(0.5),fontWeight: FontWeight.w600
            ),
          ),
        ),
      ),
    );
  }
}
