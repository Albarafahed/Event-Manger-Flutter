import 'package:event_manager/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/chat_controller.dart';

class SmartChatView extends StatelessWidget {
  const SmartChatView({super.key});

  @override
  Widget build(BuildContext context) {
    // تعريف متغير الترجمة
    final l10n = AppLocalizations.of(context)!;
    final controller = Get.put(ChatController());

    return Scaffold(
      // استخدام الترجمة لعنوان الصفحة
      appBar: AppBar(title: Text(l10n.smartChatTitle)),
      body: Column(
        children: [
          // ===== الرسائل =====
          Expanded(
            child: Obx(
              () => controller.messages.isEmpty
                  ? Center(
                      child:
                          Text(l10n.noMessagesYet)) // إضافة نص "لا توجد رسائل"
                  : ListView.builder(
                      controller: controller.scrollController,
                      padding: const EdgeInsets.all(12),
                      itemCount: controller.messages.length,
                      itemBuilder: (context, index) {
                        final msg = controller.messages[index];
                        final isUser = msg.role == "user";

                        return Align(
                          alignment: isUser
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color:
                                  isUser ? Colors.blue : Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              msg.text,
                              style: TextStyle(
                                color: isUser ? Colors.white : Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),

          // ===== الاقتراحات =====
          Obx(
            () => controller.suggestions.isEmpty
                ? const SizedBox()
                : SizedBox(
                    height: 60,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.suggestions.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () => controller.sendMessage(
                            controller.suggestions[index],
                          ),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 6),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              controller.suggestions[index],
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ),

          const Divider(),

          // ===== الإدخال =====
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.textController,
                    decoration: InputDecoration(
                      // استخدام الترجمة لتلميح الإدخال
                      hintText: l10n.askQuestionHint,
                    ),
                    onChanged: controller.updateSuggestions,
                    onSubmitted: controller.sendMessage,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () =>
                      controller.sendMessage(controller.textController.text),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
