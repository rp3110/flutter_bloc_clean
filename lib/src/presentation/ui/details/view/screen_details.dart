import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../utils/app_colors.dart';
import '../../../../utils/app_dimens.dart';
import '../../../../utils/app_images.dart';

class ScreenDetails extends StatelessWidget {
  final String demoText;

  const ScreenDetails({Key? key, required this.demoText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            color: AppColors.primaryWhite,
            child: const Text("test"),
          ),
          Container(
            color: AppColors.primaryWhite,
            child: Text(demoText),
          ),
          SvgPicture.asset(
            AppImages.demoImage,
            width: Dimens.margin100,
            height: Dimens.margin100,
            fit: BoxFit.fill,
          ),
        ],
      ),
    );
  }
}
