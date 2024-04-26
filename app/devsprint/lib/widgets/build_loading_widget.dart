import 'package:devsprint/theme/color_manager.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BuildLoadingWidget extends StatelessWidget {
  const BuildLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: LoadingAnimationWidget.horizontalRotatingDots(
            color: ColorManager.secondary,
            size: 80.w,
          ),
        ),
      ],
    );
  }
}