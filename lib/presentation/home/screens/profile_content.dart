import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:gemini_app/core/configs/theme/app_colors.dart';
import 'package:gemini_app/presentation/home/cubits/profile_cubit/profile_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/update_profile_name_cubit/update_profile_name_cubit.dart';
import 'package:gemini_app/presentation/home/cubits/update_profile_picture_cubit/update_profile_picture_cubit.dart';

class ProfileContent extends StatefulWidget {
  const ProfileContent({super.key});

  @override
  State<ProfileContent> createState() => _ProfileContentState();
}

class _ProfileContentState extends State<ProfileContent> {
  @override
  Widget build(BuildContext context) {
    bool updateNameAttempted = false;

    void didAttemptToUpdateName() {
      setState(() {
        updateNameAttempted = !updateNameAttempted;
      });
    }

    return BlocListener<UpdateProfileNameCubit, UpdateProfileNameState>(
      listener: (context, state) {
        if (updateNameAttempted && state.status.isFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Profile Update Failure'),
              ),
            );
          didAttemptToUpdateName();
        }
      },
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SingleChildScrollView(
                    child: BlocBuilder<ProfileCubit, ProfileState>(
                      builder: (context, state) {
                        return Column(
                          children: [
                            const SizedBox(height: 20),
                            Align(
                              alignment: Alignment.topCenter,
                              child: Stack(
                                children: [
                                  CircleAvatar(
                                    radius: 90,
                                    backgroundImage: state
                                            .user.profilePictureUrl.isNotEmpty
                                        ? NetworkImage(
                                            state.user.profilePictureUrl)
                                        : const AssetImage(
                                                'assets/images/default-profile-picture.png')
                                            as ImageProvider,
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: AppColors.kPrimaryColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(Icons.edit),
                                        color: AppColors.kLightGreyColor,
                                        onPressed: () {
                                          context
                                              .read<UpdateProfilePictureCubit>()
                                              .updateProfilePicture();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: _NameEditBox(name: state.user.name),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NameEditBox extends StatelessWidget {
  const _NameEditBox({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditNameDialog(context),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.kLightGreyColor),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 20,
                      color: AppColors.kLightGreyColor,
                    ),
              ),
              const Icon(Icons.edit, color: AppColors.kLightGreyColor),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditNameDialog(BuildContext context) {
    final updateProfileCubit = context.read<UpdateProfileNameCubit>();

    showDialog(
      context: context,
      builder: (context) {
        return BlocProvider.value(
          value: updateProfileCubit,
          child: AlertDialog(
            title: const Text('Edit Name'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _NameInput(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        updateProfileCubit.updateProfileName();
                        Navigator.of(context).pop();
                      },
                      child: const Text('Confirm'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpdateProfileNameCubit, UpdateProfileNameState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return TextField(
          key: const Key('profileContent_nameInput_textField'),
          onChanged: (name) =>
              context.read<UpdateProfileNameCubit>().nameChanged(name),
          keyboardType: TextInputType.name,
          decoration: InputDecoration(
            hintText: 'Name',
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.kTextFieldColor,
                ),
            helperText: '',
            errorText: state.name.displayError != null ? 'Invalid name' : null,
          ),
        );
      },
    );
  }
}
