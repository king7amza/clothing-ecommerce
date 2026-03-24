import 'package:clothing_ecommerce/features/profile/views/widgets/settings_text_field_widget.dart';
import 'package:clothing_ecommerce/features/profile/views/widgets/titled_description_navigation_widget.dart';
import 'package:flutter/material.dart';

class UserSettingsPage extends StatelessWidget {
  const UserSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final TextEditingController nameController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      backgroundColor: colorScheme.surfaceContainerHighest,
      appBar: AppBar(backgroundColor: colorScheme.surfaceContainerHighest),
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.04,
          left: size.width * 0.05,
          right: size.width * 0.05,
          bottom: size.height * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Settings',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: colorScheme.secondary,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            Text(
              'Change Personal Information',
              style: Theme.of(context).textTheme.displayMedium!.copyWith(
                fontSize: size.width * 0.04,
                color: colorScheme.secondary,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: size.height * 0.02),
            SettingsTextFieldWidget(
              controller: nameController,
              lableText: 'Name',
              hintText: 'Enter your name',
            ),
            SizedBox(height: size.height * 0.02),
            SettingsTextFieldWidget(
              controller: passwordController,
              lableText: 'Password',
              hintText: 'Enter your password',
            ),
            Divider(thickness: 1, color: colorScheme.tertiary),
            TitledDescriptionNavigationWidget(
              title: 'Themes',
              description: 'more themes',
              onTap: () {
                Navigator.pushNamed(context, '/themes');
              },
            ),
          ],
        ),
      ),
    );
  }
}
