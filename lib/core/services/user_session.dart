import 'dart:typed_data';
import 'package:event_manager/controllers/AuthController.dart';

import '../../models/user.dart';

class UserSession {
  static User? currentUser;
  static Uint8List? profileImageBytes;
  static int? userId;

  static void logout() {
    currentUser = null;
    profileImageBytes = null;
    AuthController().signOut();
  }
}
