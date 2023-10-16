import 'package:chandlier/bloc/product/product_bloc.dart';
import 'package:chandlier/bloc/product/product_event.dart';
import 'package:chandlier/bloc/product/product_state.dart';
import 'package:chandlier/data/firebase/category_service.dart';
import 'package:chandlier/data/models/category/category_model.dart';
import 'package:chandlier/data/models/coffee/coffee_model.dart';
import 'package:chandlier/data/models/universal_data.dart';
import 'package:chandlier/service/service_locator.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/auth/widgets/global_text_fields.dart';
import 'package:chandlier/ui/widgets/network_image.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:chandlier/utils/ui_utils/loading_dialog.dart';
import 'package:chandlier/utils/util_function/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String name = '';
  String price = '';
  String description = '';
  String selectedCategoryId = '';
  ImagePicker picker = ImagePicker();

  String image = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        backgroundColor: AppColors.c_0C1A30,
        elevation: 0,
        title: const Text('Add Product'),
      ),
      body: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductSuccessState) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          if (state is ProductLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      GlobalTextField(
                          hintText: 'Product name',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (v) {
                            name = v;
                          }),
                      SizedBox(height: 20 * height / figmaHeight),
                      GlobalTextField(
                          hintText: 'Product price',
                          maskFormatter: MaskTextInputFormatter(
                              mask: '######',
                              filter: {"#": RegExp(r'[0-9.]')},
                              type: MaskAutoCompletionType.lazy),
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          onChanged: (v) {
                            price = v;
                          }),
                       SizedBox(height: 20 * height / figmaHeight),
                      GlobalTextField(
                          hintText: 'Product description',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          onChanged: (v) {
                            description = v;
                          }),
                      TextButton(onPressed: () {
                            showBottomSheetDialog();
                          },
                          child: image.isEmpty? const Text('Select Image') : NetworkImageItem(image: image,imageHeight: 111,imageWidth: 111,)),
                       SizedBox(height: 24 * height / figmaHeight),
                      StreamBuilder<List<CategoryModel>>(
                        stream: getIt.get<CategoryService>().getCategories(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CategoryModel>> snapshot) {
                          if (snapshot.hasData) {
                            return snapshot.data!.isNotEmpty
                                ? SizedBox(height: 100 * height / figmaHeight,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: List.generate(
                                        snapshot.data!.length,(index) {
                                          CategoryModel categoryModel = snapshot.data![index];
                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                selectedCategoryId = categoryModel.categoryId;
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(16),
                                                color: selectedCategoryId == categoryModel.categoryId
                                                    ? Colors.green
                                                    : Colors.white,
                                              ),
                                              height: 100 * height / figmaHeight,
                                              margin:  EdgeInsets.all(16.r),
                                              padding:  EdgeInsets.all(16.r),
                                              child: Center(
                                                child: Text(categoryModel.categoryName,
                                                  style: TextStyle(
                                                    color: selectedCategoryId == categoryModel.categoryId
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  )
                                : const Center(child: Text("Empty!"));
                          }
                          if (snapshot.hasError) {
                            return Center(
                              child: Text(snapshot.error.toString()),
                            );
                          }
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ],
                  ),
                ),
                GlobalButton(
                    title: 'Add Product',
                    onTap: () {
                      if (name.isNotEmpty &&
                          price.isNotEmpty &&
                          description.isNotEmpty) {
                        context.read<ProductBloc>().add(AddProductEvent(
                            coffeeModel: CoffeeModel(
                                name: name,
                                image: image,
                                price: price,
                                description: description,
                                coffeeId: '',
                                categoryId: selectedCategoryId)));
                      }
                    }),
                SizedBox(height: 20 * height / figmaHeight),
              ],
            ),
          );
        },
      ),
    );
  }

  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF674D3F),
            borderRadius:  BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading:  Icon(Icons.photo,color: AppColors.white,),
                title:  Text("Select from Gallery",style: TextStyle(color: AppColors.white,fontSize: 16.sp,fontFamily: 'Urbanist'),),
              ),
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading:  Icon(Icons.camera_alt,color: AppColors.white,),
                title:  Text("Select from Camera",style: TextStyle(color: AppColors.white,fontSize: 16.sp,fontFamily: 'Urbanist'),),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromGallery() async {
    XFile? xFiles = await picker.pickImage(
      maxHeight: 512,
      maxWidth: 512,
      source: ImageSource.gallery,
    );
    if (xFiles != null && context.mounted) {
      showLoading(context: context);
      UniversalData data = await imageUploader(xFiles);
      image = data.data;
      setState(() {

      });
      if (context.mounted) {
        hideLoading(context: context);
      }
    } else if (context.mounted) {
      hideLoading(context: context);
    }
  }

  Future<void> _getFromCamera() async {
    XFile? xFiles = await picker.pickImage(
      maxHeight: 512,
      maxWidth: 512,
      source: ImageSource.camera,
    );
    if (xFiles != null && context.mounted) {
      showLoading(context: context);
      UniversalData data = await imageUploader(xFiles);
      image = data.data;
      setState(() {

      });
      if (context.mounted) {
        hideLoading(context: context);
      }
    } else if (context.mounted) {
      hideLoading(context: context);
    }
  }
}