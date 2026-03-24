import 'package:clothing_ecommerce/features/profile/model/orders_states_model.dart';
import 'package:clothing_ecommerce/features/profile/view_models/profile_details_cubit/profile_details_cubit.dart';
import 'package:clothing_ecommerce/features/profile/view_models/theming_cubit/theming_cubit.dart';
import 'package:clothing_ecommerce/features/profile/views/widgets/titled_description_navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  initState() {
    super.initState();
    final themeCubit = BlocProvider.of<ThemingCubit>(context);
    themeCubit.getCurrentTheme();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final themeCubit = BlocProvider.of<ThemingCubit>(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return BlocProvider(
      create: (context) {
        final cubit = ProfileDetailsCubit();
        cubit.fetchProfileDetails();
        cubit.fetchImageFromFirestore();
        return cubit;
      },
      child: Scaffold(
        backgroundColor: colorScheme.surfaceContainerHighest,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.14,
              left: size.width * 0.05,
              right: size.width * 0.05,
              bottom: size.height * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'My Profile',
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(
                    color: colorScheme.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: size.height * 0.02),
                Row(
                  //uploadImageToCloudinary uploadImageToFirestore
                  children: [
                    BlocBuilder<ProfileDetailsCubit, ProfileDetailsState>(
                      buildWhen: (previous, current) =>
                          current is ProfileImageUploading ||
                          current is ProfileImageUploaded ||
                          current is ProfileImageUploadError ||
                          current is FetchedProfileImage ||
                          current is FetchingProfileImage ||
                          current is FetchingProfileImageError,
                      builder: (context, state) {
                        if (state is ProfileImageUploading ||
                            state is FetchingProfileImage) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.primary,
                            ),
                          );
                        } else if (state is ProfileImageUploadError) {
                          return Center(child: Text(state.message));
                        } else if (state is FetchingProfileImageError) {
                          return Center(child: Text(state.message));
                        } else if (state is ProfileImageUploaded) {
                          final userImageCubit =
                              BlocProvider.of<ProfileDetailsCubit>(context);
                          userImageCubit.fetchImageFromFirestore();
                          return CircularProgressIndicator(
                            color: colorScheme.primary,
                          );
                        } else if (state is FetchedProfileImage) {
                          return InkWell(
                            onTap: () {
                              final userImageCubit =
                                  BlocProvider.of<ProfileDetailsCubit>(context);
                              userImageCubit.uploadImageToFirestore();
                            },
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(
                                state.profileImage!,
                              ),
                              backgroundColor: colorScheme.onSurface,
                              radius: size.width * 0.08,
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () {
                            final userImageCubit =
                                BlocProvider.of<ProfileDetailsCubit>(context);
                            userImageCubit.uploadImageToFirestore();
                          },
                          child: Image.asset(
                            'assets/images/add_profile_image.png',
                            width: size.width * 0.2,
                            height: size.height * 0.2,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                    SizedBox(width: size.width * 0.05),
                    BlocBuilder<ProfileDetailsCubit, ProfileDetailsState>(
                      buildWhen: (previous, current) =>
                          current is ProfileDetailsLoading ||
                          current is ProfileDetailsLoaded ||
                          current is ProfileDetailsError,
                      builder: (context, state) {
                        if (state is ProfileDetailsLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: colorScheme.primary,
                            ),
                          );
                        } else if (state is ProfileDetailsError) {
                          return Center(child: Text(state.message));
                        } else if (state is ProfileDetailsLoaded) {
                          final userDetails = state.userDetails;
                          final userName = userDetails.name;
                          final userEmail = userDetails.email;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                userName,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .copyWith(
                                      color: colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              Text(
                                userEmail,
                                style: Theme.of(context).textTheme.labelLarge!
                                    .copyWith(
                                      color: colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      },
                    ),
                  ],
                ),
                TitledDescriptionNavigationWidget(
                  title: 'My Orders',
                  description: 'Allready have ${deliveredOrders.length} orders',
                  onTap: () {
                    Navigator.pushNamed(context, '/orders');
                  },
                ),
                Divider(thickness: 1, color: colorScheme.tertiary),
                TitledDescriptionNavigationWidget(
                  title: 'Shipping Addresses',
                  description: '3 addresses',
                  onTap: () {
                    Navigator.pushNamed(context, '/address');
                  },
                ),
                Divider(thickness: 1, color: colorScheme.tertiary),
                TitledDescriptionNavigationWidget(
                  title: 'Payment Methods',
                  description: '3 payment methods',
                  onTap: () {
                    Navigator.pushNamed(context, '/payment');
                  },
                ),
                Divider(thickness: 1, color: colorScheme.tertiary),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.dark_mode_outlined,
                          size: size.width * 0.06,
                          color: colorScheme.secondary,
                        ),
                        Text(
                          'Dark Mode',
                          style: Theme.of(context).textTheme.labelLarge!
                              .copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ],
                    ),
                    BlocBuilder<ThemingCubit, ThemingState>(
                      bloc: themeCubit,
                      buildWhen: (previous, current) =>
                          current is SwitchedToDarkTheme,
                      builder: (context, state) {
                        return Switch(
                          value: themeCubit.state is SwitchedToDarkTheme
                              ? (themeCubit.state as SwitchedToDarkTheme)
                                    .isDarkMode
                              : false,
                          onChanged: (value) {
                            themeCubit.toggleToDarkTheme();
                          },
                          activeThumbColor: colorScheme.primary,
                        );
                      },
                    ),
                  ],
                ),
                Divider(thickness: 1, color: colorScheme.tertiary),
                TitledDescriptionNavigationWidget(
                  title: 'Settings',
                  description: 'Notifications, Password, Language, More',
                  onTap: () {
                    Navigator.pushNamed(context, '/settings');
                  },
                ),
                Divider(thickness: 1, color: colorScheme.tertiary),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
