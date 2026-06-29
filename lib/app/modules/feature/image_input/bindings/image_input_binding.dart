import 'package:get/get.dart';

import '../controllers/image_input_controller.dart';

class ImageInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ImageInputController>(
      () => ImageInputController(),
    );
  }
}
