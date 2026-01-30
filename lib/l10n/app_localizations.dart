import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
    Locale('tr'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Event Manager'**
  String get appTitle;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue'**
  String get loginToContinue;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @emailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get emailHint;

  /// No description provided for @emailEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Email cannot be empty'**
  String get emailEmptyError;

  /// No description provided for @emailInvalidError.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get emailInvalidError;

  /// No description provided for @passwordLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// No description provided for @passwordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// No description provided for @passwordEmptyError.
  ///
  /// In en, this message translates to:
  /// **'Password cannot be empty'**
  String get passwordEmptyError;

  /// No description provided for @passwordLengthError.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 7 characters'**
  String get passwordLengthError;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @noAccountText.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountText;

  /// No description provided for @accountText.
  ///
  /// In en, this message translates to:
  /// **'Do you have an account?'**
  String get accountText;

  /// No description provided for @signUpText.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpText;

  /// No description provided for @registerTitle.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerTitle;

  /// No description provided for @registeredUsers.
  ///
  /// In en, this message translates to:
  /// **'Registered Users'**
  String get registeredUsers;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @smartChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Smart App Chat'**
  String get smartChatTitle;

  /// No description provided for @askQuestionHint.
  ///
  /// In en, this message translates to:
  /// **'Type your question here...'**
  String get askQuestionHint;

  /// No description provided for @noMessagesYet.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get noMessagesYet;

  /// No description provided for @createEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEventTitle;

  /// No description provided for @eventTitleLabel.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get eventTitleLabel;

  /// No description provided for @eventDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get eventDescriptionLabel;

  /// No description provided for @eventLocationLabel.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get eventLocationLabel;

  /// No description provided for @eventTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Event Type'**
  String get eventTypeLabel;

  /// No description provided for @selectEventTypeHint.
  ///
  /// In en, this message translates to:
  /// **'Select event type'**
  String get selectEventTypeHint;

  /// No description provided for @addEventButton.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEventButton;

  /// No description provided for @fieldCannotBeEmpty.
  ///
  /// In en, this message translates to:
  /// **'cannot be empty'**
  String get fieldCannotBeEmpty;

  /// No description provided for @eventDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get eventDateLabel;

  /// No description provided for @eventTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get eventTimeLabel;

  /// No description provided for @eventsTitle.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get eventsTitle;

  /// No description provided for @noEventsFound.
  ///
  /// In en, this message translates to:
  /// **'No events found'**
  String get noEventsFound;

  /// No description provided for @allEventsTab.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get allEventsTab;

  /// No description provided for @homeTitle.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeTitle;

  /// No description provided for @createEventMenu.
  ///
  /// In en, this message translates to:
  /// **'Create Event'**
  String get createEventMenu;

  /// No description provided for @eventsListMenu.
  ///
  /// In en, this message translates to:
  /// **'Events List'**
  String get eventsListMenu;

  /// No description provided for @chatMenu.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get chatMenu;

  /// No description provided for @logoutMenu.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutMenu;

  /// No description provided for @welcomeText.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeText;

  /// No description provided for @eventsCountText.
  ///
  /// In en, this message translates to:
  /// **'Events count'**
  String get eventsCountText;

  /// No description provided for @priorityLevelText.
  ///
  /// In en, this message translates to:
  /// **'Priority Level'**
  String get priorityLevelText;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @primaryColor.
  ///
  /// In en, this message translates to:
  /// **'Primary Color'**
  String get primaryColor;

  /// No description provided for @pickPrimaryColor.
  ///
  /// In en, this message translates to:
  /// **'Pick Primary Color'**
  String get pickPrimaryColor;

  /// No description provided for @fontSize.
  ///
  /// In en, this message translates to:
  /// **'Font Size'**
  String get fontSize;

  /// No description provided for @enableNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Notifications'**
  String get enableNotifications;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @tabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get tabAll;

  /// No description provided for @tabMeeting.
  ///
  /// In en, this message translates to:
  /// **'Meeting'**
  String get tabMeeting;

  /// No description provided for @tabParty.
  ///
  /// In en, this message translates to:
  /// **'Party'**
  String get tabParty;

  /// No description provided for @tabSpecialOccasion.
  ///
  /// In en, this message translates to:
  /// **'Special Occasion'**
  String get tabSpecialOccasion;

  /// No description provided for @tabOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get tabOther;

  /// No description provided for @successTitle.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successTitle;

  /// No description provided for @signupSuccess.
  ///
  /// In en, this message translates to:
  /// **'User registered successfully'**
  String get signupSuccess;

  /// No description provided for @loginError.
  ///
  /// In en, this message translates to:
  /// **'Invalid email or password. Please sign up first.'**
  String get loginError;

  /// No description provided for @createEventSuccess.
  ///
  /// In en, this message translates to:
  /// **'Event Added Successfully'**
  String get createEventSuccess;

  /// No description provided for @loginErrorTitle.
  ///
  /// In en, this message translates to:
  /// **'Login Error'**
  String get loginErrorTitle;

  /// No description provided for @invalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get invalidCredentials;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @createError.
  ///
  /// In en, this message translates to:
  /// **'Creation Error'**
  String get createError;

  /// No description provided for @editEvent.
  ///
  /// In en, this message translates to:
  /// **'Edit Event'**
  String get editEvent;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'Update Data'**
  String get updateButton;

  /// No description provided for @updateSuccess.
  ///
  /// In en, this message translates to:
  /// **'Event updated successfully'**
  String get updateSuccess;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @addSuccess.
  ///
  /// In en, this message translates to:
  /// **'Event added successfully'**
  String get addSuccess;

  /// No description provided for @databaseSaveError.
  ///
  /// In en, this message translates to:
  /// **'Failed to save to database'**
  String get databaseSaveError;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered'**
  String get emailAlreadyInUse;

  /// No description provided for @invalidLogin.
  ///
  /// In en, this message translates to:
  /// **'Incorrect email or password'**
  String get invalidLogin;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @welcomeUser.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcomeUser;

  /// No description provided for @deleteEventTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Event'**
  String get deleteEventTitle;

  /// No description provided for @deleteConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this event? All associated tasks will also be deleted.'**
  String get deleteConfirmMessage;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deleteSuccess.
  ///
  /// In en, this message translates to:
  /// **'Event deleted successfully'**
  String get deleteSuccess;

  /// No description provided for @addTaskHint.
  ///
  /// In en, this message translates to:
  /// **'Add a new task...'**
  String get addTaskHint;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'NoTasksFound'**
  String get noTasksFound;

  /// No description provided for @tasksProgress.
  ///
  /// In en, this message translates to:
  /// **'Tasks Progress'**
  String get tasksProgress;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr', 'tr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'tr':
      return AppLocalizationsTr();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
