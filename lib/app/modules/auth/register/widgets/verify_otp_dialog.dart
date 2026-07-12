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

  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  bool loading = false;
  int countdown = 100;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (mounted) setState(() {});
    });

    _controller.addListener(() {
      if (mounted) setState(() {});
    });

    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    countdown = 100;

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (t) {
        if (!mounted) {
          t.cancel();
          return;
        }
        if (countdown == 0) {
          t.cancel();
        } else {
          setState(() => countdown--);
        }
      },
    );
  }

  String get otp => _controller.text.trim();

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

      timer?.cancel();
      timer = null;

      FocusScope.of(context).unfocus();

      Navigator.of(context, rootNavigator: true).pop();

      await Future.delayed(const Duration(milliseconds: 100));

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

      _controller.clear();
      _focusNode.requestFocus();
      startTimer();

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
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  Widget _buildOtpBoxes() {
    final text = _controller.text;
    final isFocused = _focusNode.hasFocus;

    return Stack(
      children: [
        Row(
          children: List.generate(otpLength, (i) {
            final hasChar = i < text.length;
            final isActive = isFocused &&
                (i == text.length || (text.length == otpLength && i == otpLength - 1));

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
                      color: isActive
                          ? const Color(0xFF6C63FF)
                          : Colors.grey.shade300,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isActive
                            ? const Color(0xFF6C63FF).withOpacity(.15)
                            : Colors.black12,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    hasChar ? text[i] : '',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),

        /// Hidden TextField transparan di atas boxes
        Positioned.fill(
          child: Opacity(
            opacity: 0,
            child: TextField(
              controller: _controller,
              focusNode: _focusNode,
              maxLength: otpLength,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              decoration: const InputDecoration(
                border: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
        ),
      ],
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
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(30),
                    onTap: Get.back,
                    child: const Icon(Icons.close, color: Colors.grey),
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

                _buildOtpBoxes(),

                const SizedBox(height: 24),

                Text(
                  countdown == 0
                      ? "Anda dapat mengirim ulang OTP"
                      : "00:${countdown.toString().padLeft(2, "0")}",
                  style: TextStyle(
                    color: countdown == 0 ? Colors.red : Colors.black87,
                    fontSize: 15,
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