import 'package:get/get.dart';

import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/onboarding/bindings/onboarding_binding.dart';
import '../modules/auth/onboarding/views/onboarding_view.dart';
import '../modules/auth/register/bindings/register_binding.dart';
import '../modules/auth/register/views/register_view.dart';
import '../modules/feature/add_task/bindings/add_task_binding.dart';
import '../modules/feature/add_task/views/add_task_view.dart';
import '../modules/feature/focus_mode/bindings/focus_mode_binding.dart';
import '../modules/feature/focus_mode/views/focus_mode_view.dart';
import '../modules/feature/image_input/bindings/image_input_binding.dart';
import '../modules/feature/image_input/views/image_input_view.dart';
import '../modules/feature/voice_input/bindings/voice_input_binding.dart';
import '../modules/feature/voice_input/views/voice_input_view.dart';
import '../modules/main/analytics/bindings/analytics_binding.dart';
import '../modules/main/analytics/views/analytics_view.dart';
import '../modules/main/calendar/bindings/calendar_binding.dart';
import '../modules/main/calendar/views/calendar_view.dart';
import '../modules/main/dashboard/bindings/home_binding.dart';
import '../modules/main/dashboard/views/home_view.dart';
import '../modules/main/profile/bindings/profile_binding.dart';
import '../modules/main/profile/views/profile_view.dart';
import '../modules/main/profile/views/personal_info_view.dart';
import '../modules/main/profile/views/security_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/feature/task_detail/bindings/task_detail_binding.dart';
import '../modules/feature/task_detail/views/task_detail_view.dart';

/// MAIN

/// FEATURE

/// AUTH

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.ANALYTICS,
      page: () => const AnalyticsView(),
      binding: AnalyticsBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: _Paths.PERSONAL_INFO,
      page: () => const PersonalInfoView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SECURITY,
      page: () => const SecurityView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_TASK,
      page: () => const AddTaskView(),
      binding: AddTaskBinding(),
    ),
    GetPage(
      name: _Paths.VOICE_INPUT,
      page: () => const VoiceInputView(),
      binding: VoiceInputBinding(),
    ),
    GetPage(
      name: _Paths.IMAGE_INPUT,
      page: () => const ImageInputView(),
      binding: ImageInputBinding(),
    ),
    GetPage(
      name: _Paths.FOCUS_MODE,
      page: () => const FocusModeView(),
      binding: FocusModeBinding(),
    ),
    GetPage(
      name: _Paths.TASK_DETAIL,
      page: () => const TaskDetailView(),
      binding: TaskDetailBinding(),
      preventDuplicates: false,
    ),
  ];
}
