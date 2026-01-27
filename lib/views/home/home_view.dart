import 'package:event_manager/widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:event_manager/l10n/app_localizations.dart'; // استيراد الترجمة
import '../../controllers/home_controller.dart';
import '../events/create_event_view.dart';
import '../events/events_list_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(title: Text(l10n.homeTitle), centerTitle: true),

      // ================= Drawer =================
      drawer: GetBuilder<HomeController>(
        builder: (_) => Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(controller.currentUser.email),
                accountEmail: Text(controller.currentUser.email),
                currentAccountPicture: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: controller.profileImage != null
                          ? MemoryImage(controller.profileImage!)
                          : null,
                      child: controller.profileImage == null
                          ? const Icon(Icons.person, size: 40)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: controller.pickProfileImage,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              _drawerItem(
                icon: Icons.add,
                title: l10n.createEventMenu, // ترجمة "Create Event"
                onTap: () {
                  Get.back();
                  Get.to(
                    () => CreateEventView(onAddEvent: controller.addEvent),
                  );
                },
              ),
              _drawerItem(
                icon: Icons.list,
                title: l10n.eventsListMenu, // ترجمة "Events List"
                onTap: () {
                  Get.back();
                  Get.to(() => EventsListView(events: controller.events));
                },
              ),
              _drawerItem(
                icon: Icons.chat,
                title: l10n.chatMenu, // ترجمة "Chat"
                onTap: () {
                  Get.back();
                  Get.toNamed('/chat');
                },
              ),
              const Divider(),
              _drawerItem(
                icon: Icons.logout,
                title: l10n.logoutMenu, // ترجمة "Logout"
                onTap: controller.logout,
              ),
            ],
          ),
        ),
      ),

      // ================= Body =================
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.home, size: 70, color: Colors.blue),
              const SizedBox(height: 10),
              Text(
                "${l10n.welcomeText} ${controller.currentUser.email}", // مرحباً بك [Email]
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 10),
              Obx(() =>
                  Text("${l10n.eventsCountText}: ${controller.eventsCount}")),
              const SizedBox(height: 30),
              Obx(
                () => Column(
                  children: [
                    Text(
                      "${l10n.priorityLevelText}: ${controller.sliderValue.value.toInt()}",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Slider(
                      value: controller.sliderValue.value,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: controller.sliderValue.value.toInt().toString(),
                      onChanged: (value) =>
                          controller.sliderValue.value = value,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const AppBottomNavBar(currentIndex: 0),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        onTap: onTap,
      ),
    );
  }
}
