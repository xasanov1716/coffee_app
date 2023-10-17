import 'package:chandlier/bloc/category/category_bloc.dart';
import 'package:chandlier/bloc/category/category_event.dart';
import 'package:chandlier/bloc/category/category_state.dart';
import 'package:chandlier/data/models/category/category_model.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/auth/widgets/global_text_fields.dart';
import 'package:chandlier/utils/ui_utils/error_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class UpdateCategoryScreen extends StatefulWidget {
  const UpdateCategoryScreen({Key? key, required this.categoryModel}) : super(key: key);


  final CategoryModel categoryModel;

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {


  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.categoryModel.categoryName;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: BlocConsumer<CategoryBloc, CategoryState>(
        listener: (context,state){
          if (state is CategorySuccessState) {
            Navigator.pop(context);
          }
          if(state is CategoryErrorState){
            showErrorMessage(message: state.errorText, context: context);
          }
        },
        builder: (context, state) {
          if (state is CategoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
              GlobalTextField(hintText: 'Category Name',
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.done,
                  controller: controller,
                  onChanged: (v) {}),
              const Spacer(),
              GlobalButton(title: 'Update Category', onTap: () {
                if (controller.text.isNotEmpty && context.mounted) {
                  context.read<CategoryBloc>().add(UpdateCategoryEvent(
                      categoryModel: CategoryModel(
                          categoryName: controller.text, createdAt: DateTime.now()
                          .toString(), categoryId: widget.categoryModel.categoryId)));

                }
              })
            ],
          );
        },
      ),
    );
  }
}
