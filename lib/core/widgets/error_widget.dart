import 'package:ebutler_task/core/utils/app_strings.dart';
import 'package:ebutler_task/core/utils/media_query_values.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  const CustomErrorWidget({Key? key, this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.warning_amber_rounded,
            size: 150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            AppStrings.somethingWentWrong,
            style: Theme.of(context).textTheme.headline2,
          ),
        ),
        Text(
          AppStrings.tryAgain,
          style: Theme.of(context).textTheme.headline3,
        ),
        Container(
          height: 55,
          width: context.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            child: const Text(
              AppStrings.reloadScreen,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}
