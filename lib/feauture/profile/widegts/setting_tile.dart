import 'package:flutter/material.dart';

import '../../../core/constants/color_manager.dart';

class SettingsTile extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const SettingsTile({super.key, required this.title, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: ColorManager.darkestGrey),
      title: Text(title,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontSize: 14,
                color: ColorManager.darkestGrey,
              )

      ),
      trailing:  Icon(Icons.chevron_right, color: ColorManager.darkGrey),
      onTap: onTap,
    );
  }
}
