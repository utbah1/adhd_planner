import 'package:get/get.dart';

import '../controllers/voice_input_controller.dart';

class VoiceInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VoiceInputController>(
      () => VoiceInputController(),
    );
  }
}
