import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../../data/models/auth/resend_otp_request.dart';
import '../../../../data/models/auth/verify_otp_request.dart';
import '../../../../data/services/auth_service.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/widgets/custom_button.dart';
import '../../../../shared/widgets2/custom_snackbar.dart';

class VerifyOtpDialog extends StatefulWidget {
  final String email;

  const VerifyOtpDialog({
    super.key,
    required this.email,
  });

  @override
  State<VerifyOtpDialog> createState() => _VerifyOtpDialogState();
}

class _VerifyOtpDialogState extends State<VerifyOtpDialog> {
  static const int otpLength = 5;

  late final List<TextEditingController> controllers;
  late final List<FocusNode> focusNodes;

  bool loading = false;
  int countdown = 60;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    controllers = List.generate(
      otpLength,
      (_) => TextEditingController(),
    );

    focusNodes = List.generate(
      otpLength,
      (_) => FocusNode(),
    );

    for (final node in focusNodes) {
      node.addListener(() {
        if (mounted) setState(() {});
      });
    }

    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    countdown = 60;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        if (countdown == 0) {
          timer.cancel();
        } else {
          setState(() {
            countdown--;
          });
        }
      },
    );
  }

  String get otp => controllers.map((e) => e.text.trim()).join();

  void onOtpChanged(String value, int index) {
    if (!mounted) return; // guard di awal

    if (value.length > 1) {
      final digits = value.replaceAll(RegExp(r'[^0-9]'), '');

      for (int i = 0; i < otpLength; i++) {
        try {
          controllers[i].text = i < digits.length ? digits[i] : '';
          controllers[i].selection = TextSelection.fromPosition(
            TextPosition(offset: controllers[i].text.length),
          );
        } catch (e) {
          return; // sudah dispose
        }
      }

      if (mounted) {
        FocusScope.of(context).unfocus();
        setState(() {});
      }
      return;
    }

    if (value.isNotEmpty) {
      if (index < otpLength - 1) {
        if (mounted) focusNodes[index + 1].requestFocus();
      } else {
        if (mounted) FocusScope.of(context).unfocus();
      }
    } else {
      if (index > 0) {
        if (mounted) focusNodes[index - 1].requestFocus();
      }
    }

    if (mounted) setState(() {});
  }

  Future<void> verify() async {
    if (!mounted) return;

    final currentOtp = otp;

    if (currentOtp.length != otpLength) {
      CustomSnackbar.error(
        title: "OTP",
        message: "Masukkan $otpLength digit OTP",
      );
      return;
    }

    setState(() => loading = true);

    try {
      await AuthService.verifyOtp(
        VerifyOtpRequest(
          email: widget.email,
          otp: currentOtp,
        ),
      );

      if (!mounted) return;

      // Dispose dulu sebelum navigasi
      timer?.cancel();

      Get.back();

      CustomSnackbar.success(
        title: "Berhasil",
        message: "Email berhasil diverifikasi.",
      );

      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      if (mounted) {
        CustomSnackbar.error(
          title: "OTP Salah",
          message: e.toString(),
        );
      }
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  Future<void> resendOtp() async {
    if (!mounted) return;

    try {
      await AuthService.resendOtp(
        ResendOtpRequest(email: widget.email),
      );

      if (!mounted) return;

      for (final c in controllers) {
        c.clear();
      }

      if (mounted) {
        focusNodes.first.requestFocus();
        startTimer();
      }

      CustomSnackbar.success(
        title: "OTP",
        message: "Kode OTP berhasil dikirim ulang.",
      );
    } catch (e) {
      if (mounted) {
        CustomSnackbar.error(
          title: "Error",
          message: e.toString(),
        );
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    timer = null;

    for (final f in focusNodes) {
      f.removeListener(() {}); // hapus listener sebelum dispose
      f.dispose();
    }

    for (final c in controllers) {
      c.dispose();
    }

    super.dispose();
  }

  Widget otpBox(int index) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 62,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              width: 2,
              color: focusNodes[index].hasFocus
                  ? const Color(0xFF6C63FF)
                  : Colors.grey.shade300,
            ),
            boxShadow: [
              BoxShadow(
                color: focusNodes[index].hasFocus
                    ? const Color(0xFF6C63FF).withOpacity(.15)
                    : Colors.black12,
                blurRadius: 12,
              ),
            ],
          ),
          child: TextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            textAlign: TextAlign.center,
            maxLength: otpLength, // bukan 1, agar paste bisa masuk ke onChanged
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              counterText: "",
            ),
            onChanged: (value) => onOtpChanged(value, index),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final screenHeight = MediaQuery.of(context).size.height;
    final maxHeight = screenHeight - bottomInset - 48;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 24,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: maxHeight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // CLOSE
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: Get.back,
                    child: const Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    color: const Color(0xff6C63FF).withOpacity(.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.mark_email_read_rounded,
                    color: Color(0xff6C63FF),
                    size: 42,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Verifikasi Email",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  "Masukkan kode OTP yang telah dikirim ke",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey.shade600),
                ),

                const SizedBox(height: 5),

                Text(
                  widget.email,
                  style: const TextStyle(
                    color: Color(0xff6C63FF),
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 28),

                Row(
                  children: List.generate(
                    otpLength,
                    (index) => otpBox(index),
                  ),
                ),

                const SizedBox(height: 24),

                Text(
                  countdown == 0
                      ? "Kode OTP telah habis"
                      : "00:${countdown.toString().padLeft(2, "0")}",
                  style: TextStyle(
                    color: countdown == 0 ? Colors.red : Colors.black87,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                TextButton(
                  onPressed: countdown == 0 ? resendOtp : null,
                  child: const Text("Kirim Ulang OTP"),
                ),

                const SizedBox(height: 24),

                CustomButton(
                  text: "Verifikasi",
                  loading: loading,
                  onTap: verify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}