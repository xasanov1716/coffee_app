import 'package:chandlier/bloc/category/category_bloc.dart';
import 'package:chandlier/bloc/category/category_event.dart';
import 'package:chandlier/bloc/category/category_state.dart';
import 'package:chandlier/data/models/category/category_model.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/auth/widgets/global_text_fields.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        backgroundColor: AppColors.c_0C1A30,
        elevation: 0,
        title: const Text('Add Category'),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context, state) {
          if (state is CategorySuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                GlobalTextField(
                    hintText: 'Category Name',
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    onChanged: (v) {
                      name = v;
                    }),
                const Spacer(),
                GlobalButton(
                    title: 'Add Category',
                    onTap: () {
                      if (name.isNotEmpty && context.mounted) {
                        context.read<CategoryBloc>().add(AddCategoryEvent(
                            categoryModel: CategoryModel(
                                categoryName: name,
                                createdAt: DateTime.now().toString(),
                                categoryId: '')));
                      }
                    })
              ],
            ),
          );
        },
      ),
    );
  }
}
