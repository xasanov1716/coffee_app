import 'package:chandlier/bloc/category/category_bloc.dart';
import 'package:chandlier/bloc/product/product_bloc.dart';
import 'package:chandlier/cubit/auth/auth_cubit.dart';
import 'package:chandlier/data/repositories/auth_repository.dart';
import 'package:chandlier/provider/order_provider.dart';
import 'package:chandlier/ui/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'service/service_locator.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  getItSetup();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => AuthRepository()),
      ],
      child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context)=>CategoryBloc()),
            BlocProvider(create: (context)=>ProductBloc()),
            BlocProvider(
                create: (context) => AuthCubit(context.read<AuthRepository>()))
          ],
          child: MultiProvider(
            providers: [ChangeNotifierProvider(create: (_) => OrderProvider())],
            child: const MainApp(),
          )),
    );
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
