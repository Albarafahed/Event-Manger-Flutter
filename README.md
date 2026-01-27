# 📅 Event Manager Pro

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![GetX](https://img.shields.io/badge/GetX-000000?style=for-the-badge&logo=getx&logoColor=white)
![MVC](https://img.shields.io/badge/Architecture-MVC-green?style=for-the-badge)

تطبيق احترافي لإدارة الفعاليات مبني باستخدام **Flutter**، مع معمارية **MVC** وفصل كامل بين منطق الأعمال والواجهات، ونظام تخزين بيانات محلي وحماية متقدمة.

---

## 🌟 نبذة عن التطبيق (About App)

**Event Manager Pro** يتيح لك:
- إنشاء وعرض الأحداث الشخصية والمناسبات  
- إدارة ملفات المستخدم (Profile Image)  
- دردشة داخل التطبيق  
- تخصيص الثيمات، اللون الرئيسي، حجم الخط، وإشعارات التطبيق  
- واجهة مستخدم سهلة وجذابة للتنقل بين الشاشات  

---

## 🚀 المميزات التقنية

- **🔐 نظام المصادقة والحماية:** Login/Signup مع التحقق من صحة البيانات.  
- **💾 التخزين المحلي (Persistence):** `GetStorage` لحفظ جلسات المستخدم وبيانات الحساب.  
- **🏗 معمارية MVC:** فصل المشروع إلى Models, Views, Controllers.  
- **🌍 التدويل (Localization):** دعم العربية والإنجليزية مع تغيير اللغة لحظياً.  
- **🎨 الثيمات الديناميكية:** Dark/Light Mode، تغيير الألوان وأحجام الخطوط.

---

## 🛠 المكتبات المستخدمة (Dependencies)

| المكتبة | الغرض |
|---------|-------|
| **GetX** | إدارة الحالة والتنقل بين الصفحات |
| **GetStorage** | تخزين البيانات بشكل دائم |
| **Flutter Localizations** | دعم الترجمة |
| **Intl** | تنسيق الأرقام والتواريخ |

---

## 📁 هيكلة المشروع (Project Structure)
```text
lib/
#├── controllers/ # المنطق الأساسي وحالة التطبيق
#├── models/ # نماذج البيانات
#├── views/ # واجهات المستخدم
#├── core/ # الإعدادات والخدمات (Themes, Routes, Services)
#├── l10n/ # ملفات الترجمة (ARB Files)
#└── main.dart # نقطة الانطلاق وتهيئة الخدمات

```

---

## 🖼️ لقطات من التطبيق (Screenshots)

<details>
<summary>Splash Screen</summary>

![Splash](https://github.com/user-attachments/assets/55da6214-9a9c-4e7a-b092-f16d4015440b)

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
