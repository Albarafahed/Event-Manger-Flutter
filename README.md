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

![Splash](https://i.postimg.cc/B6D23P4n/Splashscreen.jpg)

</details>

<details>
<summary>Login Screen</summary>

![Login](https://i.postimg.cc/0yBSJ0Nb/Screenshot_20260130_153421.jpg)

</details>

<details>
<summary>Language</summary>

![Login](https://i.postimg.cc/kgpStv54/Language.jpg)

</details>

<details>
<summary>Sign Up Screen</summary>

![Signup](https://i.postimg.cc/qv5KCx7s/Signup_screen.jpg)

</details>

<details>
<summary>Home Screen</summary>

![Home](https://i.postimg.cc/ht5m71GW/Home.jpg)
</details>

<details>
<summary>Drawer</summary>

![Drawer](https://i.postimg.cc/T3wmw4TT/Deawer.jpg)

</details>

<details>
<summary>Settings Screen</summary>

![Setting](https://i.postimg.cc/pL6jnJd8/Settingscreen.jpg)

</details>

<details>
<summary>Settings Screen Dark</summary>

![Setting](https://i.postimg.cc/pLT8T6Px/Darkscreen.jpg)

</details>

<details>
<summary>Chat Screen</summary>

![Setting](https://i.postimg.cc/4x70cw5C/Chat-Screen.jpg)

</details

<details>
<summary>Create Event</summary>

![Create Event](https://i.postimg.cc/pLT8T6P2/Createeventscreen.jpg)

</details>

<details>
<summary>Edit Event</summary>

![Edit Event](https://i.postimg.cc/zGBWBcqz/Editevent.jpg)

</details>

<details>
<summary>Event List</summary>

![Event List](https://i.postimg.cc/L8bPZ38c/Evetlist.jpg)

</details>

<details>
<summary>Task </summary>

![Task List](https://i.postimg.cc/HL8y08JJ/Task.jpg)

</details>

<details>
<summary>Task Edit </summary>

![Task Edit](https://i.postimg.cc/9fw7Pw4D/Updatetask.jpg)

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
