import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final Widget? child;

  MainButton({super.key, this.text, this.onTap, this.child}) {
    assert(text != null || child != null);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        child: text != null
            ? Text(
                text!,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium!
                    .copyWith(color: Colors.white),
              )
            : child,
      ),
    );
  }
}
