// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'SGReady';

  @override
  String get preferences => 'Preferences';

  @override
  String get personaliseSGReady => 'Personalise SGReady';

  @override
  String get preferencesDescription =>
      'These preferences help SGReady tailor your preparedness experience.';

  @override
  String get homeRegion => 'Home region';

  @override
  String get homeRegionDescription =>
      'Choose the Singapore region you usually want to see first.';

  @override
  String get central => 'Central';

  @override
  String get north => 'North';

  @override
  String get south => 'South';

  @override
  String get east => 'East';

  @override
  String get west => 'West';

  @override
  String get outdoorActivity => 'Outdoor activity';

  @override
  String get outdoorActivityDescription =>
      'How much time do you usually spend outdoors?';

  @override
  String get low => 'Low';

  @override
  String get moderate => 'Moderate';

  @override
  String get high => 'High';

  @override
  String get usuallyOutdoors => 'Usually outdoors';

  @override
  String get usuallyOutdoorsDescription =>
      'Select the periods when you are commonly outside.';

  @override
  String get morning => 'Morning';

  @override
  String get midday => 'Midday';

  @override
  String get evening => 'Evening';

  @override
  String get preparednessReminders => 'Preparedness reminders';

  @override
  String get preparednessRemindersDescription =>
      'Allow SGReady to remind you about relevant preparedness actions.';

  @override
  String get enableReminders => 'Enable reminders';

  @override
  String get notificationSchedule => 'Notification schedule';

  @override
  String get daytimeOnly => 'Daytime only';

  @override
  String get daytimeOnlyDescription =>
      'Weather and task reminders approximately every 5 hours between 8 AM and 10 PM.';

  @override
  String get twentyFourHours => '24 hours';

  @override
  String get twentyFourHoursDescription =>
      'Weather updates approximately every 5 hours, day and night. Task reminders are limited to 8 AM–10 PM.';

  @override
  String get accessibility => 'Accessibility';

  @override
  String get accessibilityDescription =>
      'Adjust SGReady to make the app easier and more comfortable to use.';

  @override
  String get largerText => 'Larger text';

  @override
  String get largerTextDescription =>
      'Increase text size across SGReady for easier reading.';

  @override
  String get largerControls => 'Larger controls';

  @override
  String get largerControlsDescription =>
      'Increase the size of important controls to make them easier to tap.';

  @override
  String get language => 'Language';

  @override
  String get languageDescription => 'Choose the language used across SGReady.';

  @override
  String get english => 'English';

  @override
  String get simplifiedChinese => 'Simplified Chinese';

  @override
  String get malay => 'Malay';

  @override
  String get appearance => 'Appearance';

  @override
  String get appearanceDescription =>
      'Choose how SGReady looks on this device.';

  @override
  String get systemDefault => 'System default';

  @override
  String get systemDefaultDescription => 'Match your device appearance';

  @override
  String get light => 'Light';

  @override
  String get lightDescription => 'Always use light mode';

  @override
  String get dark => 'Dark';

  @override
  String get darkDescription => 'Always use dark mode';

  @override
  String get savePreferences => 'Save preferences';

  @override
  String get saving => 'Saving...';

  @override
  String get preferencesSaved => 'Preferences saved.';

  @override
  String get unableToSavePreferences => 'Unable to save preferences.';

  @override
  String get navHome => 'Home';

  @override
  String get navToday => 'Today';

  @override
  String get navExplore => 'Explore';

  @override
  String get navLearn => 'Learn';

  @override
  String get navProfile => 'Profile';

  @override
  String get todayInSingapore => 'Today in Singapore';

  @override
  String get homeDescription =>
      'Check local conditions and what you should prepare for.';

  @override
  String get todaysPreparedness => 'Today’s preparedness';

  @override
  String get whatYouShouldDo => 'What you should do';

  @override
  String get showLess => 'Show less';

  @override
  String get why => 'Why?';

  @override
  String get noData => 'No data';

  @override
  String get psi24h => 'PSI (24h)';

  @override
  String get uvIndex => 'UV Index';

  @override
  String get temperature => 'Temperature';

  @override
  String get wbgtHeatStress => 'WBGT (Heat Stress)';

  @override
  String lastUpdated(String dateTime) {
    return 'Last updated: $dateTime';
  }

  @override
  String regionAverage(String region) {
    return '$region average';
  }

  @override
  String get riskElevated => 'Elevated';

  @override
  String get riskLow => 'Low';

  @override
  String get riskModerate => 'Moderate';

  @override
  String get riskHigh => 'High';

  @override
  String get riskVeryHigh => 'Very High';

  @override
  String get riskExtreme => 'Extreme';

  @override
  String get floodRiskMessage =>
      'Heavy rainfall detected. Stay alert and avoid flood-prone areas.';

  @override
  String get lowRiskMessage =>
      'Conditions are generally good. Stay prepared and keep monitoring updates.';

  @override
  String get moderateRiskMessage =>
      'Take basic precautions and follow today’s recommended actions.';

  @override
  String get highRiskMessage =>
      'Follow the safety guidance below and adjust your plans if needed.';

  @override
  String get veryHighRiskMessage =>
      'Limit outdoor exposure and take additional precautions.';

  @override
  String get extremeRiskMessage =>
      'Avoid unnecessary outdoor activity and follow safety guidance closely.';

  @override
  String get recommendationEnvironmentalDataUnavailable =>
      'Environmental data unavailable';

  @override
  String get recommendationEnvironmentalDataUnavailableBody =>
      'Current environmental readings could not be retrieved. Please try refreshing the data later.';

  @override
  String get actionCheckInternetConnection => 'Check your internet connection';

  @override
  String get actionRefreshEnvironmentalData => 'Refresh the environmental data';

  @override
  String get actionReferOfficialChannels =>
      'Refer to official NEA and PUB channels if conditions appear unsafe';

  @override
  String get recommendationPsiUnavailable => 'PSI reading unavailable';

  @override
  String get recommendationPsiUnavailableBody =>
      'The latest air-quality reading could not be retrieved.';

  @override
  String get actionRefreshDataLater => 'Refresh the data later';

  @override
  String get actionReferNeaHazeUpdates =>
      'Refer to official NEA haze updates when planning outdoor activity';

  @override
  String recommendationHaze(int psi) {
    return 'Haze / Air Quality (PSI $psi)';
  }

  @override
  String get psiBodyGood => 'Air quality is within the Good range.';

  @override
  String get psiBodyModerate =>
      'Air quality is within the Moderate range. Most people can continue normal activities, while vulnerable individuals should monitor their health and symptoms.';

  @override
  String get psiBodyHigh =>
      'Air quality is Unhealthy. Reduce prolonged or strenuous outdoor activity, particularly if you are vulnerable to air pollution.';

  @override
  String get psiBodyVeryHigh =>
      'Air quality is Very Unhealthy. Minimise outdoor activity and reduce exposure where possible.';

  @override
  String get psiBodyExtreme =>
      'Air quality is Hazardous. Remain indoors where possible and minimise exposure to outdoor air.';

  @override
  String get actionContinueNormalActivities => 'Continue normal activities';

  @override
  String get actionMonitorEnvironmentalUpdates =>
      'Monitor official environmental updates';

  @override
  String get actionContinueNormalIfWell =>
      'Continue normal activities if you feel well';

  @override
  String get actionMonitorHealthSymptoms =>
      'Monitor symptoms if you have heart or respiratory conditions';

  @override
  String get actionCheckPsiBeforeOutdoorActivity =>
      'Check updated PSI readings before prolonged outdoor activity';

  @override
  String get actionReduceOutdoorActivity =>
      'Reduce prolonged or strenuous outdoor activity';

  @override
  String get actionWearN95Appropriate =>
      'Wear a properly fitted N95 mask when appropriate';

  @override
  String get actionKeepIndoorAirClean =>
      'Keep indoor air as clean as reasonably possible';

  @override
  String get actionSeekMedicalAdvice =>
      'Seek medical advice if you feel unwell';

  @override
  String get actionMinimiseOutdoorActivity => 'Minimise outdoor activity';

  @override
  String get actionRemainIndoors => 'Remain indoors where possible';

  @override
  String get actionWearN95IfUnavoidable =>
      'Wear a properly fitted N95 mask if outdoor exposure is unavoidable';

  @override
  String get actionSeekHelpBreathing =>
      'Seek medical help if breathing difficulties develop';

  @override
  String get actionAvoidOutdoorActivity =>
      'Avoid outdoor activity where possible';

  @override
  String get actionCloseDoorsWindows =>
      'Remain indoors with doors and windows closed';

  @override
  String get actionWearN95Outside =>
      'Wear a properly fitted N95 mask if you must go outside';

  @override
  String get actionSeekHelpSeriousSymptoms =>
      'Seek medical help promptly if you experience serious symptoms';

  @override
  String get recommendationUvUnavailable => 'UV reading unavailable';

  @override
  String get recommendationUvUnavailableBody =>
      'The latest ultraviolet-index reading could not be retrieved.';

  @override
  String get actionSunProtectionExtended =>
      'Use sun protection when spending extended periods outdoors';

  @override
  String recommendationUvExposure(int uv) {
    return 'UV Exposure (Index $uv)';
  }

  @override
  String get uvBodyGood =>
      'UV exposure is Low. Minimal protection is normally required.';

  @override
  String get uvBodyModerate =>
      'UV exposure is Moderate. Use sun protection during extended periods outdoors.';

  @override
  String get uvBodyHigh =>
      'UV exposure is High. Use sunscreen, protective clothing and shade, especially around midday.';

  @override
  String get uvBodyVeryHigh =>
      'UV exposure is Very High. Minimise direct midday sun exposure and use comprehensive sun protection.';

  @override
  String get uvBodyExtreme =>
      'UV exposure is Extreme. Avoid unnecessary direct sun exposure during peak hours and use comprehensive protection.';

  @override
  String get actionBasicSunProtection =>
      'Use basic sun protection during extended outdoor exposure';

  @override
  String get actionApplySunscreen => 'Apply broad-spectrum SPF 30+ sunscreen';

  @override
  String get actionWearSunglasses =>
      'Wear sunglasses during extended outdoor activity';

  @override
  String get actionSeekShade => 'Seek shade when practical';

  @override
  String get actionReapplySunscreen =>
      'Reapply sunscreen according to product directions';

  @override
  String get actionWearHatSunglassesClothing =>
      'Wear a hat, sunglasses and protective clothing';

  @override
  String get actionSeekMiddayShade => 'Seek shade during midday hours';

  @override
  String get actionMinimiseMiddaySun =>
      'Minimise direct sun exposure around midday';

  @override
  String get actionWearProtectiveClothing =>
      'Wear protective clothing, a hat and sunglasses';

  @override
  String get actionRegularlyReapplySunscreen =>
      'Apply and regularly reapply SPF 30+ sunscreen';

  @override
  String get actionTakeShadeBreaks =>
      'Take regular shade breaks when working outdoors';

  @override
  String get actionAvoidMiddaySun =>
      'Avoid unnecessary direct sun exposure around midday';

  @override
  String get actionUseShadeProtectiveClothing =>
      'Use shade and protective clothing';

  @override
  String get actionOutdoorWorkersShadeBreaks =>
      'Outdoor workers should take frequent shaded rest breaks';

  @override
  String get recommendationHeavyRain => 'Heavy Rainfall Alert';

  @override
  String get heavyRainBodyOne =>
      'One weather station is reporting rainfall above the configured heavy-rain threshold. Flooding may occur in vulnerable or low-lying areas.';

  @override
  String heavyRainBodyMany(int count) {
    return '$count weather stations are reporting rainfall above the configured heavy-rain threshold. Flooding may occur in vulnerable or low-lying areas.';
  }

  @override
  String get actionAvoidFloodWater =>
      'Avoid entering moving or deep flood water';

  @override
  String get actionCheckPubUpdates =>
      'Check official PUB flood and heavy-rain updates';

  @override
  String get actionAvoidFloodProneRoutes =>
      'Avoid flood-prone or low-lying routes';

  @override
  String get actionKeepEmergencyDevices =>
      'Keep a charged phone, torch and power bank available';

  @override
  String get recommendationFavourable => 'Conditions look favourable';

  @override
  String get recommendationFavourableBody =>
      'Current available PSI and UV readings are within lower-risk ranges, and no heavy-rain threshold has been detected.';

  @override
  String get actionContinueMonitoring =>
      'Continue monitoring environmental updates';

  @override
  String get actionReviewEmergencyKit =>
      'Review your emergency kit and preparedness checklist';

  @override
  String get actionCompletePreparednessActivity =>
      'Complete a preparedness activity to maintain awareness';

  @override
  String get psiGood => 'Good';

  @override
  String get psiModerate => 'Moderate';

  @override
  String get psiUnhealthy => 'Unhealthy';

  @override
  String get psiVeryUnhealthy => 'Very Unhealthy';

  @override
  String get psiHazardous => 'Hazardous';

  @override
  String get todayTitle => 'Today';

  @override
  String get todayDescription =>
      'Your personalised preparedness plan for today.';

  @override
  String get todayPlanError => 'Unable to generate today’s preparedness plan.';

  @override
  String get todayProgressError => 'Unable to load today’s progress.';

  @override
  String get todayEnvironmentError =>
      'Unable to prepare today’s environmental context.';

  @override
  String get completeTasksBeforeClaiming =>
      'Complete all tasks before claiming your XP.';

  @override
  String get claimTodayReward => 'Claim today’s reward?';

  @override
  String get claimRewardDescription =>
      'Make sure you’re happy with today’s completed actions before claiming your XP.';

  @override
  String get notYet => 'Not yet';

  @override
  String claimXp(int xp) {
    return 'Claim $xp XP';
  }

  @override
  String get planComplete => 'Plan Complete!';

  @override
  String get planCompleteDescription =>
      'Great work completing today’s preparedness actions.';

  @override
  String get awesome => 'Awesome!';

  @override
  String get personalisedForYou => 'Personalised for you';

  @override
  String get yourRoutine => 'YOUR ROUTINE';

  @override
  String get todaysFocus => 'TODAY\'S FOCUS';

  @override
  String get moreTimeOutdoors => 'You spend more time outdoors';

  @override
  String get moderatelyActiveOutdoors => 'You’re moderately active outdoors';

  @override
  String get usuallyOutdoorsMidday => 'Usually outdoors at midday';

  @override
  String get airQuality => 'Air quality';

  @override
  String get heatSafety => 'Heat safety';

  @override
  String get uvProtection => 'UV protection';

  @override
  String get todayPlanAdapts =>
      'Today’s plan adapts to your routine and current environmental conditions.';

  @override
  String get todaysActions => 'Today’s actions';

  @override
  String get todaysActionsDescription =>
      'Complete the recommended actions below to build today’s preparedness.';

  @override
  String get rewardClaimed => 'Reward claimed';

  @override
  String get completeOneMoreTask => 'Complete 1 more task';

  @override
  String completeMoreTasks(int count) {
    return 'Complete $count more tasks';
  }

  @override
  String get todaysConditions => 'Today’s conditions';

  @override
  String priority(String focus) {
    return 'Priority: $focus';
  }

  @override
  String get whyThisPlan => 'Why this plan?';

  @override
  String get heavyRain => 'Heavy rain';

  @override
  String get focusRainPreparation => 'Rain preparation';

  @override
  String get focusAirQualitySunProtection => 'Air quality & sun protection';

  @override
  String get focusAirQuality => 'Air quality';

  @override
  String get focusSunProtection => 'Sun protection';

  @override
  String get focusGeneralPreparedness => 'General preparedness';

  @override
  String get dailyPreparedness => 'Daily preparedness';

  @override
  String allActionsCompleted(int total) {
    return 'All $total actions completed';
  }

  @override
  String actionsCompleted(int completed, int total) {
    return '$completed of $total actions completed';
  }

  @override
  String tasksLeft(int count) {
    return '$count left';
  }

  @override
  String counterProgress(int current, int target, String unit) {
    return '$current of $target $unit';
  }

  @override
  String get completed => 'completed';

  @override
  String get missionRewardClaimedMessage =>
      'Reward claimed. Return tomorrow for a new preparedness plan.';

  @override
  String get missionCompleteMessage =>
      'Great work. Your daily reward is ready.';

  @override
  String get missionStartMessage =>
      'Start with one small action to improve today’s preparedness.';

  @override
  String get missionGoodStartMessage =>
      'Good start. Continue with the remaining actions.';

  @override
  String get missionOneRemainingMessage =>
      'You’re almost there. Only one action remains.';

  @override
  String get missionRemainingMessage =>
      'You’re almost there. Complete the remaining actions.';

  @override
  String get done => 'Done';

  @override
  String get noDailyMission =>
      'No daily mission is currently available. Refresh the environmental data and try again.';

  @override
  String get taskReviewConditionsTitle => 'Review today’s conditions';

  @override
  String get taskReviewConditionsDescription =>
      'Check the current PSI, UV Index, temperature and rainfall conditions before planning outdoor activities.';

  @override
  String get taskReviewConditionsReason =>
      'Reviewing live conditions helps you choose the right precautions before heading outdoors.';

  @override
  String get taskMonitorAirQualityTitle => 'Monitor the air quality';

  @override
  String get taskMonitorAirQualityDescription =>
      'Check the PSI again before prolonged outdoor activity, especially if you are sensitive to haze.';

  @override
  String get taskMonitorAirQualityReason =>
      'The current PSI indicates that additional caution may be useful, particularly for sensitive individuals.';

  @override
  String get taskPackN95Title => 'Pack an N95 mask';

  @override
  String get taskPackN95Description =>
      'Bring a properly fitted N95 mask if outdoor activity cannot be avoided.';

  @override
  String get taskPackN95Reason =>
      'Air quality is currently unhealthy enough for additional protection to be recommended outdoors.';

  @override
  String get taskReduceOutdoorExerciseTitle =>
      'Reduce strenuous outdoor activity';

  @override
  String get taskReduceOutdoorExerciseDescription =>
      'Choose lighter or indoor activities while the air quality is unhealthy.';

  @override
  String get taskReduceOutdoorExerciseReason =>
      'Strenuous activity increases breathing rate and may increase exposure to air pollutants.';

  @override
  String get taskStayIndoorsHazeTitle => 'Stay indoors where possible';

  @override
  String get taskStayIndoorsHazeDescription =>
      'Keep windows and doors closed and minimise unnecessary outdoor exposure.';

  @override
  String get taskStayIndoorsHazeReason =>
      'Current air-quality conditions indicate a high level of exposure risk outdoors.';

  @override
  String get taskPrepareN95HazeTitle => 'Keep an N95 mask ready';

  @override
  String get taskPrepareN95HazeDescription =>
      'Use an N95 mask if leaving the house is unavoidable.';

  @override
  String get taskPrepareN95HazeReason =>
      'An N95 mask can help reduce exposure to fine haze particles during poor air-quality conditions.';

  @override
  String get taskCheckHazeSymptomsTitle => 'Monitor your health';

  @override
  String get taskCheckHazeSymptomsDescription =>
      'Watch for breathing difficulty, coughing or eye irritation.';

  @override
  String get taskCheckHazeSymptomsReason =>
      'Very poor air quality may affect respiratory comfort and other health symptoms.';

  @override
  String get taskApplySunscreenTitle => 'Apply sunscreen';

  @override
  String get taskApplySunscreenDescription =>
      'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.';

  @override
  String get taskApplySunscreenReason =>
      'Today’s UV level means sun protection is recommended before going outdoors.';

  @override
  String get taskSeekMiddayShadeTitle => 'Seek shade around midday';

  @override
  String get taskSeekMiddayShadeDescription =>
      'Limit direct sun exposure during the strongest UV period.';

  @override
  String get taskSeekMiddayShadeReason =>
      'UV exposure is typically stronger around midday, making shade an effective protective measure.';

  @override
  String get taskReapplySunscreenTitle => 'Reapply sunscreen';

  @override
  String get taskReapplySunscreenDescription =>
      'Reapply sunscreen according to the product instructions, especially after sweating.';

  @override
  String get taskReapplySunscreenReason =>
      'Very high UV exposure can require continued protection during prolonged outdoor activity.';

  @override
  String get taskWearSunProtectionTitle => 'Wear sun protection';

  @override
  String get taskWearSunProtectionDescription =>
      'Bring a hat, sunglasses and protective clothing.';

  @override
  String get taskWearSunProtectionReason =>
      'Additional physical protection helps reduce direct UV exposure to the skin and eyes.';

  @override
  String get taskAvoidMiddaySunTitle => 'Avoid prolonged midday sun';

  @override
  String get taskAvoidMiddaySunDescription =>
      'Move strenuous outdoor plans away from the strongest UV period.';

  @override
  String get taskAvoidMiddaySunReason =>
      'Very high UV levels make prolonged exposure around midday less advisable.';

  @override
  String get taskCarryWaterHeatTitle => 'Bring water with you';

  @override
  String get taskCarryWaterHeatDescription =>
      'Keep water available if you will be spending time outdoors.';

  @override
  String get taskCarryWaterHeatReason =>
      'Current WBGT conditions indicate Moderate heat stress.';

  @override
  String get taskHydrationGoalHeatTitle => 'Track your water intake';

  @override
  String get taskHydrationGoalHeatDescription =>
      'Record six glasses of water during the day.';

  @override
  String get taskHydrationGoalHeatReason =>
      'Current WBGT conditions indicate High heat stress.';

  @override
  String get taskCoolingBreakHeatTitle => 'Take regular cooling breaks';

  @override
  String get taskCoolingBreakHeatDescription =>
      'Spend regular breaks in shaded, ventilated or air-conditioned areas.';

  @override
  String get taskCoolingBreakHeatReason =>
      'High heat-stress conditions increase the need for rest and cooling.';

  @override
  String get taskReduceOutdoorHeatTitle => 'Reduce strenuous outdoor activity';

  @override
  String get taskReduceOutdoorHeatDescription =>
      'Choose lighter activity or move strenuous plans to a cooler part of the day.';

  @override
  String get taskReduceOutdoorHeatReason =>
      'Current WBGT conditions indicate High heat stress.';

  @override
  String get taskRainPreparationTitle => 'Prepare for heavy rain';

  @override
  String get taskRainPreparationDescription =>
      'Complete the key steps before travelling during heavy rainfall.';

  @override
  String get taskRainPreparationReason =>
      'Heavy rainfall has been detected and may affect travel, flood risk and access to weather updates.';

  @override
  String get estimatedOneMinute => '1 minute';

  @override
  String get estimatedThirtySeconds => '30 seconds';

  @override
  String get estimatedThroughoutDay => 'Throughout the day';

  @override
  String get estimatedPlanToday => 'Plan for today';

  @override
  String get estimatedTwoThreeMinutes => '2–3 minutes';

  @override
  String get unitSteps => 'steps';

  @override
  String get unitGlasses => 'glasses';

  @override
  String get undo => 'Undo';

  @override
  String get complete => 'Complete';

  @override
  String hydrationProgress(int current, int target) {
    return '$current of $target glasses';
  }

  @override
  String get undoLastGlass => 'Undo last glass';

  @override
  String get hydrationComplete => 'Hydration complete';

  @override
  String get iDrankAGlass => 'I drank a glass';

  @override
  String get hydrationGoalComplete => 'Hydration goal complete!';

  @override
  String xpWhenPlanClaimed(int xp) {
    return '+$xp XP when today’s plan is claimed';
  }

  @override
  String get sunscreenApplied => 'Sunscreen applied';

  @override
  String coveragePercent(int percent) {
    return '$percent% covered';
  }

  @override
  String get applySunscreenButton => 'Apply sunscreen';

  @override
  String rainStepsReady(int current, int target) {
    return '$current of $target steps ready';
  }

  @override
  String rainReadyProgress(int current, int target) {
    return '$current of $target ready';
  }

  @override
  String get undoLastStep => 'Undo last step';

  @override
  String get packUmbrella => 'Pack an umbrella';

  @override
  String get checkFloodAlerts => 'Check flood alerts';

  @override
  String get reviewYourRoute => 'Review your route';

  @override
  String get chargePowerBank => 'Charge your power bank';

  @override
  String get rainPrepComplete => 'Rain prep complete';

  @override
  String get completeNextStep => 'Complete next step';

  @override
  String get missionGoodMorning => 'Good morning';

  @override
  String get missionGoodAfternoon => 'Good afternoon';

  @override
  String get missionGoodEvening => 'Good evening';

  @override
  String get missionRainTitle => 'Rain preparedness is recommended';

  @override
  String get missionRainMessage =>
      'Heavy rainfall may affect travel and outdoor plans. Review today’s rain and flood-safety actions.';

  @override
  String get missionHeatUvTitle => 'Heat and UV precautions are recommended';

  @override
  String get missionHeatUvMessage =>
      'Heat stress and UV exposure may affect outdoor activity today. Stay hydrated, use sun protection and take regular cooling breaks.';

  @override
  String get missionHeatTitle => 'Heat precautions are recommended';

  @override
  String get missionHeatMessage =>
      'Heat stress is elevated today. Stay hydrated, take cooling breaks and reduce strenuous outdoor activity where possible.';

  @override
  String get missionHazeUvTitle =>
      'Air-quality and UV precautions are recommended';

  @override
  String get missionHazeUvMessage =>
      'Review both air-quality and sun-protection actions before spending time outdoors.';

  @override
  String get missionHazeTitle => 'Air-quality precautions are recommended';

  @override
  String get missionHazeMessage =>
      'Monitor the PSI and adjust prolonged outdoor activities where necessary.';

  @override
  String get missionUvTitle => 'UV protection is recommended';

  @override
  String get missionUvMessage =>
      'Sun protection and hydration may be important for outdoor activities today.';

  @override
  String get missionGeneralTitle => 'Conditions are generally manageable';

  @override
  String get missionGeneralMessage =>
      'Review today’s readings and complete the basic preparedness actions.';

  @override
  String get riskUnknown => 'Unknown';

  @override
  String get riskNoData => 'No data';

  @override
  String psiReading(String value, String label) {
    return 'PSI $value · $label';
  }

  @override
  String uvReading(String value, String label) {
    return 'UV $value · $label';
  }

  @override
  String heatStressReading(String label) {
    return 'Heat stress · $label';
  }

  @override
  String get taskApplySunscreenModerateDescription =>
      'Apply broad-spectrum SPF 30+ sunscreen before prolonged outdoor activity.';

  @override
  String get taskApplySunscreenModerateReason =>
      'Today’s UV level means sun protection is recommended when spending extended time outdoors.';

  @override
  String get taskApplySunscreenHighDescription =>
      'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.';

  @override
  String get taskApplySunscreenHighReason =>
      'The UV Index is high today, so sun protection is recommended before outdoor activity.';

  @override
  String get taskApplySunscreenVeryHighDescription =>
      'Apply broad-spectrum SPF 30+ sunscreen before going outdoors.';

  @override
  String get taskApplySunscreenVeryHighReason =>
      'Today’s UV level means strong sun protection is recommended before going outdoors.';

  @override
  String get exploreTitle => 'Explore Singapore';

  @override
  String get exploreDescription =>
      'Explore environmental conditions across Singapore.';

  @override
  String get exploreHeat => 'Heat';

  @override
  String get explorePsi => 'PSI';

  @override
  String get exploreRain => 'Rain';

  @override
  String get exploreFindNearMe => 'Find conditions near me';

  @override
  String get exploreTapMarker => 'Tap a marker to view details';

  @override
  String get exploreLow => 'Low';

  @override
  String get exploreModerate => 'Moderate';

  @override
  String get exploreHigh => 'High';

  @override
  String get exploreHeatStress => 'Heat Stress';

  @override
  String exploreWbgtStationsReporting(int count) {
    return '$count WBGT stations reporting';
  }

  @override
  String get exploreHighestObserved => 'Highest observed';

  @override
  String get exploreForYou => 'For you: ';

  @override
  String get exploreHeatAdvice =>
      'Stay hydrated and take regular cooling breaks.';

  @override
  String get exploreUnableLoadHeat => 'Unable to load heat-stress data.';

  @override
  String get exploreNoWbgtObservations =>
      'No current WBGT observations are available.';

  @override
  String get exploreHeatStressLabel => 'Heat stress';

  @override
  String get exploreRegion => 'Region';

  @override
  String get exploreLatestStationReading => 'Latest observed station reading';

  @override
  String exploreMetresAway(int distance) {
    return '$distance m away';
  }

  @override
  String exploreKilometresAway(String distance) {
    return '$distance km away';
  }

  @override
  String get exploreUnableLoadPsi => 'Unable to load PSI data.';

  @override
  String get exploreNoRegionalPsi =>
      'No current regional PSI readings are available.';

  @override
  String get exploreAirQuality => 'Air Quality';

  @override
  String get exploreSingaporeRegionalPsi => 'Singapore regional PSI';

  @override
  String get exploreBasedOnLocation => 'Based on your approximate location';

  @override
  String get exploreAirQualityLabel => 'Air quality';

  @override
  String get explorePsiAdviceGood =>
      'Air quality is good. Normal activities can continue.';

  @override
  String get explorePsiAdviceModerate =>
      'Air quality is in the moderate range. Normal activities can generally continue.';

  @override
  String get explorePsiAdviceUnhealthy =>
      'Air quality is unhealthy. Consider reducing prolonged or strenuous outdoor activity.';

  @override
  String get explorePsiAdviceVeryUnhealthy =>
      'Air quality is very unhealthy. Minimise prolonged outdoor activity.';

  @override
  String get explorePsiAdviceHazardous =>
      'Air quality is hazardous. Avoid unnecessary outdoor activity.';

  @override
  String get exploreUnableLoadRain => 'Unable to load rainfall data.';

  @override
  String get exploreNoRainfall => 'No rainfall detected';

  @override
  String get exploreNoRainfallDescription =>
      'No rainfall is currently being recorded across reporting stations in Singapore.';

  @override
  String get exploreRainfall => 'Rainfall';

  @override
  String exploreStationsReportingRain(int count) {
    return '$count station(s) currently reporting rain';
  }

  @override
  String get exploreRainLight => 'Light';

  @override
  String get exploreRainModerate => 'Moderate';

  @override
  String get exploreRainHeavy => 'Heavy';

  @override
  String get exploreRainAdviceLight =>
      'Carry an umbrella if you’re heading outdoors.';

  @override
  String get exploreRainAdviceModerate =>
      'Bring an umbrella and take care on wet paths and roads.';

  @override
  String get exploreRainAdviceHeavy =>
      'Avoid flood-prone areas and check your route before travelling.';

  @override
  String get exploreRainIntensity => 'Intensity';

  @override
  String get exploreLatestRainfallReading => 'Latest observed rainfall reading';

  @override
  String get exploreLocationAccessNeeded =>
      'Location access is needed to find conditions near you.';

  @override
  String get exploreNoRainfallStations =>
      'No rainfall stations are currently available.';

  @override
  String get exploreNoRegionalPsiNearby =>
      'No regional PSI readings are currently available.';

  @override
  String get exploreUnableFindPsiArea =>
      'Unable to find the PSI reading for your area.';

  @override
  String get exploreNoWbgtStations =>
      'No WBGT stations are currently available.';

  @override
  String get exploreUnableFindNearby => 'Unable to find nearby conditions.';

  @override
  String get learnTitle => 'Learn & Prepare';

  @override
  String get learnDescription =>
      'Build your preparedness knowledge and skills.';

  @override
  String get learnEmergencyHelp => 'Emergency Help';

  @override
  String get learnEmergencyHelpDescription =>
      'Important Singapore emergency contacts and when to use them.';

  @override
  String get learnTabMyKit => 'My Kit';

  @override
  String get learnTabQuizzes => 'Quizzes';

  @override
  String get learnTabScenarios => 'Scenarios';

  @override
  String get learnMyEmergencyKit => 'My Emergency Kit';

  @override
  String get learnEmergencyKitDescription =>
      'Build your emergency kit step by step.';

  @override
  String get learnQuickSkills => 'Quick Skills';

  @override
  String get learnLearnInMinutes => 'Learn in minutes';

  @override
  String get learnCprAed => 'CPR & AED';

  @override
  String get learnLifeSavingBasics => 'Life-saving basics';

  @override
  String get learnVideoGuide => 'Video guide';

  @override
  String get learnFlashFloodSafety => 'Flash Flood Safety';

  @override
  String get learnHeavyRainFloodSafety => 'Heavy rain & flood safety';

  @override
  String get learnQuickGuide => 'Quick guide';

  @override
  String get learnPreparednessCategories => 'Preparedness Categories';

  @override
  String learnKitReady(int percentage) {
    return '$percentage% Ready';
  }

  @override
  String get learnKitComplete => 'Your preparedness checklist is complete.';

  @override
  String learnKitItemsRemaining(int count) {
    return '$count item(s) remaining.';
  }

  @override
  String get learnKitStatusEmergencyReady => 'Emergency Ready';

  @override
  String get learnKitStatusWellPrepared => 'Well Prepared';

  @override
  String get learnKitStatusGettingPrepared => 'Getting Prepared';

  @override
  String get learnKitStatusBasicPreparation => 'Basic Preparation';

  @override
  String get learnKitStatusNeedsAttention => 'Needs Attention';

  @override
  String get learnKitProgressError =>
      'Unable to load your emergency-kit progress.';

  @override
  String get learnRecommendedComplete =>
      'You already have the recommended items for today’s conditions.';

  @override
  String get learnRecommendedToday => 'Recommended Today';

  @override
  String get learnRecommendedBasedOnConditions =>
      'Based on the current environmental conditions:';

  @override
  String get learnCategoryHaze => 'Haze';

  @override
  String get learnCategoryUv => 'UV';

  @override
  String get learnCategoryHeat => 'Heat';

  @override
  String get learnCategoryFlood => 'Flood';

  @override
  String learnCategoryProgress(int completed, int total, int percentage) {
    return '$completed of $total completed · $percentage%';
  }

  @override
  String learnItemAddedMessage(String item) {
    return '$item added.';
  }

  @override
  String learnItemRemovedMessage(String item) {
    return '$item removed.';
  }

  @override
  String get learnItemUpdateError =>
      'Unable to update the item. Please try again.';

  @override
  String get learnAdded => 'Added';

  @override
  String get learnAdd => 'Add';

  @override
  String get learnWhyThisMatters => 'Why this matters';

  @override
  String learnAddedXp(int points) {
    return 'Added · +$points XP';
  }

  @override
  String learnXp(int points) {
    return '+$points XP';
  }

  @override
  String learnEarnXpWhenAdded(int points) {
    return 'Earn $points XP when added.';
  }

  @override
  String get kitHazeMaskTitle => 'N95 masks';

  @override
  String get kitHazeMaskDescription => 'Keep at home & in your bag';

  @override
  String get kitHazeMaskExplanation =>
      'A properly fitted N95 mask can reduce exposure to fine haze particles when outdoor activity is unavoidable.';

  @override
  String get kitHazeMedsTitle => 'Allergy medication';

  @override
  String get kitHazeMedsDescription => 'Keep nearby if needed';

  @override
  String get kitHazeMedsExplanation =>
      'Keep prescribed inhalers or allergy medication available if poor air quality affects you.';

  @override
  String get kitUvSunscreenTitle => 'SPF 30+ sunscreen';

  @override
  String get kitUvSunscreenDescription => 'Protect exposed skin outdoors';

  @override
  String get kitUvSunscreenExplanation =>
      'Broad-spectrum SPF 30+ sunscreen helps protect exposed skin from ultraviolet radiation.';

  @override
  String get kitUvHatTitle => 'Hat & sunglasses';

  @override
  String get kitUvHatDescription => 'Extra protection from strong UV';

  @override
  String get kitUvHatExplanation =>
      'A hat and sunglasses provide additional protection during periods of high UV exposure.';

  @override
  String get kitHeatWaterTitle => 'Drinking water';

  @override
  String get kitHeatWaterDescription => 'Stay hydrated in hot weather';

  @override
  String get kitHeatWaterExplanation =>
      'Carrying additional water helps reduce dehydration and heat-related illness.';

  @override
  String get kitFloodBagTitle => 'Torch & power bank';

  @override
  String get kitFloodBagDescription => 'Useful during heavy rain or outages';

  @override
  String get kitFloodBagExplanation =>
      'A torch and charged power bank are useful during power disruptions and heavy rainfall.';

  @override
  String get kitFloodAlertsTitle => 'Flood alerts';

  @override
  String get kitFloodAlertsDescription => 'Stay updated on affected areas';

  @override
  String get kitFloodAlertsExplanation =>
      'Official alert channels provide timely information about rainfall and affected locations.';

  @override
  String get kitFloodRouteTitle => 'Alternative route';

  @override
  String get kitFloodRouteDescription => 'Avoid flood-prone roads';

  @override
  String get kitFloodRouteExplanation =>
      'Knowing an alternative route helps you avoid low-lying and flood-prone roads.';

  @override
  String get kitDefaultDescription => 'Preparedness essential';

  @override
  String get kitDefaultExplanation =>
      'This item supports your overall environmental preparedness.';

  @override
  String get learnKnowledgeQuizzes => 'Knowledge Quizzes';

  @override
  String get learnKnowledgeQuizzesDescription =>
      'Test your knowledge and learn how to respond to environmental hazards.';

  @override
  String get learnQuizProgress => 'Quiz Progress';

  @override
  String get learnAllQuizQuestionsCompleted => 'All quiz questions completed.';

  @override
  String learnQuizQuestionsRemaining(int count) {
    return '$count question(s) remaining.';
  }

  @override
  String learnQuizTopicTitle(String topic) {
    return '$topic Preparedness';
  }

  @override
  String get learnCompleted => 'Completed';

  @override
  String learnQuizQuestionsCompleted(int completed, int total) {
    return '$completed of $total questions completed';
  }

  @override
  String learnQuizTitle(String topic) {
    return '$topic Quiz';
  }

  @override
  String learnQuizQuestionProgress(int current, int total) {
    return 'Question $current of $total';
  }

  @override
  String get learnQuizCheckAnswer => 'Check answer';

  @override
  String get learnQuizNextQuestion => 'Next question';

  @override
  String get learnQuizViewResults => 'View results';

  @override
  String get learnQuizComplete => 'Quiz complete';

  @override
  String learnQuizScore(int score, int total) {
    return 'You scored $score out of $total.';
  }

  @override
  String get learnQuizPreviouslyCompleted =>
      'Quiz completed previously. No additional XP awarded.';

  @override
  String learnQuizXpEarned(int points) {
    return '+$points XP earned';
  }

  @override
  String get learnQuizContinue => 'Continue';

  @override
  String get learnQuizSaveError =>
      'Unable to save quiz progress. Please try again.';

  @override
  String get learnQuizResultExcellent =>
      'Excellent work. You have mastered this topic.';

  @override
  String get learnQuizResultGood =>
      'Good effort. Review the explanations to strengthen your knowledge.';

  @override
  String get learnQuizResultKeepLearning =>
      'Keep learning. You can retake the quiz to review the topic.';

  @override
  String get learnQuizNoAdditionalXp => 'No additional XP awarded.';

  @override
  String get quizHaze1Question =>
      'When the 24-hour PSI enters the Unhealthy range, what should healthy people reduce?';

  @override
  String get quizHaze1Option1 => 'Drinking water';

  @override
  String get quizHaze1Option2 => 'Prolonged or strenuous outdoor activity';

  @override
  String get quizHaze1Option3 => 'Indoor activities';

  @override
  String get quizHaze1Option4 => 'Sleeping';

  @override
  String get quizHaze1Explanation =>
      'When air quality enters the Unhealthy range, prolonged or strenuous outdoor activity should be reduced.';

  @override
  String get quizHaze2Question =>
      'Which mask is designed to filter fine haze particles?';

  @override
  String get quizHaze2Option1 => 'Surgical mask';

  @override
  String get quizHaze2Option2 => 'N95 respirator';

  @override
  String get quizHaze2Option3 => 'Cloth mask';

  @override
  String get quizHaze2Option4 => 'No mask is required';

  @override
  String get quizHaze2Explanation =>
      'A properly fitted N95 respirator is designed to filter fine particles more effectively than surgical or cloth masks.';

  @override
  String get quizHaze3Question =>
      'Why should you check air-quality conditions before prolonged outdoor activity during haze?';

  @override
  String get quizHaze3Option1 => 'Air quality can change throughout the day';

  @override
  String get quizHaze3Option2 => 'PSI only measures temperature';

  @override
  String get quizHaze3Option3 => 'Haze only affects visibility';

  @override
  String get quizHaze3Option4 => 'Outdoor activity improves air quality';

  @override
  String get quizHaze3Explanation =>
      'Air quality can change, so checking current conditions helps you decide whether to adjust prolonged outdoor activities.';

  @override
  String get quizHaze4Question =>
      'What is a sensible way to reduce haze exposure when air quality worsens?';

  @override
  String get quizHaze4Option1 => 'Spend more time outdoors';

  @override
  String get quizHaze4Option2 => 'Increase strenuous outdoor exercise';

  @override
  String get quizHaze4Option3 =>
      'Reduce unnecessary prolonged outdoor exposure';

  @override
  String get quizHaze4Option4 => 'Keep all outdoor plans unchanged';

  @override
  String get quizHaze4Explanation =>
      'Reducing unnecessary prolonged outdoor exposure can help limit exposure when air quality worsens.';

  @override
  String get quizHaze5Question =>
      'If you still need to go outside during hazy conditions, what should you continue doing?';

  @override
  String get quizHaze5Option1 => 'Ignore later air-quality updates';

  @override
  String get quizHaze5Option2 =>
      'Monitor current air-quality information and relevant advisories';

  @override
  String get quizHaze5Option3 => 'Assume conditions will remain unchanged';

  @override
  String get quizHaze5Option4 => 'Stay outside longer to adapt to the haze';

  @override
  String get quizHaze5Explanation =>
      'Continue monitoring current air-quality information because conditions and relevant recommendations may change.';

  @override
  String get quizUv1Question => 'UV Index 8–10 belongs to which category?';

  @override
  String get quizUv1Option1 => 'Low';

  @override
  String get quizUv1Option2 => 'Moderate';

  @override
  String get quizUv1Option3 => 'Very High';

  @override
  String get quizUv1Option4 => 'Extreme';

  @override
  String get quizUv1Explanation =>
      'A UV Index of 8–10 is categorised as Very High and requires strong sun protection.';

  @override
  String get quizUv2Question =>
      'When is UV exposure typically strongest in Singapore?';

  @override
  String get quizUv2Option1 => 'Early morning';

  @override
  String get quizUv2Option2 => 'Around midday';

  @override
  String get quizUv2Option3 => 'Evening';

  @override
  String get quizUv2Option4 => 'Night';

  @override
  String get quizUv2Explanation =>
      'UV radiation is generally strongest around midday, so additional protection is important during this period.';

  @override
  String get quizUv3Question =>
      'What is a good way to reduce UV exposure when spending time outdoors?';

  @override
  String get quizUv3Option1 => 'Seek shade when possible';

  @override
  String get quizUv3Option2 => 'Stay in direct sunlight for longer';

  @override
  String get quizUv3Option3 => 'Only protect yourself when it feels hot';

  @override
  String get quizUv3Option4 => 'Avoid drinking water';

  @override
  String get quizUv3Explanation =>
      'Seeking shade can help reduce direct exposure to ultraviolet radiation while outdoors.';

  @override
  String get quizUv4Question =>
      'Which combination provides better protection when UV levels are high?';

  @override
  String get quizUv4Option1 => 'Sunscreen, suitable clothing and shade';

  @override
  String get quizUv4Option2 => 'Drinking water only';

  @override
  String get quizUv4Option3 => 'A surgical mask and gloves';

  @override
  String get quizUv4Option4 => 'Staying in direct sunlight';

  @override
  String get quizUv4Explanation =>
      'Using multiple forms of sun protection, including sunscreen, suitable clothing and shade, helps reduce UV exposure.';

  @override
  String get quizUv5Question =>
      'Why should you still consider UV protection on a cloudy day?';

  @override
  String get quizUv5Option1 =>
      'UV radiation can still reach you through cloud cover';

  @override
  String get quizUv5Option2 => 'Clouds always increase the UV Index';

  @override
  String get quizUv5Option3 => 'UV radiation only exists when it rains';

  @override
  String get quizUv5Option4 => 'Sun protection is only needed on clear days';

  @override
  String get quizUv5Explanation =>
      'Cloud cover does not completely block ultraviolet radiation, so UV protection may still be necessary.';

  @override
  String get quizHeat1Question =>
      'What is one of the most important ways to reduce heat stress during prolonged outdoor activity?';

  @override
  String get quizHeat1Option1 => 'Take regular hydration and cooling breaks';

  @override
  String get quizHeat1Option2 => 'Avoid drinking water until you feel thirsty';

  @override
  String get quizHeat1Option3 => 'Wear heavier clothing';

  @override
  String get quizHeat1Option4 => 'Stay continuously in direct sunlight';

  @override
  String get quizHeat1Explanation =>
      'Regular hydration and cooling breaks can help reduce heat stress during prolonged outdoor activity.';

  @override
  String get quizHeat2Question =>
      'If you begin feeling very warm during outdoor activity, what is a safer action?';

  @override
  String get quizHeat2Option1 => 'Continue without stopping';

  @override
  String get quizHeat2Option2 =>
      'Move to a shaded or cooler area and take a break';

  @override
  String get quizHeat2Option3 => 'Exercise harder to finish sooner';

  @override
  String get quizHeat2Option4 => 'Avoid drinking water';

  @override
  String get quizHeat2Explanation =>
      'Taking a break in a shaded or cooler area helps reduce continued heat exposure and allows your body to cool down.';

  @override
  String get quizHeat3Question =>
      'Why is hydration important during hot weather?';

  @override
  String get quizHeat3Option1 =>
      'It helps replace fluids lost through sweating';

  @override
  String get quizHeat3Option2 => 'It increases your exposure to heat';

  @override
  String get quizHeat3Option3 => 'It removes the need for rest breaks';

  @override
  String get quizHeat3Option4 => 'It prevents all heat-related illness';

  @override
  String get quizHeat3Explanation =>
      'Drinking water helps replace fluids lost through sweating and supports hydration during hot conditions.';

  @override
  String get quizHeat4Question =>
      'What should you do before planning prolonged outdoor activity on a very hot day?';

  @override
  String get quizHeat4Option1 =>
      'Check current heat conditions and plan appropriate precautions';

  @override
  String get quizHeat4Option2 => 'Ignore the conditions if the sky is clear';

  @override
  String get quizHeat4Option3 => 'Avoid bringing water';

  @override
  String get quizHeat4Option4 => 'Wear additional heavy layers';

  @override
  String get quizHeat4Explanation =>
      'Checking current heat conditions helps you plan hydration, cooling breaks and other precautions before prolonged outdoor activity.';

  @override
  String get quizHeat5Question =>
      'If hot conditions continue throughout the day, what should you do?';

  @override
  String get quizHeat5Option1 => 'Assume conditions will improve automatically';

  @override
  String get quizHeat5Option2 => 'Continue all outdoor plans without changes';

  @override
  String get quizHeat5Option3 =>
      'Continue monitoring conditions and adjust your plans when necessary';

  @override
  String get quizHeat5Option4 => 'Stop drinking water so you need fewer breaks';

  @override
  String get quizHeat5Explanation =>
      'Heat conditions can change throughout the day, so continue monitoring them and adjust prolonged outdoor activities when necessary.';

  @override
  String get quizFlood1Question =>
      'What should you do if the road ahead is covered by flood water and you cannot tell how deep it is?';

  @override
  String get quizFlood1Option1 => 'Drive through slowly';

  @override
  String get quizFlood1Option2 => 'Turn around and use another route';

  @override
  String get quizFlood1Option3 => 'Stop in the flooded section';

  @override
  String get quizFlood1Option4 =>
      'Drive through quickly before the water rises';

  @override
  String get quizFlood1Explanation =>
      'Avoid entering flood water when its depth and conditions are uncertain. Turning around and using a safer alternative route reduces the risk.';

  @override
  String get quizFlood2Question =>
      'What should you do before choosing an alternative route during a flash flood?';

  @override
  String get quizFlood2Option1 =>
      'Check current flood information and road conditions';

  @override
  String get quizFlood2Option2 => 'Choose the shortest route without checking';

  @override
  String get quizFlood2Option3 => 'Return to the flooded road';

  @override
  String get quizFlood2Option4 => 'Keep driving until you find an open road';

  @override
  String get quizFlood2Explanation =>
      'Checking current flood and road information can help you avoid routes affected by flooding.';

  @override
  String get quizFlood3Question =>
      'What should you do when driving visibility becomes poor during heavy rain?';

  @override
  String get quizFlood3Option1 => 'Speed up to leave the rain sooner';

  @override
  String get quizFlood3Option2 => 'Slow down and drive cautiously';

  @override
  String get quizFlood3Option3 => 'Continue at the same speed';

  @override
  String get quizFlood3Option4 =>
      'Use your phone to check weather updates while driving';

  @override
  String get quizFlood3Explanation =>
      'Slowing down and driving cautiously is safer when heavy rain reduces visibility.';

  @override
  String get quizFlood4Question => 'Why should you avoid entering flood water?';

  @override
  String get quizFlood4Option1 => 'Flood water is always shallow';

  @override
  String get quizFlood4Option2 => 'Flood water makes your vehicle cleaner';

  @override
  String get quizFlood4Option3 =>
      'The water may be deeper or faster-moving than it appears';

  @override
  String get quizFlood4Option4 => 'Flood water always disappears immediately';

  @override
  String get quizFlood4Explanation =>
      'Flood water can be deeper or faster-moving than it appears, making it dangerous to enter.';

  @override
  String get quizFlood5Question =>
      'What should you do while heavy rain and flood conditions continue?';

  @override
  String get quizFlood5Option1 =>
      'Continue monitoring conditions and follow relevant safety information';

  @override
  String get quizFlood5Option2 => 'Ignore further weather updates';

  @override
  String get quizFlood5Option3 => 'Assume all roads are safe if they are open';

  @override
  String get quizFlood5Option4 =>
      'Enter flooded areas to check the water depth';

  @override
  String get quizFlood5Explanation =>
      'Conditions can change during heavy rain, so continue monitoring current information and adjust your plans when necessary.';

  @override
  String get scenarioChallenges => 'Scenario Challenges';

  @override
  String get scenarioChallengesDescription =>
      'Practise making safe decisions in realistic environmental situations.';

  @override
  String get scenarioProgress => 'Scenario Progress';

  @override
  String get scenarioAllCompleted => 'All scenario challenges completed.';

  @override
  String scenarioRemaining(int count) {
    return '$count scenario(s) remaining.';
  }

  @override
  String get scenarioCompleted => 'Completed';

  @override
  String get scenarioNotCompleted => 'Not completed';

  @override
  String get scenarioFlashFloodTitle => 'Flash Flood on Your Route';

  @override
  String get scenarioFlashFloodDescription =>
      'Make decisions while travelling during sudden flooding.';

  @override
  String get scenarioHazeTitle => 'Haze During Outdoor Activity';

  @override
  String get scenarioHazeDescription =>
      'Make safe decisions when air quality worsens during outdoor plans.';

  @override
  String get scenarioHeatUvTitle => 'Heat & UV During Outdoor Activity';

  @override
  String get scenarioHeatUvDescription =>
      'Make safe decisions when heat and UV exposure are high.';

  @override
  String get scenarioFloodStep1Situation =>
      'You are travelling home during heavy rain. The road ahead is covered by flood water and you cannot tell how deep it is.';

  @override
  String get scenarioFloodStep1Question => 'What should you do?';

  @override
  String get scenarioFloodStep1Option1 =>
      'Drive through quickly before the water rises further.';

  @override
  String get scenarioFloodStep1Option2 => 'Turn around and use another route.';

  @override
  String get scenarioFloodStep1Option3 =>
      'Stop in the flooded section and wait.';

  @override
  String get scenarioFloodStep1Option4 =>
      'Open the windows and continue slowly.';

  @override
  String get scenarioFloodStep1CorrectFeedback =>
      'Good decision. Avoid entering flood water and use a safer alternative route.';

  @override
  String get scenarioFloodStep1IncorrectFeedback =>
      'Avoid entering flood water. It may be deeper or faster-moving than it appears.';

  @override
  String get scenarioFloodStep2Situation =>
      'You turn around safely, but the rain is becoming heavier. You need to decide which route to take next.';

  @override
  String get scenarioFloodStep2Question =>
      'What should you do before choosing another route?';

  @override
  String get scenarioFloodStep2Option1 =>
      'Choose the shortest road without checking conditions.';

  @override
  String get scenarioFloodStep2Option2 =>
      'Check current flood information and plan a safer route.';

  @override
  String get scenarioFloodStep2Option3 =>
      'Return to the flooded road to see if conditions improved.';

  @override
  String get scenarioFloodStep2Option4 =>
      'Continue driving until you find an open road.';

  @override
  String get scenarioFloodStep2CorrectFeedback =>
      'Correct. Checking current conditions helps you avoid roads affected by flooding.';

  @override
  String get scenarioFloodStep2IncorrectFeedback =>
      'A safer approach is to check current flood information before choosing another route.';

  @override
  String get scenarioFloodStep3Situation =>
      'Your alternative route is clear, but heavy rain is continuing and visibility is becoming poor.';

  @override
  String get scenarioFloodStep3Question => 'What is the safest next action?';

  @override
  String get scenarioFloodStep3Option1 =>
      'Speed up so you can get home sooner.';

  @override
  String get scenarioFloodStep3Option2 =>
      'Continue normally and ignore the reduced visibility.';

  @override
  String get scenarioFloodStep3Option3 =>
      'Slow down and continue cautiously while monitoring conditions.';

  @override
  String get scenarioFloodStep3Option4 =>
      'Use your phone while driving to check updates.';

  @override
  String get scenarioFloodStep3CorrectFeedback =>
      'Correct. Slowing down and staying alert is safer when visibility is reduced.';

  @override
  String get scenarioFloodStep3IncorrectFeedback =>
      'Poor visibility increases driving risk. Slow down, stay alert and monitor conditions safely.';

  @override
  String get scenarioCompleteTitle => 'Scenario complete';

  @override
  String scenarioSafeDecisions(int safe, int total) {
    return '$safe of $total safe decisions';
  }

  @override
  String get scenarioPreviouslyCompleted =>
      'Scenario completed previously. No additional XP awarded.';

  @override
  String scenarioXpEarned(int points) {
    return '+$points XP earned';
  }

  @override
  String get scenarioContinue => 'Continue';

  @override
  String get scenarioSaveError =>
      'Unable to save scenario progress. Please try again.';

  @override
  String get scenarioHazeStep1Situation =>
      'You planned to exercise outdoors this afternoon, but you notice that conditions look hazy.';

  @override
  String get scenarioHazeStep1Question =>
      'What should you do before heading out?';

  @override
  String get scenarioHazeStep1Option1 =>
      'Continue with your plans without checking anything.';

  @override
  String get scenarioHazeStep1Option2 =>
      'Check the latest PSI and air-quality conditions.';

  @override
  String get scenarioHazeStep1Option3 =>
      'Exercise harder so you can finish sooner.';

  @override
  String get scenarioHazeStep1Option4 =>
      'Assume the haze is harmless because visibility is still acceptable.';

  @override
  String get scenarioHazeStep1CorrectFeedback =>
      'Good decision. Checking current air-quality information helps you decide whether outdoor activity is appropriate.';

  @override
  String get scenarioHazeStep1IncorrectFeedback =>
      'Check current air-quality information before deciding whether to continue with prolonged outdoor activity.';

  @override
  String get scenarioHazeStep2Situation =>
      'The PSI indicates poorer air quality than usual. You still want to stay active today.';

  @override
  String get scenarioHazeStep2Question => 'What is the safer choice?';

  @override
  String get scenarioHazeStep2Option1 =>
      'Continue a long, strenuous outdoor workout.';

  @override
  String get scenarioHazeStep2Option2 =>
      'Move your workout indoors or reduce prolonged outdoor exertion.';

  @override
  String get scenarioHazeStep2Option3 =>
      'Ignore the reading because you already planned the workout.';

  @override
  String get scenarioHazeStep2Option4 =>
      'Stay outdoors for longer to adapt to the haze.';

  @override
  String get scenarioHazeStep2CorrectFeedback =>
      'Correct. Adjusting your activity can reduce unnecessary exposure when air quality deteriorates.';

  @override
  String get scenarioHazeStep2IncorrectFeedback =>
      'Consider moving strenuous activity indoors or reducing prolonged outdoor exertion when conditions worsen.';

  @override
  String get scenarioHazeStep3Situation =>
      'Later, you need to go outside and the hazy conditions are still present.';

  @override
  String get scenarioHazeStep3Question => 'What should you do?';

  @override
  String get scenarioHazeStep3Option1 =>
      'Monitor current conditions and follow the recommended precautions.';

  @override
  String get scenarioHazeStep3Option2 => 'Ignore further air-quality updates.';

  @override
  String get scenarioHazeStep3Option3 =>
      'Spend extra time outdoors because your workout was cancelled.';

  @override
  String get scenarioHazeStep3Option4 =>
      'Assume conditions cannot change during the day.';

  @override
  String get scenarioHazeStep3CorrectFeedback =>
      'Correct. Air quality can change, so continue monitoring conditions and follow appropriate precautions.';

  @override
  String get scenarioHazeStep3IncorrectFeedback =>
      'Continue checking current conditions because air quality can change throughout the day.';

  @override
  String get scenarioSituationLabel => 'Situation';

  @override
  String get scenarioCheckDecision => 'Check decision';

  @override
  String get scenarioNextSituation => 'Next situation';

  @override
  String get scenarioFinishScenario => 'Finish scenario';

  @override
  String get scenarioHeatUvStep1Situation =>
      'You are planning to spend several hours outdoors around midday. The weather is hot and the UV Index is high.';

  @override
  String get scenarioHeatUvStep1Question =>
      'What should you do before heading out?';

  @override
  String get scenarioHeatUvStep1Option1 =>
      'Go out immediately because sunny weather is safe.';

  @override
  String get scenarioHeatUvStep1Option2 =>
      'Apply sun protection, bring water and plan for shade.';

  @override
  String get scenarioHeatUvStep1Option3 =>
      'Avoid drinking water so you do not need breaks.';

  @override
  String get scenarioHeatUvStep1Option4 =>
      'Wear heavier clothing to get used to the heat.';

  @override
  String get scenarioHeatUvStep1CorrectFeedback =>
      'Good decision. Preparing sun protection, hydration and access to shade helps reduce heat and UV exposure.';

  @override
  String get scenarioHeatUvStep1IncorrectFeedback =>
      'Prepare for both heat and UV exposure before spending prolonged periods outdoors.';

  @override
  String get scenarioHeatUvStep2Situation =>
      'After spending some time outdoors, you are becoming very warm and have been exposed to direct sunlight for a while.';

  @override
  String get scenarioHeatUvStep2Question => 'What is the safer next action?';

  @override
  String get scenarioHeatUvStep2Option1 => 'Keep going without stopping.';

  @override
  String get scenarioHeatUvStep2Option2 =>
      'Drink water and take a break in a shaded or cooler area.';

  @override
  String get scenarioHeatUvStep2Option3 =>
      'Exercise harder so you can finish sooner.';

  @override
  String get scenarioHeatUvStep2Option4 =>
      'Stay in direct sunlight during your break.';

  @override
  String get scenarioHeatUvStep2CorrectFeedback =>
      'Correct. Hydration and cooling breaks can help reduce heat stress during prolonged outdoor activity.';

  @override
  String get scenarioHeatUvStep2IncorrectFeedback =>
      'Take regular hydration and cooling breaks rather than continuing prolonged activity in the heat.';

  @override
  String get scenarioHeatUvStep3Situation =>
      'You still have more outdoor activities planned later in the day.';

  @override
  String get scenarioHeatUvStep3Question => 'How should you continue?';

  @override
  String get scenarioHeatUvStep3Option1 =>
      'Ignore any changes because you already checked conditions earlier.';

  @override
  String get scenarioHeatUvStep3Option2 =>
      'Avoid water until you feel extremely thirsty.';

  @override
  String get scenarioHeatUvStep3Option3 =>
      'Continue monitoring conditions and adjust your plans if necessary.';

  @override
  String get scenarioHeatUvStep3Option4 =>
      'Stay outdoors continuously so your body adapts.';

  @override
  String get scenarioHeatUvStep3CorrectFeedback =>
      'Correct. Conditions can change, so continue monitoring them and adjust outdoor plans when necessary.';

  @override
  String get scenarioHeatUvStep3IncorrectFeedback =>
      'Continue monitoring heat and UV conditions and adjust your plans when necessary.';

  @override
  String get cprAedTitle => 'CPR & AED';

  @override
  String get cprAedVideoTitle => 'Learn CPR & AED Procedures';

  @override
  String get cprAedVideoSubtitle => 'Opens official SCDF video';

  @override
  String get cprAedDescription =>
      'Know the basic actions to take during a suspected cardiac arrest.';

  @override
  String get cprAedRememberActions => 'Remember these actions';

  @override
  String get cprAedStep1Title => 'Check responsiveness';

  @override
  String get cprAedStep1Description =>
      'Tap the person on the shoulders and check whether they respond.';

  @override
  String get cprAedStep2Title => 'Call 995 & get an AED';

  @override
  String get cprAedStep2Description =>
      'Ask someone to call 995 and another person to retrieve the nearest AED.';

  @override
  String get cprAedStep3Title => 'Start CPR';

  @override
  String get cprAedStep3Description =>
      'If the person is not breathing, begin hands-only CPR and follow the 995 dispatcher’s instructions.';

  @override
  String get cprAedStep4Title => 'Use the AED';

  @override
  String get cprAedStep4Description =>
      'Use the AED when it becomes available and follow its voice or visual instructions.';

  @override
  String get cprAedWatchVideo => 'Watch official SCDF video';

  @override
  String get cprAedDisclaimer =>
      'This quick guide is for preparedness learning and does not replace certified CPR/AED training. During an emergency, call 995 and follow the instructions given by the SCDF dispatcher.';

  @override
  String get cprAedVideoError => 'Unable to open the SCDF video.';

  @override
  String get floodSafetyTitle => 'Flash Flood Safety';

  @override
  String get floodSafetyHeroTitle => 'Heavy rain can cause flash floods';

  @override
  String get floodSafetyHeroDescription =>
      'Know what to do if you encounter flooding while travelling in Singapore.';

  @override
  String get floodSafetyEncounterTitle => 'If you encounter a flood';

  @override
  String get floodSafetyTurnBackTitle => 'Turn back';

  @override
  String get floodSafetyTurnBackDescription =>
      'Do not enter a flooded area. Use a safer alternative route.';

  @override
  String get floodSafetyHigherGroundTitle => 'Move to higher ground';

  @override
  String get floodSafetyHigherGroundDescription =>
      'If flooding is ahead, move away from the area as water levels can rise quickly.';

  @override
  String get floodSafetyAvoidMovingWaterTitle => 'Avoid moving floodwater';

  @override
  String get floodSafetyAvoidMovingWaterDescription =>
      'Floodwater can be difficult to judge and moving water can cause you to fall.';

  @override
  String get floodSafetyAvoidDrivingTitle =>
      'Do not drive into deep floodwater';

  @override
  String get floodSafetyAvoidDrivingDescription =>
      'Avoid flooded roads where water is above kerb height or road markings are no longer visible.';

  @override
  String get floodSafetyBeforeTravellingTitle => 'Before travelling';

  @override
  String get floodSafetyBeforeTravellingDescription =>
      'Check current weather and flood alerts before travelling during heavy rain, and plan an alternative route if necessary.';

  @override
  String get floodSafetySource =>
      'Safety guidance adapted from PUB, Singapore’s National Water Agency.';

  @override
  String get floodSafetyDo => 'DO';

  @override
  String get floodSafetyDont => 'DON’T';

  @override
  String scenarioRewardXp(int points) {
    return '· +$points XP';
  }

  @override
  String get learnTryAgain => 'Try again';

  @override
  String get emergencyHelpTitle => 'Emergency Help';

  @override
  String get emergencyInEmergency => 'In an emergency';

  @override
  String get emergencyImmediateDangerDescription =>
      'If someone is in immediate danger, contact the appropriate emergency service immediately.';

  @override
  String get emergencyServices => 'Emergency services';

  @override
  String get emergencyFireRescueTitle => 'Fire, Rescue & Emergency Ambulance';

  @override
  String get emergencyFireRescueDescription =>
      'Fire, rescue or life-threatening emergencies';

  @override
  String get emergencyPoliceTitle => 'Police Emergency';

  @override
  String get emergencyPoliceDescription => 'Immediate police assistance';

  @override
  String get emergencySms => 'Emergency SMS';

  @override
  String get emergencyPoliceSmsTitle => 'Police Emergency SMS';

  @override
  String get emergencyPoliceSmsDescription =>
      'Emergency SMS when calling is unsafe';

  @override
  String get emergencyScdfSmsTitle => 'SCDF Emergency SMS';

  @override
  String get emergencyScdfSmsDescription =>
      'Emergency SMS service for people who are deaf, hard-of-hearing or have speech impairments.';

  @override
  String get emergencyOtherUsefulContacts => 'Other useful contacts';

  @override
  String get emergencyNurseFirstDescription => 'Non-emergency medical advice';

  @override
  String get emergencyNeaHotline => 'NEA Hotline';

  @override
  String get emergencyNeaDescription => 'Environmental feedback and enquiries';

  @override
  String get emergencyWhenToCall => 'When should I call?';

  @override
  String get emergencyEmergencyLabel => 'Emergency';

  @override
  String get emergencyEmergencyGuide =>
      'Someone is in immediate danger, seriously injured, experiencing a life-threatening medical condition, or there is a fire or rescue situation.';

  @override
  String get emergencyNonEmergencyLabel => 'Non-emergency';

  @override
  String get emergencyNonEmergencyGuide =>
      'The situation does not pose an immediate threat to life or safety. Use the appropriate non-emergency service instead.';

  @override
  String get emergencyDisclaimer =>
      'Emergency information is provided for preparedness purposes. Always follow instructions from the relevant Singapore authorities.';

  @override
  String get profileLoadProgressError => 'Unable to load your progress.';

  @override
  String get profileWeeklyActivity => 'Weekly Activity';

  @override
  String profileWeeklyDaysCompleted(int completed) {
    return '$completed / 7 days';
  }

  @override
  String get profileWeeklyActivityDescription =>
      'Your preparedness-plan activity over the last 7 days.';

  @override
  String profileCurrentStreak(int days) {
    return '$days-day current streak';
  }

  @override
  String get profileYourProgress => 'Your Progress';

  @override
  String get profileProgressDescription =>
      'Track your preparedness journey and achievements.';

  @override
  String profileLevel(int level) {
    return 'Level $level';
  }

  @override
  String profileXpStreak(int xp, int days) {
    return '$xp XP · $days-day streak';
  }

  @override
  String profileProgressToLevel(int level) {
    return 'Progress to Level $level';
  }

  @override
  String profileXpProgress(int current) {
    return '$current / 100 XP';
  }

  @override
  String profileXpToLevel(int xp, int level) {
    return '$xp XP to Level $level';
  }

  @override
  String get profileTodayPlanCompleted => 'Today’s plan completed';

  @override
  String get profileTodayPlanNotCompleted => 'Today’s plan not completed yet';

  @override
  String get profileTodayPlanCompletedDescription =>
      'Your XP and streak have been updated.';

  @override
  String get profileTodayPlanNotCompletedDescription =>
      'Complete today’s preparedness plan to continue your streak.';

  @override
  String get profileNextBadge => 'Next badge';

  @override
  String get profileBadges => 'Badges';

  @override
  String get profileBadgeFirstCheckTitle => 'First Check';

  @override
  String get profileBadgeFirstCheckDescription =>
      'Complete your first preparedness checklist item.';

  @override
  String get profileBadgeHazeHeroTitle => 'Haze Hero';

  @override
  String get profileBadgeHazeHeroDescription => 'Complete both haze quizzes.';

  @override
  String get profileBadgeUvGuardianTitle => 'UV Guardian';

  @override
  String get profileBadgeUvGuardianDescription => 'Complete both UV quizzes.';

  @override
  String get profileBadgeFloodReadyTitle => 'Flood Ready';

  @override
  String get profileBadgeFloodReadyDescription =>
      'Complete all flood preparedness checklist items.';

  @override
  String get profileBadgeStreak7Title => '7-Day Streak';

  @override
  String get profileBadgeStreak7Description =>
      'Maintain your preparedness streak for 7 days.';

  @override
  String get profileSettings => 'Settings';

  @override
  String get profilePreferences => 'Preferences';

  @override
  String get profilePreferencesDescription =>
      'Region, outdoor activity and preparedness reminders.';

  @override
  String get profileAccount => 'Account';

  @override
  String get profileLogout => 'Log Out';

  @override
  String get profileLogoutDescription => 'Sign out of your SGReady account.';

  @override
  String get profileLogoutDialogTitle => 'Log out of SGReady?';

  @override
  String get profileLogoutDialogDescription =>
      'You can log back in anytime using your account.';

  @override
  String get profileCancel => 'Cancel';

  @override
  String get profilePhotoSelectError =>
      'Unable to select that photo. Please try again.';

  @override
  String get profileChangePhoto => 'Change profile photo';

  @override
  String get profileChoosePhoto => 'Choose profile photo';

  @override
  String get profileRemovePhoto => 'Remove profile photo';

  @override
  String get profileRewards => 'Rewards';

  @override
  String profileLifetimeXp(int xp) {
    return '$xp lifetime XP';
  }

  @override
  String get profileAllRewardsUnlocked =>
      'All prototype reward milestones unlocked.';

  @override
  String profileXpUntilNextReward(int xp) {
    return '$xp XP until your next reward.';
  }

  @override
  String get profilePreparednessScore => 'Preparedness Score';

  @override
  String get profileScoreChecklist => 'Checklist';

  @override
  String get profileScoreQuizzes => 'Quizzes';

  @override
  String get profileScoreEngagement => 'Engagement';

  @override
  String get profileScoreBadges => 'Badges';

  @override
  String get rewardsScreenTitle => 'Rewards';

  @override
  String get rewardsMilestones => 'Reward milestones';

  @override
  String get rewardsMilestonesDescription =>
      'Build your preparedness knowledge and unlock rewards as your lifetime XP grows.';

  @override
  String get rewardTreatVoucherTitle => '\$5 Treat Voucher';

  @override
  String get rewardTreatVoucherDescription =>
      'A little treat for building good preparedness habits.';

  @override
  String get rewardLifestyleVoucherTitle => '\$10 Lifestyle Voucher';

  @override
  String get rewardLifestyleVoucherDescription =>
      'A reward for staying active and prepared.';

  @override
  String get rewardPreparednessPackTitle => 'SGReady Preparedness Pack';

  @override
  String get rewardPreparednessPackDescription =>
      'Useful essentials to help you stay ready for emergencies.';

  @override
  String get rewardsLifetimeXpTitle => 'Your lifetime XP';

  @override
  String rewardsXpValue(int xp) {
    return '$xp XP';
  }

  @override
  String rewardsTier(String tier) {
    return '$tier tier';
  }

  @override
  String get rewardsHighestTierReached => 'Highest reward tier reached';

  @override
  String rewardsXpToTier(int xp, String tier) {
    return '$xp XP to $tier';
  }

  @override
  String get rewardsEarnXpDescription =>
      'Earn XP from daily preparedness actions, quizzes, scenarios and your emergency kit.';

  @override
  String get rewardsTierStarter => 'Starter';

  @override
  String get rewardsTierPrepared => 'Prepared';

  @override
  String get rewardsTierReady => 'Ready';

  @override
  String get rewardsTierResilient => 'Resilient';

  @override
  String get rewardUnlocked => 'Reward unlocked';

  @override
  String rewardXpMoreToUnlock(int xp) {
    return '$xp XP more to unlock';
  }

  @override
  String get rewardView => 'View reward';

  @override
  String get rewardPrototypeDialogDescription =>
      'This reward is part of the SGReady prototype and is not currently redeemable. In a future implementation, eligible users could redeem rewards through participating partner organisations.';

  @override
  String get rewardGotIt => 'Got it';

  @override
  String get prototypeRewardsTitle => 'Prototype rewards';

  @override
  String get prototypeRewardsDescription =>
      'Rewards shown in SGReady are simulated for demonstration purposes and are not currently redeemable. Real-world implementation would require partnerships with participating organisations and secure reward fulfilment.';

  @override
  String get youSpendMoreTimeOutdoors => 'You spend more time outdoors';

  @override
  String get usuallyOutdoorsAtMidday => 'Usually outdoors at midday';

  @override
  String get todayFocusAirQuality => 'Air quality';

  @override
  String get todayFocusHeatSafety => 'Heat safety';

  @override
  String get todayFocusUvProtection => 'UV protection';
}
