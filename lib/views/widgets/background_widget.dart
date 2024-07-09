import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_getx/themes/theme_changer.dart';

import '../../wrappers/svg_image_loader.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget childWidget;

  const BackgroundWidget({super.key, required this.childWidget});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          SizedBox(
              width: double.infinity,
              child: GetBuilder<ThemeChanger>(
                builder: (viewModel) {
                  return SVGImageLoader(
                    asset: viewModel.getBackgroundImage(context),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height,
                  );
                },
              )),
          childWidget,
        ],
      ),
    );
  }
}
