# 📅 Event Manager Pro (Hybrid Edition) 🔐 🇾🇪

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=white)
![SQLite](https://img.shields.io/badge/SQLite-07405E?style=for-the-badge&logo=sqlite&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-000000?style=for-the-badge&logo=getx&logoColor=white)

تطبيق احترافي لإدارة الفعاليات يجمع بين قوة السحاب في المصادقة وسرعة التخزين المحلي للبيانات، مع واجهة مستخدم عالمية تدعم السحب والإيماءات.

---

## 🌟 الإضافات والمميزات الأخيرة (What's New)

- **🔐 نظام المصادقة السحابي:** دمج **Firebase Authentication** لضمان أمان حسابات المستخدمين وحماية بياناتهم.
- **✅ إدارة المهام (Tasks):** إمكانية إضافة قائمة مهام فرعية لكل فعالية بشكل مستقل (SQLite).
- **📊 مؤشر الإنجاز الذكي:** شريط تقدم (Progress Bar) يحسب نسبة اكتمال مهام الفعالية لحظياً.
- **🌍 التدويل العالمي (5 لغات):** دعم كامل لـ (العربية 🇾🇪، الإنجليزية، الفرنسية، التركية، الصينية).
- **📍 ثبات الواجهة (UI Fix):** تثبيت أيقونة تغيير اللغة في الـ AppBar لضمان عدم تحركها عند التبديل بين اللغات (RTL/LTR).
- **🖱️ تحكم ذكي:** دعم السحب (Swipe) للتفاعل السريع مع المهام (تعديل/حذف).

---

## 🚀 المميزات التقنية

- **🏗 معمارية MVC:** فصل كامل ومحكم بين منطق الأعمال (Firebase/SQLite) والواجهات.
- **💾 نظام التخزين الهجين:** - **Firebase:** للمصادقة السحابية آمنة.
    - **SQLite:** لإدارة البيانات المرتبطة (الفعاليات والمهام) محلياً وبسرعة عالية.
    - **GetStorage:** لحفظ الثيمات، الألوان، وأحجام الخطوط.
- **🎨 تجربة مستخدم ديناميكية:** دعم كامل للوضع الليلي وتغيير ألوان التطبيق لحظياً دون إعادة التشغيل.

---

## 🛠 المكتبات المستخدمة (Dependencies)

| المكتبة | الغرض |
|---------|-------|
| **Firebase Auth** | المصادقة وحماية حسابات المستخدمين |
| **Sqflite** | قاعدة بيانات محلية لإدارة الفعاليات والمهام |
| **GetX** | إدارة الحالة (State)، التنقل، والترجمة |
| **GetStorage** | تخزين إعدادات المستخدم وتفضيلاته |
| **Intl** | تنسيق الوقت، التواريخ، والأرقام |

---

## 📁 هيكلة المشروع (Project Structure)
```text
lib/
├── core/         # إعدادات Firebase، SQLite (DbHelper)، وخدمات الترجمة
├── controllers/  # إدارة منطق الفعاليات والمهام (GetX Controllers)
├── models/       # نماذج البيانات (Event & Task Models)
├── views/        # واجهات المستخدم (Home, Details, Settings, Chat)
├── l10n/         # ملفات الترجمة العالمية (ARB Files)
└── main.dart     # نقطة انطلاق التطبيق وتهيئة الخدمات

```

---

## 🖼️ لقطات من التطبيق (Screenshots)

<details>
<summary>Splash Screen</summary>

![Splash]([![Splashscreen.jpg](https://i.postimg.cc/B6D23P4n/Splashscreen.jpg)

</details>

<details>
<summary>Login Screen</summary>

![Login](https://github.com/user-attachments/assets/17f0a33b-5871-4b6c-8836-fa59f67f5ec1)

</details>

<details>
<summary>Sign Up Screen</summary>

![Signup](https://github.com/user-attachments/assets/016bcca9-53fc-4d41-9948-472728ec81da)

</details>

<details>
<summary>Home Screen</summary>

<img width="631" height="907" alt="home_screenshot" src="https://github.com/user-attachments/assets/3f80a84b-c733-489c-a4d4-5f2b84199a86" />

</details>

<details>
<summary>Drawer</summary>

![Drawer](https://github.com/user-attachments/assets/5f991023-aded-4314-bb58-463edb79dbae)

</details>

<details>
<summary>Settings Screen</summary>

<img width="543" height="925" alt="settings_screenshot" src="https://github.com/user-attachments/assets/cbee79e1-4fb6-476c-b94b-62e8cc797639" />

</details>

<details>
<summary>Chat Screen</summary>

<img width="526" height="861" alt="Chat_screenshot" src="https://github.com/user-attachments/assets/240105a4-484a-4144-8e99-54bc55cbe09d" />

</details>

<details>
<summary>Create Event</summary>

<img width="526" height="886" alt="CreateEvent_screenshot" src="https://github.com/user-attachments/assets/e2fa3479-e121-4005-90a7-1506790b039f" />

</details>

<details>
<summary>Event List</summary>

<img width="595" height="898" alt="EventList_screenshot" src="https://github.com/user-attachments/assets/872313d8-b79d-4db2-8bd4-181aeb699343" />

</details>

---

## ⚙️ تشغيل المشروع (Installation & Run)

1. تثبيت [Flutter](https://flutter.dev/docs/get-started/install)  
2. Clone المشروع:  
```bash
git clone https://github.com/yourusername/event_manager.git
تثبيت المكتبات:

flutter pub get


توليد ملفات الترجمة:

flutter gen-l10n


تشغيل التطبيق:

flutter run
