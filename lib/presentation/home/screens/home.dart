import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/domain/entities/user.dart';
import 'package:gemini_app/presentation/auth/cubits/auth_cubit/auth_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/profile_cubit/profile_cubit.dart';
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
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.kPrimaryColor,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                return _buildHeader(state.user);
              },
            ),
            _buildItem(
              icon: Icons.account_circle,
              title: 'View Profile',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
            _buildItem(
              icon: Icons.exit_to_app,
              title: 'Sign Out',
              onTap: () {
                context.read<AuthCubit>().signOut();
              },
            ),
          ],
        ),
      ),
      body: const HomeContent(),
    );
  }

  _buildHeader(UserEntity user) {
    return DrawerHeader(
      decoration: const BoxDecoration(
        color: AppColors.kPrimaryColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.profilePictureUrl.isNotEmpty
                ? NetworkImage(user.profilePictureUrl)
                : const AssetImage('assets/images/default-profile-picture.png')
                    as ImageProvider,
          ),
          const SizedBox(height: 5),
          Text(
            user.name,
            style: const TextStyle(
              color: AppColors.kWhiteColor,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }

  _buildItem(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }
}
