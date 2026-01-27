import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/chat_message_model.dart';

class ChatController extends GetxController {
  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final RxList<ChatMessage> messages = <ChatMessage>[].obs;
  final RxList<String> suggestions = <String>[].obs;

  final List<Map<String, dynamic>> faq = [
    {
      "keywords": ["اضف حدث", "اضافة حدث", "create event", "new event"],
      "answer": "اضغط على زر 'Create Event' لإضافة حدث جديد.",
    },
    {
      "keywords": ["عرض الأحداث", "events list", "شوف الأحداث"],
      "answer": "اذهب إلى 'Events List' لرؤية جميع الأحداث.",
    },
    {
      "keywords": ["تعديل حساب", "edit profile", "change account"],
      "answer": "اذهب إلى الإعدادات لتعديل معلومات حسابك.",
    },
    {
      "keywords": ["تسجيل خروج", "logout", "خروج"],
      "answer": "اضغط على زر 'Logout' في القائمة لتسجيل الخروج.",
    },
    {
      "keywords": ["اضافة صورة", "profile image", "تغيير صورة"],
      "answer": "اضغط على أيقونة '+' في البروفايل لتغيير الصورة.",
    },
    {
      "keywords": ["مساعدة", "help", "كيف", "كيفية", "how"],
      "answer":
          "استخدم القائمة للتنقل بين إضافة الأحداث، عرض الأحداث، الإعدادات وتسجيل الخروج.",
    },
  ];

  // ===== إرسال رسالة =====
  void sendMessage(String text) {
    if (text.trim().isEmpty) return;

    messages.add(ChatMessage(role: "user", text: text));
    textController.clear();
    suggestions.clear();

    String response = "عذرًا، لم أفهم سؤالك.";

    for (var item in faq) {
      for (var keyword in item["keywords"]) {
        if (text.toLowerCase().contains(keyword.toLowerCase())) {
          response = item["answer"];
          break;
        }
      }
      if (response != "عذرًا، لم أفهم سؤالك.") break;
    }

    messages.add(ChatMessage(role: "ai", text: response));
    _scrollToBottom();
  }

  // ===== اقتراحات =====
  void updateSuggestions(String input) {
    if (input.isEmpty) {
      suggestions.clear();
      return;
    }

    final Set<String> matches = {};
    for (var item in faq) {
      for (var keyword in item["keywords"]) {
        if (keyword.toLowerCase().contains(input.toLowerCase())) {
          matches.add(keyword);
        }
      }
    }
    suggestions.value = matches.toList();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
}
