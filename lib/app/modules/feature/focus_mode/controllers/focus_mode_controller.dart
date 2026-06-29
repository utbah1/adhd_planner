import 'dart:async';

import 'package:get/get.dart';

class FocusModeController extends GetxController {

  RxInt totalSeconds = 1500.obs;

  RxBool isRunning = false.obs;

  Timer? timer;

  String get formattedTime {

    final minutes = totalSeconds.value ~/ 60;

    final seconds = totalSeconds.value % 60;

    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  void startTimer() {

    if (isRunning.value) return;

    isRunning.value = true;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {

        if (totalSeconds.value > 0) {
          totalSeconds.value--;
        }
        else {
          stopTimer();
        }
      },
    );
  }

  void pauseTimer() {
    timer?.cancel();
    isRunning.value = false;
  }

  void stopTimer() {
    timer?.cancel();
    isRunning.value = false;
    totalSeconds.value = 1500;
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}