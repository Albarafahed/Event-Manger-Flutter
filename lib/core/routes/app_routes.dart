import 'package:event_manager/views/auth/login_view.dart';
import 'package:event_manager/views/auth/signup_view.dart';
import 'package:event_manager/views/chat/chat_view.dart';
import 'package:event_manager/views/home/home_view.dart';
import 'package:event_manager/views/settings/settings_view.dart';
import 'package:flutter/material.dart';

import '../../views/splash/splash_view.dart';


class AppRoutes {
  static const splash = '/';
  static const login = '/login';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const chat = '/chat';
  static const settings = '/settings';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (_) => const SplashView(),
    login: (_) => LoginView(),
    signUp: (_) => SignupView(),
    home: (_) => const HomeView(),
    chat: (_) => const SmartChatView(),
    settings: (_) => const SettingsScreen (),
  };
}
