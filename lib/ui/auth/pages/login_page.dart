import 'package:chandlier/cubit/auth/auth_cubit.dart';
import 'package:chandlier/cubit/auth/auth_state.dart';
import 'package:chandlier/data/models/status/form_status.dart';
import 'package:chandlier/ui/auth/widgets/global_button.dart';
import 'package:chandlier/ui/auth/widgets/global_text_fields.dart';
import 'package:chandlier/utils/size/screen_size.dart';
import 'package:chandlier/utils/ui_utils/error_message_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.onChanged});

  final VoidCallback onChanged;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
        if(state.status == FormStatus.failure){
          showErrorMessage(message: state.statusMessage, context: context);
        }
        },
        builder: (context, state) {
          if(state.status == FormStatus.failure){
            showErrorMessage(message: state.statusMessage, context: context);
          }
          if(state.status == FormStatus.loading){
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding:  EdgeInsets.all(10.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height:  MediaQuery.of(context).size.height / 12,
                ),
                 Text('Grab a cup of',style: TextStyle(
                    color: const Color(0xFFEDE0D4),
                    fontWeight: FontWeight.w700,
                    fontSize: 28.sp),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text('coffee',
                      style: TextStyle(
                          color: const Color(0xFFE7BC91),
                          fontWeight: FontWeight.w700,
                          fontSize: 64.sp),
                    ),
                    Image.asset('assets/images/coffee.png',height: 108 * height / figmaHeight,width: 108 * width / figmaWidth,),
                  ],
                ),
                Expanded(
                  child: ListView(
                    physics: const BouncingScrollPhysics(),
                    children: [
                      SizedBox(height: height * 120 / figmaHeight,),
                      Center(child: Image.asset('assets/images/coffee_background.png',height: 61,width: 61)),
                      SizedBox(height: height * 36 / figmaHeight),
                      GlobalTextField(
                        hintText: "Email",
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        onChanged: (v) {
                          context.read<AuthCubit>().updateEmail(v);
                        },
                      ),
                       SizedBox(height: 24 * height / figmaHeight),
                      GlobalTextField(
                          hintText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onChanged: (v) {
                            context.read<AuthCubit>().updatePassword(v);
                          }
                      ),
                       SizedBox(height: height * 24 / figmaHeight),
                      GlobalButton(
                          title: "Log In",
                          onTap: () {
                            if (context.mounted) {
                              context.read<AuthCubit>().logIn(context);
                            }
                          }),
                       SizedBox(height: height * 24 / figmaHeight),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 25.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                                onPressed: () {
                                  onChanged.call();
                                },
                                child: const Text("Sign Up",
                                  style: TextStyle(color: Color(0xFFBE9173),
                                      fontSize: 18,fontWeight: FontWeight.w800),
                                )),
                          ],
                        ),
                      ),
                    SizedBox(height: height * 24 / figmaHeight,)
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
