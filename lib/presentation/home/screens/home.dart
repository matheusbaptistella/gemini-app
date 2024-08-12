import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/presentation/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/profile_cubit/profile_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/story_cubit/story_cubit.dart';
import 'package:gemini_app/presentation/home/screens/home_content.dart';
import 'package:gemini_app/presentation/home/screens/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: screenWidth <= 600
          ? AppBar(
              backgroundColor: AppColors.kPrimaryColor,
            )
          : null,
      drawer: screenWidth <= 600
          ? BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return _buildDrawer(user: state.user);
              },
            )
          : null,
      body: Row(
        children: [
          screenWidth > 600
              ? Expanded(
                  flex: 1,
                  child: BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      return _buildDrawer(user: state.user);
                    },
                  ),
                )
              : const SizedBox(width: 0),
          Expanded(
            flex: 5,
            child: BlocProvider<StoryCubit>(
              create: (context) => StoryCubit(),
              child: const HomeContent(),
            ),
          ),
        ],
      ),
    );
  }

  _buildDrawer({required UserEntity user}) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _buildHeader(user: user),
          Column(
            children: [
              screenWidth > 1024 || screenWidth <= 600
                  ? ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text('View Profile'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProfileScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.account_circle),
                      iconSize: 40,
                    ),
              const SizedBox(height: 20),
              screenWidth > 1024 || screenWidth <= 600
                  ? ListTile(
                      leading: const Icon(Icons.exit_to_app),
                      title: const Text('Sign Out'),
                      onTap: () {
                        context.read<AuthCubit>().signOut();
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        context.read<AuthCubit>().signOut();
                      },
                      icon: const Icon(Icons.exit_to_app),
                      iconSize: 40,
                    ),
            ],
          ),
        ],
      ),
    );
  }

  _buildHeader({required UserEntity user}) {
    final screenWidth = MediaQuery.sizeOf(context).width;

    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryColor,
      ),
      child: screenWidth > 1024 || screenWidth <= 600
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profilePictureUrl.isNotEmpty
                      ? NetworkImage(user.profilePictureUrl)
                      : const AssetImage(
                              'assets/images/default-profile-picture.png')
                          as ImageProvider,
                ),
                const SizedBox(height: 5),
                Text(
                  user.name,
                  style: const TextStyle(
                    color: AppColors.kLightGreyColor,
                    fontSize: 20,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: user.profilePictureUrl.isNotEmpty
                      ? NetworkImage(user.profilePictureUrl)
                      : const AssetImage(
                              'assets/images/default-profile-picture.png')
                          as ImageProvider,
                ),
              ],
            ),
    );
  }
}
