// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'SGReady';

  @override
  String get preferences => '偏好设置';

  @override
  String get personaliseSGReady => '个性化 SGReady';

  @override
  String get preferencesDescription => '这些偏好设置可帮助 SGReady 根据您的需要调整防灾准备体验。';

  @override
  String get homeRegion => '常用地区';

  @override
  String get homeRegionDescription => '选择您通常希望优先查看的新加坡地区。';

  @override
  String get central => '中部';

  @override
  String get north => '北部';

  @override
  String get south => '南部';

  @override
  String get east => '东部';

  @override
  String get west => '西部';

  @override
  String get outdoorActivity => '户外活动';

  @override
  String get outdoorActivityDescription => '您通常有多少时间在户外活动？';

  @override
  String get low => '较少';

  @override
  String get moderate => '适中';

  @override
  String get high => '较多';

  @override
  String get usuallyOutdoors => '通常在户外的时段';

  @override
  String get usuallyOutdoorsDescription => '选择您通常在户外活动的时段。';

  @override
  String get morning => '早上';

  @override
  String get midday => '中午';

  @override
  String get evening => '晚上';

  @override
  String get preparednessReminders => '防灾准备提醒';

  @override
  String get preparednessRemindersDescription => '允许 SGReady 提醒您采取相关的防灾准备措施。';

  @override
  String get enableReminders => '启用提醒';

  @override
  String get notificationSchedule => '通知时间';

  @override
  String get daytimeOnly => '仅限白天';

  @override
  String get daytimeOnlyDescription => '上午 8 点至晚上 10 点之间，大约每 5 小时发送一次天气和任务提醒。';

  @override
  String get twentyFourHours => '24 小时';

  @override
  String get twentyFourHoursDescription =>
      '全天大约每 5 小时发送一次天气更新。任务提醒仅限上午 8 点至晚上 10 点。';

  @override
  String get accessibility => '无障碍功能';

  @override
  String get accessibilityDescription => '调整 SGReady，使应用更易于使用。';

  @override
  String get largerText => '放大文字';

  @override
  String get largerTextDescription => '增大 SGReady 中的文字尺寸，方便阅读。';

  @override
  String get largerControls => '放大控件';

  @override
  String get largerControlsDescription => '增大重要控件的尺寸，使其更容易点击。';

  @override
  String get language => '语言';

  @override
  String get languageDescription => '选择 SGReady 使用的语言。';

  @override
  String get english => '英语';

  @override
  String get simplifiedChinese => '简体中文';

  @override
  String get malay => '马来语';

  @override
  String get appearance => '外观';

  @override
  String get appearanceDescription => '选择 SGReady 在此设备上的显示方式。';

  @override
  String get systemDefault => '跟随系统';

  @override
  String get systemDefaultDescription => '与设备的外观设置保持一致';

  @override
  String get light => '浅色';

  @override
  String get lightDescription => '始终使用浅色模式';

  @override
  String get dark => '深色';

  @override
  String get darkDescription => '始终使用深色模式';

  @override
  String get savePreferences => '保存偏好设置';

  @override
  String get saving => '正在保存...';

  @override
  String get preferencesSaved => '偏好设置已保存。';

  @override
  String get unableToSavePreferences => '无法保存偏好设置。';

  @override
  String get navHome => '首页';

  @override
  String get navToday => '今日';

  @override
  String get navExplore => '探索';

  @override
  String get navLearn => '学习';

  @override
  String get navProfile => '个人资料';

  @override
  String get todayInSingapore => '今日新加坡';

  @override
  String get homeDescription => '查看本地环境状况以及您应该做好的准备。';

  @override
  String get todaysPreparedness => '今日防灾准备';

  @override
  String get whatYouShouldDo => '您应该采取的行动';

  @override
  String get showLess => '收起';

  @override
  String get why => '为什么？';

  @override
  String get noData => '暂无数据';

  @override
  String get psi24h => 'PSI（24小时）';

  @override
  String get uvIndex => '紫外线指数';

  @override
  String get temperature => '温度';

  @override
  String get wbgtHeatStress => 'WBGT（热应激）';

  @override
  String lastUpdated(String dateTime) {
    return '最后更新：$dateTime';
  }

  @override
  String regionAverage(String region) {
    return '$region平均值';
  }

  @override
  String get riskElevated => '风险升高';

  @override
  String get riskLow => '低';

  @override
  String get riskModerate => '中等';

  @override
  String get riskHigh => '高';

  @override
  String get riskVeryHigh => '非常高';

  @override
  String get riskExtreme => '极高';

  @override
  String get floodRiskMessage => '检测到强降雨。请保持警惕，并避开易发生水灾的地区。';

  @override
  String get lowRiskMessage => '整体情况良好。请保持准备并继续留意最新信息。';

  @override
  String get moderateRiskMessage => '请采取基本预防措施，并遵循今日建议的行动。';

  @override
  String get highRiskMessage => '请遵循以下安全指引，并在需要时调整您的计划。';

  @override
  String get veryHighRiskMessage => '请减少户外活动，并采取额外的预防措施。';

  @override
  String get extremeRiskMessage => '请避免不必要的户外活动，并密切遵循安全指引。';

  @override
  String get recommendationEnvironmentalDataUnavailable => '环境数据暂时无法获取';

  @override
  String get recommendationEnvironmentalDataUnavailableBody =>
      '目前无法获取环境监测数据。请稍后刷新并重试。';

  @override
  String get actionCheckInternetConnection => '检查您的网络连接';

  @override
  String get actionRefreshEnvironmentalData => '刷新环境数据';

  @override
  String get actionReferOfficialChannels => '如果环境状况看起来不安全，请参考 NEA 和 PUB 的官方信息';

  @override
  String get recommendationPsiUnavailable => 'PSI 数据暂时无法获取';

  @override
  String get recommendationPsiUnavailableBody => '目前无法获取最新的空气质量数据。';

  @override
  String get actionRefreshDataLater => '稍后刷新数据';

  @override
  String get actionReferNeaHazeUpdates => '规划户外活动时，请参考 NEA 官方烟霾信息';

  @override
  String recommendationHaze(int psi) {
    return '烟霾／空气质量（PSI $psi）';
  }

  @override
  String get psiBodyGood => '空气质量处于良好范围。';

  @override
  String get psiBodyModerate => '空气质量处于中等范围。大多数人可以继续正常活动，较易受影响的人士应留意自身健康状况和症状。';

  @override
  String get psiBodyHigh => '空气质量处于不健康水平。请减少长时间或剧烈的户外活动，尤其是较易受空气污染影响的人士。';

  @override
  String get psiBodyVeryHigh => '空气质量处于非常不健康水平。请尽量减少户外活动，并尽可能减少接触室外空气。';

  @override
  String get psiBodyExtreme => '空气质量处于危险水平。请尽可能留在室内，并尽量减少接触室外空气。';

  @override
  String get actionContinueNormalActivities => '继续正常活动';

  @override
  String get actionMonitorEnvironmentalUpdates => '留意官方环境信息更新';

  @override
  String get actionContinueNormalIfWell => '如果身体状况良好，可继续正常活动';

  @override
  String get actionMonitorHealthSymptoms => '如有心脏或呼吸系统疾病，请留意身体症状';

  @override
  String get actionCheckPsiBeforeOutdoorActivity => '长时间进行户外活动前，请查看最新的 PSI 数据';

  @override
  String get actionReduceOutdoorActivity => '减少长时间或剧烈的户外活动';

  @override
  String get actionWearN95Appropriate => '在适当情况下佩戴贴合良好的 N95 口罩';

  @override
  String get actionKeepIndoorAirClean => '尽可能保持室内空气清洁';

  @override
  String get actionSeekMedicalAdvice => '如果感到不适，请寻求医疗建议';

  @override
  String get actionMinimiseOutdoorActivity => '尽量减少户外活动';

  @override
  String get actionRemainIndoors => '尽可能留在室内';

  @override
  String get actionWearN95IfUnavoidable => '如果无法避免外出，请佩戴贴合良好的 N95 口罩';

  @override
  String get actionSeekHelpBreathing => '如果出现呼吸困难，请寻求医疗帮助';

  @override
  String get actionAvoidOutdoorActivity => '尽可能避免户外活动';

  @override
  String get actionCloseDoorsWindows => '留在室内并关闭门窗';

  @override
  String get actionWearN95Outside => '如必须外出，请佩戴贴合良好的 N95 口罩';

  @override
  String get actionSeekHelpSeriousSymptoms => '如果出现严重症状，请立即寻求医疗帮助';

  @override
  String get recommendationUvUnavailable => '紫外线数据暂时无法获取';

  @override
  String get recommendationUvUnavailableBody => '目前无法获取最新的紫外线指数数据。';

  @override
  String get actionSunProtectionExtended => '长时间进行户外活动时，请采取防晒措施';

  @override
  String recommendationUvExposure(int uv) {
    return '紫外线暴露（指数 $uv）';
  }

  @override
  String get uvBodyGood => '紫外线暴露水平较低。一般只需采取基本防护措施。';

  @override
  String get uvBodyModerate => '紫外线暴露处于中等水平。长时间在户外时请采取防晒措施。';

  @override
  String get uvBodyHigh => '紫外线暴露水平较高。请使用防晒霜、穿着防护衣物并尽量待在阴凉处，尤其是在中午时段。';

  @override
  String get uvBodyVeryHigh => '紫外线暴露水平非常高。请尽量减少中午时段的阳光直射，并采取全面的防晒措施。';

  @override
  String get uvBodyExtreme => '紫外线暴露达到极高水平。请避免在高峰时段不必要的阳光直射，并采取全面的防晒措施。';

  @override
  String get actionBasicSunProtection => '长时间在户外时采取基本防晒措施';

  @override
  String get actionApplySunscreen => '涂抹 SPF 30+ 广谱防晒霜';

  @override
  String get actionWearSunglasses => '长时间进行户外活动时佩戴太阳眼镜';

  @override
  String get actionSeekShade => '尽可能待在阴凉处';

  @override
  String get actionReapplySunscreen => '按照产品说明重新涂抹防晒霜';

  @override
  String get actionWearHatSunglassesClothing => '佩戴帽子和太阳眼镜，并穿着防护衣物';

  @override
  String get actionSeekMiddayShade => '中午时段尽量待在阴凉处';

  @override
  String get actionMinimiseMiddaySun => '尽量减少中午时段的阳光直射';

  @override
  String get actionWearProtectiveClothing => '穿着防护衣物，并佩戴帽子和太阳眼镜';

  @override
  String get actionRegularlyReapplySunscreen => '涂抹并定时补涂 SPF 30+ 防晒霜';

  @override
  String get actionTakeShadeBreaks => '户外工作时定时到阴凉处休息';

  @override
  String get actionAvoidMiddaySun => '避免中午时段不必要的阳光直射';

  @override
  String get actionUseShadeProtectiveClothing => '利用阴凉处并穿着防护衣物';

  @override
  String get actionOutdoorWorkersShadeBreaks => '户外工作者应经常到阴凉处休息';

  @override
  String get recommendationHeavyRain => '强降雨警报';

  @override
  String get heavyRainBodyOne => '一个气象站报告的降雨量已超过设定的强降雨阈值。易受影响或低洼地区可能发生水灾。';

  @override
  String heavyRainBodyMany(int count) {
    return '$count 个气象站报告的降雨量已超过设定的强降雨阈值。易受影响或低洼地区可能发生水灾。';
  }

  @override
  String get actionAvoidFloodWater => '避免进入流动或较深的积水';

  @override
  String get actionCheckPubUpdates => '查看 PUB 官方水灾和强降雨信息';

  @override
  String get actionAvoidFloodProneRoutes => '避开易发生水灾或低洼的路线';

  @override
  String get actionKeepEmergencyDevices => '准备好已充电的手机、手电筒和移动电源';

  @override
  String get recommendationFavourable => '当前情况良好';

  @override
  String get recommendationFavourableBody =>
      '目前可获取的 PSI 和紫外线数据均处于较低风险范围，并且未检测到达到强降雨阈值的情况。';

  @override
  String get actionContinueMonitoring => '继续留意环境信息更新';

  @override
  String get actionReviewEmergencyKit => '检查您的应急包和防灾准备清单';

  @override
  String get actionCompletePreparednessActivity => '完成一项防灾准备活动以保持安全意识';

  @override
  String get psiGood => '良好';

  @override
  String get psiModerate => '中等';

  @override
  String get psiUnhealthy => '不健康';

  @override
  String get psiVeryUnhealthy => '非常不健康';

  @override
  String get psiHazardous => '危险';

  @override
  String get todayTitle => '今天';

  @override
  String get todayDescription => '查看您今天的个性化应急准备计划。';

  @override
  String get todayPlanError => '无法生成今天的应急准备计划。';

  @override
  String get todayProgressError => '无法加载今日进度。';

  @override
  String get todayEnvironmentError => '无法准备今天的环境信息。';

  @override
  String get completeTasksBeforeClaiming => '请先完成所有任务，再领取您的 XP。';

  @override
  String get claimTodayReward => '领取今天的奖励？';

  @override
  String get claimRewardDescription => '领取 XP 前，请确认您已完成并满意今天的准备行动。';

  @override
  String get notYet => '暂不';

  @override
  String claimXp(int xp) {
    return '领取 $xp XP';
  }

  @override
  String get planComplete => '计划完成！';

  @override
  String get planCompleteDescription => '做得好！您已完成今天的应急准备行动。';

  @override
  String get awesome => '太棒了！';

  @override
  String get personalisedForYou => '为您个性化定制';

  @override
  String get yourRoutine => '您的日常习惯';

  @override
  String get todaysFocus => '今日重点';

  @override
  String get moreTimeOutdoors => '您较常进行户外活动';

  @override
  String get moderatelyActiveOutdoors => '您有适度的户外活动';

  @override
  String get usuallyOutdoorsMidday => '通常在中午进行户外活动';

  @override
  String get airQuality => '空气质量';

  @override
  String get heatSafety => '高温安全';

  @override
  String get uvProtection => '紫外线防护';

  @override
  String get todayPlanAdapts => '今日计划会根据您的日常习惯和当前环境状况进行调整。';

  @override
  String get todaysActions => '今日行动';

  @override
  String get todaysActionsDescription => '完成以下建议行动，提升您今天的应急准备。';

  @override
  String get rewardClaimed => '奖励已领取';

  @override
  String get completeOneMoreTask => '再完成 1 项任务';

  @override
  String completeMoreTasks(int count) {
    return '再完成 $count 项任务';
  }

  @override
  String get todaysConditions => '今日状况';

  @override
  String priority(String focus) {
    return '重点：$focus';
  }

  @override
  String get whyThisPlan => '为什么是这个计划？';

  @override
  String get heavyRain => '大雨';

  @override
  String get focusRainPreparation => '雨天准备';

  @override
  String get focusAirQualitySunProtection => '空气质量与防晒';

  @override
  String get focusAirQuality => '空气质量';

  @override
  String get focusSunProtection => '防晒';

  @override
  String get focusGeneralPreparedness => '一般应急准备';

  @override
  String get dailyPreparedness => '每日应急准备';

  @override
  String allActionsCompleted(int total) {
    return '已完成全部 $total 项行动';
  }

  @override
  String actionsCompleted(int completed, int total) {
    return '已完成 $completed/$total 项行动';
  }

  @override
  String tasksLeft(int count) {
    return '剩余 $count 项';
  }

  @override
  String counterProgress(int current, int target, String unit) {
    return '$current/$target $unit';
  }

  @override
  String get completed => '已完成';

  @override
  String get missionRewardClaimedMessage => '奖励已领取。明天再回来查看新的应急准备计划。';

  @override
  String get missionCompleteMessage => '做得好！您的每日奖励已经可以领取。';

  @override
  String get missionStartMessage => '从一个简单的行动开始，提升今天的应急准备。';

  @override
  String get missionGoodStartMessage => '不错的开始。继续完成剩余行动。';

  @override
  String get missionOneRemainingMessage => '快完成了！只剩最后一项行动。';

  @override
  String get missionRemainingMessage => '快完成了！请完成剩余行动。';

  @override
  String get done => '完成';

  @override
  String get noDailyMission => '目前没有可用的每日任务。请刷新环境数据后再试。';

  @override
  String get taskReviewConditionsTitle => '查看今日环境状况';

  @override
  String get taskReviewConditionsDescription =>
      '规划户外活动前，请查看当前的 PSI、紫外线指数、温度和降雨情况。';

  @override
  String get taskReviewConditionsReason => '查看实时环境状况有助于您在外出前采取适当的预防措施。';

  @override
  String get taskMonitorAirQualityTitle => '留意空气质量';

  @override
  String get taskMonitorAirQualityDescription =>
      '长时间进行户外活动前再次查看 PSI，尤其是如果您对烟霾较敏感。';

  @override
  String get taskMonitorAirQualityReason =>
      '当前的 PSI 表明可能需要采取额外的预防措施，尤其是较易受影响的人士。';

  @override
  String get taskPackN95Title => '携带 N95 口罩';

  @override
  String get taskPackN95Description => '如果无法避免户外活动，请携带贴合良好的 N95 口罩。';

  @override
  String get taskPackN95Reason => '当前空气质量处于不健康水平，建议在户外采取额外防护措施。';

  @override
  String get taskReduceOutdoorExerciseTitle => '减少剧烈户外活动';

  @override
  String get taskReduceOutdoorExerciseDescription => '空气质量不健康时，请选择较轻松的活动或室内活动。';

  @override
  String get taskReduceOutdoorExerciseReason => '剧烈活动会增加呼吸频率，并可能增加接触空气污染物的程度。';

  @override
  String get taskStayIndoorsHazeTitle => '尽可能留在室内';

  @override
  String get taskStayIndoorsHazeDescription => '关闭门窗，并尽量减少不必要的户外活动。';

  @override
  String get taskStayIndoorsHazeReason => '当前空气质量状况表明户外暴露风险较高。';

  @override
  String get taskPrepareN95HazeTitle => '准备好 N95 口罩';

  @override
  String get taskPrepareN95HazeDescription => '如果必须外出，请佩戴 N95 口罩。';

  @override
  String get taskPrepareN95HazeReason => '在空气质量较差时，N95 口罩有助于减少接触细微烟霾颗粒。';

  @override
  String get taskCheckHazeSymptomsTitle => '留意身体状况';

  @override
  String get taskCheckHazeSymptomsDescription => '留意呼吸困难、咳嗽或眼睛不适等症状。';

  @override
  String get taskCheckHazeSymptomsReason => '非常差的空气质量可能影响呼吸舒适度并引起其他健康症状。';

  @override
  String get taskApplySunscreenTitle => '涂抹防晒霜';

  @override
  String get taskApplySunscreenDescription => '外出前涂抹 SPF 30+ 广谱防晒霜。';

  @override
  String get taskApplySunscreenReason => '今天的紫外线水平表示在户外活动前建议采取防晒措施。';

  @override
  String get taskSeekMiddayShadeTitle => '中午时段尽量待在阴凉处';

  @override
  String get taskSeekMiddayShadeDescription => '在紫外线最强的时段减少阳光直射。';

  @override
  String get taskSeekMiddayShadeReason => '中午时段的紫外线通常较强，待在阴凉处可以有效减少暴露。';

  @override
  String get taskReapplySunscreenTitle => '补涂防晒霜';

  @override
  String get taskReapplySunscreenDescription => '按照产品说明补涂防晒霜，尤其是在出汗后。';

  @override
  String get taskReapplySunscreenReason => '紫外线水平非常高时，长时间在户外需要持续采取防晒措施。';

  @override
  String get taskWearSunProtectionTitle => '做好防晒措施';

  @override
  String get taskWearSunProtectionDescription => '携带帽子、太阳眼镜并穿着防护衣物。';

  @override
  String get taskWearSunProtectionReason => '额外的物理防护有助于减少皮肤和眼睛受到紫外线直接照射。';

  @override
  String get taskAvoidMiddaySunTitle => '避免长时间暴露在中午阳光下';

  @override
  String get taskAvoidMiddaySunDescription => '将剧烈的户外活动安排在紫外线较弱的时段。';

  @override
  String get taskAvoidMiddaySunReason => '紫外线水平非常高时，不建议在中午长时间暴露于阳光下。';

  @override
  String get taskCarryWaterHeatTitle => '随身携带饮用水';

  @override
  String get taskCarryWaterHeatDescription => '如果您会在户外活动，请确保随时有饮用水。';

  @override
  String get taskCarryWaterHeatReason => '当前 WBGT 状况表示热应激处于中等水平。';

  @override
  String get taskHydrationGoalHeatTitle => '记录饮水量';

  @override
  String get taskHydrationGoalHeatDescription => '在一天内记录饮用六杯水。';

  @override
  String get taskHydrationGoalHeatReason => '当前 WBGT 状况表示热应激处于高水平。';

  @override
  String get taskCoolingBreakHeatTitle => '定时休息降温';

  @override
  String get taskCoolingBreakHeatDescription => '定时到阴凉、通风或有空调的地方休息。';

  @override
  String get taskCoolingBreakHeatReason => '高热应激状况会增加休息和降温的需要。';

  @override
  String get taskReduceOutdoorHeatTitle => '减少剧烈户外活动';

  @override
  String get taskReduceOutdoorHeatDescription => '选择较轻松的活动，或将剧烈活动安排在一天中较凉爽的时段。';

  @override
  String get taskReduceOutdoorHeatReason => '当前 WBGT 状况表示热应激处于高水平。';

  @override
  String get taskRainPreparationTitle => '做好强降雨准备';

  @override
  String get taskRainPreparationDescription => '在强降雨期间出行前完成重要的准备步骤。';

  @override
  String get taskRainPreparationReason => '检测到强降雨，可能影响出行、增加水灾风险，并影响获取天气更新。';

  @override
  String get estimatedOneMinute => '1 分钟';

  @override
  String get estimatedThirtySeconds => '30 秒';

  @override
  String get estimatedThroughoutDay => '全天';

  @override
  String get estimatedPlanToday => '今日计划';

  @override
  String get estimatedTwoThreeMinutes => '2–3 分钟';

  @override
  String get unitSteps => '步骤';

  @override
  String get unitGlasses => '杯';

  @override
  String get undo => '撤销';

  @override
  String get complete => '完成';

  @override
  String hydrationProgress(int current, int target) {
    return '$current/$target 杯';
  }

  @override
  String get undoLastGlass => '撤销上一杯';

  @override
  String get hydrationComplete => '饮水目标已完成';

  @override
  String get iDrankAGlass => '我喝了一杯水';

  @override
  String get hydrationGoalComplete => '饮水目标完成！';

  @override
  String xpWhenPlanClaimed(int xp) {
    return '领取今日计划奖励时获得 +$xp XP';
  }

  @override
  String get sunscreenApplied => '已涂抹防晒霜';

  @override
  String coveragePercent(int percent) {
    return '已完成 $percent%';
  }

  @override
  String get applySunscreenButton => '涂抹防晒霜';

  @override
  String rainStepsReady(int current, int target) {
    return '已准备 $current/$target 个步骤';
  }

  @override
  String rainReadyProgress(int current, int target) {
    return '已准备 $current/$target';
  }

  @override
  String get undoLastStep => '撤销上一步';

  @override
  String get packUmbrella => '携带雨伞';

  @override
  String get checkFloodAlerts => '查看水灾警报';

  @override
  String get reviewYourRoute => '查看出行路线';

  @override
  String get chargePowerBank => '为移动电源充电';

  @override
  String get rainPrepComplete => '雨天准备已完成';

  @override
  String get completeNextStep => '完成下一步';

  @override
  String get missionGoodMorning => '早上好';

  @override
  String get missionGoodAfternoon => '下午好';

  @override
  String get missionGoodEvening => '晚上好';

  @override
  String get missionRainTitle => '建议做好强降雨准备';

  @override
  String get missionRainMessage => '强降雨可能影响出行和户外计划。请查看今天的降雨及防洪安全行动。';

  @override
  String get missionHeatUvTitle => '建议采取高温和紫外线防护措施';

  @override
  String get missionHeatUvMessage =>
      '高温压力和紫外线暴露可能影响今天的户外活动。请保持充足水分、做好防晒并定时到凉爽处休息。';

  @override
  String get missionHeatTitle => '建议采取高温防护措施';

  @override
  String get missionHeatMessage => '今天的高温压力较高。请保持充足水分、适时到凉爽处休息，并尽可能减少剧烈的户外活动。';

  @override
  String get missionHazeUvTitle => '建议采取空气质量和紫外线防护措施';

  @override
  String get missionHazeUvMessage => '进行户外活动前，请查看空气质量并做好防晒措施。';

  @override
  String get missionHazeTitle => '建议采取空气质量防护措施';

  @override
  String get missionHazeMessage => '请留意 PSI，并根据情况调整长时间的户外活动。';

  @override
  String get missionUvTitle => '建议采取紫外线防护措施';

  @override
  String get missionUvMessage => '今天进行户外活动时，防晒和补充水分可能较为重要。';

  @override
  String get missionGeneralTitle => '目前情况总体可控';

  @override
  String get missionGeneralMessage => '请查看今天的环境数据，并完成基本的防护准备行动。';

  @override
  String get riskUnknown => '未知';

  @override
  String get riskNoData => '无数据';

  @override
  String psiReading(String value, String label) {
    return 'PSI $value · $label';
  }

  @override
  String uvReading(String value, String label) {
    return '紫外线 $value · $label';
  }

  @override
  String heatStressReading(String label) {
    return '高温压力 · $label';
  }

  @override
  String get taskApplySunscreenModerateDescription =>
      '长时间进行户外活动前，请涂抹 SPF 30+ 广谱防晒霜。';

  @override
  String get taskApplySunscreenModerateReason => '今天的紫外线水平表示长时间在户外时建议采取防晒措施。';

  @override
  String get taskApplySunscreenHighDescription => '外出前请涂抹 SPF 30+ 广谱防晒霜。';

  @override
  String get taskApplySunscreenHighReason => '今天的紫外线指数较高，因此建议在户外活动前采取防晒措施。';

  @override
  String get taskApplySunscreenVeryHighDescription => '外出前请涂抹 SPF 30+ 广谱防晒霜。';

  @override
  String get taskApplySunscreenVeryHighReason => '今天的紫外线水平表示外出前建议采取较强的防晒措施。';

  @override
  String get exploreTitle => '探索新加坡';

  @override
  String get exploreDescription => '探索新加坡各地的环境状况。';

  @override
  String get exploreHeat => '高温';

  @override
  String get explorePsi => 'PSI';

  @override
  String get exploreRain => '降雨';

  @override
  String get exploreFindNearMe => '查找我附近的环境状况';

  @override
  String get exploreTapMarker => '点击标记查看详情';

  @override
  String get exploreLow => '低';

  @override
  String get exploreModerate => '中等';

  @override
  String get exploreHigh => '高';

  @override
  String get exploreHeatStress => '热应激';

  @override
  String exploreWbgtStationsReporting(int count) {
    return '$count 个 WBGT 监测站正在报告';
  }

  @override
  String get exploreHighestObserved => '最高观测值';

  @override
  String get exploreForYou => '建议：';

  @override
  String get exploreHeatAdvice => '保持充足水分，并定时休息降温。';

  @override
  String get exploreUnableLoadHeat => '无法加载热应激数据。';

  @override
  String get exploreNoWbgtObservations => '目前没有可用的 WBGT 观测数据。';

  @override
  String get exploreHeatStressLabel => '热应激';

  @override
  String get exploreRegion => '区域';

  @override
  String get exploreLatestStationReading => '最新监测站观测数据';

  @override
  String exploreMetresAway(int distance) {
    return '距离 $distance 米';
  }

  @override
  String exploreKilometresAway(String distance) {
    return '距离 $distance 公里';
  }

  @override
  String get exploreUnableLoadPsi => '无法加载 PSI 数据。';

  @override
  String get exploreNoRegionalPsi => '目前没有可用的区域 PSI 读数。';

  @override
  String get exploreAirQuality => '空气质量';

  @override
  String get exploreSingaporeRegionalPsi => '新加坡区域 PSI';

  @override
  String get exploreBasedOnLocation => '根据您的大概位置';

  @override
  String get exploreAirQualityLabel => '空气质量';

  @override
  String get explorePsiAdviceGood => '空气质量良好，可以正常进行日常活动。';

  @override
  String get explorePsiAdviceModerate => '空气质量处于中等水平，一般可以正常进行日常活动。';

  @override
  String get explorePsiAdviceUnhealthy => '空气质量不健康。建议减少长时间或剧烈的户外活动。';

  @override
  String get explorePsiAdviceVeryUnhealthy => '空气质量非常不健康。尽量减少长时间的户外活动。';

  @override
  String get explorePsiAdviceHazardous => '空气质量处于危险水平。避免不必要的户外活动。';

  @override
  String get exploreUnableLoadRain => '无法加载降雨数据。';

  @override
  String get exploreNoRainfall => '未检测到降雨';

  @override
  String get exploreNoRainfallDescription => '新加坡各报告站目前均未记录到降雨。';

  @override
  String get exploreRainfall => '降雨';

  @override
  String exploreStationsReportingRain(int count) {
    return '目前有 $count 个站点报告降雨';
  }

  @override
  String get exploreRainLight => '小雨';

  @override
  String get exploreRainModerate => '中雨';

  @override
  String get exploreRainHeavy => '大雨';

  @override
  String get exploreRainAdviceLight => '如果要外出，请携带雨伞。';

  @override
  String get exploreRainAdviceModerate => '请携带雨伞，并在湿滑的道路和人行道上小心通行。';

  @override
  String get exploreRainAdviceHeavy => '避免前往易发生积水或水灾的地区，并在出行前查看路线状况。';

  @override
  String get exploreRainIntensity => '降雨强度';

  @override
  String get exploreLatestRainfallReading => '最新观测到的降雨读数';

  @override
  String get exploreLocationAccessNeeded => '需要位置访问权限才能查找您附近的环境状况。';

  @override
  String get exploreNoRainfallStations => '目前没有可用的降雨监测站。';

  @override
  String get exploreNoRegionalPsiNearby => '目前没有可用的区域 PSI 读数。';

  @override
  String get exploreUnableFindPsiArea => '无法找到您所在区域的 PSI 读数。';

  @override
  String get exploreNoWbgtStations => '目前没有可用的 WBGT 监测站。';

  @override
  String get exploreUnableFindNearby => '无法查找附近的环境状况。';

  @override
  String get learnTitle => '学习与准备';

  @override
  String get learnDescription => '提升您的应急准备知识和技能。';

  @override
  String get learnEmergencyHelp => '紧急求助';

  @override
  String get learnEmergencyHelpDescription => '了解新加坡重要的紧急联系电话及其适用情况。';

  @override
  String get learnTabMyKit => '我的应急包';

  @override
  String get learnTabQuizzes => '测验';

  @override
  String get learnTabScenarios => '情境挑战';

  @override
  String get learnMyEmergencyKit => '我的应急包';

  @override
  String get learnEmergencyKitDescription => '逐步准备您的应急包。';

  @override
  String get learnQuickSkills => '快速技能';

  @override
  String get learnLearnInMinutes => '几分钟内学习';

  @override
  String get learnCprAed => '心肺复苏与 AED';

  @override
  String get learnLifeSavingBasics => '救命基础知识';

  @override
  String get learnVideoGuide => '视频指南';

  @override
  String get learnFlashFloodSafety => '突发洪水安全';

  @override
  String get learnHeavyRainFloodSafety => '暴雨与洪水安全';

  @override
  String get learnQuickGuide => '快速指南';

  @override
  String get learnPreparednessCategories => '应急准备类别';

  @override
  String learnKitReady(int percentage) {
    return '已准备 $percentage%';
  }

  @override
  String get learnKitComplete => '您的应急准备清单已完成。';

  @override
  String learnKitItemsRemaining(int count) {
    return '还有 $count 项待完成。';
  }

  @override
  String get learnKitStatusEmergencyReady => '应急准备完成';

  @override
  String get learnKitStatusWellPrepared => '准备充分';

  @override
  String get learnKitStatusGettingPrepared => '正在准备';

  @override
  String get learnKitStatusBasicPreparation => '基础准备';

  @override
  String get learnKitStatusNeedsAttention => '需要完善';

  @override
  String get learnKitProgressError => '无法加载您的应急包进度。';

  @override
  String get learnRecommendedComplete => '您已经备齐了适合今日环境状况的推荐物品。';

  @override
  String get learnRecommendedToday => '今日推荐';

  @override
  String get learnRecommendedBasedOnConditions => '根据当前的环境状况：';

  @override
  String get learnCategoryHaze => '烟霾';

  @override
  String get learnCategoryUv => '紫外线';

  @override
  String get learnCategoryHeat => '高温';

  @override
  String get learnCategoryFlood => '洪水';

  @override
  String learnCategoryProgress(int completed, int total, int percentage) {
    return '已完成 $completed/$total · $percentage%';
  }

  @override
  String learnItemAddedMessage(String item) {
    return '已添加$item。';
  }

  @override
  String learnItemRemovedMessage(String item) {
    return '已移除$item。';
  }

  @override
  String get learnItemUpdateError => '无法更新此物品，请重试。';

  @override
  String get learnAdded => '已添加';

  @override
  String get learnAdd => '添加';

  @override
  String get learnWhyThisMatters => '为什么这很重要';

  @override
  String learnAddedXp(int points) {
    return '已添加 · +$points XP';
  }

  @override
  String learnXp(int points) {
    return '+$points XP';
  }

  @override
  String learnEarnXpWhenAdded(int points) {
    return '添加后可获得 $points XP。';
  }

  @override
  String get kitHazeMaskTitle => 'N95 口罩';

  @override
  String get kitHazeMaskDescription => '存放在家中及随身携带';

  @override
  String get kitHazeMaskExplanation => '在无法避免户外活动时，正确佩戴 N95 口罩有助于减少吸入烟霾中的细颗粒物。';

  @override
  String get kitHazeMedsTitle => '过敏药物';

  @override
  String get kitHazeMedsDescription => '如有需要，请放在身边';

  @override
  String get kitHazeMedsExplanation => '如果空气质量不佳会影响您的健康，请随身备好医生处方的吸入器或过敏药物。';

  @override
  String get kitUvSunscreenTitle => 'SPF 30+ 防晒霜';

  @override
  String get kitUvSunscreenDescription => '保护户外暴露的皮肤';

  @override
  String get kitUvSunscreenExplanation => '广谱 SPF 30+ 防晒霜有助于保护暴露的皮肤免受紫外线伤害。';

  @override
  String get kitUvHatTitle => '帽子和太阳镜';

  @override
  String get kitUvHatDescription => '加强高紫外线下的防护';

  @override
  String get kitUvHatExplanation => '在紫外线较强时，帽子和太阳镜可以提供额外的防护。';

  @override
  String get kitHeatWaterTitle => '饮用水';

  @override
  String get kitHeatWaterDescription => '炎热天气注意补充水分';

  @override
  String get kitHeatWaterExplanation => '携带足够的饮用水有助于降低脱水和高温相关疾病的风险。';

  @override
  String get kitFloodBagTitle => '手电筒和充电宝';

  @override
  String get kitFloodBagDescription => '适用于暴雨或停电情况';

  @override
  String get kitFloodBagExplanation => '在停电和暴雨期间，手电筒和已充电的充电宝十分实用。';

  @override
  String get kitFloodAlertsTitle => '洪水警报';

  @override
  String get kitFloodAlertsDescription => '及时了解受影响地区';

  @override
  String get kitFloodAlertsExplanation => '官方警报渠道可及时提供降雨情况和受影响地点的信息。';

  @override
  String get kitFloodRouteTitle => '备用路线';

  @override
  String get kitFloodRouteDescription => '避开易发生洪水的道路';

  @override
  String get kitFloodRouteExplanation => '提前了解备用路线有助于避开低洼地区和易发生洪水的道路。';

  @override
  String get kitDefaultDescription => '应急准备必需品';

  @override
  String get kitDefaultExplanation => '此物品有助于提升您的整体环境应急准备能力。';

  @override
  String get learnKnowledgeQuizzes => '知识测验';

  @override
  String get learnKnowledgeQuizzesDescription => '测试您的知识，并学习如何应对环境危害。';

  @override
  String get learnQuizProgress => '测验进度';

  @override
  String get learnAllQuizQuestionsCompleted => '所有测验题目均已完成。';

  @override
  String learnQuizQuestionsRemaining(int count) {
    return '剩余 $count 道题。';
  }

  @override
  String learnQuizTopicTitle(String topic) {
    return '$topic 防护知识';
  }

  @override
  String get learnCompleted => '已完成';

  @override
  String learnQuizQuestionsCompleted(int completed, int total) {
    return '已完成 $completed / $total 道题';
  }

  @override
  String learnQuizTitle(String topic) {
    return '$topic 测验';
  }

  @override
  String learnQuizQuestionProgress(int current, int total) {
    return '第 $current 题，共 $total 题';
  }

  @override
  String get learnQuizCheckAnswer => '检查答案';

  @override
  String get learnQuizNextQuestion => '下一题';

  @override
  String get learnQuizViewResults => '查看结果';

  @override
  String get learnQuizComplete => '测验完成';

  @override
  String learnQuizScore(int score, int total) {
    return '您的得分为 $score / $total。';
  }

  @override
  String get learnQuizPreviouslyCompleted => '您之前已完成此测验，因此不会获得额外 XP。';

  @override
  String learnQuizXpEarned(int points) {
    return '获得 +$points XP';
  }

  @override
  String get learnQuizContinue => '继续';

  @override
  String get learnQuizSaveError => '无法保存测验进度。请重试。';

  @override
  String get learnQuizResultExcellent => '做得很好！您已经掌握了这个主题。';

  @override
  String get learnQuizResultGood => '做得不错。请查看解释以进一步巩固您的知识。';

  @override
  String get learnQuizResultKeepLearning => '继续学习。您可以重新进行测验来复习这个主题。';

  @override
  String get learnQuizNoAdditionalXp => '不会获得额外 XP。';

  @override
  String get quizHaze1Question => '当 24 小时 PSI 进入“不健康”范围时，健康人士应减少什么？';

  @override
  String get quizHaze1Option1 => '喝水';

  @override
  String get quizHaze1Option2 => '长时间或剧烈的户外活动';

  @override
  String get quizHaze1Option3 => '室内活动';

  @override
  String get quizHaze1Option4 => '睡眠';

  @override
  String get quizHaze1Explanation => '当空气质量进入“不健康”范围时，应减少长时间或剧烈的户外活动。';

  @override
  String get quizHaze2Question => '哪一种口罩是专为过滤烟霾中的细小颗粒而设计的？';

  @override
  String get quizHaze2Option1 => '外科口罩';

  @override
  String get quizHaze2Option2 => 'N95 防护口罩';

  @override
  String get quizHaze2Option3 => '布口罩';

  @override
  String get quizHaze2Option4 => '不需要戴口罩';

  @override
  String get quizHaze2Explanation => '正确佩戴的 N95 防护口罩能比外科口罩或布口罩更有效地过滤细小颗粒。';

  @override
  String get quizHaze3Question => '在烟霾期间进行长时间户外活动前，为什么应该查看空气质量状况？';

  @override
  String get quizHaze3Option1 => '空气质量可能在一天内发生变化';

  @override
  String get quizHaze3Option2 => 'PSI 只测量温度';

  @override
  String get quizHaze3Option3 => '烟霾只影响能见度';

  @override
  String get quizHaze3Option4 => '户外活动能改善空气质量';

  @override
  String get quizHaze3Explanation => '空气质量可能发生变化，因此查看当前状况有助于你决定是否需要调整长时间的户外活动。';

  @override
  String get quizHaze4Question => '当空气质量恶化时，怎样做可以合理地减少烟霾暴露？';

  @override
  String get quizHaze4Option1 => '增加户外活动时间';

  @override
  String get quizHaze4Option2 => '增加剧烈的户外运动';

  @override
  String get quizHaze4Option3 => '减少不必要的长时间户外暴露';

  @override
  String get quizHaze4Option4 => '保持所有户外计划不变';

  @override
  String get quizHaze4Explanation => '当空气质量恶化时，减少不必要的长时间户外暴露有助于降低烟霾暴露。';

  @override
  String get quizHaze5Question => '如果在烟霾天气下仍需要外出，你应该继续做什么？';

  @override
  String get quizHaze5Option1 => '忽略之后的空气质量更新';

  @override
  String get quizHaze5Option2 => '持续关注当前空气质量信息和相关通告';

  @override
  String get quizHaze5Option3 => '假设情况不会改变';

  @override
  String get quizHaze5Option4 => '延长户外时间以适应烟霾';

  @override
  String get quizHaze5Explanation => '应持续关注当前空气质量信息，因为空气状况和相关建议可能会发生变化。';

  @override
  String get quizUv1Question => '紫外线指数 8–10 属于哪个等级？';

  @override
  String get quizUv1Option1 => '低';

  @override
  String get quizUv1Option2 => '中等';

  @override
  String get quizUv1Option3 => '非常高';

  @override
  String get quizUv1Option4 => '极高';

  @override
  String get quizUv1Explanation => '紫外线指数 8–10 属于“非常高”等级，因此需要采取充分的防晒措施。';

  @override
  String get quizUv2Question => '在新加坡，紫外线照射通常在什么时候最强？';

  @override
  String get quizUv2Option1 => '清晨';

  @override
  String get quizUv2Option2 => '中午前后';

  @override
  String get quizUv2Option3 => '傍晚';

  @override
  String get quizUv2Option4 => '夜间';

  @override
  String get quizUv2Explanation => '紫外线辐射通常在中午前后最强，因此在这段时间采取额外的防晒措施十分重要。';

  @override
  String get quizUv3Question => '在户外活动时，怎样做有助于减少紫外线照射？';

  @override
  String get quizUv3Option1 => '尽可能待在阴凉处';

  @override
  String get quizUv3Option2 => '延长在阳光直射下的时间';

  @override
  String get quizUv3Option3 => '只有感觉炎热时才采取防晒措施';

  @override
  String get quizUv3Option4 => '避免喝水';

  @override
  String get quizUv3Explanation => '在户外时尽可能待在阴凉处，有助于减少紫外线的直接照射。';

  @override
  String get quizUv4Question => '当紫外线水平较高时，哪种组合能提供更好的防护？';

  @override
  String get quizUv4Option1 => '防晒霜、合适的衣物和阴凉处';

  @override
  String get quizUv4Option2 => '只喝水';

  @override
  String get quizUv4Option3 => '外科口罩和手套';

  @override
  String get quizUv4Option4 => '待在阳光直射下';

  @override
  String get quizUv4Explanation => '结合使用多种防晒措施，包括防晒霜、合适的衣物和阴凉处，有助于减少紫外线照射。';

  @override
  String get quizUv5Question => '为什么在阴天仍应考虑采取防晒措施？';

  @override
  String get quizUv5Option1 => '紫外线辐射仍可穿过云层照射到人体';

  @override
  String get quizUv5Option2 => '云层总会提高紫外线指数';

  @override
  String get quizUv5Option3 => '紫外线辐射只在下雨时存在';

  @override
  String get quizUv5Option4 => '只有晴天才需要防晒';

  @override
  String get quizUv5Explanation => '云层并不能完全阻挡紫外线辐射，因此即使在阴天也可能需要采取防晒措施。';

  @override
  String get quizHeat1Question => '在长时间户外活动中，减少热应激最重要的方法之一是什么？';

  @override
  String get quizHeat1Option1 => '定时补充水分并进行降温休息';

  @override
  String get quizHeat1Option2 => '等到感到口渴时才喝水';

  @override
  String get quizHeat1Option3 => '穿更厚重的衣物';

  @override
  String get quizHeat1Option4 => '持续待在阳光直射下';

  @override
  String get quizHeat1Explanation => '在长时间户外活动中，定时补充水分并进行降温休息有助于减少热应激。';

  @override
  String get quizHeat2Question => '如果你在户外活动时开始感到非常炎热，怎样做会更安全？';

  @override
  String get quizHeat2Option1 => '继续活动而不休息';

  @override
  String get quizHeat2Option2 => '到阴凉或较凉爽的地方休息';

  @override
  String get quizHeat2Option3 => '加大运动强度以尽快完成';

  @override
  String get quizHeat2Option4 => '避免喝水';

  @override
  String get quizHeat2Explanation => '在阴凉或较凉爽的地方休息可以减少持续的高温暴露，并让身体有机会降温。';

  @override
  String get quizHeat3Question => '为什么在炎热天气中补充水分很重要？';

  @override
  String get quizHeat3Option1 => '有助于补充因出汗而流失的水分';

  @override
  String get quizHeat3Option2 => '会增加身体受到的高温影响';

  @override
  String get quizHeat3Option3 => '可以完全取代休息';

  @override
  String get quizHeat3Option4 => '可以预防所有与高温有关的疾病';

  @override
  String get quizHeat3Explanation => '喝水有助于补充因出汗而流失的水分，并帮助身体在炎热环境中保持水分。';

  @override
  String get quizHeat4Question => '在非常炎热的日子计划长时间户外活动前，你应该怎么做？';

  @override
  String get quizHeat4Option1 => '查看当前的高温状况并计划适当的防护措施';

  @override
  String get quizHeat4Option2 => '如果天空晴朗就忽略高温状况';

  @override
  String get quizHeat4Option3 => '不要携带饮用水';

  @override
  String get quizHeat4Option4 => '多穿几层厚重衣物';

  @override
  String get quizHeat4Explanation => '查看当前的高温状况有助于你在长时间户外活动前安排补水、降温休息和其他防护措施。';

  @override
  String get quizHeat5Question => '如果炎热天气持续一整天，你应该怎么做？';

  @override
  String get quizHeat5Option1 => '假设天气会自动好转';

  @override
  String get quizHeat5Option2 => '完全不调整户外计划';

  @override
  String get quizHeat5Option3 => '持续关注状况，并在必要时调整计划';

  @override
  String get quizHeat5Option4 => '停止喝水以减少休息次数';

  @override
  String get quizHeat5Explanation => '高温状况可能在一天内发生变化，因此应持续关注，并在必要时调整长时间的户外活动。';

  @override
  String get quizFlood1Question => '如果前方道路被洪水淹没，而且你无法判断水有多深，应该怎么做？';

  @override
  String get quizFlood1Option1 => '缓慢驶过积水路段';

  @override
  String get quizFlood1Option2 => '掉头并改走其他路线';

  @override
  String get quizFlood1Option3 => '停在被淹的路段中';

  @override
  String get quizFlood1Option4 => '趁水位还没升高前快速驶过';

  @override
  String get quizFlood1Explanation =>
      '当无法确定积水深度和状况时，应避免进入积水区域。掉头并选择更安全的替代路线可以降低风险。';

  @override
  String get quizFlood2Question => '发生突发洪水时，在选择替代路线之前应该怎么做？';

  @override
  String get quizFlood2Option1 => '查看最新的洪水信息和道路状况';

  @override
  String get quizFlood2Option2 => '不查看情况，直接选择最短路线';

  @override
  String get quizFlood2Option3 => '返回被洪水淹没的道路';

  @override
  String get quizFlood2Option4 => '继续驾驶，直到找到一条开放的道路';

  @override
  String get quizFlood2Explanation => '查看最新的洪水和道路信息，可以帮助你避开受洪水影响的路线。';

  @override
  String get quizFlood3Question => '暴雨导致驾驶能见度降低时，你应该怎么做？';

  @override
  String get quizFlood3Option1 => '加速以尽快离开雨区';

  @override
  String get quizFlood3Option2 => '减速并谨慎驾驶';

  @override
  String get quizFlood3Option3 => '保持原来的速度继续行驶';

  @override
  String get quizFlood3Option4 => '驾驶时使用手机查看天气更新';

  @override
  String get quizFlood3Explanation => '当暴雨降低能见度时，减速并谨慎驾驶会更加安全。';

  @override
  String get quizFlood4Question => '为什么应该避免进入洪水积水区域？';

  @override
  String get quizFlood4Option1 => '洪水积水总是很浅';

  @override
  String get quizFlood4Option2 => '洪水会让车辆变得更干净';

  @override
  String get quizFlood4Option3 => '水可能比看起来更深或流动得更快';

  @override
  String get quizFlood4Option4 => '洪水积水总会立即消退';

  @override
  String get quizFlood4Explanation => '洪水积水可能比看起来更深或流动得更快，因此进入积水区域可能十分危险。';

  @override
  String get quizFlood5Question => '当暴雨和洪水情况持续时，你应该怎么做？';

  @override
  String get quizFlood5Option1 => '持续关注情况并遵循相关安全信息';

  @override
  String get quizFlood5Option2 => '忽略之后的天气更新';

  @override
  String get quizFlood5Option3 => '只要道路开放就认为一定安全';

  @override
  String get quizFlood5Option4 => '进入积水区域查看水深';

  @override
  String get quizFlood5Explanation => '暴雨期间情况可能不断变化，因此应持续关注最新信息，并在必要时调整计划。';

  @override
  String get scenarioChallenges => '情境挑战';

  @override
  String get scenarioChallengesDescription => '在贴近现实的环境情境中练习做出安全的决定。';

  @override
  String get scenarioProgress => '情境挑战进度';

  @override
  String get scenarioAllCompleted => '所有情境挑战均已完成。';

  @override
  String scenarioRemaining(int count) {
    return '还剩 $count 个情境挑战。';
  }

  @override
  String get scenarioCompleted => '已完成';

  @override
  String get scenarioNotCompleted => '未完成';

  @override
  String get scenarioFlashFloodTitle => '路线突发洪水';

  @override
  String get scenarioFlashFloodDescription => '在突发洪水期间出行时做出安全决定。';

  @override
  String get scenarioHazeTitle => '户外活动期间的烟霾';

  @override
  String get scenarioHazeDescription => '当户外计划期间空气质量恶化时，做出安全决定。';

  @override
  String get scenarioHeatUvTitle => '户外活动期间的高温与紫外线';

  @override
  String get scenarioHeatUvDescription => '当高温和紫外线暴露较高时，做出安全决定。';

  @override
  String get scenarioFloodStep1Situation => '你正在暴雨中回家。前方道路已被洪水淹没，而且你无法判断积水有多深。';

  @override
  String get scenarioFloodStep1Question => '你应该怎么做？';

  @override
  String get scenarioFloodStep1Option1 => '趁水位进一步上涨前快速驶过。';

  @override
  String get scenarioFloodStep1Option2 => '掉头并改走其他路线。';

  @override
  String get scenarioFloodStep1Option3 => '停在被淹的路段中等待。';

  @override
  String get scenarioFloodStep1Option4 => '打开车窗并缓慢继续行驶。';

  @override
  String get scenarioFloodStep1CorrectFeedback =>
      '正确的决定。应避免驶入积水区域，并选择更安全的替代路线。';

  @override
  String get scenarioFloodStep1IncorrectFeedback =>
      '应避免驶入积水区域。水可能比看起来更深或流动得更快。';

  @override
  String get scenarioFloodStep2Situation => '你已安全掉头，但雨势正在增强。现在你需要决定接下来走哪条路线。';

  @override
  String get scenarioFloodStep2Question => '在选择另一条路线之前，你应该怎么做？';

  @override
  String get scenarioFloodStep2Option1 => '不查看当前情况，直接选择最短的道路。';

  @override
  String get scenarioFloodStep2Option2 => '查看当前洪水信息并规划更安全的路线。';

  @override
  String get scenarioFloodStep2Option3 => '返回被淹的道路，看看情况是否有所改善。';

  @override
  String get scenarioFloodStep2Option4 => '继续驾驶，直到找到一条开放的道路。';

  @override
  String get scenarioFloodStep2CorrectFeedback => '正确。查看当前情况有助于避开受洪水影响的道路。';

  @override
  String get scenarioFloodStep2IncorrectFeedback =>
      '更安全的做法是在选择其他路线前先查看当前的洪水信息。';

  @override
  String get scenarioFloodStep3Situation => '你的替代路线目前畅通，但暴雨仍在持续，能见度也正在下降。';

  @override
  String get scenarioFloodStep3Question => '接下来最安全的做法是什么？';

  @override
  String get scenarioFloodStep3Option1 => '加速，以便更快回家。';

  @override
  String get scenarioFloodStep3Option2 => '照常驾驶并忽略能见度下降。';

  @override
  String get scenarioFloodStep3Option3 => '减速谨慎驾驶，同时继续留意路况。';

  @override
  String get scenarioFloodStep3Option4 => '驾驶时使用手机查看最新信息。';

  @override
  String get scenarioFloodStep3CorrectFeedback => '正确。能见度降低时，减速并保持警觉会更加安全。';

  @override
  String get scenarioFloodStep3IncorrectFeedback =>
      '能见度降低会增加驾驶风险。请减速、保持警觉，并安全地留意当前情况。';

  @override
  String get scenarioCompleteTitle => '情境挑战完成';

  @override
  String scenarioSafeDecisions(int safe, int total) {
    return '$safe / $total 个安全决定';
  }

  @override
  String get scenarioPreviouslyCompleted => '此情境挑战之前已完成，因此不会获得额外 XP。';

  @override
  String scenarioXpEarned(int points) {
    return '+$points XP 已获得';
  }

  @override
  String get scenarioContinue => '继续';

  @override
  String get scenarioSaveError => '无法保存情境挑战进度，请重试。';

  @override
  String get scenarioHazeStep1Situation => '你计划今天下午在户外运动，但发现外面的环境看起来有烟霾。';

  @override
  String get scenarioHazeStep1Question => '出门前你应该怎么做？';

  @override
  String get scenarioHazeStep1Option1 => '不查看任何信息，继续原来的计划。';

  @override
  String get scenarioHazeStep1Option2 => '查看最新的 PSI 和空气质量状况。';

  @override
  String get scenarioHazeStep1Option3 => '加大运动强度，以便更快完成。';

  @override
  String get scenarioHazeStep1Option4 => '因为能见度仍可接受，所以认为烟霾没有危害。';

  @override
  String get scenarioHazeStep1CorrectFeedback =>
      '正确的决定。查看当前空气质量信息有助于你判断是否适合进行户外活动。';

  @override
  String get scenarioHazeStep1IncorrectFeedback =>
      '在决定是否继续长时间户外活动前，应先查看当前的空气质量信息。';

  @override
  String get scenarioHazeStep2Situation => 'PSI 显示空气质量比平时更差，但你今天仍想保持活动。';

  @override
  String get scenarioHazeStep2Question => '哪一种选择更安全？';

  @override
  String get scenarioHazeStep2Option1 => '继续进行长时间、高强度的户外运动。';

  @override
  String get scenarioHazeStep2Option2 => '改到室内运动，或减少长时间的户外剧烈活动。';

  @override
  String get scenarioHazeStep2Option3 => '因为已经安排好运动，所以忽略空气质量读数。';

  @override
  String get scenarioHazeStep2Option4 => '延长户外活动时间，让自己适应烟霾。';

  @override
  String get scenarioHazeStep2CorrectFeedback =>
      '正确。当空气质量恶化时，调整活动方式可以减少不必要的暴露。';

  @override
  String get scenarioHazeStep2IncorrectFeedback =>
      '当空气质量恶化时，应考虑将剧烈运动移到室内，或减少长时间的户外剧烈活动。';

  @override
  String get scenarioHazeStep3Situation => '稍后你需要外出，而烟霾情况仍然存在。';

  @override
  String get scenarioHazeStep3Question => '你应该怎么做？';

  @override
  String get scenarioHazeStep3Option1 => '继续留意当前情况，并遵循建议的防护措施。';

  @override
  String get scenarioHazeStep3Option2 => '忽略之后的空气质量更新。';

  @override
  String get scenarioHazeStep3Option3 => '因为运动计划取消了，所以花更多时间待在户外。';

  @override
  String get scenarioHazeStep3Option4 => '认为一天内的空气质量不会发生变化。';

  @override
  String get scenarioHazeStep3CorrectFeedback =>
      '正确。空气质量可能会发生变化，因此应继续留意当前情况并采取适当的防护措施。';

  @override
  String get scenarioHazeStep3IncorrectFeedback =>
      '空气质量可能在一天中发生变化，因此应继续查看当前情况。';

  @override
  String get scenarioSituationLabel => '情境';

  @override
  String get scenarioCheckDecision => '检查决定';

  @override
  String get scenarioNextSituation => '下一个情境';

  @override
  String get scenarioFinishScenario => '完成情境挑战';

  @override
  String get scenarioHeatUvStep1Situation =>
      '你计划在中午前后进行数小时的户外活动。天气炎热，而且紫外线指数很高。';

  @override
  String get scenarioHeatUvStep1Question => '出门前你应该怎么做？';

  @override
  String get scenarioHeatUvStep1Option1 => '因为天气晴朗很安全，所以立即出门。';

  @override
  String get scenarioHeatUvStep1Option2 => '做好防晒措施，携带饮用水，并计划在阴凉处休息。';

  @override
  String get scenarioHeatUvStep1Option3 => '避免喝水，这样就不需要休息。';

  @override
  String get scenarioHeatUvStep1Option4 => '穿更厚的衣服，让自己适应炎热天气。';

  @override
  String get scenarioHeatUvStep1CorrectFeedback =>
      '正确的决定。做好防晒、补充水分并安排阴凉处休息，有助于减少高温和紫外线带来的影响。';

  @override
  String get scenarioHeatUvStep1IncorrectFeedback =>
      '长时间进行户外活动前，应同时为高温和紫外线暴露做好准备。';

  @override
  String get scenarioHeatUvStep2Situation =>
      '在户外活动一段时间后，你开始感到非常炎热，而且已经在阳光直射下待了一段时间。';

  @override
  String get scenarioHeatUvStep2Question => '接下来哪一种做法更安全？';

  @override
  String get scenarioHeatUvStep2Option1 => '不停下来，继续进行活动。';

  @override
  String get scenarioHeatUvStep2Option2 => '喝水，并到阴凉或较凉爽的地方休息。';

  @override
  String get scenarioHeatUvStep2Option3 => '加大运动强度，以便更快完成。';

  @override
  String get scenarioHeatUvStep2Option4 => '休息时继续待在阳光直射的地方。';

  @override
  String get scenarioHeatUvStep2CorrectFeedback =>
      '正确。补充水分并适时到凉爽处休息，有助于减少长时间户外活动造成的热应激。';

  @override
  String get scenarioHeatUvStep2IncorrectFeedback =>
      '应定期补充水分并到凉爽处休息，而不是在炎热环境中持续长时间活动。';

  @override
  String get scenarioHeatUvStep3Situation => '当天稍后你仍计划进行更多户外活动。';

  @override
  String get scenarioHeatUvStep3Question => '接下来你应该怎么做？';

  @override
  String get scenarioHeatUvStep3Option1 => '因为之前已经查看过情况，所以忽略之后的任何变化。';

  @override
  String get scenarioHeatUvStep3Option2 => '等到非常口渴时才喝水。';

  @override
  String get scenarioHeatUvStep3Option3 => '继续留意当前情况，并在必要时调整计划。';

  @override
  String get scenarioHeatUvStep3Option4 => '持续待在户外，让身体适应炎热天气。';

  @override
  String get scenarioHeatUvStep3CorrectFeedback =>
      '正确。环境状况可能发生变化，因此应继续留意情况，并在必要时调整户外活动计划。';

  @override
  String get scenarioHeatUvStep3IncorrectFeedback => '应继续留意高温和紫外线情况，并在必要时调整计划。';

  @override
  String get cprAedTitle => '心肺复苏与自动体外除颤器';

  @override
  String get cprAedVideoTitle => '学习心肺复苏与 AED 操作步骤';

  @override
  String get cprAedVideoSubtitle => '打开新加坡民防部队（SCDF）官方视频';

  @override
  String get cprAedDescription => '了解在疑似心脏骤停时应采取的基本行动。';

  @override
  String get cprAedRememberActions => '记住以下步骤';

  @override
  String get cprAedStep1Title => '检查反应';

  @override
  String get cprAedStep1Description => '轻拍患者的肩膀，检查对方是否有反应。';

  @override
  String get cprAedStep2Title => '拨打 995 并获取 AED';

  @override
  String get cprAedStep2Description => '请一人拨打 995，并让另一人取来最近的 AED。';

  @override
  String get cprAedStep3Title => '开始心肺复苏';

  @override
  String get cprAedStep3Description => '如果患者没有呼吸，请开始进行徒手心肺复苏，并遵循 995 调度员的指示。';

  @override
  String get cprAedStep4Title => '使用 AED';

  @override
  String get cprAedStep4Description => 'AED 到达后立即使用，并按照设备的语音或视觉指示操作。';

  @override
  String get cprAedWatchVideo => '观看 SCDF 官方视频';

  @override
  String get cprAedDisclaimer =>
      '本快速指南仅用于应急准备学习，不能替代经过认证的心肺复苏/AED 培训。发生紧急情况时，请拨打 995，并遵循 SCDF 调度员的指示。';

  @override
  String get cprAedVideoError => '无法打开 SCDF 视频。';

  @override
  String get floodSafetyTitle => '突发洪水安全指南';

  @override
  String get floodSafetyHeroTitle => '暴雨可能引发突发洪水';

  @override
  String get floodSafetyHeroDescription => '了解在新加坡出行时遇到洪水应采取的行动。';

  @override
  String get floodSafetyEncounterTitle => '如果遇到洪水';

  @override
  String get floodSafetyTurnBackTitle => '掉头返回';

  @override
  String get floodSafetyTurnBackDescription => '不要进入积水区域。请选择更安全的替代路线。';

  @override
  String get floodSafetyHigherGroundTitle => '前往较高处';

  @override
  String get floodSafetyHigherGroundDescription =>
      '如果前方发生洪水，请远离该区域，因为水位可能迅速上升。';

  @override
  String get floodSafetyAvoidMovingWaterTitle => '避开流动的洪水';

  @override
  String get floodSafetyAvoidMovingWaterDescription =>
      '洪水的深度和流速可能难以判断，流动的水可能使你跌倒。';

  @override
  String get floodSafetyAvoidDrivingTitle => '不要驶入较深的洪水';

  @override
  String get floodSafetyAvoidDrivingDescription =>
      '如果积水已高于路缘，或道路标线已无法看见，请避免驶入该道路。';

  @override
  String get floodSafetyBeforeTravellingTitle => '出行前';

  @override
  String get floodSafetyBeforeTravellingDescription =>
      '暴雨期间出行前，请查看当前天气和洪水警报，并在必要时规划替代路线。';

  @override
  String get floodSafetySource => '安全指南参考自新加坡国家水务局 PUB。';

  @override
  String get floodSafetyDo => '应该做';

  @override
  String get floodSafetyDont => '不要做';

  @override
  String scenarioRewardXp(int points) {
    return '· +$points XP';
  }

  @override
  String get learnTryAgain => '重试';

  @override
  String get emergencyHelpTitle => '紧急求助';

  @override
  String get emergencyInEmergency => '发生紧急情况时';

  @override
  String get emergencyImmediateDangerDescription => '如果有人面临即时危险，请立即联系适当的紧急服务。';

  @override
  String get emergencyServices => '紧急服务';

  @override
  String get emergencyFireRescueTitle => '消防、救援与紧急救护车';

  @override
  String get emergencyFireRescueDescription => '火灾、救援或危及生命的紧急情况';

  @override
  String get emergencyPoliceTitle => '警方紧急服务';

  @override
  String get emergencyPoliceDescription => '需要警方立即协助';

  @override
  String get emergencySms => '紧急短信服务';

  @override
  String get emergencyPoliceSmsTitle => '警方紧急短信服务';

  @override
  String get emergencyPoliceSmsDescription => '在不安全或无法拨打电话时使用的紧急短信服务';

  @override
  String get emergencyScdfSmsTitle => '民防部队紧急短信服务';

  @override
  String get emergencyScdfSmsDescription => '为失聪、听障或有语言障碍人士提供的紧急短信服务。';

  @override
  String get emergencyOtherUsefulContacts => '其他实用联系方式';

  @override
  String get emergencyNurseFirstDescription => '非紧急医疗咨询';

  @override
  String get emergencyNeaHotline => '国家环境局热线';

  @override
  String get emergencyNeaDescription => '环境反馈与咨询';

  @override
  String get emergencyWhenToCall => '什么时候应该拨打紧急电话？';

  @override
  String get emergencyEmergencyLabel => '紧急情况';

  @override
  String get emergencyEmergencyGuide =>
      '有人面临即时危险、严重受伤、出现危及生命的医疗状况，或发生火灾或需要救援的情况。';

  @override
  String get emergencyNonEmergencyLabel => '非紧急情况';

  @override
  String get emergencyNonEmergencyGuide => '情况不会对生命或安全构成即时威胁。请改用适当的非紧急服务。';

  @override
  String get emergencyDisclaimer => '紧急信息仅供防灾准备参考。请始终遵循新加坡相关政府机构的指示。';

  @override
  String get profileLoadProgressError => '无法加载您的进度。';

  @override
  String get profileWeeklyActivity => '每周活动';

  @override
  String profileWeeklyDaysCompleted(int completed) {
    return '$completed / 7 天';
  }

  @override
  String get profileWeeklyActivityDescription => '您过去 7 天的防灾准备计划活动。';

  @override
  String profileCurrentStreak(int days) {
    return '当前连续 $days 天';
  }

  @override
  String get profileYourProgress => '您的进度';

  @override
  String get profileProgressDescription => '追踪您的防灾准备进度和成就。';

  @override
  String profileLevel(int level) {
    return '等级 $level';
  }

  @override
  String profileXpStreak(int xp, int days) {
    return '$xp XP · 连续 $days 天';
  }

  @override
  String profileProgressToLevel(int level) {
    return '距离等级 $level 的进度';
  }

  @override
  String profileXpProgress(int current) {
    return '$current / 100 XP';
  }

  @override
  String profileXpToLevel(int xp, int level) {
    return '还需 $xp XP 达到等级 $level';
  }

  @override
  String get profileTodayPlanCompleted => '今日计划已完成';

  @override
  String get profileTodayPlanNotCompleted => '今日计划尚未完成';

  @override
  String get profileTodayPlanCompletedDescription => '您的 XP 和连续记录已更新。';

  @override
  String get profileTodayPlanNotCompletedDescription => '完成今天的防灾准备计划以延续您的连续记录。';

  @override
  String get profileNextBadge => '下一个徽章';

  @override
  String get profileBadges => '徽章';

  @override
  String get profileBadgeFirstCheckTitle => '首次检查';

  @override
  String get profileBadgeFirstCheckDescription => '完成您的第一个防灾准备清单项目。';

  @override
  String get profileBadgeHazeHeroTitle => '烟霾英雄';

  @override
  String get profileBadgeHazeHeroDescription => '完成两个烟霾测验。';

  @override
  String get profileBadgeUvGuardianTitle => '紫外线守护者';

  @override
  String get profileBadgeUvGuardianDescription => '完成两个紫外线测验。';

  @override
  String get profileBadgeFloodReadyTitle => '防洪准备';

  @override
  String get profileBadgeFloodReadyDescription => '完成所有防洪准备清单项目。';

  @override
  String get profileBadgeStreak7Title => '连续 7 天';

  @override
  String get profileBadgeStreak7Description => '连续 7 天保持您的防灾准备记录。';

  @override
  String get profileSettings => '设置';

  @override
  String get profilePreferences => '偏好设置';

  @override
  String get profilePreferencesDescription => '地区、户外活动和防灾准备提醒。';

  @override
  String get profileAccount => '账户';

  @override
  String get profileLogout => '退出登录';

  @override
  String get profileLogoutDescription => '退出您的 SGReady 账户。';

  @override
  String get profileLogoutDialogTitle => '退出 SGReady？';

  @override
  String get profileLogoutDialogDescription => '您可以随时使用您的账户重新登录。';

  @override
  String get profileCancel => '取消';

  @override
  String get profilePhotoSelectError => '无法选择该照片。请重试。';

  @override
  String get profileChangePhoto => '更改个人资料照片';

  @override
  String get profileChoosePhoto => '选择个人资料照片';

  @override
  String get profileRemovePhoto => '移除个人资料照片';

  @override
  String get profileRewards => '奖励';

  @override
  String profileLifetimeXp(int xp) {
    return '累计 $xp XP';
  }

  @override
  String get profileAllRewardsUnlocked => '所有原型奖励里程碑均已解锁。';

  @override
  String profileXpUntilNextReward(int xp) {
    return '距离下一个奖励还需 $xp XP。';
  }

  @override
  String get profilePreparednessScore => '防灾准备评分';

  @override
  String get profileScoreChecklist => '清单';

  @override
  String get profileScoreQuizzes => '测验';

  @override
  String get profileScoreEngagement => '参与度';

  @override
  String get profileScoreBadges => '徽章';

  @override
  String get rewardsScreenTitle => '奖励';

  @override
  String get rewardsMilestones => '奖励里程碑';

  @override
  String get rewardsMilestonesDescription => '提升您的防灾准备知识，并随着累计 XP 增加解锁奖励。';

  @override
  String get rewardTreatVoucherTitle => '\$5 美食礼券';

  @override
  String get rewardTreatVoucherDescription => '培养良好防灾准备习惯的小奖励。';

  @override
  String get rewardLifestyleVoucherTitle => '\$10 生活礼券';

  @override
  String get rewardLifestyleVoucherDescription => '奖励您持续积极参与并做好防灾准备。';

  @override
  String get rewardPreparednessPackTitle => 'SGReady 防灾准备包';

  @override
  String get rewardPreparednessPackDescription => '实用必需品，帮助您为紧急情况做好准备。';

  @override
  String get rewardsLifetimeXpTitle => '您的累计 XP';

  @override
  String rewardsXpValue(int xp) {
    return '$xp XP';
  }

  @override
  String rewardsTier(String tier) {
    return '$tier等级';
  }

  @override
  String get rewardsHighestTierReached => '已达到最高奖励等级';

  @override
  String rewardsXpToTier(int xp, String tier) {
    return '还需 $xp XP 达到$tier';
  }

  @override
  String get rewardsEarnXpDescription => '通过每日防灾准备行动、测验、情景挑战和应急包获取 XP。';

  @override
  String get rewardsTierStarter => '起步';

  @override
  String get rewardsTierPrepared => '已准备';

  @override
  String get rewardsTierReady => '就绪';

  @override
  String get rewardsTierResilient => '韧性';

  @override
  String get rewardUnlocked => '奖励已解锁';

  @override
  String rewardXpMoreToUnlock(int xp) {
    return '还需 $xp XP 解锁';
  }

  @override
  String get rewardView => '查看奖励';

  @override
  String get rewardPrototypeDialogDescription =>
      '此奖励属于 SGReady 原型，目前无法兑换。在未来的实现中，符合条件的用户可以通过参与合作的机构兑换奖励。';

  @override
  String get rewardGotIt => '知道了';

  @override
  String get prototypeRewardsTitle => '原型奖励';

  @override
  String get prototypeRewardsDescription =>
      'SGReady 中显示的奖励仅为演示用途，目前无法兑换。实际应用需要与参与机构建立合作，并采用安全的奖励发放机制。';

  @override
  String get youSpendMoreTimeOutdoors => '您经常进行户外活动';

  @override
  String get usuallyOutdoorsAtMidday => '通常在中午进行户外活动';

  @override
  String get todayFocusAirQuality => '空气质量';

  @override
  String get todayFocusHeatSafety => '高温安全';

  @override
  String get todayFocusUvProtection => '紫外线防护';
}
