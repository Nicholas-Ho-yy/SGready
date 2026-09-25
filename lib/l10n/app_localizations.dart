import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ms.dart';
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
    Locale('en'),
    Locale('ms'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'SGReady'**
  String get appTitle;

  /// No description provided for @preferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// No description provided for @personaliseSGReady.
  ///
  /// In en, this message translates to:
  /// **'Personalise SGReady'**
  String get personaliseSGReady;

  /// No description provided for @preferencesDescription.
  ///
  /// In en, this message translates to:
  /// **'These preferences help SGReady tailor your preparedness experience.'**
  String get preferencesDescription;

  /// No description provided for @homeRegion.
  ///
  /// In en, this message translates to:
  /// **'Home region'**
  String get homeRegion;

  /// No description provided for @homeRegionDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the Singapore region you usually want to see first.'**
  String get homeRegionDescription;

  /// No description provided for @central.
  ///
  /// In en, this message translates to:
  /// **'Central'**
  String get central;

  /// No description provided for @north.
  ///
  /// In en, this message translates to:
  /// **'North'**
  String get north;

  /// No description provided for @south.
  ///
  /// In en, this message translates to:
  /// **'South'**
  String get south;

  /// No description provided for @east.
  ///
  /// In en, this message translates to:
  /// **'East'**
  String get east;

  /// No description provided for @west.
  ///
  /// In en, this message translates to:
  /// **'West'**
  String get west;

  /// No description provided for @outdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Outdoor activity'**
  String get outdoorActivity;

  /// No description provided for @outdoorActivityDescription.
  ///
  /// In en, this message translates to:
  /// **'How much time do you usually spend outdoors?'**
  String get outdoorActivityDescription;

  /// No description provided for @low.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get low;

  /// No description provided for @moderate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get moderate;

  /// No description provided for @high.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get high;

  /// No description provided for @usuallyOutdoors.
  ///
  /// In en, this message translates to:
  /// **'Usually outdoors'**
  String get usuallyOutdoors;

  /// No description provided for @usuallyOutdoorsDescription.
  ///
  /// In en, this message translates to:
  /// **'Select the periods when you are commonly outside.'**
  String get usuallyOutdoorsDescription;

  /// No description provided for @morning.
  ///
  /// In en, this message translates to:
  /// **'Morning'**
  String get morning;

  /// No description provided for @midday.
  ///
  /// In en, this message translates to:
  /// **'Midday'**
  String get midday;

  /// No description provided for @evening.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get evening;

  /// No description provided for @preparednessReminders.
  ///
  /// In en, this message translates to:
  /// **'Preparedness reminders'**
  String get preparednessReminders;

  /// No description provided for @preparednessRemindersDescription.
  ///
  /// In en, this message translates to:
  /// **'Allow SGReady to remind you about relevant preparedness actions.'**
  String get preparednessRemindersDescription;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable reminders'**
  String get enableReminders;

  /// No description provided for @notificationSchedule.
  ///
  /// In en, this message translates to:
  /// **'Notification schedule'**
  String get notificationSchedule;

  /// No description provided for @daytimeOnly.
  ///
  /// In en, this message translates to:
  /// **'Daytime only'**
  String get daytimeOnly;

  /// No description provided for @daytimeOnlyDescription.
  ///
  /// In en, this message translates to:
  /// **'Weather and task reminders approximately every 5 hours between 8 AM and 10 PM.'**
  String get daytimeOnlyDescription;

  /// No description provided for @twentyFourHours.
  ///
  /// In en, this message translates to:
  /// **'24 hours'**
  String get twentyFourHours;

  /// No description provided for @twentyFourHoursDescription.
  ///
  /// In en, this message translates to:
  /// **'Weather updates approximately every 5 hours, day and night. Task reminders are limited to 8 AM–10 PM.'**
  String get twentyFourHoursDescription;

  /// No description provided for @accessibility.
  ///
  /// In en, this message translates to:
  /// **'Accessibility'**
  String get accessibility;

  /// No description provided for @accessibilityDescription.
  ///
  /// In en, this message translates to:
  /// **'Adjust SGReady to make the app easier and more comfortable to use.'**
  String get accessibilityDescription;

  /// No description provided for @largerText.
  ///
  /// In en, this message translates to:
  /// **'Larger text'**
  String get largerText;

  /// No description provided for @largerTextDescription.
  ///
  /// In en, this message translates to:
  /// **'Increase text size across SGReady for easier reading.'**
  String get largerTextDescription;

  /// No description provided for @largerControls.
  ///
  /// In en, this message translates to:
  /// **'Larger controls'**
  String get largerControls;

  /// No description provided for @largerControlsDescription.
  ///
  /// In en, this message translates to:
  /// **'Increase the size of important controls to make them easier to tap.'**
  String get largerControlsDescription;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose the language used across SGReady.'**
  String get languageDescription;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @simplifiedChinese.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get simplifiedChinese;

  /// No description provided for @malay.
  ///
  /// In en, this message translates to:
  /// **'Malay'**
  String get malay;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @appearanceDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose how SGReady looks on this device.'**
  String get appearanceDescription;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System default'**
  String get systemDefault;

  /// No description provided for @systemDefaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Match your device appearance'**
  String get systemDefaultDescription;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @lightDescription.
  ///
  /// In en, this message translates to:
  /// **'Always use light mode'**
  String get lightDescription;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @darkDescription.
  ///
  /// In en, this message translates to:
  /// **'Always use dark mode'**
  String get darkDescription;

  /// No description provided for @savePreferences.
  ///
  /// In en, this message translates to:
  /// **'Save preferences'**
  String get savePreferences;

  /// No description provided for @saving.
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// No description provided for @preferencesSaved.
  ///
  /// In en, this message translates to:
  /// **'Preferences saved.'**
  String get preferencesSaved;

  /// No description provided for @unableToSavePreferences.
  ///
  /// In en, this message translates to:
  /// **'Unable to save preferences.'**
  String get unableToSavePreferences;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get navToday;

  /// No description provided for @navExplore.
  ///
  /// In en, this message translates to:
  /// **'Explore'**
  String get navExplore;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @todayInSingapore.
  ///
  /// In en, this message translates to:
  /// **'Today in Singapore'**
  String get todayInSingapore;

  /// No description provided for @homeDescription.
  ///
  /// In en, this message translates to:
  /// **'Check local conditions and what you should prepare for.'**
  String get homeDescription;

  /// No description provided for @todaysPreparedness.
  ///
  /// In en, this message translates to:
  /// **'Today’s preparedness'**
  String get todaysPreparedness;

  /// No description provided for @whatYouShouldDo.
  ///
  /// In en, this message translates to:
  /// **'What you should do'**
  String get whatYouShouldDo;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @why.
  ///
  /// In en, this message translates to:
  /// **'Why?'**
  String get why;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @psi24h.
  ///
  /// In en, this message translates to:
  /// **'PSI (24h)'**
  String get psi24h;

  /// No description provided for @uvIndex.
  ///
  /// In en, this message translates to:
  /// **'UV Index'**
  String get uvIndex;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @wbgtHeatStress.
  ///
  /// In en, this message translates to:
  /// **'WBGT (Heat Stress)'**
  String get wbgtHeatStress;

  /// No description provided for @lastUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: {dateTime}'**
  String lastUpdated(String dateTime);

  /// No description provided for @regionAverage.
  ///
  /// In en, this message translates to:
  /// **'{region} average'**
  String regionAverage(String region);

  /// No description provided for @riskElevated.
  ///
  /// In en, this message translates to:
  /// **'Elevated'**
  String get riskElevated;

  /// No description provided for @riskLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get riskLow;

  /// No description provided for @riskModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get riskModerate;

  /// No description provided for @riskHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get riskHigh;

  /// No description provided for @riskVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get riskVeryHigh;

  /// No description provided for @riskExtreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get riskExtreme;

  /// No description provided for @floodRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Heavy rainfall detected. Stay alert and avoid flood-prone areas.'**
  String get floodRiskMessage;

  /// No description provided for @lowRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Conditions are generally good. Stay prepared and keep monitoring updates.'**
  String get lowRiskMessage;

  /// No description provided for @moderateRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Take basic precautions and follow today’s recommended actions.'**
  String get moderateRiskMessage;

  /// No description provided for @highRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Follow the safety guidance below and adjust your plans if needed.'**
  String get highRiskMessage;

  /// No description provided for @veryHighRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Limit outdoor exposure and take additional precautions.'**
  String get veryHighRiskMessage;

  /// No description provided for @extremeRiskMessage.
  ///
  /// In en, this message translates to:
  /// **'Avoid unnecessary outdoor activity and follow safety guidance closely.'**
  String get extremeRiskMessage;

  /// No description provided for @recommendationEnvironmentalDataUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Environmental data unavailable'**
  String get recommendationEnvironmentalDataUnavailable;

  /// No description provided for @recommendationEnvironmentalDataUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'Current environmental readings could not be retrieved. Please try refreshing the data later.'**
  String get recommendationEnvironmentalDataUnavailableBody;

  /// No description provided for @actionCheckInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'Check your internet connection'**
  String get actionCheckInternetConnection;

  /// No description provided for @actionRefreshEnvironmentalData.
  ///
  /// In en, this message translates to:
  /// **'Refresh the environmental data'**
  String get actionRefreshEnvironmentalData;

  /// No description provided for @actionReferOfficialChannels.
  ///
  /// In en, this message translates to:
  /// **'Refer to official NEA and PUB channels if conditions appear unsafe'**
  String get actionReferOfficialChannels;

  /// No description provided for @recommendationPsiUnavailable.
  ///
  /// In en, this message translates to:
  /// **'PSI reading unavailable'**
  String get recommendationPsiUnavailable;

  /// No description provided for @recommendationPsiUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'The latest air-quality reading could not be retrieved.'**
  String get recommendationPsiUnavailableBody;

  /// No description provided for @actionRefreshDataLater.
  ///
  /// In en, this message translates to:
  /// **'Refresh the data later'**
  String get actionRefreshDataLater;

  /// No description provided for @actionReferNeaHazeUpdates.
  ///
  /// In en, this message translates to:
  /// **'Refer to official NEA haze updates when planning outdoor activity'**
  String get actionReferNeaHazeUpdates;

  /// No description provided for @recommendationHaze.
  ///
  /// In en, this message translates to:
  /// **'Haze / Air Quality (PSI {psi})'**
  String recommendationHaze(int psi);

  /// No description provided for @psiBodyGood.
  ///
  /// In en, this message translates to:
  /// **'Air quality is within the Good range.'**
  String get psiBodyGood;

  /// No description provided for @psiBodyModerate.
  ///
  /// In en, this message translates to:
  /// **'Air quality is within the Moderate range. Most people can continue normal activities, while vulnerable individuals should monitor their health and symptoms.'**
  String get psiBodyModerate;

  /// No description provided for @psiBodyHigh.
  ///
  /// In en, this message translates to:
  /// **'Air quality is Unhealthy. Reduce prolonged or strenuous outdoor activity, particularly if you are vulnerable to air pollution.'**
  String get psiBodyHigh;

  /// No description provided for @psiBodyVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'Air quality is Very Unhealthy. Minimise outdoor activity and reduce exposure where possible.'**
  String get psiBodyVeryHigh;

  /// No description provided for @psiBodyExtreme.
  ///
  /// In en, this message translates to:
  /// **'Air quality is Hazardous. Remain indoors where possible and minimise exposure to outdoor air.'**
  String get psiBodyExtreme;

  /// No description provided for @actionContinueNormalActivities.
  ///
  /// In en, this message translates to:
  /// **'Continue normal activities'**
  String get actionContinueNormalActivities;

  /// No description provided for @actionMonitorEnvironmentalUpdates.
  ///
  /// In en, this message translates to:
  /// **'Monitor official environmental updates'**
  String get actionMonitorEnvironmentalUpdates;

  /// No description provided for @actionContinueNormalIfWell.
  ///
  /// In en, this message translates to:
  /// **'Continue normal activities if you feel well'**
  String get actionContinueNormalIfWell;

  /// No description provided for @actionMonitorHealthSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Monitor symptoms if you have heart or respiratory conditions'**
  String get actionMonitorHealthSymptoms;

  /// No description provided for @actionCheckPsiBeforeOutdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Check updated PSI readings before prolonged outdoor activity'**
  String get actionCheckPsiBeforeOutdoorActivity;

  /// No description provided for @actionReduceOutdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Reduce prolonged or strenuous outdoor activity'**
  String get actionReduceOutdoorActivity;

  /// No description provided for @actionWearN95Appropriate.
  ///
  /// In en, this message translates to:
  /// **'Wear a properly fitted N95 mask when appropriate'**
  String get actionWearN95Appropriate;

  /// No description provided for @actionKeepIndoorAirClean.
  ///
  /// In en, this message translates to:
  /// **'Keep indoor air as clean as reasonably possible'**
  String get actionKeepIndoorAirClean;

  /// No description provided for @actionSeekMedicalAdvice.
  ///
  /// In en, this message translates to:
  /// **'Seek medical advice if you feel unwell'**
  String get actionSeekMedicalAdvice;

  /// No description provided for @actionMinimiseOutdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Minimise outdoor activity'**
  String get actionMinimiseOutdoorActivity;

  /// No description provided for @actionRemainIndoors.
  ///
  /// In en, this message translates to:
  /// **'Remain indoors where possible'**
  String get actionRemainIndoors;

  /// No description provided for @actionWearN95IfUnavoidable.
  ///
  /// In en, this message translates to:
  /// **'Wear a properly fitted N95 mask if outdoor exposure is unavoidable'**
  String get actionWearN95IfUnavoidable;

  /// No description provided for @actionSeekHelpBreathing.
  ///
  /// In en, this message translates to:
  /// **'Seek medical help if breathing difficulties develop'**
  String get actionSeekHelpBreathing;

  /// No description provided for @actionAvoidOutdoorActivity.
  ///
  /// In en, this message translates to:
  /// **'Avoid outdoor activity where possible'**
  String get actionAvoidOutdoorActivity;

  /// No description provided for @actionCloseDoorsWindows.
  ///
  /// In en, this message translates to:
  /// **'Remain indoors with doors and windows closed'**
  String get actionCloseDoorsWindows;

  /// No description provided for @actionWearN95Outside.
  ///
  /// In en, this message translates to:
  /// **'Wear a properly fitted N95 mask if you must go outside'**
  String get actionWearN95Outside;

  /// No description provided for @actionSeekHelpSeriousSymptoms.
  ///
  /// In en, this message translates to:
  /// **'Seek medical help promptly if you experience serious symptoms'**
  String get actionSeekHelpSeriousSymptoms;

  /// No description provided for @recommendationUvUnavailable.
  ///
  /// In en, this message translates to:
  /// **'UV reading unavailable'**
  String get recommendationUvUnavailable;

  /// No description provided for @recommendationUvUnavailableBody.
  ///
  /// In en, this message translates to:
  /// **'The latest ultraviolet-index reading could not be retrieved.'**
  String get recommendationUvUnavailableBody;

  /// No description provided for @actionSunProtectionExtended.
  ///
  /// In en, this message translates to:
  /// **'Use sun protection when spending extended periods outdoors'**
  String get actionSunProtectionExtended;

  /// No description provided for @recommendationUvExposure.
  ///
  /// In en, this message translates to:
  /// **'UV Exposure (Index {uv})'**
  String recommendationUvExposure(int uv);

  /// No description provided for @uvBodyGood.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is Low. Minimal protection is normally required.'**
  String get uvBodyGood;

  /// No description provided for @uvBodyModerate.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is Moderate. Use sun protection during extended periods outdoors.'**
  String get uvBodyModerate;

  /// No description provided for @uvBodyHigh.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is High. Use sunscreen, protective clothing and shade, especially around midday.'**
  String get uvBodyHigh;

  /// No description provided for @uvBodyVeryHigh.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is Very High. Minimise direct midday sun exposure and use comprehensive sun protection.'**
  String get uvBodyVeryHigh;

  /// No description provided for @uvBodyExtreme.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is Extreme. Avoid unnecessary direct sun exposure during peak hours and use comprehensive protection.'**
  String get uvBodyExtreme;

  /// No description provided for @actionBasicSunProtection.
  ///
  /// In en, this message translates to:
  /// **'Use basic sun protection during extended outdoor exposure'**
  String get actionBasicSunProtection;

  /// No description provided for @actionApplySunscreen.
  ///
  /// In en, this message translates to:
  /// **'Apply broad-spectrum SPF 30+ sunscreen'**
  String get actionApplySunscreen;

  /// No description provided for @actionWearSunglasses.
  ///
  /// In en, this message translates to:
  /// **'Wear sunglasses during extended outdoor activity'**
  String get actionWearSunglasses;

  /// No description provided for @actionSeekShade.
  ///
  /// In en, this message translates to:
  /// **'Seek shade when practical'**
  String get actionSeekShade;

  /// No description provided for @actionReapplySunscreen.
  ///
  /// In en, this message translates to:
  /// **'Reapply sunscreen according to product directions'**
  String get actionReapplySunscreen;

  /// No description provided for @actionWearHatSunglassesClothing.
  ///
  /// In en, this message translates to:
  /// **'Wear a hat, sunglasses and protective clothing'**
  String get actionWearHatSunglassesClothing;

  /// No description provided for @actionSeekMiddayShade.
  ///
  /// In en, this message translates to:
  /// **'Seek shade during midday hours'**
  String get actionSeekMiddayShade;

  /// No description provided for @actionMinimiseMiddaySun.
  ///
  /// In en, this message translates to:
  /// **'Minimise direct sun exposure around midday'**
  String get actionMinimiseMiddaySun;

  /// No description provided for @actionWearProtectiveClothing.
  ///
  /// In en, this message translates to:
  /// **'Wear protective clothing, a hat and sunglasses'**
  String get actionWearProtectiveClothing;

  /// No description provided for @actionRegularlyReapplySunscreen.
  ///
  /// In en, this message translates to:
  /// **'Apply and regularly reapply SPF 30+ sunscreen'**
  String get actionRegularlyReapplySunscreen;

  /// No description provided for @actionTakeShadeBreaks.
  ///
  /// In en, this message translates to:
  /// **'Take regular shade breaks when working outdoors'**
  String get actionTakeShadeBreaks;

  /// No description provided for @actionAvoidMiddaySun.
  ///
  /// In en, this message translates to:
  /// **'Avoid unnecessary direct sun exposure around midday'**
  String get actionAvoidMiddaySun;

  /// No description provided for @actionUseShadeProtectiveClothing.
  ///
  /// In en, this message translates to:
  /// **'Use shade and protective clothing'**
  String get actionUseShadeProtectiveClothing;

  /// No description provided for @actionOutdoorWorkersShadeBreaks.
  ///
  /// In en, this message translates to:
  /// **'Outdoor workers should take frequent shaded rest breaks'**
  String get actionOutdoorWorkersShadeBreaks;

  /// No description provided for @recommendationHeavyRain.
  ///
  /// In en, this message translates to:
  /// **'Heavy Rainfall Alert'**
  String get recommendationHeavyRain;

  /// No description provided for @heavyRainBodyOne.
  ///
  /// In en, this message translates to:
  /// **'One weather station is reporting rainfall above the configured heavy-rain threshold. Flooding may occur in vulnerable or low-lying areas.'**
  String get heavyRainBodyOne;

  /// No description provided for @heavyRainBodyMany.
  ///
  /// In en, this message translates to:
  /// **'{count} weather stations are reporting rainfall above the configured heavy-rain threshold. Flooding may occur in vulnerable or low-lying areas.'**
  String heavyRainBodyMany(int count);

  /// No description provided for @actionAvoidFloodWater.
  ///
  /// In en, this message translates to:
  /// **'Avoid entering moving or deep flood water'**
  String get actionAvoidFloodWater;

  /// No description provided for @actionCheckPubUpdates.
  ///
  /// In en, this message translates to:
  /// **'Check official PUB flood and heavy-rain updates'**
  String get actionCheckPubUpdates;

  /// No description provided for @actionAvoidFloodProneRoutes.
  ///
  /// In en, this message translates to:
  /// **'Avoid flood-prone or low-lying routes'**
  String get actionAvoidFloodProneRoutes;

  /// No description provided for @actionKeepEmergencyDevices.
  ///
  /// In en, this message translates to:
  /// **'Keep a charged phone, torch and power bank available'**
  String get actionKeepEmergencyDevices;

  /// No description provided for @recommendationFavourable.
  ///
  /// In en, this message translates to:
  /// **'Conditions look favourable'**
  String get recommendationFavourable;

  /// No description provided for @recommendationFavourableBody.
  ///
  /// In en, this message translates to:
  /// **'Current available PSI and UV readings are within lower-risk ranges, and no heavy-rain threshold has been detected.'**
  String get recommendationFavourableBody;

  /// No description provided for @actionContinueMonitoring.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring environmental updates'**
  String get actionContinueMonitoring;

  /// No description provided for @actionReviewEmergencyKit.
  ///
  /// In en, this message translates to:
  /// **'Review your emergency kit and preparedness checklist'**
  String get actionReviewEmergencyKit;

  /// No description provided for @actionCompletePreparednessActivity.
  ///
  /// In en, this message translates to:
  /// **'Complete a preparedness activity to maintain awareness'**
  String get actionCompletePreparednessActivity;

  /// No description provided for @psiGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get psiGood;

  /// No description provided for @psiModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get psiModerate;

  /// No description provided for @psiUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Unhealthy'**
  String get psiUnhealthy;

  /// No description provided for @psiVeryUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Very Unhealthy'**
  String get psiVeryUnhealthy;

  /// No description provided for @psiHazardous.
  ///
  /// In en, this message translates to:
  /// **'Hazardous'**
  String get psiHazardous;

  /// No description provided for @todayTitle.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayTitle;

  /// No description provided for @todayDescription.
  ///
  /// In en, this message translates to:
  /// **'Your personalised preparedness plan for today.'**
  String get todayDescription;

  /// No description provided for @todayPlanError.
  ///
  /// In en, this message translates to:
  /// **'Unable to generate today’s preparedness plan.'**
  String get todayPlanError;

  /// No description provided for @todayProgressError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load today’s progress.'**
  String get todayProgressError;

  /// No description provided for @todayEnvironmentError.
  ///
  /// In en, this message translates to:
  /// **'Unable to prepare today’s environmental context.'**
  String get todayEnvironmentError;

  /// No description provided for @completeTasksBeforeClaiming.
  ///
  /// In en, this message translates to:
  /// **'Complete all tasks before claiming your XP.'**
  String get completeTasksBeforeClaiming;

  /// No description provided for @claimTodayReward.
  ///
  /// In en, this message translates to:
  /// **'Claim today’s reward?'**
  String get claimTodayReward;

  /// No description provided for @claimRewardDescription.
  ///
  /// In en, this message translates to:
  /// **'Make sure you’re happy with today’s completed actions before claiming your XP.'**
  String get claimRewardDescription;

  /// No description provided for @notYet.
  ///
  /// In en, this message translates to:
  /// **'Not yet'**
  String get notYet;

  /// No description provided for @claimXp.
  ///
  /// In en, this message translates to:
  /// **'Claim {xp} XP'**
  String claimXp(int xp);

  /// No description provided for @planComplete.
  ///
  /// In en, this message translates to:
  /// **'Plan Complete!'**
  String get planComplete;

  /// No description provided for @planCompleteDescription.
  ///
  /// In en, this message translates to:
  /// **'Great work completing today’s preparedness actions.'**
  String get planCompleteDescription;

  /// No description provided for @awesome.
  ///
  /// In en, this message translates to:
  /// **'Awesome!'**
  String get awesome;

  /// No description provided for @personalisedForYou.
  ///
  /// In en, this message translates to:
  /// **'Personalised for you'**
  String get personalisedForYou;

  /// No description provided for @yourRoutine.
  ///
  /// In en, this message translates to:
  /// **'YOUR ROUTINE'**
  String get yourRoutine;

  /// No description provided for @todaysFocus.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S FOCUS'**
  String get todaysFocus;

  /// No description provided for @moreTimeOutdoors.
  ///
  /// In en, this message translates to:
  /// **'You spend more time outdoors'**
  String get moreTimeOutdoors;

  /// No description provided for @moderatelyActiveOutdoors.
  ///
  /// In en, this message translates to:
  /// **'You’re moderately active outdoors'**
  String get moderatelyActiveOutdoors;

  /// No description provided for @usuallyOutdoorsMidday.
  ///
  /// In en, this message translates to:
  /// **'Usually outdoors at midday'**
  String get usuallyOutdoorsMidday;

  /// No description provided for @airQuality.
  ///
  /// In en, this message translates to:
  /// **'Air quality'**
  String get airQuality;

  /// No description provided for @heatSafety.
  ///
  /// In en, this message translates to:
  /// **'Heat safety'**
  String get heatSafety;

  /// No description provided for @uvProtection.
  ///
  /// In en, this message translates to:
  /// **'UV protection'**
  String get uvProtection;

  /// No description provided for @todayPlanAdapts.
  ///
  /// In en, this message translates to:
  /// **'Today’s plan adapts to your routine and current environmental conditions.'**
  String get todayPlanAdapts;

  /// No description provided for @todaysActions.
  ///
  /// In en, this message translates to:
  /// **'Today’s actions'**
  String get todaysActions;

  /// No description provided for @todaysActionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete the recommended actions below to build today’s preparedness.'**
  String get todaysActionsDescription;

  /// No description provided for @rewardClaimed.
  ///
  /// In en, this message translates to:
  /// **'Reward claimed'**
  String get rewardClaimed;

  /// No description provided for @completeOneMoreTask.
  ///
  /// In en, this message translates to:
  /// **'Complete 1 more task'**
  String get completeOneMoreTask;

  /// No description provided for @completeMoreTasks.
  ///
  /// In en, this message translates to:
  /// **'Complete {count} more tasks'**
  String completeMoreTasks(int count);

  /// No description provided for @todaysConditions.
  ///
  /// In en, this message translates to:
  /// **'Today’s conditions'**
  String get todaysConditions;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority: {focus}'**
  String priority(String focus);

  /// No description provided for @whyThisPlan.
  ///
  /// In en, this message translates to:
  /// **'Why this plan?'**
  String get whyThisPlan;

  /// No description provided for @heavyRain.
  ///
  /// In en, this message translates to:
  /// **'Heavy rain'**
  String get heavyRain;

  /// No description provided for @focusRainPreparation.
  ///
  /// In en, this message translates to:
  /// **'Rain preparation'**
  String get focusRainPreparation;

  /// No description provided for @focusAirQualitySunProtection.
  ///
  /// In en, this message translates to:
  /// **'Air quality & sun protection'**
  String get focusAirQualitySunProtection;

  /// No description provided for @focusAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air quality'**
  String get focusAirQuality;

  /// No description provided for @focusSunProtection.
  ///
  /// In en, this message translates to:
  /// **'Sun protection'**
  String get focusSunProtection;

  /// No description provided for @focusGeneralPreparedness.
  ///
  /// In en, this message translates to:
  /// **'General preparedness'**
  String get focusGeneralPreparedness;

  /// No description provided for @dailyPreparedness.
  ///
  /// In en, this message translates to:
  /// **'Daily preparedness'**
  String get dailyPreparedness;

  /// No description provided for @allActionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All {total} actions completed'**
  String allActionsCompleted(int total);

  /// No description provided for @actionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} actions completed'**
  String actionsCompleted(int completed, int total);

  /// No description provided for @tasksLeft.
  ///
  /// In en, this message translates to:
  /// **'{count} left'**
  String tasksLeft(int count);

  /// No description provided for @counterProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {target} {unit}'**
  String counterProgress(int current, int target, String unit);

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'completed'**
  String get completed;

  /// No description provided for @missionRewardClaimedMessage.
  ///
  /// In en, this message translates to:
  /// **'Reward claimed. Return tomorrow for a new preparedness plan.'**
  String get missionRewardClaimedMessage;

  /// No description provided for @missionCompleteMessage.
  ///
  /// In en, this message translates to:
  /// **'Great work. Your daily reward is ready.'**
  String get missionCompleteMessage;

  /// No description provided for @missionStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Start with one small action to improve today’s preparedness.'**
  String get missionStartMessage;

  /// No description provided for @missionGoodStartMessage.
  ///
  /// In en, this message translates to:
  /// **'Good start. Continue with the remaining actions.'**
  String get missionGoodStartMessage;

  /// No description provided for @missionOneRemainingMessage.
  ///
  /// In en, this message translates to:
  /// **'You’re almost there. Only one action remains.'**
  String get missionOneRemainingMessage;

  /// No description provided for @missionRemainingMessage.
  ///
  /// In en, this message translates to:
  /// **'You’re almost there. Complete the remaining actions.'**
  String get missionRemainingMessage;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @noDailyMission.
  ///
  /// In en, this message translates to:
  /// **'No daily mission is currently available. Refresh the environmental data and try again.'**
  String get noDailyMission;

  /// No description provided for @taskReviewConditionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Review today’s conditions'**
  String get taskReviewConditionsTitle;

  /// No description provided for @taskReviewConditionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Check the current PSI, UV Index, temperature and rainfall conditions before planning outdoor activities.'**
  String get taskReviewConditionsDescription;

  /// No description provided for @taskReviewConditionsReason.
  ///
  /// In en, this message translates to:
  /// **'Reviewing live conditions helps you choose the right precautions before heading outdoors.'**
  String get taskReviewConditionsReason;

  /// No description provided for @taskMonitorAirQualityTitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor the air quality'**
  String get taskMonitorAirQualityTitle;

  /// No description provided for @taskMonitorAirQualityDescription.
  ///
  /// In en, this message translates to:
  /// **'Check the PSI again before prolonged outdoor activity, especially if you are sensitive to haze.'**
  String get taskMonitorAirQualityDescription;

  /// No description provided for @taskMonitorAirQualityReason.
  ///
  /// In en, this message translates to:
  /// **'The current PSI indicates that additional caution may be useful, particularly for sensitive individuals.'**
  String get taskMonitorAirQualityReason;

  /// No description provided for @taskPackN95Title.
  ///
  /// In en, this message translates to:
  /// **'Pack an N95 mask'**
  String get taskPackN95Title;

  /// No description provided for @taskPackN95Description.
  ///
  /// In en, this message translates to:
  /// **'Bring a properly fitted N95 mask if outdoor activity cannot be avoided.'**
  String get taskPackN95Description;

  /// No description provided for @taskPackN95Reason.
  ///
  /// In en, this message translates to:
  /// **'Air quality is currently unhealthy enough for additional protection to be recommended outdoors.'**
  String get taskPackN95Reason;

  /// No description provided for @taskReduceOutdoorExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Reduce strenuous outdoor activity'**
  String get taskReduceOutdoorExerciseTitle;

  /// No description provided for @taskReduceOutdoorExerciseDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose lighter or indoor activities while the air quality is unhealthy.'**
  String get taskReduceOutdoorExerciseDescription;

  /// No description provided for @taskReduceOutdoorExerciseReason.
  ///
  /// In en, this message translates to:
  /// **'Strenuous activity increases breathing rate and may increase exposure to air pollutants.'**
  String get taskReduceOutdoorExerciseReason;

  /// No description provided for @taskStayIndoorsHazeTitle.
  ///
  /// In en, this message translates to:
  /// **'Stay indoors where possible'**
  String get taskStayIndoorsHazeTitle;

  /// No description provided for @taskStayIndoorsHazeDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep windows and doors closed and minimise unnecessary outdoor exposure.'**
  String get taskStayIndoorsHazeDescription;

  /// No description provided for @taskStayIndoorsHazeReason.
  ///
  /// In en, this message translates to:
  /// **'Current air-quality conditions indicate a high level of exposure risk outdoors.'**
  String get taskStayIndoorsHazeReason;

  /// No description provided for @taskPrepareN95HazeTitle.
  ///
  /// In en, this message translates to:
  /// **'Keep an N95 mask ready'**
  String get taskPrepareN95HazeTitle;

  /// No description provided for @taskPrepareN95HazeDescription.
  ///
  /// In en, this message translates to:
  /// **'Use an N95 mask if leaving the house is unavoidable.'**
  String get taskPrepareN95HazeDescription;

  /// No description provided for @taskPrepareN95HazeReason.
  ///
  /// In en, this message translates to:
  /// **'An N95 mask can help reduce exposure to fine haze particles during poor air-quality conditions.'**
  String get taskPrepareN95HazeReason;

  /// No description provided for @taskCheckHazeSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Monitor your health'**
  String get taskCheckHazeSymptomsTitle;

  /// No description provided for @taskCheckHazeSymptomsDescription.
  ///
  /// In en, this message translates to:
  /// **'Watch for breathing difficulty, coughing or eye irritation.'**
  String get taskCheckHazeSymptomsDescription;

  /// No description provided for @taskCheckHazeSymptomsReason.
  ///
  /// In en, this message translates to:
  /// **'Very poor air quality may affect respiratory comfort and other health symptoms.'**
  String get taskCheckHazeSymptomsReason;

  /// No description provided for @taskApplySunscreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Apply sunscreen'**
  String get taskApplySunscreenTitle;

  /// No description provided for @taskApplySunscreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.'**
  String get taskApplySunscreenDescription;

  /// No description provided for @taskApplySunscreenReason.
  ///
  /// In en, this message translates to:
  /// **'Today’s UV level means sun protection is recommended before going outdoors.'**
  String get taskApplySunscreenReason;

  /// No description provided for @taskSeekMiddayShadeTitle.
  ///
  /// In en, this message translates to:
  /// **'Seek shade around midday'**
  String get taskSeekMiddayShadeTitle;

  /// No description provided for @taskSeekMiddayShadeDescription.
  ///
  /// In en, this message translates to:
  /// **'Limit direct sun exposure during the strongest UV period.'**
  String get taskSeekMiddayShadeDescription;

  /// No description provided for @taskSeekMiddayShadeReason.
  ///
  /// In en, this message translates to:
  /// **'UV exposure is typically stronger around midday, making shade an effective protective measure.'**
  String get taskSeekMiddayShadeReason;

  /// No description provided for @taskReapplySunscreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Reapply sunscreen'**
  String get taskReapplySunscreenTitle;

  /// No description provided for @taskReapplySunscreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Reapply sunscreen according to the product instructions, especially after sweating.'**
  String get taskReapplySunscreenDescription;

  /// No description provided for @taskReapplySunscreenReason.
  ///
  /// In en, this message translates to:
  /// **'Very high UV exposure can require continued protection during prolonged outdoor activity.'**
  String get taskReapplySunscreenReason;

  /// No description provided for @taskWearSunProtectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Wear sun protection'**
  String get taskWearSunProtectionTitle;

  /// No description provided for @taskWearSunProtectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Bring a hat, sunglasses and protective clothing.'**
  String get taskWearSunProtectionDescription;

  /// No description provided for @taskWearSunProtectionReason.
  ///
  /// In en, this message translates to:
  /// **'Additional physical protection helps reduce direct UV exposure to the skin and eyes.'**
  String get taskWearSunProtectionReason;

  /// No description provided for @taskAvoidMiddaySunTitle.
  ///
  /// In en, this message translates to:
  /// **'Avoid prolonged midday sun'**
  String get taskAvoidMiddaySunTitle;

  /// No description provided for @taskAvoidMiddaySunDescription.
  ///
  /// In en, this message translates to:
  /// **'Move strenuous outdoor plans away from the strongest UV period.'**
  String get taskAvoidMiddaySunDescription;

  /// No description provided for @taskAvoidMiddaySunReason.
  ///
  /// In en, this message translates to:
  /// **'Very high UV levels make prolonged exposure around midday less advisable.'**
  String get taskAvoidMiddaySunReason;

  /// No description provided for @taskCarryWaterHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Bring water with you'**
  String get taskCarryWaterHeatTitle;

  /// No description provided for @taskCarryWaterHeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep water available if you will be spending time outdoors.'**
  String get taskCarryWaterHeatDescription;

  /// No description provided for @taskCarryWaterHeatReason.
  ///
  /// In en, this message translates to:
  /// **'Current WBGT conditions indicate Moderate heat stress.'**
  String get taskCarryWaterHeatReason;

  /// No description provided for @taskHydrationGoalHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Track your water intake'**
  String get taskHydrationGoalHeatTitle;

  /// No description provided for @taskHydrationGoalHeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Record six glasses of water during the day.'**
  String get taskHydrationGoalHeatDescription;

  /// No description provided for @taskHydrationGoalHeatReason.
  ///
  /// In en, this message translates to:
  /// **'Current WBGT conditions indicate High heat stress.'**
  String get taskHydrationGoalHeatReason;

  /// No description provided for @taskCoolingBreakHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Take regular cooling breaks'**
  String get taskCoolingBreakHeatTitle;

  /// No description provided for @taskCoolingBreakHeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Spend regular breaks in shaded, ventilated or air-conditioned areas.'**
  String get taskCoolingBreakHeatDescription;

  /// No description provided for @taskCoolingBreakHeatReason.
  ///
  /// In en, this message translates to:
  /// **'High heat-stress conditions increase the need for rest and cooling.'**
  String get taskCoolingBreakHeatReason;

  /// No description provided for @taskReduceOutdoorHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Reduce strenuous outdoor activity'**
  String get taskReduceOutdoorHeatTitle;

  /// No description provided for @taskReduceOutdoorHeatDescription.
  ///
  /// In en, this message translates to:
  /// **'Choose lighter activity or move strenuous plans to a cooler part of the day.'**
  String get taskReduceOutdoorHeatDescription;

  /// No description provided for @taskReduceOutdoorHeatReason.
  ///
  /// In en, this message translates to:
  /// **'Current WBGT conditions indicate High heat stress.'**
  String get taskReduceOutdoorHeatReason;

  /// No description provided for @taskRainPreparationTitle.
  ///
  /// In en, this message translates to:
  /// **'Prepare for heavy rain'**
  String get taskRainPreparationTitle;

  /// No description provided for @taskRainPreparationDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete the key steps before travelling during heavy rainfall.'**
  String get taskRainPreparationDescription;

  /// No description provided for @taskRainPreparationReason.
  ///
  /// In en, this message translates to:
  /// **'Heavy rainfall has been detected and may affect travel, flood risk and access to weather updates.'**
  String get taskRainPreparationReason;

  /// No description provided for @estimatedOneMinute.
  ///
  /// In en, this message translates to:
  /// **'1 minute'**
  String get estimatedOneMinute;

  /// No description provided for @estimatedThirtySeconds.
  ///
  /// In en, this message translates to:
  /// **'30 seconds'**
  String get estimatedThirtySeconds;

  /// No description provided for @estimatedThroughoutDay.
  ///
  /// In en, this message translates to:
  /// **'Throughout the day'**
  String get estimatedThroughoutDay;

  /// No description provided for @estimatedPlanToday.
  ///
  /// In en, this message translates to:
  /// **'Plan for today'**
  String get estimatedPlanToday;

  /// No description provided for @estimatedTwoThreeMinutes.
  ///
  /// In en, this message translates to:
  /// **'2–3 minutes'**
  String get estimatedTwoThreeMinutes;

  /// No description provided for @unitSteps.
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get unitSteps;

  /// No description provided for @unitGlasses.
  ///
  /// In en, this message translates to:
  /// **'glasses'**
  String get unitGlasses;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// No description provided for @complete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get complete;

  /// No description provided for @hydrationProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {target} glasses'**
  String hydrationProgress(int current, int target);

  /// No description provided for @undoLastGlass.
  ///
  /// In en, this message translates to:
  /// **'Undo last glass'**
  String get undoLastGlass;

  /// No description provided for @hydrationComplete.
  ///
  /// In en, this message translates to:
  /// **'Hydration complete'**
  String get hydrationComplete;

  /// No description provided for @iDrankAGlass.
  ///
  /// In en, this message translates to:
  /// **'I drank a glass'**
  String get iDrankAGlass;

  /// No description provided for @hydrationGoalComplete.
  ///
  /// In en, this message translates to:
  /// **'Hydration goal complete!'**
  String get hydrationGoalComplete;

  /// No description provided for @xpWhenPlanClaimed.
  ///
  /// In en, this message translates to:
  /// **'+{xp} XP when today’s plan is claimed'**
  String xpWhenPlanClaimed(int xp);

  /// No description provided for @sunscreenApplied.
  ///
  /// In en, this message translates to:
  /// **'Sunscreen applied'**
  String get sunscreenApplied;

  /// No description provided for @coveragePercent.
  ///
  /// In en, this message translates to:
  /// **'{percent}% covered'**
  String coveragePercent(int percent);

  /// No description provided for @applySunscreenButton.
  ///
  /// In en, this message translates to:
  /// **'Apply sunscreen'**
  String get applySunscreenButton;

  /// No description provided for @rainStepsReady.
  ///
  /// In en, this message translates to:
  /// **'{current} of {target} steps ready'**
  String rainStepsReady(int current, int target);

  /// No description provided for @rainReadyProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} of {target} ready'**
  String rainReadyProgress(int current, int target);

  /// No description provided for @undoLastStep.
  ///
  /// In en, this message translates to:
  /// **'Undo last step'**
  String get undoLastStep;

  /// No description provided for @packUmbrella.
  ///
  /// In en, this message translates to:
  /// **'Pack an umbrella'**
  String get packUmbrella;

  /// No description provided for @checkFloodAlerts.
  ///
  /// In en, this message translates to:
  /// **'Check flood alerts'**
  String get checkFloodAlerts;

  /// No description provided for @reviewYourRoute.
  ///
  /// In en, this message translates to:
  /// **'Review your route'**
  String get reviewYourRoute;

  /// No description provided for @chargePowerBank.
  ///
  /// In en, this message translates to:
  /// **'Charge your power bank'**
  String get chargePowerBank;

  /// No description provided for @rainPrepComplete.
  ///
  /// In en, this message translates to:
  /// **'Rain prep complete'**
  String get rainPrepComplete;

  /// No description provided for @completeNextStep.
  ///
  /// In en, this message translates to:
  /// **'Complete next step'**
  String get completeNextStep;

  /// No description provided for @missionGoodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get missionGoodMorning;

  /// No description provided for @missionGoodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get missionGoodAfternoon;

  /// No description provided for @missionGoodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get missionGoodEvening;

  /// No description provided for @missionRainTitle.
  ///
  /// In en, this message translates to:
  /// **'Rain preparedness is recommended'**
  String get missionRainTitle;

  /// No description provided for @missionRainMessage.
  ///
  /// In en, this message translates to:
  /// **'Heavy rainfall may affect travel and outdoor plans. Review today’s rain and flood-safety actions.'**
  String get missionRainMessage;

  /// No description provided for @missionHeatUvTitle.
  ///
  /// In en, this message translates to:
  /// **'Heat and UV precautions are recommended'**
  String get missionHeatUvTitle;

  /// No description provided for @missionHeatUvMessage.
  ///
  /// In en, this message translates to:
  /// **'Heat stress and UV exposure may affect outdoor activity today. Stay hydrated, use sun protection and take regular cooling breaks.'**
  String get missionHeatUvMessage;

  /// No description provided for @missionHeatTitle.
  ///
  /// In en, this message translates to:
  /// **'Heat precautions are recommended'**
  String get missionHeatTitle;

  /// No description provided for @missionHeatMessage.
  ///
  /// In en, this message translates to:
  /// **'Heat stress is elevated today. Stay hydrated, take cooling breaks and reduce strenuous outdoor activity where possible.'**
  String get missionHeatMessage;

  /// No description provided for @missionHazeUvTitle.
  ///
  /// In en, this message translates to:
  /// **'Air-quality and UV precautions are recommended'**
  String get missionHazeUvTitle;

  /// No description provided for @missionHazeUvMessage.
  ///
  /// In en, this message translates to:
  /// **'Review both air-quality and sun-protection actions before spending time outdoors.'**
  String get missionHazeUvMessage;

  /// No description provided for @missionHazeTitle.
  ///
  /// In en, this message translates to:
  /// **'Air-quality precautions are recommended'**
  String get missionHazeTitle;

  /// No description provided for @missionHazeMessage.
  ///
  /// In en, this message translates to:
  /// **'Monitor the PSI and adjust prolonged outdoor activities where necessary.'**
  String get missionHazeMessage;

  /// No description provided for @missionUvTitle.
  ///
  /// In en, this message translates to:
  /// **'UV protection is recommended'**
  String get missionUvTitle;

  /// No description provided for @missionUvMessage.
  ///
  /// In en, this message translates to:
  /// **'Sun protection and hydration may be important for outdoor activities today.'**
  String get missionUvMessage;

  /// No description provided for @missionGeneralTitle.
  ///
  /// In en, this message translates to:
  /// **'Conditions are generally manageable'**
  String get missionGeneralTitle;

  /// No description provided for @missionGeneralMessage.
  ///
  /// In en, this message translates to:
  /// **'Review today’s readings and complete the basic preparedness actions.'**
  String get missionGeneralMessage;

  /// No description provided for @riskUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get riskUnknown;

  /// No description provided for @riskNoData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get riskNoData;

  /// No description provided for @psiReading.
  ///
  /// In en, this message translates to:
  /// **'PSI {value} · {label}'**
  String psiReading(String value, String label);

  /// No description provided for @uvReading.
  ///
  /// In en, this message translates to:
  /// **'UV {value} · {label}'**
  String uvReading(String value, String label);

  /// No description provided for @heatStressReading.
  ///
  /// In en, this message translates to:
  /// **'Heat stress · {label}'**
  String heatStressReading(String label);

  /// No description provided for @taskApplySunscreenModerateDescription.
  ///
  /// In en, this message translates to:
  /// **'Apply broad-spectrum SPF 30+ sunscreen before prolonged outdoor activity.'**
  String get taskApplySunscreenModerateDescription;

  /// No description provided for @taskApplySunscreenModerateReason.
  ///
  /// In en, this message translates to:
  /// **'Today’s UV level means sun protection is recommended when spending extended time outdoors.'**
  String get taskApplySunscreenModerateReason;

  /// No description provided for @taskApplySunscreenHighDescription.
  ///
  /// In en, this message translates to:
  /// **'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.'**
  String get taskApplySunscreenHighDescription;

  /// No description provided for @taskApplySunscreenHighReason.
  ///
  /// In en, this message translates to:
  /// **'The UV Index is high today, so sun protection is recommended before outdoor activity.'**
  String get taskApplySunscreenHighReason;

  /// No description provided for @taskApplySunscreenVeryHighDescription.
  ///
  /// In en, this message translates to:
  /// **'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.'**
  String get taskApplySunscreenVeryHighDescription;

  /// No description provided for @taskApplySunscreenVeryHighReason.
  ///
  /// In en, this message translates to:
  /// **'Today’s UV level means strong sun protection is recommended before going outdoors.'**
  String get taskApplySunscreenVeryHighReason;

  /// No description provided for @exploreTitle.
  ///
  /// In en, this message translates to:
  /// **'Explore Singapore'**
  String get exploreTitle;

  /// No description provided for @exploreDescription.
  ///
  /// In en, this message translates to:
  /// **'Explore environmental conditions across Singapore.'**
  String get exploreDescription;

  /// No description provided for @exploreHeat.
  ///
  /// In en, this message translates to:
  /// **'Heat'**
  String get exploreHeat;

  /// No description provided for @explorePsi.
  ///
  /// In en, this message translates to:
  /// **'PSI'**
  String get explorePsi;

  /// No description provided for @exploreRain.
  ///
  /// In en, this message translates to:
  /// **'Rain'**
  String get exploreRain;

  /// No description provided for @exploreFindNearMe.
  ///
  /// In en, this message translates to:
  /// **'Find conditions near me'**
  String get exploreFindNearMe;

  /// No description provided for @exploreTapMarker.
  ///
  /// In en, this message translates to:
  /// **'Tap a marker to view details'**
  String get exploreTapMarker;

  /// No description provided for @exploreLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get exploreLow;

  /// No description provided for @exploreModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get exploreModerate;

  /// No description provided for @exploreHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get exploreHigh;

  /// No description provided for @exploreHeatStress.
  ///
  /// In en, this message translates to:
  /// **'Heat Stress'**
  String get exploreHeatStress;

  /// No description provided for @exploreWbgtStationsReporting.
  ///
  /// In en, this message translates to:
  /// **'{count} WBGT stations reporting'**
  String exploreWbgtStationsReporting(int count);

  /// No description provided for @exploreHighestObserved.
  ///
  /// In en, this message translates to:
  /// **'Highest observed'**
  String get exploreHighestObserved;

  /// No description provided for @exploreForYou.
  ///
  /// In en, this message translates to:
  /// **'For you: '**
  String get exploreForYou;

  /// No description provided for @exploreHeatAdvice.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated and take regular cooling breaks.'**
  String get exploreHeatAdvice;

  /// No description provided for @exploreUnableLoadHeat.
  ///
  /// In en, this message translates to:
  /// **'Unable to load heat-stress data.'**
  String get exploreUnableLoadHeat;

  /// No description provided for @exploreNoWbgtObservations.
  ///
  /// In en, this message translates to:
  /// **'No current WBGT observations are available.'**
  String get exploreNoWbgtObservations;

  /// No description provided for @exploreHeatStressLabel.
  ///
  /// In en, this message translates to:
  /// **'Heat stress'**
  String get exploreHeatStressLabel;

  /// No description provided for @exploreRegion.
  ///
  /// In en, this message translates to:
  /// **'Region'**
  String get exploreRegion;

  /// No description provided for @exploreLatestStationReading.
  ///
  /// In en, this message translates to:
  /// **'Latest observed station reading'**
  String get exploreLatestStationReading;

  /// No description provided for @exploreMetresAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} m away'**
  String exploreMetresAway(int distance);

  /// No description provided for @exploreKilometresAway.
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String exploreKilometresAway(String distance);

  /// No description provided for @exploreUnableLoadPsi.
  ///
  /// In en, this message translates to:
  /// **'Unable to load PSI data.'**
  String get exploreUnableLoadPsi;

  /// No description provided for @exploreNoRegionalPsi.
  ///
  /// In en, this message translates to:
  /// **'No current regional PSI readings are available.'**
  String get exploreNoRegionalPsi;

  /// No description provided for @exploreAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air Quality'**
  String get exploreAirQuality;

  /// No description provided for @exploreSingaporeRegionalPsi.
  ///
  /// In en, this message translates to:
  /// **'Singapore regional PSI'**
  String get exploreSingaporeRegionalPsi;

  /// No description provided for @exploreBasedOnLocation.
  ///
  /// In en, this message translates to:
  /// **'Based on your approximate location'**
  String get exploreBasedOnLocation;

  /// No description provided for @exploreAirQualityLabel.
  ///
  /// In en, this message translates to:
  /// **'Air quality'**
  String get exploreAirQualityLabel;

  /// No description provided for @explorePsiAdviceGood.
  ///
  /// In en, this message translates to:
  /// **'Air quality is good. Normal activities can continue.'**
  String get explorePsiAdviceGood;

  /// No description provided for @explorePsiAdviceModerate.
  ///
  /// In en, this message translates to:
  /// **'Air quality is in the moderate range. Normal activities can generally continue.'**
  String get explorePsiAdviceModerate;

  /// No description provided for @explorePsiAdviceUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Air quality is unhealthy. Consider reducing prolonged or strenuous outdoor activity.'**
  String get explorePsiAdviceUnhealthy;

  /// No description provided for @explorePsiAdviceVeryUnhealthy.
  ///
  /// In en, this message translates to:
  /// **'Air quality is very unhealthy. Minimise prolonged outdoor activity.'**
  String get explorePsiAdviceVeryUnhealthy;

  /// No description provided for @explorePsiAdviceHazardous.
  ///
  /// In en, this message translates to:
  /// **'Air quality is hazardous. Avoid unnecessary outdoor activity.'**
  String get explorePsiAdviceHazardous;

  /// No description provided for @exploreUnableLoadRain.
  ///
  /// In en, this message translates to:
  /// **'Unable to load rainfall data.'**
  String get exploreUnableLoadRain;

  /// No description provided for @exploreNoRainfall.
  ///
  /// In en, this message translates to:
  /// **'No rainfall detected'**
  String get exploreNoRainfall;

  /// No description provided for @exploreNoRainfallDescription.
  ///
  /// In en, this message translates to:
  /// **'No rainfall is currently being recorded across reporting stations in Singapore.'**
  String get exploreNoRainfallDescription;

  /// No description provided for @exploreRainfall.
  ///
  /// In en, this message translates to:
  /// **'Rainfall'**
  String get exploreRainfall;

  /// No description provided for @exploreStationsReportingRain.
  ///
  /// In en, this message translates to:
  /// **'{count} station(s) currently reporting rain'**
  String exploreStationsReportingRain(int count);

  /// No description provided for @exploreRainLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get exploreRainLight;

  /// No description provided for @exploreRainModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get exploreRainModerate;

  /// No description provided for @exploreRainHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get exploreRainHeavy;

  /// No description provided for @exploreRainAdviceLight.
  ///
  /// In en, this message translates to:
  /// **'Carry an umbrella if you’re heading outdoors.'**
  String get exploreRainAdviceLight;

  /// No description provided for @exploreRainAdviceModerate.
  ///
  /// In en, this message translates to:
  /// **'Bring an umbrella and take care on wet paths and roads.'**
  String get exploreRainAdviceModerate;

  /// No description provided for @exploreRainAdviceHeavy.
  ///
  /// In en, this message translates to:
  /// **'Avoid flood-prone areas and check your route before travelling.'**
  String get exploreRainAdviceHeavy;

  /// No description provided for @exploreRainIntensity.
  ///
  /// In en, this message translates to:
  /// **'Intensity'**
  String get exploreRainIntensity;

  /// No description provided for @exploreLatestRainfallReading.
  ///
  /// In en, this message translates to:
  /// **'Latest observed rainfall reading'**
  String get exploreLatestRainfallReading;

  /// No description provided for @exploreLocationAccessNeeded.
  ///
  /// In en, this message translates to:
  /// **'Location access is needed to find conditions near you.'**
  String get exploreLocationAccessNeeded;

  /// No description provided for @exploreNoRainfallStations.
  ///
  /// In en, this message translates to:
  /// **'No rainfall stations are currently available.'**
  String get exploreNoRainfallStations;

  /// No description provided for @exploreNoRegionalPsiNearby.
  ///
  /// In en, this message translates to:
  /// **'No regional PSI readings are currently available.'**
  String get exploreNoRegionalPsiNearby;

  /// No description provided for @exploreUnableFindPsiArea.
  ///
  /// In en, this message translates to:
  /// **'Unable to find the PSI reading for your area.'**
  String get exploreUnableFindPsiArea;

  /// No description provided for @exploreNoWbgtStations.
  ///
  /// In en, this message translates to:
  /// **'No WBGT stations are currently available.'**
  String get exploreNoWbgtStations;

  /// No description provided for @exploreUnableFindNearby.
  ///
  /// In en, this message translates to:
  /// **'Unable to find nearby conditions.'**
  String get exploreUnableFindNearby;

  /// No description provided for @learnTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn & Prepare'**
  String get learnTitle;

  /// No description provided for @learnDescription.
  ///
  /// In en, this message translates to:
  /// **'Build your preparedness knowledge and skills.'**
  String get learnDescription;

  /// No description provided for @learnEmergencyHelp.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get learnEmergencyHelp;

  /// No description provided for @learnEmergencyHelpDescription.
  ///
  /// In en, this message translates to:
  /// **'Important Singapore emergency contacts and when to use them.'**
  String get learnEmergencyHelpDescription;

  /// No description provided for @learnTabMyKit.
  ///
  /// In en, this message translates to:
  /// **'My Kit'**
  String get learnTabMyKit;

  /// No description provided for @learnTabQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get learnTabQuizzes;

  /// No description provided for @learnTabScenarios.
  ///
  /// In en, this message translates to:
  /// **'Scenarios'**
  String get learnTabScenarios;

  /// No description provided for @learnMyEmergencyKit.
  ///
  /// In en, this message translates to:
  /// **'My Emergency Kit'**
  String get learnMyEmergencyKit;

  /// No description provided for @learnEmergencyKitDescription.
  ///
  /// In en, this message translates to:
  /// **'Build your emergency kit step by step.'**
  String get learnEmergencyKitDescription;

  /// No description provided for @learnQuickSkills.
  ///
  /// In en, this message translates to:
  /// **'Quick Skills'**
  String get learnQuickSkills;

  /// No description provided for @learnLearnInMinutes.
  ///
  /// In en, this message translates to:
  /// **'Learn in minutes'**
  String get learnLearnInMinutes;

  /// No description provided for @learnCprAed.
  ///
  /// In en, this message translates to:
  /// **'CPR & AED'**
  String get learnCprAed;

  /// No description provided for @learnLifeSavingBasics.
  ///
  /// In en, this message translates to:
  /// **'Life-saving basics'**
  String get learnLifeSavingBasics;

  /// No description provided for @learnVideoGuide.
  ///
  /// In en, this message translates to:
  /// **'Video guide'**
  String get learnVideoGuide;

  /// No description provided for @learnFlashFloodSafety.
  ///
  /// In en, this message translates to:
  /// **'Flash Flood Safety'**
  String get learnFlashFloodSafety;

  /// No description provided for @learnHeavyRainFloodSafety.
  ///
  /// In en, this message translates to:
  /// **'Heavy rain & flood safety'**
  String get learnHeavyRainFloodSafety;

  /// No description provided for @learnQuickGuide.
  ///
  /// In en, this message translates to:
  /// **'Quick guide'**
  String get learnQuickGuide;

  /// No description provided for @learnPreparednessCategories.
  ///
  /// In en, this message translates to:
  /// **'Preparedness Categories'**
  String get learnPreparednessCategories;

  /// No description provided for @learnKitReady.
  ///
  /// In en, this message translates to:
  /// **'{percentage}% Ready'**
  String learnKitReady(int percentage);

  /// No description provided for @learnKitComplete.
  ///
  /// In en, this message translates to:
  /// **'Your preparedness checklist is complete.'**
  String get learnKitComplete;

  /// No description provided for @learnKitItemsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} item(s) remaining.'**
  String learnKitItemsRemaining(int count);

  /// No description provided for @learnKitStatusEmergencyReady.
  ///
  /// In en, this message translates to:
  /// **'Emergency Ready'**
  String get learnKitStatusEmergencyReady;

  /// No description provided for @learnKitStatusWellPrepared.
  ///
  /// In en, this message translates to:
  /// **'Well Prepared'**
  String get learnKitStatusWellPrepared;

  /// No description provided for @learnKitStatusGettingPrepared.
  ///
  /// In en, this message translates to:
  /// **'Getting Prepared'**
  String get learnKitStatusGettingPrepared;

  /// No description provided for @learnKitStatusBasicPreparation.
  ///
  /// In en, this message translates to:
  /// **'Basic Preparation'**
  String get learnKitStatusBasicPreparation;

  /// No description provided for @learnKitStatusNeedsAttention.
  ///
  /// In en, this message translates to:
  /// **'Needs Attention'**
  String get learnKitStatusNeedsAttention;

  /// No description provided for @learnKitProgressError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your emergency-kit progress.'**
  String get learnKitProgressError;

  /// No description provided for @learnRecommendedComplete.
  ///
  /// In en, this message translates to:
  /// **'You already have the recommended items for today’s conditions.'**
  String get learnRecommendedComplete;

  /// No description provided for @learnRecommendedToday.
  ///
  /// In en, this message translates to:
  /// **'Recommended Today'**
  String get learnRecommendedToday;

  /// No description provided for @learnRecommendedBasedOnConditions.
  ///
  /// In en, this message translates to:
  /// **'Based on the current environmental conditions:'**
  String get learnRecommendedBasedOnConditions;

  /// No description provided for @learnCategoryHaze.
  ///
  /// In en, this message translates to:
  /// **'Haze'**
  String get learnCategoryHaze;

  /// No description provided for @learnCategoryUv.
  ///
  /// In en, this message translates to:
  /// **'UV'**
  String get learnCategoryUv;

  /// No description provided for @learnCategoryHeat.
  ///
  /// In en, this message translates to:
  /// **'Heat'**
  String get learnCategoryHeat;

  /// No description provided for @learnCategoryFlood.
  ///
  /// In en, this message translates to:
  /// **'Flood'**
  String get learnCategoryFlood;

  /// No description provided for @learnCategoryProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} completed · {percentage}%'**
  String learnCategoryProgress(int completed, int total, int percentage);

  /// No description provided for @learnItemAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'{item} added.'**
  String learnItemAddedMessage(String item);

  /// No description provided for @learnItemRemovedMessage.
  ///
  /// In en, this message translates to:
  /// **'{item} removed.'**
  String learnItemRemovedMessage(String item);

  /// No description provided for @learnItemUpdateError.
  ///
  /// In en, this message translates to:
  /// **'Unable to update the item. Please try again.'**
  String get learnItemUpdateError;

  /// No description provided for @learnAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get learnAdded;

  /// No description provided for @learnAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get learnAdd;

  /// No description provided for @learnWhyThisMatters.
  ///
  /// In en, this message translates to:
  /// **'Why this matters'**
  String get learnWhyThisMatters;

  /// No description provided for @learnAddedXp.
  ///
  /// In en, this message translates to:
  /// **'Added · +{points} XP'**
  String learnAddedXp(int points);

  /// No description provided for @learnXp.
  ///
  /// In en, this message translates to:
  /// **'+{points} XP'**
  String learnXp(int points);

  /// No description provided for @learnEarnXpWhenAdded.
  ///
  /// In en, this message translates to:
  /// **'Earn {points} XP when added.'**
  String learnEarnXpWhenAdded(int points);

  /// No description provided for @kitHazeMaskTitle.
  ///
  /// In en, this message translates to:
  /// **'N95 masks'**
  String get kitHazeMaskTitle;

  /// No description provided for @kitHazeMaskDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep at home & in your bag'**
  String get kitHazeMaskDescription;

  /// No description provided for @kitHazeMaskExplanation.
  ///
  /// In en, this message translates to:
  /// **'A properly fitted N95 mask can reduce exposure to fine haze particles when outdoor activity is unavoidable.'**
  String get kitHazeMaskExplanation;

  /// No description provided for @kitHazeMedsTitle.
  ///
  /// In en, this message translates to:
  /// **'Allergy medication'**
  String get kitHazeMedsTitle;

  /// No description provided for @kitHazeMedsDescription.
  ///
  /// In en, this message translates to:
  /// **'Keep nearby if needed'**
  String get kitHazeMedsDescription;

  /// No description provided for @kitHazeMedsExplanation.
  ///
  /// In en, this message translates to:
  /// **'Keep prescribed inhalers or allergy medication available if poor air quality affects you.'**
  String get kitHazeMedsExplanation;

  /// No description provided for @kitUvSunscreenTitle.
  ///
  /// In en, this message translates to:
  /// **'SPF 30+ sunscreen'**
  String get kitUvSunscreenTitle;

  /// No description provided for @kitUvSunscreenDescription.
  ///
  /// In en, this message translates to:
  /// **'Protect exposed skin outdoors'**
  String get kitUvSunscreenDescription;

  /// No description provided for @kitUvSunscreenExplanation.
  ///
  /// In en, this message translates to:
  /// **'Broad-spectrum SPF 30+ sunscreen helps protect exposed skin from ultraviolet radiation.'**
  String get kitUvSunscreenExplanation;

  /// No description provided for @kitUvHatTitle.
  ///
  /// In en, this message translates to:
  /// **'Hat & sunglasses'**
  String get kitUvHatTitle;

  /// No description provided for @kitUvHatDescription.
  ///
  /// In en, this message translates to:
  /// **'Extra protection from strong UV'**
  String get kitUvHatDescription;

  /// No description provided for @kitUvHatExplanation.
  ///
  /// In en, this message translates to:
  /// **'A hat and sunglasses provide additional protection during periods of high UV exposure.'**
  String get kitUvHatExplanation;

  /// No description provided for @kitHeatWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Drinking water'**
  String get kitHeatWaterTitle;

  /// No description provided for @kitHeatWaterDescription.
  ///
  /// In en, this message translates to:
  /// **'Stay hydrated in hot weather'**
  String get kitHeatWaterDescription;

  /// No description provided for @kitHeatWaterExplanation.
  ///
  /// In en, this message translates to:
  /// **'Carrying additional water helps reduce dehydration and heat-related illness.'**
  String get kitHeatWaterExplanation;

  /// No description provided for @kitFloodBagTitle.
  ///
  /// In en, this message translates to:
  /// **'Torch & power bank'**
  String get kitFloodBagTitle;

  /// No description provided for @kitFloodBagDescription.
  ///
  /// In en, this message translates to:
  /// **'Useful during heavy rain or outages'**
  String get kitFloodBagDescription;

  /// No description provided for @kitFloodBagExplanation.
  ///
  /// In en, this message translates to:
  /// **'A torch and charged power bank are useful during power disruptions and heavy rainfall.'**
  String get kitFloodBagExplanation;

  /// No description provided for @kitFloodAlertsTitle.
  ///
  /// In en, this message translates to:
  /// **'Flood alerts'**
  String get kitFloodAlertsTitle;

  /// No description provided for @kitFloodAlertsDescription.
  ///
  /// In en, this message translates to:
  /// **'Stay updated on affected areas'**
  String get kitFloodAlertsDescription;

  /// No description provided for @kitFloodAlertsExplanation.
  ///
  /// In en, this message translates to:
  /// **'Official alert channels provide timely information about rainfall and affected locations.'**
  String get kitFloodAlertsExplanation;

  /// No description provided for @kitFloodRouteTitle.
  ///
  /// In en, this message translates to:
  /// **'Alternative route'**
  String get kitFloodRouteTitle;

  /// No description provided for @kitFloodRouteDescription.
  ///
  /// In en, this message translates to:
  /// **'Avoid flood-prone roads'**
  String get kitFloodRouteDescription;

  /// No description provided for @kitFloodRouteExplanation.
  ///
  /// In en, this message translates to:
  /// **'Knowing an alternative route helps you avoid low-lying and flood-prone roads.'**
  String get kitFloodRouteExplanation;

  /// No description provided for @kitDefaultDescription.
  ///
  /// In en, this message translates to:
  /// **'Preparedness essential'**
  String get kitDefaultDescription;

  /// No description provided for @kitDefaultExplanation.
  ///
  /// In en, this message translates to:
  /// **'This item supports your overall environmental preparedness.'**
  String get kitDefaultExplanation;

  /// No description provided for @learnKnowledgeQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Knowledge Quizzes'**
  String get learnKnowledgeQuizzes;

  /// No description provided for @learnKnowledgeQuizzesDescription.
  ///
  /// In en, this message translates to:
  /// **'Test your knowledge and learn how to respond to environmental hazards.'**
  String get learnKnowledgeQuizzesDescription;

  /// No description provided for @learnQuizProgress.
  ///
  /// In en, this message translates to:
  /// **'Quiz Progress'**
  String get learnQuizProgress;

  /// No description provided for @learnAllQuizQuestionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'All quiz questions completed.'**
  String get learnAllQuizQuestionsCompleted;

  /// No description provided for @learnQuizQuestionsRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} question(s) remaining.'**
  String learnQuizQuestionsRemaining(int count);

  /// No description provided for @learnQuizTopicTitle.
  ///
  /// In en, this message translates to:
  /// **'{topic} Preparedness'**
  String learnQuizTopicTitle(String topic);

  /// No description provided for @learnCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get learnCompleted;

  /// No description provided for @learnQuizQuestionsCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed} of {total} questions completed'**
  String learnQuizQuestionsCompleted(int completed, int total);

  /// No description provided for @learnQuizTitle.
  ///
  /// In en, this message translates to:
  /// **'{topic} Quiz'**
  String learnQuizTitle(String topic);

  /// No description provided for @learnQuizQuestionProgress.
  ///
  /// In en, this message translates to:
  /// **'Question {current} of {total}'**
  String learnQuizQuestionProgress(int current, int total);

  /// No description provided for @learnQuizCheckAnswer.
  ///
  /// In en, this message translates to:
  /// **'Check answer'**
  String get learnQuizCheckAnswer;

  /// No description provided for @learnQuizNextQuestion.
  ///
  /// In en, this message translates to:
  /// **'Next question'**
  String get learnQuizNextQuestion;

  /// No description provided for @learnQuizViewResults.
  ///
  /// In en, this message translates to:
  /// **'View results'**
  String get learnQuizViewResults;

  /// No description provided for @learnQuizComplete.
  ///
  /// In en, this message translates to:
  /// **'Quiz complete'**
  String get learnQuizComplete;

  /// No description provided for @learnQuizScore.
  ///
  /// In en, this message translates to:
  /// **'You scored {score} out of {total}.'**
  String learnQuizScore(int score, int total);

  /// No description provided for @learnQuizPreviouslyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Quiz completed previously. No additional XP awarded.'**
  String get learnQuizPreviouslyCompleted;

  /// No description provided for @learnQuizXpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{points} XP earned'**
  String learnQuizXpEarned(int points);

  /// No description provided for @learnQuizContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get learnQuizContinue;

  /// No description provided for @learnQuizSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save quiz progress. Please try again.'**
  String get learnQuizSaveError;

  /// No description provided for @learnQuizResultExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent work. You have mastered this topic.'**
  String get learnQuizResultExcellent;

  /// No description provided for @learnQuizResultGood.
  ///
  /// In en, this message translates to:
  /// **'Good effort. Review the explanations to strengthen your knowledge.'**
  String get learnQuizResultGood;

  /// No description provided for @learnQuizResultKeepLearning.
  ///
  /// In en, this message translates to:
  /// **'Keep learning. You can retake the quiz to review the topic.'**
  String get learnQuizResultKeepLearning;

  /// No description provided for @learnQuizNoAdditionalXp.
  ///
  /// In en, this message translates to:
  /// **'No additional XP awarded.'**
  String get learnQuizNoAdditionalXp;

  /// No description provided for @quizHaze1Question.
  ///
  /// In en, this message translates to:
  /// **'When the 24-hour PSI enters the Unhealthy range, what should healthy people reduce?'**
  String get quizHaze1Question;

  /// No description provided for @quizHaze1Option1.
  ///
  /// In en, this message translates to:
  /// **'Drinking water'**
  String get quizHaze1Option1;

  /// No description provided for @quizHaze1Option2.
  ///
  /// In en, this message translates to:
  /// **'Prolonged or strenuous outdoor activity'**
  String get quizHaze1Option2;

  /// No description provided for @quizHaze1Option3.
  ///
  /// In en, this message translates to:
  /// **'Indoor activities'**
  String get quizHaze1Option3;

  /// No description provided for @quizHaze1Option4.
  ///
  /// In en, this message translates to:
  /// **'Sleeping'**
  String get quizHaze1Option4;

  /// No description provided for @quizHaze1Explanation.
  ///
  /// In en, this message translates to:
  /// **'When air quality enters the Unhealthy range, prolonged or strenuous outdoor activity should be reduced.'**
  String get quizHaze1Explanation;

  /// No description provided for @quizHaze2Question.
  ///
  /// In en, this message translates to:
  /// **'Which mask is designed to filter fine haze particles?'**
  String get quizHaze2Question;

  /// No description provided for @quizHaze2Option1.
  ///
  /// In en, this message translates to:
  /// **'Surgical mask'**
  String get quizHaze2Option1;

  /// No description provided for @quizHaze2Option2.
  ///
  /// In en, this message translates to:
  /// **'N95 respirator'**
  String get quizHaze2Option2;

  /// No description provided for @quizHaze2Option3.
  ///
  /// In en, this message translates to:
  /// **'Cloth mask'**
  String get quizHaze2Option3;

  /// No description provided for @quizHaze2Option4.
  ///
  /// In en, this message translates to:
  /// **'No mask is required'**
  String get quizHaze2Option4;

  /// No description provided for @quizHaze2Explanation.
  ///
  /// In en, this message translates to:
  /// **'A properly fitted N95 respirator is designed to filter fine particles more effectively than surgical or cloth masks.'**
  String get quizHaze2Explanation;

  /// No description provided for @quizHaze3Question.
  ///
  /// In en, this message translates to:
  /// **'Why should you check air-quality conditions before prolonged outdoor activity during haze?'**
  String get quizHaze3Question;

  /// No description provided for @quizHaze3Option1.
  ///
  /// In en, this message translates to:
  /// **'Air quality can change throughout the day'**
  String get quizHaze3Option1;

  /// No description provided for @quizHaze3Option2.
  ///
  /// In en, this message translates to:
  /// **'PSI only measures temperature'**
  String get quizHaze3Option2;

  /// No description provided for @quizHaze3Option3.
  ///
  /// In en, this message translates to:
  /// **'Haze only affects visibility'**
  String get quizHaze3Option3;

  /// No description provided for @quizHaze3Option4.
  ///
  /// In en, this message translates to:
  /// **'Outdoor activity improves air quality'**
  String get quizHaze3Option4;

  /// No description provided for @quizHaze3Explanation.
  ///
  /// In en, this message translates to:
  /// **'Air quality can change, so checking current conditions helps you decide whether to adjust prolonged outdoor activities.'**
  String get quizHaze3Explanation;

  /// No description provided for @quizHaze4Question.
  ///
  /// In en, this message translates to:
  /// **'What is a sensible way to reduce haze exposure when air quality worsens?'**
  String get quizHaze4Question;

  /// No description provided for @quizHaze4Option1.
  ///
  /// In en, this message translates to:
  /// **'Spend more time outdoors'**
  String get quizHaze4Option1;

  /// No description provided for @quizHaze4Option2.
  ///
  /// In en, this message translates to:
  /// **'Increase strenuous outdoor exercise'**
  String get quizHaze4Option2;

  /// No description provided for @quizHaze4Option3.
  ///
  /// In en, this message translates to:
  /// **'Reduce unnecessary prolonged outdoor exposure'**
  String get quizHaze4Option3;

  /// No description provided for @quizHaze4Option4.
  ///
  /// In en, this message translates to:
  /// **'Keep all outdoor plans unchanged'**
  String get quizHaze4Option4;

  /// No description provided for @quizHaze4Explanation.
  ///
  /// In en, this message translates to:
  /// **'Reducing unnecessary prolonged outdoor exposure can help limit exposure when air quality worsens.'**
  String get quizHaze4Explanation;

  /// No description provided for @quizHaze5Question.
  ///
  /// In en, this message translates to:
  /// **'If you still need to go outside during hazy conditions, what should you continue doing?'**
  String get quizHaze5Question;

  /// No description provided for @quizHaze5Option1.
  ///
  /// In en, this message translates to:
  /// **'Ignore later air-quality updates'**
  String get quizHaze5Option1;

  /// No description provided for @quizHaze5Option2.
  ///
  /// In en, this message translates to:
  /// **'Monitor current air-quality information and relevant advisories'**
  String get quizHaze5Option2;

  /// No description provided for @quizHaze5Option3.
  ///
  /// In en, this message translates to:
  /// **'Assume conditions will remain unchanged'**
  String get quizHaze5Option3;

  /// No description provided for @quizHaze5Option4.
  ///
  /// In en, this message translates to:
  /// **'Stay outside longer to adapt to the haze'**
  String get quizHaze5Option4;

  /// No description provided for @quizHaze5Explanation.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring current air-quality information because conditions and relevant recommendations may change.'**
  String get quizHaze5Explanation;

  /// No description provided for @quizUv1Question.
  ///
  /// In en, this message translates to:
  /// **'UV Index 8–10 belongs to which category?'**
  String get quizUv1Question;

  /// No description provided for @quizUv1Option1.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get quizUv1Option1;

  /// No description provided for @quizUv1Option2.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get quizUv1Option2;

  /// No description provided for @quizUv1Option3.
  ///
  /// In en, this message translates to:
  /// **'Very High'**
  String get quizUv1Option3;

  /// No description provided for @quizUv1Option4.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get quizUv1Option4;

  /// No description provided for @quizUv1Explanation.
  ///
  /// In en, this message translates to:
  /// **'A UV Index of 8–10 is categorised as Very High and requires strong sun protection.'**
  String get quizUv1Explanation;

  /// No description provided for @quizUv2Question.
  ///
  /// In en, this message translates to:
  /// **'When is UV exposure typically strongest in Singapore?'**
  String get quizUv2Question;

  /// No description provided for @quizUv2Option1.
  ///
  /// In en, this message translates to:
  /// **'Early morning'**
  String get quizUv2Option1;

  /// No description provided for @quizUv2Option2.
  ///
  /// In en, this message translates to:
  /// **'Around midday'**
  String get quizUv2Option2;

  /// No description provided for @quizUv2Option3.
  ///
  /// In en, this message translates to:
  /// **'Evening'**
  String get quizUv2Option3;

  /// No description provided for @quizUv2Option4.
  ///
  /// In en, this message translates to:
  /// **'Night'**
  String get quizUv2Option4;

  /// No description provided for @quizUv2Explanation.
  ///
  /// In en, this message translates to:
  /// **'UV radiation is generally strongest around midday, so additional protection is important during this period.'**
  String get quizUv2Explanation;

  /// No description provided for @quizUv3Question.
  ///
  /// In en, this message translates to:
  /// **'What is a good way to reduce UV exposure when spending time outdoors?'**
  String get quizUv3Question;

  /// No description provided for @quizUv3Option1.
  ///
  /// In en, this message translates to:
  /// **'Seek shade when possible'**
  String get quizUv3Option1;

  /// No description provided for @quizUv3Option2.
  ///
  /// In en, this message translates to:
  /// **'Stay in direct sunlight for longer'**
  String get quizUv3Option2;

  /// No description provided for @quizUv3Option3.
  ///
  /// In en, this message translates to:
  /// **'Only protect yourself when it feels hot'**
  String get quizUv3Option3;

  /// No description provided for @quizUv3Option4.
  ///
  /// In en, this message translates to:
  /// **'Avoid drinking water'**
  String get quizUv3Option4;

  /// No description provided for @quizUv3Explanation.
  ///
  /// In en, this message translates to:
  /// **'Seeking shade can help reduce direct exposure to ultraviolet radiation while outdoors.'**
  String get quizUv3Explanation;

  /// No description provided for @quizUv4Question.
  ///
  /// In en, this message translates to:
  /// **'Which combination provides better protection when UV levels are high?'**
  String get quizUv4Question;

  /// No description provided for @quizUv4Option1.
  ///
  /// In en, this message translates to:
  /// **'Sunscreen, suitable clothing and shade'**
  String get quizUv4Option1;

  /// No description provided for @quizUv4Option2.
  ///
  /// In en, this message translates to:
  /// **'Drinking water only'**
  String get quizUv4Option2;

  /// No description provided for @quizUv4Option3.
  ///
  /// In en, this message translates to:
  /// **'A surgical mask and gloves'**
  String get quizUv4Option3;

  /// No description provided for @quizUv4Option4.
  ///
  /// In en, this message translates to:
  /// **'Staying in direct sunlight'**
  String get quizUv4Option4;

  /// No description provided for @quizUv4Explanation.
  ///
  /// In en, this message translates to:
  /// **'Using multiple forms of sun protection, including sunscreen, suitable clothing and shade, helps reduce UV exposure.'**
  String get quizUv4Explanation;

  /// No description provided for @quizUv5Question.
  ///
  /// In en, this message translates to:
  /// **'Why should you still consider UV protection on a cloudy day?'**
  String get quizUv5Question;

  /// No description provided for @quizUv5Option1.
  ///
  /// In en, this message translates to:
  /// **'UV radiation can still reach you through cloud cover'**
  String get quizUv5Option1;

  /// No description provided for @quizUv5Option2.
  ///
  /// In en, this message translates to:
  /// **'Clouds always increase the UV Index'**
  String get quizUv5Option2;

  /// No description provided for @quizUv5Option3.
  ///
  /// In en, this message translates to:
  /// **'UV radiation only exists when it rains'**
  String get quizUv5Option3;

  /// No description provided for @quizUv5Option4.
  ///
  /// In en, this message translates to:
  /// **'Sun protection is only needed on clear days'**
  String get quizUv5Option4;

  /// No description provided for @quizUv5Explanation.
  ///
  /// In en, this message translates to:
  /// **'Cloud cover does not completely block ultraviolet radiation, so UV protection may still be necessary.'**
  String get quizUv5Explanation;

  /// No description provided for @quizHeat1Question.
  ///
  /// In en, this message translates to:
  /// **'What is one of the most important ways to reduce heat stress during prolonged outdoor activity?'**
  String get quizHeat1Question;

  /// No description provided for @quizHeat1Option1.
  ///
  /// In en, this message translates to:
  /// **'Take regular hydration and cooling breaks'**
  String get quizHeat1Option1;

  /// No description provided for @quizHeat1Option2.
  ///
  /// In en, this message translates to:
  /// **'Avoid drinking water until you feel thirsty'**
  String get quizHeat1Option2;

  /// No description provided for @quizHeat1Option3.
  ///
  /// In en, this message translates to:
  /// **'Wear heavier clothing'**
  String get quizHeat1Option3;

  /// No description provided for @quizHeat1Option4.
  ///
  /// In en, this message translates to:
  /// **'Stay continuously in direct sunlight'**
  String get quizHeat1Option4;

  /// No description provided for @quizHeat1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Regular hydration and cooling breaks can help reduce heat stress during prolonged outdoor activity.'**
  String get quizHeat1Explanation;

  /// No description provided for @quizHeat2Question.
  ///
  /// In en, this message translates to:
  /// **'If you begin feeling very warm during outdoor activity, what is a safer action?'**
  String get quizHeat2Question;

  /// No description provided for @quizHeat2Option1.
  ///
  /// In en, this message translates to:
  /// **'Continue without stopping'**
  String get quizHeat2Option1;

  /// No description provided for @quizHeat2Option2.
  ///
  /// In en, this message translates to:
  /// **'Move to a shaded or cooler area and take a break'**
  String get quizHeat2Option2;

  /// No description provided for @quizHeat2Option3.
  ///
  /// In en, this message translates to:
  /// **'Exercise harder to finish sooner'**
  String get quizHeat2Option3;

  /// No description provided for @quizHeat2Option4.
  ///
  /// In en, this message translates to:
  /// **'Avoid drinking water'**
  String get quizHeat2Option4;

  /// No description provided for @quizHeat2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Taking a break in a shaded or cooler area helps reduce continued heat exposure and allows your body to cool down.'**
  String get quizHeat2Explanation;

  /// No description provided for @quizHeat3Question.
  ///
  /// In en, this message translates to:
  /// **'Why is hydration important during hot weather?'**
  String get quizHeat3Question;

  /// No description provided for @quizHeat3Option1.
  ///
  /// In en, this message translates to:
  /// **'It helps replace fluids lost through sweating'**
  String get quizHeat3Option1;

  /// No description provided for @quizHeat3Option2.
  ///
  /// In en, this message translates to:
  /// **'It increases your exposure to heat'**
  String get quizHeat3Option2;

  /// No description provided for @quizHeat3Option3.
  ///
  /// In en, this message translates to:
  /// **'It removes the need for rest breaks'**
  String get quizHeat3Option3;

  /// No description provided for @quizHeat3Option4.
  ///
  /// In en, this message translates to:
  /// **'It prevents all heat-related illness'**
  String get quizHeat3Option4;

  /// No description provided for @quizHeat3Explanation.
  ///
  /// In en, this message translates to:
  /// **'Drinking water helps replace fluids lost through sweating and supports hydration during hot conditions.'**
  String get quizHeat3Explanation;

  /// No description provided for @quizHeat4Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do before planning prolonged outdoor activity on a very hot day?'**
  String get quizHeat4Question;

  /// No description provided for @quizHeat4Option1.
  ///
  /// In en, this message translates to:
  /// **'Check current heat conditions and plan appropriate precautions'**
  String get quizHeat4Option1;

  /// No description provided for @quizHeat4Option2.
  ///
  /// In en, this message translates to:
  /// **'Ignore the conditions if the sky is clear'**
  String get quizHeat4Option2;

  /// No description provided for @quizHeat4Option3.
  ///
  /// In en, this message translates to:
  /// **'Avoid bringing water'**
  String get quizHeat4Option3;

  /// No description provided for @quizHeat4Option4.
  ///
  /// In en, this message translates to:
  /// **'Wear additional heavy layers'**
  String get quizHeat4Option4;

  /// No description provided for @quizHeat4Explanation.
  ///
  /// In en, this message translates to:
  /// **'Checking current heat conditions helps you plan hydration, cooling breaks and other precautions before prolonged outdoor activity.'**
  String get quizHeat4Explanation;

  /// No description provided for @quizHeat5Question.
  ///
  /// In en, this message translates to:
  /// **'If hot conditions continue throughout the day, what should you do?'**
  String get quizHeat5Question;

  /// No description provided for @quizHeat5Option1.
  ///
  /// In en, this message translates to:
  /// **'Assume conditions will improve automatically'**
  String get quizHeat5Option1;

  /// No description provided for @quizHeat5Option2.
  ///
  /// In en, this message translates to:
  /// **'Continue all outdoor plans without changes'**
  String get quizHeat5Option2;

  /// No description provided for @quizHeat5Option3.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring conditions and adjust your plans when necessary'**
  String get quizHeat5Option3;

  /// No description provided for @quizHeat5Option4.
  ///
  /// In en, this message translates to:
  /// **'Stop drinking water so you need fewer breaks'**
  String get quizHeat5Option4;

  /// No description provided for @quizHeat5Explanation.
  ///
  /// In en, this message translates to:
  /// **'Heat conditions can change throughout the day, so continue monitoring them and adjust prolonged outdoor activities when necessary.'**
  String get quizHeat5Explanation;

  /// No description provided for @quizFlood1Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do if the road ahead is covered by flood water and you cannot tell how deep it is?'**
  String get quizFlood1Question;

  /// No description provided for @quizFlood1Option1.
  ///
  /// In en, this message translates to:
  /// **'Drive through slowly'**
  String get quizFlood1Option1;

  /// No description provided for @quizFlood1Option2.
  ///
  /// In en, this message translates to:
  /// **'Turn around and use another route'**
  String get quizFlood1Option2;

  /// No description provided for @quizFlood1Option3.
  ///
  /// In en, this message translates to:
  /// **'Stop in the flooded section'**
  String get quizFlood1Option3;

  /// No description provided for @quizFlood1Option4.
  ///
  /// In en, this message translates to:
  /// **'Drive through quickly before the water rises'**
  String get quizFlood1Option4;

  /// No description provided for @quizFlood1Explanation.
  ///
  /// In en, this message translates to:
  /// **'Avoid entering flood water when its depth and conditions are uncertain. Turning around and using a safer alternative route reduces the risk.'**
  String get quizFlood1Explanation;

  /// No description provided for @quizFlood2Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do before choosing an alternative route during a flash flood?'**
  String get quizFlood2Question;

  /// No description provided for @quizFlood2Option1.
  ///
  /// In en, this message translates to:
  /// **'Check current flood information and road conditions'**
  String get quizFlood2Option1;

  /// No description provided for @quizFlood2Option2.
  ///
  /// In en, this message translates to:
  /// **'Choose the shortest route without checking'**
  String get quizFlood2Option2;

  /// No description provided for @quizFlood2Option3.
  ///
  /// In en, this message translates to:
  /// **'Return to the flooded road'**
  String get quizFlood2Option3;

  /// No description provided for @quizFlood2Option4.
  ///
  /// In en, this message translates to:
  /// **'Keep driving until you find an open road'**
  String get quizFlood2Option4;

  /// No description provided for @quizFlood2Explanation.
  ///
  /// In en, this message translates to:
  /// **'Checking current flood and road information can help you avoid routes affected by flooding.'**
  String get quizFlood2Explanation;

  /// No description provided for @quizFlood3Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do when driving visibility becomes poor during heavy rain?'**
  String get quizFlood3Question;

  /// No description provided for @quizFlood3Option1.
  ///
  /// In en, this message translates to:
  /// **'Speed up to leave the rain sooner'**
  String get quizFlood3Option1;

  /// No description provided for @quizFlood3Option2.
  ///
  /// In en, this message translates to:
  /// **'Slow down and drive cautiously'**
  String get quizFlood3Option2;

  /// No description provided for @quizFlood3Option3.
  ///
  /// In en, this message translates to:
  /// **'Continue at the same speed'**
  String get quizFlood3Option3;

  /// No description provided for @quizFlood3Option4.
  ///
  /// In en, this message translates to:
  /// **'Use your phone to check weather updates while driving'**
  String get quizFlood3Option4;

  /// No description provided for @quizFlood3Explanation.
  ///
  /// In en, this message translates to:
  /// **'Slowing down and driving cautiously is safer when heavy rain reduces visibility.'**
  String get quizFlood3Explanation;

  /// No description provided for @quizFlood4Question.
  ///
  /// In en, this message translates to:
  /// **'Why should you avoid entering flood water?'**
  String get quizFlood4Question;

  /// No description provided for @quizFlood4Option1.
  ///
  /// In en, this message translates to:
  /// **'Flood water is always shallow'**
  String get quizFlood4Option1;

  /// No description provided for @quizFlood4Option2.
  ///
  /// In en, this message translates to:
  /// **'Flood water makes your vehicle cleaner'**
  String get quizFlood4Option2;

  /// No description provided for @quizFlood4Option3.
  ///
  /// In en, this message translates to:
  /// **'The water may be deeper or faster-moving than it appears'**
  String get quizFlood4Option3;

  /// No description provided for @quizFlood4Option4.
  ///
  /// In en, this message translates to:
  /// **'Flood water always disappears immediately'**
  String get quizFlood4Option4;

  /// No description provided for @quizFlood4Explanation.
  ///
  /// In en, this message translates to:
  /// **'Flood water can be deeper or faster-moving than it appears, making it dangerous to enter.'**
  String get quizFlood4Explanation;

  /// No description provided for @quizFlood5Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do while heavy rain and flood conditions continue?'**
  String get quizFlood5Question;

  /// No description provided for @quizFlood5Option1.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring conditions and follow relevant safety information'**
  String get quizFlood5Option1;

  /// No description provided for @quizFlood5Option2.
  ///
  /// In en, this message translates to:
  /// **'Ignore further weather updates'**
  String get quizFlood5Option2;

  /// No description provided for @quizFlood5Option3.
  ///
  /// In en, this message translates to:
  /// **'Assume all roads are safe if they are open'**
  String get quizFlood5Option3;

  /// No description provided for @quizFlood5Option4.
  ///
  /// In en, this message translates to:
  /// **'Enter flooded areas to check the water depth'**
  String get quizFlood5Option4;

  /// No description provided for @quizFlood5Explanation.
  ///
  /// In en, this message translates to:
  /// **'Conditions can change during heavy rain, so continue monitoring current information and adjust your plans when necessary.'**
  String get quizFlood5Explanation;

  /// No description provided for @scenarioChallenges.
  ///
  /// In en, this message translates to:
  /// **'Scenario Challenges'**
  String get scenarioChallenges;

  /// No description provided for @scenarioChallengesDescription.
  ///
  /// In en, this message translates to:
  /// **'Practise making safe decisions in realistic environmental situations.'**
  String get scenarioChallengesDescription;

  /// No description provided for @scenarioProgress.
  ///
  /// In en, this message translates to:
  /// **'Scenario Progress'**
  String get scenarioProgress;

  /// No description provided for @scenarioAllCompleted.
  ///
  /// In en, this message translates to:
  /// **'All scenario challenges completed.'**
  String get scenarioAllCompleted;

  /// No description provided for @scenarioRemaining.
  ///
  /// In en, this message translates to:
  /// **'{count} scenario(s) remaining.'**
  String scenarioRemaining(int count);

  /// No description provided for @scenarioCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get scenarioCompleted;

  /// No description provided for @scenarioNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'Not completed'**
  String get scenarioNotCompleted;

  /// No description provided for @scenarioFlashFloodTitle.
  ///
  /// In en, this message translates to:
  /// **'Flash Flood on Your Route'**
  String get scenarioFlashFloodTitle;

  /// No description provided for @scenarioFlashFloodDescription.
  ///
  /// In en, this message translates to:
  /// **'Make decisions while travelling during sudden flooding.'**
  String get scenarioFlashFloodDescription;

  /// No description provided for @scenarioHazeTitle.
  ///
  /// In en, this message translates to:
  /// **'Haze During Outdoor Activity'**
  String get scenarioHazeTitle;

  /// No description provided for @scenarioHazeDescription.
  ///
  /// In en, this message translates to:
  /// **'Make safe decisions when air quality worsens during outdoor plans.'**
  String get scenarioHazeDescription;

  /// No description provided for @scenarioHeatUvTitle.
  ///
  /// In en, this message translates to:
  /// **'Heat & UV During Outdoor Activity'**
  String get scenarioHeatUvTitle;

  /// No description provided for @scenarioHeatUvDescription.
  ///
  /// In en, this message translates to:
  /// **'Make safe decisions when heat and UV exposure are high.'**
  String get scenarioHeatUvDescription;

  /// No description provided for @scenarioFloodStep1Situation.
  ///
  /// In en, this message translates to:
  /// **'You are travelling home during heavy rain. The road ahead is covered by flood water and you cannot tell how deep it is.'**
  String get scenarioFloodStep1Situation;

  /// No description provided for @scenarioFloodStep1Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do?'**
  String get scenarioFloodStep1Question;

  /// No description provided for @scenarioFloodStep1Option1.
  ///
  /// In en, this message translates to:
  /// **'Drive through quickly before the water rises further.'**
  String get scenarioFloodStep1Option1;

  /// No description provided for @scenarioFloodStep1Option2.
  ///
  /// In en, this message translates to:
  /// **'Turn around and use another route.'**
  String get scenarioFloodStep1Option2;

  /// No description provided for @scenarioFloodStep1Option3.
  ///
  /// In en, this message translates to:
  /// **'Stop in the flooded section and wait.'**
  String get scenarioFloodStep1Option3;

  /// No description provided for @scenarioFloodStep1Option4.
  ///
  /// In en, this message translates to:
  /// **'Open the windows and continue slowly.'**
  String get scenarioFloodStep1Option4;

  /// No description provided for @scenarioFloodStep1CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Good decision. Avoid entering flood water and use a safer alternative route.'**
  String get scenarioFloodStep1CorrectFeedback;

  /// No description provided for @scenarioFloodStep1IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Avoid entering flood water. It may be deeper or faster-moving than it appears.'**
  String get scenarioFloodStep1IncorrectFeedback;

  /// No description provided for @scenarioFloodStep2Situation.
  ///
  /// In en, this message translates to:
  /// **'You turn around safely, but the rain is becoming heavier. You need to decide which route to take next.'**
  String get scenarioFloodStep2Situation;

  /// No description provided for @scenarioFloodStep2Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do before choosing another route?'**
  String get scenarioFloodStep2Question;

  /// No description provided for @scenarioFloodStep2Option1.
  ///
  /// In en, this message translates to:
  /// **'Choose the shortest road without checking conditions.'**
  String get scenarioFloodStep2Option1;

  /// No description provided for @scenarioFloodStep2Option2.
  ///
  /// In en, this message translates to:
  /// **'Check current flood information and plan a safer route.'**
  String get scenarioFloodStep2Option2;

  /// No description provided for @scenarioFloodStep2Option3.
  ///
  /// In en, this message translates to:
  /// **'Return to the flooded road to see if conditions improved.'**
  String get scenarioFloodStep2Option3;

  /// No description provided for @scenarioFloodStep2Option4.
  ///
  /// In en, this message translates to:
  /// **'Continue driving until you find an open road.'**
  String get scenarioFloodStep2Option4;

  /// No description provided for @scenarioFloodStep2CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Checking current conditions helps you avoid roads affected by flooding.'**
  String get scenarioFloodStep2CorrectFeedback;

  /// No description provided for @scenarioFloodStep2IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'A safer approach is to check current flood information before choosing another route.'**
  String get scenarioFloodStep2IncorrectFeedback;

  /// No description provided for @scenarioFloodStep3Situation.
  ///
  /// In en, this message translates to:
  /// **'Your alternative route is clear, but heavy rain is continuing and visibility is becoming poor.'**
  String get scenarioFloodStep3Situation;

  /// No description provided for @scenarioFloodStep3Question.
  ///
  /// In en, this message translates to:
  /// **'What is the safest next action?'**
  String get scenarioFloodStep3Question;

  /// No description provided for @scenarioFloodStep3Option1.
  ///
  /// In en, this message translates to:
  /// **'Speed up so you can get home sooner.'**
  String get scenarioFloodStep3Option1;

  /// No description provided for @scenarioFloodStep3Option2.
  ///
  /// In en, this message translates to:
  /// **'Continue normally and ignore the reduced visibility.'**
  String get scenarioFloodStep3Option2;

  /// No description provided for @scenarioFloodStep3Option3.
  ///
  /// In en, this message translates to:
  /// **'Slow down and continue cautiously while monitoring conditions.'**
  String get scenarioFloodStep3Option3;

  /// No description provided for @scenarioFloodStep3Option4.
  ///
  /// In en, this message translates to:
  /// **'Use your phone while driving to check updates.'**
  String get scenarioFloodStep3Option4;

  /// No description provided for @scenarioFloodStep3CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Slowing down and staying alert is safer when visibility is reduced.'**
  String get scenarioFloodStep3CorrectFeedback;

  /// No description provided for @scenarioFloodStep3IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Poor visibility increases driving risk. Slow down, stay alert and monitor conditions safely.'**
  String get scenarioFloodStep3IncorrectFeedback;

  /// No description provided for @scenarioCompleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Scenario complete'**
  String get scenarioCompleteTitle;

  /// No description provided for @scenarioSafeDecisions.
  ///
  /// In en, this message translates to:
  /// **'{safe} of {total} safe decisions'**
  String scenarioSafeDecisions(int safe, int total);

  /// No description provided for @scenarioPreviouslyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Scenario completed previously. No additional XP awarded.'**
  String get scenarioPreviouslyCompleted;

  /// No description provided for @scenarioXpEarned.
  ///
  /// In en, this message translates to:
  /// **'+{points} XP earned'**
  String scenarioXpEarned(int points);

  /// No description provided for @scenarioContinue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get scenarioContinue;

  /// No description provided for @scenarioSaveError.
  ///
  /// In en, this message translates to:
  /// **'Unable to save scenario progress. Please try again.'**
  String get scenarioSaveError;

  /// No description provided for @scenarioHazeStep1Situation.
  ///
  /// In en, this message translates to:
  /// **'You planned to exercise outdoors this afternoon, but you notice that conditions look hazy.'**
  String get scenarioHazeStep1Situation;

  /// No description provided for @scenarioHazeStep1Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do before heading out?'**
  String get scenarioHazeStep1Question;

  /// No description provided for @scenarioHazeStep1Option1.
  ///
  /// In en, this message translates to:
  /// **'Continue with your plans without checking anything.'**
  String get scenarioHazeStep1Option1;

  /// No description provided for @scenarioHazeStep1Option2.
  ///
  /// In en, this message translates to:
  /// **'Check the latest PSI and air-quality conditions.'**
  String get scenarioHazeStep1Option2;

  /// No description provided for @scenarioHazeStep1Option3.
  ///
  /// In en, this message translates to:
  /// **'Exercise harder so you can finish sooner.'**
  String get scenarioHazeStep1Option3;

  /// No description provided for @scenarioHazeStep1Option4.
  ///
  /// In en, this message translates to:
  /// **'Assume the haze is harmless because visibility is still acceptable.'**
  String get scenarioHazeStep1Option4;

  /// No description provided for @scenarioHazeStep1CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Good decision. Checking current air-quality information helps you decide whether outdoor activity is appropriate.'**
  String get scenarioHazeStep1CorrectFeedback;

  /// No description provided for @scenarioHazeStep1IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Check current air-quality information before deciding whether to continue with prolonged outdoor activity.'**
  String get scenarioHazeStep1IncorrectFeedback;

  /// No description provided for @scenarioHazeStep2Situation.
  ///
  /// In en, this message translates to:
  /// **'The PSI indicates poorer air quality than usual. You still want to stay active today.'**
  String get scenarioHazeStep2Situation;

  /// No description provided for @scenarioHazeStep2Question.
  ///
  /// In en, this message translates to:
  /// **'What is the safer choice?'**
  String get scenarioHazeStep2Question;

  /// No description provided for @scenarioHazeStep2Option1.
  ///
  /// In en, this message translates to:
  /// **'Continue a long, strenuous outdoor workout.'**
  String get scenarioHazeStep2Option1;

  /// No description provided for @scenarioHazeStep2Option2.
  ///
  /// In en, this message translates to:
  /// **'Move your workout indoors or reduce prolonged outdoor exertion.'**
  String get scenarioHazeStep2Option2;

  /// No description provided for @scenarioHazeStep2Option3.
  ///
  /// In en, this message translates to:
  /// **'Ignore the reading because you already planned the workout.'**
  String get scenarioHazeStep2Option3;

  /// No description provided for @scenarioHazeStep2Option4.
  ///
  /// In en, this message translates to:
  /// **'Stay outdoors for longer to adapt to the haze.'**
  String get scenarioHazeStep2Option4;

  /// No description provided for @scenarioHazeStep2CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Adjusting your activity can reduce unnecessary exposure when air quality deteriorates.'**
  String get scenarioHazeStep2CorrectFeedback;

  /// No description provided for @scenarioHazeStep2IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Consider moving strenuous activity indoors or reducing prolonged outdoor exertion when conditions worsen.'**
  String get scenarioHazeStep2IncorrectFeedback;

  /// No description provided for @scenarioHazeStep3Situation.
  ///
  /// In en, this message translates to:
  /// **'Later, you need to go outside and the hazy conditions are still present.'**
  String get scenarioHazeStep3Situation;

  /// No description provided for @scenarioHazeStep3Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do?'**
  String get scenarioHazeStep3Question;

  /// No description provided for @scenarioHazeStep3Option1.
  ///
  /// In en, this message translates to:
  /// **'Monitor current conditions and follow the recommended precautions.'**
  String get scenarioHazeStep3Option1;

  /// No description provided for @scenarioHazeStep3Option2.
  ///
  /// In en, this message translates to:
  /// **'Ignore further air-quality updates.'**
  String get scenarioHazeStep3Option2;

  /// No description provided for @scenarioHazeStep3Option3.
  ///
  /// In en, this message translates to:
  /// **'Spend extra time outdoors because your workout was cancelled.'**
  String get scenarioHazeStep3Option3;

  /// No description provided for @scenarioHazeStep3Option4.
  ///
  /// In en, this message translates to:
  /// **'Assume conditions cannot change during the day.'**
  String get scenarioHazeStep3Option4;

  /// No description provided for @scenarioHazeStep3CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Air quality can change, so continue monitoring conditions and follow appropriate precautions.'**
  String get scenarioHazeStep3CorrectFeedback;

  /// No description provided for @scenarioHazeStep3IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Continue checking current conditions because air quality can change throughout the day.'**
  String get scenarioHazeStep3IncorrectFeedback;

  /// No description provided for @scenarioSituationLabel.
  ///
  /// In en, this message translates to:
  /// **'Situation'**
  String get scenarioSituationLabel;

  /// No description provided for @scenarioCheckDecision.
  ///
  /// In en, this message translates to:
  /// **'Check decision'**
  String get scenarioCheckDecision;

  /// No description provided for @scenarioNextSituation.
  ///
  /// In en, this message translates to:
  /// **'Next situation'**
  String get scenarioNextSituation;

  /// No description provided for @scenarioFinishScenario.
  ///
  /// In en, this message translates to:
  /// **'Finish scenario'**
  String get scenarioFinishScenario;

  /// No description provided for @scenarioHeatUvStep1Situation.
  ///
  /// In en, this message translates to:
  /// **'You are planning to spend several hours outdoors around midday. The weather is hot and the UV Index is high.'**
  String get scenarioHeatUvStep1Situation;

  /// No description provided for @scenarioHeatUvStep1Question.
  ///
  /// In en, this message translates to:
  /// **'What should you do before heading out?'**
  String get scenarioHeatUvStep1Question;

  /// No description provided for @scenarioHeatUvStep1Option1.
  ///
  /// In en, this message translates to:
  /// **'Go out immediately because sunny weather is safe.'**
  String get scenarioHeatUvStep1Option1;

  /// No description provided for @scenarioHeatUvStep1Option2.
  ///
  /// In en, this message translates to:
  /// **'Apply sun protection, bring water and plan for shade.'**
  String get scenarioHeatUvStep1Option2;

  /// No description provided for @scenarioHeatUvStep1Option3.
  ///
  /// In en, this message translates to:
  /// **'Avoid drinking water so you do not need breaks.'**
  String get scenarioHeatUvStep1Option3;

  /// No description provided for @scenarioHeatUvStep1Option4.
  ///
  /// In en, this message translates to:
  /// **'Wear heavier clothing to get used to the heat.'**
  String get scenarioHeatUvStep1Option4;

  /// No description provided for @scenarioHeatUvStep1CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Good decision. Preparing sun protection, hydration and access to shade helps reduce heat and UV exposure.'**
  String get scenarioHeatUvStep1CorrectFeedback;

  /// No description provided for @scenarioHeatUvStep1IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Prepare for both heat and UV exposure before spending prolonged periods outdoors.'**
  String get scenarioHeatUvStep1IncorrectFeedback;

  /// No description provided for @scenarioHeatUvStep2Situation.
  ///
  /// In en, this message translates to:
  /// **'After spending some time outdoors, you are becoming very warm and have been exposed to direct sunlight for a while.'**
  String get scenarioHeatUvStep2Situation;

  /// No description provided for @scenarioHeatUvStep2Question.
  ///
  /// In en, this message translates to:
  /// **'What is the safer next action?'**
  String get scenarioHeatUvStep2Question;

  /// No description provided for @scenarioHeatUvStep2Option1.
  ///
  /// In en, this message translates to:
  /// **'Keep going without stopping.'**
  String get scenarioHeatUvStep2Option1;

  /// No description provided for @scenarioHeatUvStep2Option2.
  ///
  /// In en, this message translates to:
  /// **'Drink water and take a break in a shaded or cooler area.'**
  String get scenarioHeatUvStep2Option2;

  /// No description provided for @scenarioHeatUvStep2Option3.
  ///
  /// In en, this message translates to:
  /// **'Exercise harder so you can finish sooner.'**
  String get scenarioHeatUvStep2Option3;

  /// No description provided for @scenarioHeatUvStep2Option4.
  ///
  /// In en, this message translates to:
  /// **'Stay in direct sunlight during your break.'**
  String get scenarioHeatUvStep2Option4;

  /// No description provided for @scenarioHeatUvStep2CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Hydration and cooling breaks can help reduce heat stress during prolonged outdoor activity.'**
  String get scenarioHeatUvStep2CorrectFeedback;

  /// No description provided for @scenarioHeatUvStep2IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Take regular hydration and cooling breaks rather than continuing prolonged activity in the heat.'**
  String get scenarioHeatUvStep2IncorrectFeedback;

  /// No description provided for @scenarioHeatUvStep3Situation.
  ///
  /// In en, this message translates to:
  /// **'You still have more outdoor activities planned later in the day.'**
  String get scenarioHeatUvStep3Situation;

  /// No description provided for @scenarioHeatUvStep3Question.
  ///
  /// In en, this message translates to:
  /// **'How should you continue?'**
  String get scenarioHeatUvStep3Question;

  /// No description provided for @scenarioHeatUvStep3Option1.
  ///
  /// In en, this message translates to:
  /// **'Ignore any changes because you already checked conditions earlier.'**
  String get scenarioHeatUvStep3Option1;

  /// No description provided for @scenarioHeatUvStep3Option2.
  ///
  /// In en, this message translates to:
  /// **'Avoid water until you feel extremely thirsty.'**
  String get scenarioHeatUvStep3Option2;

  /// No description provided for @scenarioHeatUvStep3Option3.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring conditions and adjust your plans if necessary.'**
  String get scenarioHeatUvStep3Option3;

  /// No description provided for @scenarioHeatUvStep3Option4.
  ///
  /// In en, this message translates to:
  /// **'Stay outdoors continuously so your body adapts.'**
  String get scenarioHeatUvStep3Option4;

  /// No description provided for @scenarioHeatUvStep3CorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Correct. Conditions can change, so continue monitoring them and adjust outdoor plans when necessary.'**
  String get scenarioHeatUvStep3CorrectFeedback;

  /// No description provided for @scenarioHeatUvStep3IncorrectFeedback.
  ///
  /// In en, this message translates to:
  /// **'Continue monitoring heat and UV conditions and adjust your plans when necessary.'**
  String get scenarioHeatUvStep3IncorrectFeedback;

  /// No description provided for @cprAedTitle.
  ///
  /// In en, this message translates to:
  /// **'CPR & AED'**
  String get cprAedTitle;

  /// No description provided for @cprAedVideoTitle.
  ///
  /// In en, this message translates to:
  /// **'Learn CPR & AED Procedures'**
  String get cprAedVideoTitle;

  /// No description provided for @cprAedVideoSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Opens official SCDF video'**
  String get cprAedVideoSubtitle;

  /// No description provided for @cprAedDescription.
  ///
  /// In en, this message translates to:
  /// **'Know the basic actions to take during a suspected cardiac arrest.'**
  String get cprAedDescription;

  /// No description provided for @cprAedRememberActions.
  ///
  /// In en, this message translates to:
  /// **'Remember these actions'**
  String get cprAedRememberActions;

  /// No description provided for @cprAedStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Check responsiveness'**
  String get cprAedStep1Title;

  /// No description provided for @cprAedStep1Description.
  ///
  /// In en, this message translates to:
  /// **'Tap the person on the shoulders and check whether they respond.'**
  String get cprAedStep1Description;

  /// No description provided for @cprAedStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Call 995 & get an AED'**
  String get cprAedStep2Title;

  /// No description provided for @cprAedStep2Description.
  ///
  /// In en, this message translates to:
  /// **'Ask someone to call 995 and another person to retrieve the nearest AED.'**
  String get cprAedStep2Description;

  /// No description provided for @cprAedStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Start CPR'**
  String get cprAedStep3Title;

  /// No description provided for @cprAedStep3Description.
  ///
  /// In en, this message translates to:
  /// **'If the person is not breathing, begin hands-only CPR and follow the 995 dispatcher’s instructions.'**
  String get cprAedStep3Description;

  /// No description provided for @cprAedStep4Title.
  ///
  /// In en, this message translates to:
  /// **'Use the AED'**
  String get cprAedStep4Title;

  /// No description provided for @cprAedStep4Description.
  ///
  /// In en, this message translates to:
  /// **'Use the AED when it becomes available and follow its voice or visual instructions.'**
  String get cprAedStep4Description;

  /// No description provided for @cprAedWatchVideo.
  ///
  /// In en, this message translates to:
  /// **'Watch official SCDF video'**
  String get cprAedWatchVideo;

  /// No description provided for @cprAedDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'This quick guide is for preparedness learning and does not replace certified CPR/AED training. During an emergency, call 995 and follow the instructions given by the SCDF dispatcher.'**
  String get cprAedDisclaimer;

  /// No description provided for @cprAedVideoError.
  ///
  /// In en, this message translates to:
  /// **'Unable to open the SCDF video.'**
  String get cprAedVideoError;

  /// No description provided for @floodSafetyTitle.
  ///
  /// In en, this message translates to:
  /// **'Flash Flood Safety'**
  String get floodSafetyTitle;

  /// No description provided for @floodSafetyHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Heavy rain can cause flash floods'**
  String get floodSafetyHeroTitle;

  /// No description provided for @floodSafetyHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Know what to do if you encounter flooding while travelling in Singapore.'**
  String get floodSafetyHeroDescription;

  /// No description provided for @floodSafetyEncounterTitle.
  ///
  /// In en, this message translates to:
  /// **'If you encounter a flood'**
  String get floodSafetyEncounterTitle;

  /// No description provided for @floodSafetyTurnBackTitle.
  ///
  /// In en, this message translates to:
  /// **'Turn back'**
  String get floodSafetyTurnBackTitle;

  /// No description provided for @floodSafetyTurnBackDescription.
  ///
  /// In en, this message translates to:
  /// **'Do not enter a flooded area. Use a safer alternative route.'**
  String get floodSafetyTurnBackDescription;

  /// No description provided for @floodSafetyHigherGroundTitle.
  ///
  /// In en, this message translates to:
  /// **'Move to higher ground'**
  String get floodSafetyHigherGroundTitle;

  /// No description provided for @floodSafetyHigherGroundDescription.
  ///
  /// In en, this message translates to:
  /// **'If flooding is ahead, move away from the area as water levels can rise quickly.'**
  String get floodSafetyHigherGroundDescription;

  /// No description provided for @floodSafetyAvoidMovingWaterTitle.
  ///
  /// In en, this message translates to:
  /// **'Avoid moving floodwater'**
  String get floodSafetyAvoidMovingWaterTitle;

  /// No description provided for @floodSafetyAvoidMovingWaterDescription.
  ///
  /// In en, this message translates to:
  /// **'Floodwater can be difficult to judge and moving water can cause you to fall.'**
  String get floodSafetyAvoidMovingWaterDescription;

  /// No description provided for @floodSafetyAvoidDrivingTitle.
  ///
  /// In en, this message translates to:
  /// **'Do not drive into deep floodwater'**
  String get floodSafetyAvoidDrivingTitle;

  /// No description provided for @floodSafetyAvoidDrivingDescription.
  ///
  /// In en, this message translates to:
  /// **'Avoid flooded roads where water is above kerb height or road markings are no longer visible.'**
  String get floodSafetyAvoidDrivingDescription;

  /// No description provided for @floodSafetyBeforeTravellingTitle.
  ///
  /// In en, this message translates to:
  /// **'Before travelling'**
  String get floodSafetyBeforeTravellingTitle;

  /// No description provided for @floodSafetyBeforeTravellingDescription.
  ///
  /// In en, this message translates to:
  /// **'Check current weather and flood alerts before travelling during heavy rain, and plan an alternative route if necessary.'**
  String get floodSafetyBeforeTravellingDescription;

  /// No description provided for @floodSafetySource.
  ///
  /// In en, this message translates to:
  /// **'Safety guidance adapted from PUB, Singapore’s National Water Agency.'**
  String get floodSafetySource;

  /// No description provided for @floodSafetyDo.
  ///
  /// In en, this message translates to:
  /// **'DO'**
  String get floodSafetyDo;

  /// No description provided for @floodSafetyDont.
  ///
  /// In en, this message translates to:
  /// **'DON’T'**
  String get floodSafetyDont;

  /// No description provided for @scenarioRewardXp.
  ///
  /// In en, this message translates to:
  /// **'· +{points} XP'**
  String scenarioRewardXp(int points);

  /// No description provided for @learnTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get learnTryAgain;

  /// No description provided for @emergencyHelpTitle.
  ///
  /// In en, this message translates to:
  /// **'Emergency Help'**
  String get emergencyHelpTitle;

  /// No description provided for @emergencyInEmergency.
  ///
  /// In en, this message translates to:
  /// **'In an emergency'**
  String get emergencyInEmergency;

  /// No description provided for @emergencyImmediateDangerDescription.
  ///
  /// In en, this message translates to:
  /// **'If someone is in immediate danger, contact the appropriate emergency service immediately.'**
  String get emergencyImmediateDangerDescription;

  /// No description provided for @emergencyServices.
  ///
  /// In en, this message translates to:
  /// **'Emergency services'**
  String get emergencyServices;

  /// No description provided for @emergencyFireRescueTitle.
  ///
  /// In en, this message translates to:
  /// **'Fire, Rescue & Emergency Ambulance'**
  String get emergencyFireRescueTitle;

  /// No description provided for @emergencyFireRescueDescription.
  ///
  /// In en, this message translates to:
  /// **'Fire, rescue or life-threatening emergencies'**
  String get emergencyFireRescueDescription;

  /// No description provided for @emergencyPoliceTitle.
  ///
  /// In en, this message translates to:
  /// **'Police Emergency'**
  String get emergencyPoliceTitle;

  /// No description provided for @emergencyPoliceDescription.
  ///
  /// In en, this message translates to:
  /// **'Immediate police assistance'**
  String get emergencyPoliceDescription;

  /// No description provided for @emergencySms.
  ///
  /// In en, this message translates to:
  /// **'Emergency SMS'**
  String get emergencySms;

  /// No description provided for @emergencyPoliceSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'Police Emergency SMS'**
  String get emergencyPoliceSmsTitle;

  /// No description provided for @emergencyPoliceSmsDescription.
  ///
  /// In en, this message translates to:
  /// **'Emergency SMS when calling is unsafe'**
  String get emergencyPoliceSmsDescription;

  /// No description provided for @emergencyScdfSmsTitle.
  ///
  /// In en, this message translates to:
  /// **'SCDF Emergency SMS'**
  String get emergencyScdfSmsTitle;

  /// No description provided for @emergencyScdfSmsDescription.
  ///
  /// In en, this message translates to:
  /// **'Emergency SMS service for people who are deaf, hard-of-hearing or have speech impairments.'**
  String get emergencyScdfSmsDescription;

  /// No description provided for @emergencyOtherUsefulContacts.
  ///
  /// In en, this message translates to:
  /// **'Other useful contacts'**
  String get emergencyOtherUsefulContacts;

  /// No description provided for @emergencyNurseFirstDescription.
  ///
  /// In en, this message translates to:
  /// **'Non-emergency medical advice'**
  String get emergencyNurseFirstDescription;

  /// No description provided for @emergencyNeaHotline.
  ///
  /// In en, this message translates to:
  /// **'NEA Hotline'**
  String get emergencyNeaHotline;

  /// No description provided for @emergencyNeaDescription.
  ///
  /// In en, this message translates to:
  /// **'Environmental feedback and enquiries'**
  String get emergencyNeaDescription;

  /// No description provided for @emergencyWhenToCall.
  ///
  /// In en, this message translates to:
  /// **'When should I call?'**
  String get emergencyWhenToCall;

  /// No description provided for @emergencyEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Emergency'**
  String get emergencyEmergencyLabel;

  /// No description provided for @emergencyEmergencyGuide.
  ///
  /// In en, this message translates to:
  /// **'Someone is in immediate danger, seriously injured, experiencing a life-threatening medical condition, or there is a fire or rescue situation.'**
  String get emergencyEmergencyGuide;

  /// No description provided for @emergencyNonEmergencyLabel.
  ///
  /// In en, this message translates to:
  /// **'Non-emergency'**
  String get emergencyNonEmergencyLabel;

  /// No description provided for @emergencyNonEmergencyGuide.
  ///
  /// In en, this message translates to:
  /// **'The situation does not pose an immediate threat to life or safety. Use the appropriate non-emergency service instead.'**
  String get emergencyNonEmergencyGuide;

  /// No description provided for @emergencyDisclaimer.
  ///
  /// In en, this message translates to:
  /// **'Emergency information is provided for preparedness purposes. Always follow instructions from the relevant Singapore authorities.'**
  String get emergencyDisclaimer;

  /// No description provided for @profileLoadProgressError.
  ///
  /// In en, this message translates to:
  /// **'Unable to load your progress.'**
  String get profileLoadProgressError;

  /// No description provided for @profileWeeklyActivity.
  ///
  /// In en, this message translates to:
  /// **'Weekly Activity'**
  String get profileWeeklyActivity;

  /// No description provided for @profileWeeklyDaysCompleted.
  ///
  /// In en, this message translates to:
  /// **'{completed} / 7 days'**
  String profileWeeklyDaysCompleted(int completed);

  /// No description provided for @profileWeeklyActivityDescription.
  ///
  /// In en, this message translates to:
  /// **'Your preparedness-plan activity over the last 7 days.'**
  String get profileWeeklyActivityDescription;

  /// No description provided for @profileCurrentStreak.
  ///
  /// In en, this message translates to:
  /// **'{days}-day current streak'**
  String profileCurrentStreak(int days);

  /// No description provided for @profileYourProgress.
  ///
  /// In en, this message translates to:
  /// **'Your Progress'**
  String get profileYourProgress;

  /// No description provided for @profileProgressDescription.
  ///
  /// In en, this message translates to:
  /// **'Track your preparedness journey and achievements.'**
  String get profileProgressDescription;

  /// No description provided for @profileLevel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String profileLevel(int level);

  /// No description provided for @profileXpStreak.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP · {days}-day streak'**
  String profileXpStreak(int xp, int days);

  /// No description provided for @profileProgressToLevel.
  ///
  /// In en, this message translates to:
  /// **'Progress to Level {level}'**
  String profileProgressToLevel(int level);

  /// No description provided for @profileXpProgress.
  ///
  /// In en, this message translates to:
  /// **'{current} / 100 XP'**
  String profileXpProgress(int current);

  /// No description provided for @profileXpToLevel.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to Level {level}'**
  String profileXpToLevel(int xp, int level);

  /// No description provided for @profileTodayPlanCompleted.
  ///
  /// In en, this message translates to:
  /// **'Today’s plan completed'**
  String get profileTodayPlanCompleted;

  /// No description provided for @profileTodayPlanNotCompleted.
  ///
  /// In en, this message translates to:
  /// **'Today’s plan not completed yet'**
  String get profileTodayPlanNotCompleted;

  /// No description provided for @profileTodayPlanCompletedDescription.
  ///
  /// In en, this message translates to:
  /// **'Your XP and streak have been updated.'**
  String get profileTodayPlanCompletedDescription;

  /// No description provided for @profileTodayPlanNotCompletedDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete today’s preparedness plan to continue your streak.'**
  String get profileTodayPlanNotCompletedDescription;

  /// No description provided for @profileNextBadge.
  ///
  /// In en, this message translates to:
  /// **'Next badge'**
  String get profileNextBadge;

  /// No description provided for @profileBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get profileBadges;

  /// No description provided for @profileBadgeFirstCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'First Check'**
  String get profileBadgeFirstCheckTitle;

  /// No description provided for @profileBadgeFirstCheckDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete your first preparedness checklist item.'**
  String get profileBadgeFirstCheckDescription;

  /// No description provided for @profileBadgeHazeHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Haze Hero'**
  String get profileBadgeHazeHeroTitle;

  /// No description provided for @profileBadgeHazeHeroDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete both haze quizzes.'**
  String get profileBadgeHazeHeroDescription;

  /// No description provided for @profileBadgeUvGuardianTitle.
  ///
  /// In en, this message translates to:
  /// **'UV Guardian'**
  String get profileBadgeUvGuardianTitle;

  /// No description provided for @profileBadgeUvGuardianDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete both UV quizzes.'**
  String get profileBadgeUvGuardianDescription;

  /// No description provided for @profileBadgeFloodReadyTitle.
  ///
  /// In en, this message translates to:
  /// **'Flood Ready'**
  String get profileBadgeFloodReadyTitle;

  /// No description provided for @profileBadgeFloodReadyDescription.
  ///
  /// In en, this message translates to:
  /// **'Complete all flood preparedness checklist items.'**
  String get profileBadgeFloodReadyDescription;

  /// No description provided for @profileBadgeStreak7Title.
  ///
  /// In en, this message translates to:
  /// **'7-Day Streak'**
  String get profileBadgeStreak7Title;

  /// No description provided for @profileBadgeStreak7Description.
  ///
  /// In en, this message translates to:
  /// **'Maintain your preparedness streak for 7 days.'**
  String get profileBadgeStreak7Description;

  /// No description provided for @profileSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get profileSettings;

  /// No description provided for @profilePreferences.
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferences;

  /// No description provided for @profilePreferencesDescription.
  ///
  /// In en, this message translates to:
  /// **'Region, outdoor activity and preparedness reminders.'**
  String get profilePreferencesDescription;

  /// No description provided for @profileAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccount;

  /// No description provided for @profileLogout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get profileLogout;

  /// No description provided for @profileLogoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Sign out of your SGReady account.'**
  String get profileLogoutDescription;

  /// No description provided for @profileLogoutDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Log out of SGReady?'**
  String get profileLogoutDialogTitle;

  /// No description provided for @profileLogoutDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'You can log back in anytime using your account.'**
  String get profileLogoutDialogDescription;

  /// No description provided for @profileCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get profileCancel;

  /// No description provided for @profilePhotoSelectError.
  ///
  /// In en, this message translates to:
  /// **'Unable to select that photo. Please try again.'**
  String get profilePhotoSelectError;

  /// No description provided for @profileChangePhoto.
  ///
  /// In en, this message translates to:
  /// **'Change profile photo'**
  String get profileChangePhoto;

  /// No description provided for @profileChoosePhoto.
  ///
  /// In en, this message translates to:
  /// **'Choose profile photo'**
  String get profileChoosePhoto;

  /// No description provided for @profileRemovePhoto.
  ///
  /// In en, this message translates to:
  /// **'Remove profile photo'**
  String get profileRemovePhoto;

  /// No description provided for @profileRewards.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get profileRewards;

  /// No description provided for @profileLifetimeXp.
  ///
  /// In en, this message translates to:
  /// **'{xp} lifetime XP'**
  String profileLifetimeXp(int xp);

  /// No description provided for @profileAllRewardsUnlocked.
  ///
  /// In en, this message translates to:
  /// **'All prototype reward milestones unlocked.'**
  String get profileAllRewardsUnlocked;

  /// No description provided for @profileXpUntilNextReward.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP until your next reward.'**
  String profileXpUntilNextReward(int xp);

  /// No description provided for @profilePreparednessScore.
  ///
  /// In en, this message translates to:
  /// **'Preparedness Score'**
  String get profilePreparednessScore;

  /// No description provided for @profileScoreChecklist.
  ///
  /// In en, this message translates to:
  /// **'Checklist'**
  String get profileScoreChecklist;

  /// No description provided for @profileScoreQuizzes.
  ///
  /// In en, this message translates to:
  /// **'Quizzes'**
  String get profileScoreQuizzes;

  /// No description provided for @profileScoreEngagement.
  ///
  /// In en, this message translates to:
  /// **'Engagement'**
  String get profileScoreEngagement;

  /// No description provided for @profileScoreBadges.
  ///
  /// In en, this message translates to:
  /// **'Badges'**
  String get profileScoreBadges;

  /// No description provided for @rewardsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Rewards'**
  String get rewardsScreenTitle;

  /// No description provided for @rewardsMilestones.
  ///
  /// In en, this message translates to:
  /// **'Reward milestones'**
  String get rewardsMilestones;

  /// No description provided for @rewardsMilestonesDescription.
  ///
  /// In en, this message translates to:
  /// **'Build your preparedness knowledge and unlock rewards as your lifetime XP grows.'**
  String get rewardsMilestonesDescription;

  /// No description provided for @rewardTreatVoucherTitle.
  ///
  /// In en, this message translates to:
  /// **'\$5 Treat Voucher'**
  String get rewardTreatVoucherTitle;

  /// No description provided for @rewardTreatVoucherDescription.
  ///
  /// In en, this message translates to:
  /// **'A little treat for building good preparedness habits.'**
  String get rewardTreatVoucherDescription;

  /// No description provided for @rewardLifestyleVoucherTitle.
  ///
  /// In en, this message translates to:
  /// **'\$10 Lifestyle Voucher'**
  String get rewardLifestyleVoucherTitle;

  /// No description provided for @rewardLifestyleVoucherDescription.
  ///
  /// In en, this message translates to:
  /// **'A reward for staying active and prepared.'**
  String get rewardLifestyleVoucherDescription;

  /// No description provided for @rewardPreparednessPackTitle.
  ///
  /// In en, this message translates to:
  /// **'SGReady Preparedness Pack'**
  String get rewardPreparednessPackTitle;

  /// No description provided for @rewardPreparednessPackDescription.
  ///
  /// In en, this message translates to:
  /// **'Useful essentials to help you stay ready for emergencies.'**
  String get rewardPreparednessPackDescription;

  /// No description provided for @rewardsLifetimeXpTitle.
  ///
  /// In en, this message translates to:
  /// **'Your lifetime XP'**
  String get rewardsLifetimeXpTitle;

  /// No description provided for @rewardsXpValue.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP'**
  String rewardsXpValue(int xp);

  /// No description provided for @rewardsTier.
  ///
  /// In en, this message translates to:
  /// **'{tier} tier'**
  String rewardsTier(String tier);

  /// No description provided for @rewardsHighestTierReached.
  ///
  /// In en, this message translates to:
  /// **'Highest reward tier reached'**
  String get rewardsHighestTierReached;

  /// No description provided for @rewardsXpToTier.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP to {tier}'**
  String rewardsXpToTier(int xp, String tier);

  /// No description provided for @rewardsEarnXpDescription.
  ///
  /// In en, this message translates to:
  /// **'Earn XP from daily preparedness actions, quizzes, scenarios and your emergency kit.'**
  String get rewardsEarnXpDescription;

  /// No description provided for @rewardsTierStarter.
  ///
  /// In en, this message translates to:
  /// **'Starter'**
  String get rewardsTierStarter;

  /// No description provided for @rewardsTierPrepared.
  ///
  /// In en, this message translates to:
  /// **'Prepared'**
  String get rewardsTierPrepared;

  /// No description provided for @rewardsTierReady.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get rewardsTierReady;

  /// No description provided for @rewardsTierResilient.
  ///
  /// In en, this message translates to:
  /// **'Resilient'**
  String get rewardsTierResilient;

  /// No description provided for @rewardUnlocked.
  ///
  /// In en, this message translates to:
  /// **'Reward unlocked'**
  String get rewardUnlocked;

  /// No description provided for @rewardXpMoreToUnlock.
  ///
  /// In en, this message translates to:
  /// **'{xp} XP more to unlock'**
  String rewardXpMoreToUnlock(int xp);

  /// No description provided for @rewardView.
  ///
  /// In en, this message translates to:
  /// **'View reward'**
  String get rewardView;

  /// No description provided for @rewardPrototypeDialogDescription.
  ///
  /// In en, this message translates to:
  /// **'This reward is part of the SGReady prototype and is not currently redeemable. In a future implementation, eligible users could redeem rewards through participating partner organisations.'**
  String get rewardPrototypeDialogDescription;

  /// No description provided for @rewardGotIt.
  ///
  /// In en, this message translates to:
  /// **'Got it'**
  String get rewardGotIt;

  /// No description provided for @prototypeRewardsTitle.
  ///
  /// In en, this message translates to:
  /// **'Prototype rewards'**
  String get prototypeRewardsTitle;

  /// No description provided for @prototypeRewardsDescription.
  ///
  /// In en, this message translates to:
  /// **'Rewards shown in SGReady are simulated for demonstration purposes and are not currently redeemable. Real-world implementation would require partnerships with participating organisations and secure reward fulfilment.'**
  String get prototypeRewardsDescription;

  /// No description provided for @youSpendMoreTimeOutdoors.
  ///
  /// In en, this message translates to:
  /// **'You spend more time outdoors'**
  String get youSpendMoreTimeOutdoors;

  /// No description provided for @usuallyOutdoorsAtMidday.
  ///
  /// In en, this message translates to:
  /// **'Usually outdoors at midday'**
  String get usuallyOutdoorsAtMidday;

  /// No description provided for @todayFocusAirQuality.
  ///
  /// In en, this message translates to:
  /// **'Air quality'**
  String get todayFocusAirQuality;

  /// No description provided for @todayFocusHeatSafety.
  ///
  /// In en, this message translates to:
  /// **'Heat safety'**
  String get todayFocusHeatSafety;

  /// No description provided for @todayFocusUvProtection.
  ///
  /// In en, this message translates to:
  /// **'UV protection'**
  String get todayFocusUvProtection;
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
      <String>['en', 'ms', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ms':
      return AppLocalizationsMs();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
