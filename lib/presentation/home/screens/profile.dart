import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/home/cubits/profile_cubit/profile_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/update_profile_name_cubit/update_profile_name_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';
import 'package:gemini_app/presentation/home/screens/profile_content.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<UpdateProfileNameCubit>(
            create: (context) => UpdateProfileNameCubit(
                userId: context.read<ProfileCubit>().state.user.userId),
          ),
          BlocProvider<UpdateProfilePictureCubit>(
            create: (context) => UpdateProfilePictureCubit(
                userId: context.read<ProfileCubit>().state.user.userId),
          ),
        ],
        child: const ProfileContent(),
      ),
    );
  }
}
