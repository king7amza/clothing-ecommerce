import 'package:clothing_ecommerce/core/utils/themes/app_colors.dart';
import 'package:clothing_ecommerce/features/profile/views/widgets/titled_description_navigation_widget.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: AppColors.lightGrey1,
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
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Image.asset(
                    'assets/images/add_profile_image.png',
                    width: size.width * 0.2,
                    height: size.height * 0.2,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: size.width * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hamza Hossam',
                        style: Theme.of(context).textTheme.headlineMedium!
                            .copyWith(
                              color: AppColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Text(
                        'hamza.says2017@gmail.com',
                        style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: AppColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              TitledDescriptionNavigationWidget(
                title: 'My Orders',
                description: 'Allready have 12 orders',
                onTap: () {
                  Navigator.pushNamed(context, '/orders');
                },
              ),
              Divider(thickness: 1, color: AppColors.lightGrey3),
              TitledDescriptionNavigationWidget(
                title: 'Shipping Addresses',
                description: '3 addresses',
                onTap: () {
                  Navigator.pushNamed(context, '/address');
                },
              ),
              Divider(thickness: 1, color: AppColors.lightGrey3),
              TitledDescriptionNavigationWidget(
                title: 'Payment Methods',
                description: '3 payment methods',
                onTap: () {
                  Navigator.pushNamed(context, '/payment');
                },
              ),
              Divider(thickness: 1, color: AppColors.lightGrey3),
              TitledDescriptionNavigationWidget(
                title: 'Settings',
                description: 'Notifications, Password, Language, More',
                onTap: () {
                  Navigator.pushNamed(context, '/settings');
                },
              ),
              Divider(thickness: 1, color: AppColors.lightGrey3),
            ],
          ),
        ),
      ),
    );
  }
}
