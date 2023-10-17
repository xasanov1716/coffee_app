import 'package:chandlier/cubit/auth/auth_cubit.dart';
import 'package:chandlier/data/local/storage/storage_repo.dart';
import 'package:chandlier/utils/colors/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';


class ProfileScreenClient extends StatefulWidget {
  const ProfileScreenClient({super.key});

  @override
  State<ProfileScreenClient> createState() => _ProfileScreenClientState();
}

class _ProfileScreenClientState extends State<ProfileScreenClient> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.c_0C1A30,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.c_0C1A30,
        title: const Text("Profile"),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => AlertDialog(
                    title: const Text("Close your account ?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.deepPurpleAccent),
                        child: const Text(
                          "Close",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          StorageRepository.deleteString('address');
                          StorageRepository.deleteString('fullName');
                          context.read<AuthCubit>().logOutUser();
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.redAccent),
                        child: const Text(
                          "Log out",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body:  Center(child: Lottie.asset('assets/lottie/empty.json'),),
    );
  }
}
