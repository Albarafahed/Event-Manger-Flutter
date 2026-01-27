import 'dart:typed_data';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../core/services/user_session.dart';
import '../models/event_model.dart';
import '../models/user.dart';

class HomeController extends GetxController {
  late User currentUser;

  final RxList<EventModel> events = <EventModel>[].obs;
  final RxDouble sliderValue = 50.0.obs;

  final ImagePicker picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    currentUser = UserSession.currentUser!;
  }

  // ===== اختيار صورة البروفايل =====
  Future<void> pickProfileImage() async {
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      UserSession.profileImageBytes = bytes;
      update(); // لتحديث Drawer
    }
  }

  // ===== إضافة حدث =====
  void addEvent(EventModel event) {
    events.add(event);
  }

  int get eventsCount => events.length;

  Uint8List? get profileImage => UserSession.profileImageBytes;

  void logout() {
    UserSession.logout();
    Get.offAllNamed('/login');
  }
}
