
import 'package:flutter/animation.dart';

 class AnimUtil{

static bool isBackpanelVisible(AnimationController _controller) {
    final AnimationStatus status =_controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }
  }