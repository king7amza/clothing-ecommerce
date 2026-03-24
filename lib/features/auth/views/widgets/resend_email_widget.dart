import 'package:flutter/material.dart';

class ResendEmailWidget extends StatelessWidget {
  final bool isLoading;
  final bool isEmailResent;
  final VoidCallback? onTap;
  const ResendEmailWidget({
    super.key,
    this.isLoading = false,
    this.onTap,
    this.isEmailResent = false,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(size.height * 0.017),
        width: size.width * 0.55,
        decoration: BoxDecoration(
          color: colorScheme.surface,
          borderRadius: BorderRadius.circular(size.height * 0.02),
        ),
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: colorScheme.primary),
              )
            : isEmailResent
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "email resent",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Icon(Icons.check, color: colorScheme.secondaryContainer),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "resend email link",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: colorScheme.secondary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: size.width * 0.02),
                  Icon(Icons.email, color: colorScheme.primary),
                ],
              ),
      ),
    );
  }
}
