import 'package:flutter/material.dart';

import '/src/global/global.dart';

class SettingListTile extends StatelessWidget {
  SettingListTile({
    super.key,
    required this.title,
    required this.icon,
    this.leading,
    this.buttonText,
    this.onPressed,
    this.buttonStyle,
  }) {
    assert(title.isNotEmpty, 'title must not be empty');
    if (leading == null) {
      assert(buttonText != null, 'buttonText must not be null');
      // assert(onPressed != null, 'onPressed must not be null');
    }

    assert(leading == null || buttonText == null,
        'leading and buttonText must not be used together');

    if (leading != null) {
      assert(onPressed == null, 'onPressed must not be used with leading');
    }
  }

  final String title;
  final IconData icon;
  final Widget? leading;
  final String? buttonText;
  final void Function()? onPressed;
  final ButtonStyle? buttonStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: <Widget>[
            Icon(icon),
            const SizedBox(width: 10),
            Text(title, style: context.textTheme.labelLarge),
          ],
        ),
        leading == null
            ? TextButton(
                style: buttonStyle,
                onPressed: onPressed,
                child: Text(buttonText ?? 'Button'))
            : leading!,
      ],
    );
  }
}
