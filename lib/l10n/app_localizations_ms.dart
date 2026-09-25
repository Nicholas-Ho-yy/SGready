// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Malay (`ms`).
class AppLocalizationsMs extends AppLocalizations {
  AppLocalizationsMs([String locale = 'ms']) : super(locale);

  @override
  String get appTitle => 'SGReady';

  @override
  String get preferences => 'Keutamaan';

  @override
  String get personaliseSGReady => 'Peribadikan SGReady';

  @override
  String get preferencesDescription =>
      'Keutamaan ini membantu SGReady menyesuaikan pengalaman kesiapsiagaan anda.';

  @override
  String get homeRegion => 'Kawasan utama';

  @override
  String get homeRegionDescription =>
      'Pilih kawasan Singapura yang biasanya anda mahu lihat terlebih dahulu.';

  @override
  String get central => 'Tengah';

  @override
  String get north => 'Utara';

  @override
  String get south => 'Selatan';

  @override
  String get east => 'Timur';

  @override
  String get west => 'Barat';

  @override
  String get outdoorActivity => 'Aktiviti luar';

  @override
  String get outdoorActivityDescription =>
      'Berapa banyak masa yang biasanya anda luangkan di luar?';

  @override
  String get low => 'Rendah';

  @override
  String get moderate => 'Sederhana';

  @override
  String get high => 'Tinggi';

  @override
  String get usuallyOutdoors => 'Biasanya berada di luar';

  @override
  String get usuallyOutdoorsDescription =>
      'Pilih waktu apabila anda biasanya berada di luar.';

  @override
  String get morning => 'Pagi';

  @override
  String get midday => 'Tengah hari';

  @override
  String get evening => 'Petang';

  @override
  String get preparednessReminders => 'Peringatan kesiapsiagaan';

  @override
  String get preparednessRemindersDescription =>
      'Benarkan SGReady mengingatkan anda tentang tindakan kesiapsiagaan yang berkaitan.';

  @override
  String get enableReminders => 'Aktifkan peringatan';

  @override
  String get notificationSchedule => 'Jadual pemberitahuan';

  @override
  String get daytimeOnly => 'Waktu siang sahaja';

  @override
  String get daytimeOnlyDescription =>
      'Peringatan cuaca dan tugasan dihantar kira-kira setiap 5 jam antara 8 pagi hingga 10 malam.';

  @override
  String get twentyFourHours => '24 jam';

  @override
  String get twentyFourHoursDescription =>
      'Kemas kini cuaca dihantar kira-kira setiap 5 jam, siang dan malam. Peringatan tugasan dihadkan antara 8 pagi hingga 10 malam.';

  @override
  String get accessibility => 'Kebolehcapaian';

  @override
  String get accessibilityDescription =>
      'Laraskan SGReady supaya aplikasi lebih mudah dan selesa digunakan.';

  @override
  String get largerText => 'Teks lebih besar';

  @override
  String get largerTextDescription =>
      'Besarkan saiz teks di seluruh SGReady supaya lebih mudah dibaca.';

  @override
  String get largerControls => 'Kawalan lebih besar';

  @override
  String get largerControlsDescription =>
      'Besarkan saiz kawalan penting supaya lebih mudah disentuh.';

  @override
  String get language => 'Bahasa';

  @override
  String get languageDescription =>
      'Pilih bahasa yang digunakan dalam SGReady.';

  @override
  String get english => 'Bahasa Inggeris';

  @override
  String get simplifiedChinese => 'Bahasa Cina Ringkas';

  @override
  String get malay => 'Bahasa Melayu';

  @override
  String get appearance => 'Paparan';

  @override
  String get appearanceDescription =>
      'Pilih cara SGReady dipaparkan pada peranti ini.';

  @override
  String get systemDefault => 'Tetapan sistem';

  @override
  String get systemDefaultDescription => 'Ikut tetapan paparan peranti anda';

  @override
  String get light => 'Cerah';

  @override
  String get lightDescription => 'Sentiasa gunakan mod cerah';

  @override
  String get dark => 'Gelap';

  @override
  String get darkDescription => 'Sentiasa gunakan mod gelap';

  @override
  String get savePreferences => 'Simpan keutamaan';

  @override
  String get saving => 'Sedang menyimpan...';

  @override
  String get preferencesSaved => 'Keutamaan telah disimpan.';

  @override
  String get unableToSavePreferences => 'Tidak dapat menyimpan keutamaan.';

  @override
  String get navHome => 'Utama';

  @override
  String get navToday => 'Hari Ini';

  @override
  String get navExplore => 'Teroka';

  @override
  String get navLearn => 'Belajar';

  @override
  String get navProfile => 'Profil';

  @override
  String get todayInSingapore => 'Hari Ini di Singapura';

  @override
  String get homeDescription =>
      'Semak keadaan setempat dan persediaan yang perlu anda lakukan.';

  @override
  String get todaysPreparedness => 'Kesiapsiagaan hari ini';

  @override
  String get whatYouShouldDo => 'Apa yang perlu anda lakukan';

  @override
  String get showLess => 'Tunjukkan kurang';

  @override
  String get why => 'Mengapa?';

  @override
  String get noData => 'Tiada data';

  @override
  String get psi24h => 'PSI (24 jam)';

  @override
  String get uvIndex => 'Indeks UV';

  @override
  String get temperature => 'Suhu';

  @override
  String get wbgtHeatStress => 'WBGT (Tekanan Haba)';

  @override
  String lastUpdated(String dateTime) {
    return 'Kemas kini terakhir: $dateTime';
  }

  @override
  String regionAverage(String region) {
    return 'Purata $region';
  }

  @override
  String get riskElevated => 'Meningkat';

  @override
  String get riskLow => 'Rendah';

  @override
  String get riskModerate => 'Sederhana';

  @override
  String get riskHigh => 'Tinggi';

  @override
  String get riskVeryHigh => 'Sangat Tinggi';

  @override
  String get riskExtreme => 'Ekstrem';

  @override
  String get floodRiskMessage =>
      'Hujan lebat dikesan. Kekal berwaspada dan elakkan kawasan yang mudah dilanda banjir.';

  @override
  String get lowRiskMessage =>
      'Keadaan secara amnya baik. Kekal bersedia dan terus pantau perkembangan terkini.';

  @override
  String get moderateRiskMessage =>
      'Ambil langkah berjaga-jaga asas dan ikuti tindakan yang disyorkan hari ini.';

  @override
  String get highRiskMessage =>
      'Ikuti panduan keselamatan di bawah dan sesuaikan rancangan anda jika perlu.';

  @override
  String get veryHighRiskMessage =>
      'Hadkan pendedahan di luar dan ambil langkah berjaga-jaga tambahan.';

  @override
  String get extremeRiskMessage =>
      'Elakkan aktiviti luar yang tidak perlu dan ikuti panduan keselamatan dengan teliti.';

  @override
  String get recommendationEnvironmentalDataUnavailable =>
      'Data alam sekitar tidak tersedia';

  @override
  String get recommendationEnvironmentalDataUnavailableBody =>
      'Bacaan alam sekitar semasa tidak dapat diperoleh. Sila cuba muat semula data kemudian.';

  @override
  String get actionCheckInternetConnection => 'Periksa sambungan internet anda';

  @override
  String get actionRefreshEnvironmentalData => 'Muat semula data alam sekitar';

  @override
  String get actionReferOfficialChannels =>
      'Rujuk saluran rasmi NEA dan PUB jika keadaan kelihatan tidak selamat';

  @override
  String get recommendationPsiUnavailable => 'Bacaan PSI tidak tersedia';

  @override
  String get recommendationPsiUnavailableBody =>
      'Bacaan kualiti udara terkini tidak dapat diperoleh.';

  @override
  String get actionRefreshDataLater => 'Muat semula data kemudian';

  @override
  String get actionReferNeaHazeUpdates =>
      'Rujuk maklumat jerebu rasmi NEA semasa merancang aktiviti luar';

  @override
  String recommendationHaze(int psi) {
    return 'Jerebu / Kualiti Udara (PSI $psi)';
  }

  @override
  String get psiBodyGood => 'Kualiti udara berada dalam julat Baik.';

  @override
  String get psiBodyModerate =>
      'Kualiti udara berada dalam julat Sederhana. Kebanyakan orang boleh meneruskan aktiviti seperti biasa, manakala individu yang lebih terdedah perlu memantau kesihatan dan gejala mereka.';

  @override
  String get psiBodyHigh =>
      'Kualiti udara berada pada tahap Tidak Sihat. Kurangkan aktiviti luar yang berpanjangan atau lasak, terutamanya jika anda lebih terdedah kepada pencemaran udara.';

  @override
  String get psiBodyVeryHigh =>
      'Kualiti udara berada pada tahap Sangat Tidak Sihat. Kurangkan aktiviti luar dan pendedahan kepada udara luar jika boleh.';

  @override
  String get psiBodyExtreme =>
      'Kualiti udara berada pada tahap Berbahaya. Kekal di dalam bangunan jika boleh dan kurangkan pendedahan kepada udara luar.';

  @override
  String get actionContinueNormalActivities =>
      'Teruskan aktiviti seperti biasa';

  @override
  String get actionMonitorEnvironmentalUpdates =>
      'Pantau maklumat alam sekitar rasmi';

  @override
  String get actionContinueNormalIfWell =>
      'Teruskan aktiviti seperti biasa jika anda berasa sihat';

  @override
  String get actionMonitorHealthSymptoms =>
      'Pantau gejala jika anda mempunyai masalah jantung atau pernafasan';

  @override
  String get actionCheckPsiBeforeOutdoorActivity =>
      'Semak bacaan PSI terkini sebelum melakukan aktiviti luar yang berpanjangan';

  @override
  String get actionReduceOutdoorActivity =>
      'Kurangkan aktiviti luar yang berpanjangan atau lasak';

  @override
  String get actionWearN95Appropriate =>
      'Pakai pelitup N95 yang dipasang dengan betul apabila sesuai';

  @override
  String get actionKeepIndoorAirClean =>
      'Pastikan udara di dalam bangunan sebersih yang boleh';

  @override
  String get actionSeekMedicalAdvice =>
      'Dapatkan nasihat perubatan jika anda berasa tidak sihat';

  @override
  String get actionMinimiseOutdoorActivity => 'Kurangkan aktiviti luar';

  @override
  String get actionRemainIndoors => 'Kekal di dalam bangunan jika boleh';

  @override
  String get actionWearN95IfUnavoidable =>
      'Pakai pelitup N95 yang dipasang dengan betul jika pendedahan di luar tidak dapat dielakkan';

  @override
  String get actionSeekHelpBreathing =>
      'Dapatkan bantuan perubatan jika anda mengalami kesukaran bernafas';

  @override
  String get actionAvoidOutdoorActivity => 'Elakkan aktiviti luar jika boleh';

  @override
  String get actionCloseDoorsWindows =>
      'Kekal di dalam bangunan dengan pintu dan tingkap ditutup';

  @override
  String get actionWearN95Outside =>
      'Pakai pelitup N95 yang dipasang dengan betul jika anda perlu keluar';

  @override
  String get actionSeekHelpSeriousSymptoms =>
      'Dapatkan bantuan perubatan dengan segera jika anda mengalami gejala yang serius';

  @override
  String get recommendationUvUnavailable => 'Bacaan UV tidak tersedia';

  @override
  String get recommendationUvUnavailableBody =>
      'Bacaan indeks ultraviolet terkini tidak dapat diperoleh.';

  @override
  String get actionSunProtectionExtended =>
      'Gunakan perlindungan matahari apabila berada di luar untuk tempoh yang lama';

  @override
  String recommendationUvExposure(int uv) {
    return 'Pendedahan UV (Indeks $uv)';
  }

  @override
  String get uvBodyGood =>
      'Pendedahan UV adalah Rendah. Perlindungan minimum biasanya mencukupi.';

  @override
  String get uvBodyModerate =>
      'Pendedahan UV adalah Sederhana. Gunakan perlindungan matahari apabila berada di luar untuk tempoh yang lama.';

  @override
  String get uvBodyHigh =>
      'Pendedahan UV adalah Tinggi. Gunakan pelindung matahari, pakaian pelindung dan tempat teduh, terutamanya sekitar tengah hari.';

  @override
  String get uvBodyVeryHigh =>
      'Pendedahan UV adalah Sangat Tinggi. Kurangkan pendedahan terus kepada cahaya matahari sekitar tengah hari dan gunakan perlindungan matahari yang menyeluruh.';

  @override
  String get uvBodyExtreme =>
      'Pendedahan UV adalah Ekstrem. Elakkan pendedahan terus kepada cahaya matahari yang tidak perlu pada waktu puncak dan gunakan perlindungan yang menyeluruh.';

  @override
  String get actionBasicSunProtection =>
      'Gunakan perlindungan asas daripada matahari apabila berada di luar untuk tempoh yang lama';

  @override
  String get actionApplySunscreen =>
      'Sapukan pelindung matahari spektrum luas SPF 30+';

  @override
  String get actionWearSunglasses =>
      'Pakai cermin mata hitam semasa melakukan aktiviti luar yang berpanjangan';

  @override
  String get actionSeekShade => 'Berteduh apabila boleh';

  @override
  String get actionReapplySunscreen =>
      'Sapukan semula pelindung matahari mengikut arahan produk';

  @override
  String get actionWearHatSunglassesClothing =>
      'Pakai topi, cermin mata hitam dan pakaian pelindung';

  @override
  String get actionSeekMiddayShade => 'Berteduh pada waktu tengah hari';

  @override
  String get actionMinimiseMiddaySun =>
      'Kurangkan pendedahan terus kepada cahaya matahari sekitar tengah hari';

  @override
  String get actionWearProtectiveClothing =>
      'Pakai pakaian pelindung, topi dan cermin mata hitam';

  @override
  String get actionRegularlyReapplySunscreen =>
      'Sapukan dan sapukan semula pelindung matahari SPF 30+ secara berkala';

  @override
  String get actionTakeShadeBreaks =>
      'Berehat secara berkala di tempat teduh semasa bekerja di luar';

  @override
  String get actionAvoidMiddaySun =>
      'Elakkan pendedahan terus kepada cahaya matahari yang tidak perlu sekitar tengah hari';

  @override
  String get actionUseShadeProtectiveClothing =>
      'Gunakan tempat teduh dan pakaian pelindung';

  @override
  String get actionOutdoorWorkersShadeBreaks =>
      'Pekerja luar perlu kerap berehat di tempat teduh';

  @override
  String get recommendationHeavyRain => 'Amaran Hujan Lebat';

  @override
  String get heavyRainBodyOne =>
      'Satu stesen cuaca melaporkan hujan melebihi ambang hujan lebat yang ditetapkan. Banjir mungkin berlaku di kawasan yang terdedah atau rendah.';

  @override
  String heavyRainBodyMany(int count) {
    return '$count stesen cuaca melaporkan hujan melebihi ambang hujan lebat yang ditetapkan. Banjir mungkin berlaku di kawasan yang terdedah atau rendah.';
  }

  @override
  String get actionAvoidFloodWater =>
      'Elakkan memasuki air banjir yang mengalir atau dalam';

  @override
  String get actionCheckPubUpdates =>
      'Semak maklumat rasmi PUB mengenai banjir dan hujan lebat';

  @override
  String get actionAvoidFloodProneRoutes =>
      'Elakkan laluan yang mudah dilanda banjir atau kawasan rendah';

  @override
  String get actionKeepEmergencyDevices =>
      'Sediakan telefon yang dicas, lampu suluh dan bank kuasa';

  @override
  String get recommendationFavourable => 'Keadaan kelihatan baik';

  @override
  String get recommendationFavourableBody =>
      'Bacaan PSI dan UV yang tersedia kini berada dalam julat risiko lebih rendah dan tiada ambang hujan lebat dikesan.';

  @override
  String get actionContinueMonitoring => 'Terus pantau maklumat alam sekitar';

  @override
  String get actionReviewEmergencyKit =>
      'Semak kit kecemasan dan senarai semak kesiapsiagaan anda';

  @override
  String get actionCompletePreparednessActivity =>
      'Lengkapkan aktiviti kesiapsiagaan untuk mengekalkan kesedaran';

  @override
  String get psiGood => 'Baik';

  @override
  String get psiModerate => 'Sederhana';

  @override
  String get psiUnhealthy => 'Tidak Sihat';

  @override
  String get psiVeryUnhealthy => 'Sangat Tidak Sihat';

  @override
  String get psiHazardous => 'Berbahaya';

  @override
  String get todayTitle => 'Hari Ini';

  @override
  String get todayDescription =>
      'Lihat pelan kesiapsiagaan peribadi anda untuk hari ini.';

  @override
  String get todayPlanError =>
      'Tidak dapat menjana pelan kesiapsiagaan hari ini.';

  @override
  String get todayProgressError => 'Tidak dapat memuatkan kemajuan hari ini.';

  @override
  String get todayEnvironmentError =>
      'Tidak dapat menyediakan maklumat persekitaran hari ini.';

  @override
  String get completeTasksBeforeClaiming =>
      'Selesaikan semua tugasan sebelum menuntut XP anda.';

  @override
  String get claimTodayReward => 'Tuntut ganjaran hari ini?';

  @override
  String get claimRewardDescription =>
      'Pastikan anda berpuas hati dengan tindakan yang telah diselesaikan hari ini sebelum menuntut XP anda.';

  @override
  String get notYet => 'Belum lagi';

  @override
  String claimXp(int xp) {
    return 'Tuntut $xp XP';
  }

  @override
  String get planComplete => 'Pelan Selesai!';

  @override
  String get planCompleteDescription =>
      'Syabas kerana melengkapkan tindakan kesiapsiagaan hari ini.';

  @override
  String get awesome => 'Hebat!';

  @override
  String get personalisedForYou => 'Diperibadikan untuk anda';

  @override
  String get yourRoutine => 'RUTIN ANDA';

  @override
  String get todaysFocus => 'FOKUS HARI INI';

  @override
  String get moreTimeOutdoors => 'Anda meluangkan lebih banyak masa di luar';

  @override
  String get moderatelyActiveOutdoors => 'Anda sederhana aktif di luar';

  @override
  String get usuallyOutdoorsMidday =>
      'Biasanya berada di luar pada tengah hari';

  @override
  String get airQuality => 'Kualiti udara';

  @override
  String get heatSafety => 'Keselamatan haba';

  @override
  String get uvProtection => 'Perlindungan UV';

  @override
  String get todayPlanAdapts =>
      'Pelan hari ini disesuaikan mengikut rutin anda dan keadaan persekitaran semasa.';

  @override
  String get todaysActions => 'Tindakan hari ini';

  @override
  String get todaysActionsDescription =>
      'Lengkapkan tindakan yang disyorkan di bawah untuk meningkatkan kesiapsiagaan anda hari ini.';

  @override
  String get rewardClaimed => 'Ganjaran telah dituntut';

  @override
  String get completeOneMoreTask => 'Lengkapkan 1 lagi tugasan';

  @override
  String completeMoreTasks(int count) {
    return 'Lengkapkan $count lagi tugasan';
  }

  @override
  String get todaysConditions => 'Keadaan hari ini';

  @override
  String priority(String focus) {
    return 'Keutamaan: $focus';
  }

  @override
  String get whyThisPlan => 'Mengapa pelan ini?';

  @override
  String get heavyRain => 'Hujan lebat';

  @override
  String get focusRainPreparation => 'Persediaan hujan';

  @override
  String get focusAirQualitySunProtection =>
      'Kualiti udara & perlindungan matahari';

  @override
  String get focusAirQuality => 'Kualiti udara';

  @override
  String get focusSunProtection => 'Perlindungan matahari';

  @override
  String get focusGeneralPreparedness => 'Kesiapsiagaan umum';

  @override
  String get dailyPreparedness => 'Kesiapsiagaan harian';

  @override
  String allActionsCompleted(int total) {
    return 'Semua $total tindakan selesai';
  }

  @override
  String actionsCompleted(int completed, int total) {
    return '$completed daripada $total tindakan selesai';
  }

  @override
  String tasksLeft(int count) {
    return '$count lagi';
  }

  @override
  String counterProgress(int current, int target, String unit) {
    return '$current daripada $target $unit';
  }

  @override
  String get completed => 'selesai';

  @override
  String get missionRewardClaimedMessage =>
      'Ganjaran telah dituntut. Kembali esok untuk pelan kesiapsiagaan baharu.';

  @override
  String get missionCompleteMessage =>
      'Syabas. Ganjaran harian anda sedia untuk dituntut.';

  @override
  String get missionStartMessage =>
      'Mulakan dengan satu tindakan kecil untuk meningkatkan kesiapsiagaan hari ini.';

  @override
  String get missionGoodStartMessage =>
      'Permulaan yang baik. Teruskan dengan tindakan yang masih berbaki.';

  @override
  String get missionOneRemainingMessage =>
      'Hampir selesai. Hanya satu tindakan lagi.';

  @override
  String get missionRemainingMessage =>
      'Hampir selesai. Lengkapkan tindakan yang masih berbaki.';

  @override
  String get done => 'Selesai';

  @override
  String get noDailyMission =>
      'Tiada misi harian tersedia buat masa ini. Muat semula data persekitaran dan cuba lagi.';

  @override
  String get taskReviewConditionsTitle => 'Semak keadaan hari ini';

  @override
  String get taskReviewConditionsDescription =>
      'Semak PSI, Indeks UV, suhu dan keadaan hujan semasa sebelum merancang aktiviti luar.';

  @override
  String get taskReviewConditionsReason =>
      'Menyemak keadaan semasa membantu anda memilih langkah berjaga-jaga yang sesuai sebelum keluar.';

  @override
  String get taskMonitorAirQualityTitle => 'Pantau kualiti udara';

  @override
  String get taskMonitorAirQualityDescription =>
      'Semak PSI sekali lagi sebelum melakukan aktiviti luar yang berpanjangan, terutamanya jika anda sensitif terhadap jerebu.';

  @override
  String get taskMonitorAirQualityReason =>
      'PSI semasa menunjukkan bahawa langkah berjaga-jaga tambahan mungkin diperlukan, khususnya bagi individu yang lebih sensitif.';

  @override
  String get taskPackN95Title => 'Bawa pelitup N95';

  @override
  String get taskPackN95Description =>
      'Bawa pelitup N95 yang dipasang dengan betul jika aktiviti luar tidak dapat dielakkan.';

  @override
  String get taskPackN95Reason =>
      'Kualiti udara kini berada pada tahap tidak sihat dan perlindungan tambahan disyorkan semasa berada di luar.';

  @override
  String get taskReduceOutdoorExerciseTitle =>
      'Kurangkan aktiviti luar yang lasak';

  @override
  String get taskReduceOutdoorExerciseDescription =>
      'Pilih aktiviti yang lebih ringan atau aktiviti di dalam bangunan ketika kualiti udara tidak sihat.';

  @override
  String get taskReduceOutdoorExerciseReason =>
      'Aktiviti lasak meningkatkan kadar pernafasan dan boleh meningkatkan pendedahan kepada pencemar udara.';

  @override
  String get taskStayIndoorsHazeTitle => 'Kekal di dalam bangunan jika boleh';

  @override
  String get taskStayIndoorsHazeDescription =>
      'Tutup pintu dan tingkap serta kurangkan pendedahan di luar yang tidak perlu.';

  @override
  String get taskStayIndoorsHazeReason =>
      'Keadaan kualiti udara semasa menunjukkan risiko pendedahan yang tinggi di luar.';

  @override
  String get taskPrepareN95HazeTitle => 'Sediakan pelitup N95';

  @override
  String get taskPrepareN95HazeDescription =>
      'Gunakan pelitup N95 jika keluar rumah tidak dapat dielakkan.';

  @override
  String get taskPrepareN95HazeReason =>
      'Pelitup N95 boleh membantu mengurangkan pendedahan kepada zarah halus jerebu semasa kualiti udara kurang baik.';

  @override
  String get taskCheckHazeSymptomsTitle => 'Pantau kesihatan anda';

  @override
  String get taskCheckHazeSymptomsDescription =>
      'Perhatikan kesukaran bernafas, batuk atau kerengsaan mata.';

  @override
  String get taskCheckHazeSymptomsReason =>
      'Kualiti udara yang sangat buruk boleh menjejaskan keselesaan pernafasan dan menyebabkan gejala kesihatan lain.';

  @override
  String get taskApplySunscreenTitle => 'Sapukan pelindung matahari';

  @override
  String get taskApplySunscreenDescription =>
      'Sapukan pelindung matahari spektrum luas SPF 30+ sebelum keluar.';

  @override
  String get taskApplySunscreenReason =>
      'Tahap UV hari ini menunjukkan bahawa perlindungan matahari disyorkan sebelum melakukan aktiviti luar.';

  @override
  String get taskSeekMiddayShadeTitle => 'Berteduh sekitar tengah hari';

  @override
  String get taskSeekMiddayShadeDescription =>
      'Kurangkan pendedahan terus kepada cahaya matahari ketika UV paling kuat.';

  @override
  String get taskSeekMiddayShadeReason =>
      'Pendedahan UV biasanya lebih kuat sekitar tengah hari, jadi berteduh merupakan langkah perlindungan yang berkesan.';

  @override
  String get taskReapplySunscreenTitle => 'Sapukan semula pelindung matahari';

  @override
  String get taskReapplySunscreenDescription =>
      'Sapukan semula pelindung matahari mengikut arahan produk, terutamanya selepas berpeluh.';

  @override
  String get taskReapplySunscreenReason =>
      'Pendedahan UV yang sangat tinggi mungkin memerlukan perlindungan berterusan semasa berada di luar untuk tempoh yang lama.';

  @override
  String get taskWearSunProtectionTitle => 'Gunakan perlindungan matahari';

  @override
  String get taskWearSunProtectionDescription =>
      'Bawa topi, cermin mata hitam dan pakaian pelindung.';

  @override
  String get taskWearSunProtectionReason =>
      'Perlindungan fizikal tambahan membantu mengurangkan pendedahan terus UV pada kulit dan mata.';

  @override
  String get taskAvoidMiddaySunTitle =>
      'Elakkan matahari tengah hari yang berpanjangan';

  @override
  String get taskAvoidMiddaySunDescription =>
      'Alihkan rancangan aktiviti luar yang lasak daripada waktu UV paling kuat.';

  @override
  String get taskAvoidMiddaySunReason =>
      'Tahap UV yang sangat tinggi menjadikan pendedahan berpanjangan sekitar tengah hari kurang sesuai.';

  @override
  String get taskCarryWaterHeatTitle => 'Bawa air bersama anda';

  @override
  String get taskCarryWaterHeatDescription =>
      'Pastikan air tersedia jika anda akan meluangkan masa di luar.';

  @override
  String get taskCarryWaterHeatReason =>
      'Keadaan WBGT semasa menunjukkan tekanan haba Sederhana.';

  @override
  String get taskHydrationGoalHeatTitle => 'Jejaki pengambilan air anda';

  @override
  String get taskHydrationGoalHeatDescription =>
      'Catat enam gelas air sepanjang hari.';

  @override
  String get taskHydrationGoalHeatReason =>
      'Keadaan WBGT semasa menunjukkan tekanan haba Tinggi.';

  @override
  String get taskCoolingBreakHeatTitle => 'Ambil rehat untuk menyejukkan badan';

  @override
  String get taskCoolingBreakHeatDescription =>
      'Berehat secara berkala di kawasan teduh, mempunyai pengudaraan atau berhawa dingin.';

  @override
  String get taskCoolingBreakHeatReason =>
      'Keadaan tekanan haba yang tinggi meningkatkan keperluan untuk berehat dan menyejukkan badan.';

  @override
  String get taskReduceOutdoorHeatTitle => 'Kurangkan aktiviti luar yang lasak';

  @override
  String get taskReduceOutdoorHeatDescription =>
      'Pilih aktiviti yang lebih ringan atau pindahkan aktiviti lasak ke waktu yang lebih sejuk.';

  @override
  String get taskReduceOutdoorHeatReason =>
      'Keadaan WBGT semasa menunjukkan tekanan haba Tinggi.';

  @override
  String get taskRainPreparationTitle => 'Bersedia untuk hujan lebat';

  @override
  String get taskRainPreparationDescription =>
      'Lengkapkan langkah penting sebelum melakukan perjalanan ketika hujan lebat.';

  @override
  String get taskRainPreparationReason =>
      'Hujan lebat telah dikesan dan mungkin menjejaskan perjalanan, risiko banjir serta akses kepada kemas kini cuaca.';

  @override
  String get estimatedOneMinute => '1 minit';

  @override
  String get estimatedThirtySeconds => '30 saat';

  @override
  String get estimatedThroughoutDay => 'Sepanjang hari';

  @override
  String get estimatedPlanToday => 'Rancang untuk hari ini';

  @override
  String get estimatedTwoThreeMinutes => '2–3 minit';

  @override
  String get unitSteps => 'langkah';

  @override
  String get unitGlasses => 'gelas';

  @override
  String get undo => 'Buat asal';

  @override
  String get complete => 'Selesai';

  @override
  String hydrationProgress(int current, int target) {
    return '$current daripada $target gelas';
  }

  @override
  String get undoLastGlass => 'Batalkan gelas terakhir';

  @override
  String get hydrationComplete => 'Hidrasi selesai';

  @override
  String get iDrankAGlass => 'Saya minum segelas air';

  @override
  String get hydrationGoalComplete => 'Matlamat hidrasi selesai!';

  @override
  String xpWhenPlanClaimed(int xp) {
    return '+$xp XP apabila pelan hari ini dituntut';
  }

  @override
  String get sunscreenApplied => 'Pelindung matahari telah disapu';

  @override
  String coveragePercent(int percent) {
    return '$percent% selesai';
  }

  @override
  String get applySunscreenButton => 'Sapukan pelindung matahari';

  @override
  String rainStepsReady(int current, int target) {
    return '$current daripada $target langkah telah siap';
  }

  @override
  String rainReadyProgress(int current, int target) {
    return '$current daripada $target telah siap';
  }

  @override
  String get undoLastStep => 'Batalkan langkah terakhir';

  @override
  String get packUmbrella => 'Bawa payung';

  @override
  String get checkFloodAlerts => 'Semak amaran banjir';

  @override
  String get reviewYourRoute => 'Semak laluan anda';

  @override
  String get chargePowerBank => 'Cas bank kuasa anda';

  @override
  String get rainPrepComplete => 'Persediaan hujan selesai';

  @override
  String get completeNextStep => 'Lengkapkan langkah seterusnya';

  @override
  String get missionGoodMorning => 'Selamat pagi';

  @override
  String get missionGoodAfternoon => 'Selamat petang';

  @override
  String get missionGoodEvening => 'Selamat malam';

  @override
  String get missionRainTitle => 'Persediaan menghadapi hujan disyorkan';

  @override
  String get missionRainMessage =>
      'Hujan lebat mungkin menjejaskan perjalanan dan rancangan aktiviti luar. Semak tindakan keselamatan berkaitan hujan dan banjir untuk hari ini.';

  @override
  String get missionHeatUvTitle =>
      'Langkah berjaga-jaga terhadap haba dan UV disyorkan';

  @override
  String get missionHeatUvMessage =>
      'Tekanan haba dan pendedahan UV mungkin menjejaskan aktiviti luar hari ini. Kekal terhidrat, gunakan perlindungan matahari dan berehat secara berkala di tempat yang sejuk.';

  @override
  String get missionHeatTitle => 'Langkah berjaga-jaga terhadap haba disyorkan';

  @override
  String get missionHeatMessage =>
      'Tekanan haba meningkat hari ini. Kekal terhidrat, berehat di tempat yang sejuk dan kurangkan aktiviti luar yang lasak jika boleh.';

  @override
  String get missionHazeUvTitle =>
      'Langkah berjaga-jaga terhadap kualiti udara dan UV disyorkan';

  @override
  String get missionHazeUvMessage =>
      'Semak kualiti udara dan langkah perlindungan matahari sebelum meluangkan masa di luar.';

  @override
  String get missionHazeTitle =>
      'Langkah berjaga-jaga terhadap kualiti udara disyorkan';

  @override
  String get missionHazeMessage =>
      'Pantau PSI dan sesuaikan aktiviti luar yang berpanjangan jika perlu.';

  @override
  String get missionUvTitle => 'Perlindungan UV disyorkan';

  @override
  String get missionUvMessage =>
      'Perlindungan matahari dan pengambilan air yang mencukupi mungkin penting untuk aktiviti luar hari ini.';

  @override
  String get missionGeneralTitle => 'Keadaan secara umumnya terkawal';

  @override
  String get missionGeneralMessage =>
      'Semak bacaan hari ini dan lengkapkan tindakan asas kesiapsiagaan.';

  @override
  String get riskUnknown => 'Tidak diketahui';

  @override
  String get riskNoData => 'Tiada data';

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
    return 'Tekanan haba · $label';
  }

  @override
  String get taskApplySunscreenModerateDescription =>
      'Sapukan pelindung matahari spektrum luas SPF 30+ sebelum melakukan aktiviti luar yang berpanjangan.';

  @override
  String get taskApplySunscreenModerateReason =>
      'Tahap UV hari ini menunjukkan bahawa perlindungan matahari disyorkan apabila berada di luar untuk tempoh yang lama.';

  @override
  String get taskApplySunscreenHighDescription =>
      'Sapukan pelindung matahari spektrum luas SPF 30+ sebelum keluar.';

  @override
  String get taskApplySunscreenHighReason =>
      'Indeks UV tinggi hari ini, jadi perlindungan matahari disyorkan sebelum melakukan aktiviti luar.';

  @override
  String get taskApplySunscreenVeryHighDescription =>
      'Sapukan pelindung matahari spektrum luas SPF 30+ sebelum keluar.';

  @override
  String get taskApplySunscreenVeryHighReason =>
      'Tahap UV hari ini menunjukkan bahawa perlindungan matahari yang lebih menyeluruh disyorkan sebelum keluar.';

  @override
  String get exploreTitle => 'Terokai Singapura';

  @override
  String get exploreDescription =>
      'Terokai keadaan persekitaran di seluruh Singapura.';

  @override
  String get exploreHeat => 'Haba';

  @override
  String get explorePsi => 'PSI';

  @override
  String get exploreRain => 'Hujan';

  @override
  String get exploreFindNearMe => 'Cari keadaan berhampiran saya';

  @override
  String get exploreTapMarker => 'Ketik penanda untuk melihat butiran';

  @override
  String get exploreLow => 'Rendah';

  @override
  String get exploreModerate => 'Sederhana';

  @override
  String get exploreHigh => 'Tinggi';

  @override
  String get exploreHeatStress => 'Tekanan Haba';

  @override
  String exploreWbgtStationsReporting(int count) {
    return '$count stesen WBGT sedang melaporkan';
  }

  @override
  String get exploreHighestObserved => 'Bacaan tertinggi';

  @override
  String get exploreForYou => 'Untuk anda: ';

  @override
  String get exploreHeatAdvice =>
      'Kekal terhidrat dan berehat secara berkala untuk menyejukkan badan.';

  @override
  String get exploreUnableLoadHeat =>
      'Tidak dapat memuatkan data tekanan haba.';

  @override
  String get exploreNoWbgtObservations =>
      'Tiada pemerhatian WBGT semasa tersedia.';

  @override
  String get exploreHeatStressLabel => 'Tekanan haba';

  @override
  String get exploreRegion => 'Wilayah';

  @override
  String get exploreLatestStationReading =>
      'Bacaan stesen terkini yang diperhatikan';

  @override
  String exploreMetresAway(int distance) {
    return '$distance m dari anda';
  }

  @override
  String exploreKilometresAway(String distance) {
    return '$distance km dari anda';
  }

  @override
  String get exploreUnableLoadPsi => 'Tidak dapat memuatkan data PSI.';

  @override
  String get exploreNoRegionalPsi =>
      'Tiada bacaan PSI serantau semasa tersedia.';

  @override
  String get exploreAirQuality => 'Kualiti Udara';

  @override
  String get exploreSingaporeRegionalPsi => 'PSI serantau Singapura';

  @override
  String get exploreBasedOnLocation => 'Berdasarkan anggaran lokasi anda';

  @override
  String get exploreAirQualityLabel => 'Kualiti udara';

  @override
  String get explorePsiAdviceGood =>
      'Kualiti udara adalah baik. Aktiviti biasa boleh diteruskan.';

  @override
  String get explorePsiAdviceModerate =>
      'Kualiti udara berada pada tahap sederhana. Aktiviti biasa secara amnya boleh diteruskan.';

  @override
  String get explorePsiAdviceUnhealthy =>
      'Kualiti udara tidak sihat. Pertimbangkan untuk mengurangkan aktiviti luar yang berpanjangan atau lasak.';

  @override
  String get explorePsiAdviceVeryUnhealthy =>
      'Kualiti udara sangat tidak sihat. Kurangkan aktiviti luar yang berpanjangan.';

  @override
  String get explorePsiAdviceHazardous =>
      'Kualiti udara berada pada tahap berbahaya. Elakkan aktiviti luar yang tidak perlu.';

  @override
  String get exploreUnableLoadRain => 'Tidak dapat memuatkan data hujan.';

  @override
  String get exploreNoRainfall => 'Tiada hujan dikesan';

  @override
  String get exploreNoRainfallDescription =>
      'Tiada hujan sedang direkodkan di stesen pelaporan di seluruh Singapura.';

  @override
  String get exploreRainfall => 'Hujan';

  @override
  String exploreStationsReportingRain(int count) {
    return '$count stesen sedang melaporkan hujan';
  }

  @override
  String get exploreRainLight => 'Ringan';

  @override
  String get exploreRainModerate => 'Sederhana';

  @override
  String get exploreRainHeavy => 'Lebat';

  @override
  String get exploreRainAdviceLight => 'Bawa payung jika anda hendak keluar.';

  @override
  String get exploreRainAdviceModerate =>
      'Bawa payung dan berhati-hati di laluan serta jalan yang basah.';

  @override
  String get exploreRainAdviceHeavy =>
      'Elakkan kawasan yang mudah dilanda banjir dan semak laluan anda sebelum bergerak.';

  @override
  String get exploreRainIntensity => 'Keamatan';

  @override
  String get exploreLatestRainfallReading =>
      'Bacaan hujan terkini yang diperhatikan';

  @override
  String get exploreLocationAccessNeeded =>
      'Akses lokasi diperlukan untuk mencari keadaan berhampiran anda.';

  @override
  String get exploreNoRainfallStations =>
      'Tiada stesen hujan tersedia pada masa ini.';

  @override
  String get exploreNoRegionalPsiNearby =>
      'Tiada bacaan PSI serantau tersedia pada masa ini.';

  @override
  String get exploreUnableFindPsiArea =>
      'Tidak dapat mencari bacaan PSI untuk kawasan anda.';

  @override
  String get exploreNoWbgtStations =>
      'Tiada stesen WBGT tersedia pada masa ini.';

  @override
  String get exploreUnableFindNearby =>
      'Tidak dapat mencari keadaan berhampiran.';

  @override
  String get learnTitle => 'Belajar & Bersedia';

  @override
  String get learnDescription =>
      'Tingkatkan pengetahuan dan kemahiran kesiapsiagaan anda.';

  @override
  String get learnEmergencyHelp => 'Bantuan Kecemasan';

  @override
  String get learnEmergencyHelpDescription =>
      'Nombor penting kecemasan Singapura dan bila anda perlu menggunakannya.';

  @override
  String get learnTabMyKit => 'Kit Saya';

  @override
  String get learnTabQuizzes => 'Kuiz';

  @override
  String get learnTabScenarios => 'Senario';

  @override
  String get learnMyEmergencyKit => 'Kit Kecemasan Saya';

  @override
  String get learnEmergencyKitDescription =>
      'Sediakan kit kecemasan anda langkah demi langkah.';

  @override
  String get learnQuickSkills => 'Kemahiran Pantas';

  @override
  String get learnLearnInMinutes => 'Belajar dalam beberapa minit';

  @override
  String get learnCprAed => 'CPR & AED';

  @override
  String get learnLifeSavingBasics => 'Asas menyelamatkan nyawa';

  @override
  String get learnVideoGuide => 'Panduan video';

  @override
  String get learnFlashFloodSafety => 'Keselamatan Banjir Kilat';

  @override
  String get learnHeavyRainFloodSafety => 'Keselamatan hujan lebat & banjir';

  @override
  String get learnQuickGuide => 'Panduan ringkas';

  @override
  String get learnPreparednessCategories => 'Kategori Kesiapsiagaan';

  @override
  String learnKitReady(int percentage) {
    return '$percentage% Bersedia';
  }

  @override
  String get learnKitComplete =>
      'Senarai semak kesiapsiagaan anda telah lengkap.';

  @override
  String learnKitItemsRemaining(int count) {
    return '$count item masih belum selesai.';
  }

  @override
  String get learnKitStatusEmergencyReady => 'Sedia Menghadapi Kecemasan';

  @override
  String get learnKitStatusWellPrepared => 'Bersedia Dengan Baik';

  @override
  String get learnKitStatusGettingPrepared => 'Sedang Bersedia';

  @override
  String get learnKitStatusBasicPreparation => 'Persediaan Asas';

  @override
  String get learnKitStatusNeedsAttention => 'Perlu Perhatian';

  @override
  String get learnKitProgressError =>
      'Tidak dapat memuatkan kemajuan kit kecemasan anda.';

  @override
  String get learnRecommendedComplete =>
      'Anda sudah mempunyai item yang disyorkan untuk keadaan hari ini.';

  @override
  String get learnRecommendedToday => 'Disyorkan Hari Ini';

  @override
  String get learnRecommendedBasedOnConditions =>
      'Berdasarkan keadaan persekitaran semasa:';

  @override
  String get learnCategoryHaze => 'Jerebu';

  @override
  String get learnCategoryUv => 'UV';

  @override
  String get learnCategoryHeat => 'Haba';

  @override
  String get learnCategoryFlood => 'Banjir';

  @override
  String learnCategoryProgress(int completed, int total, int percentage) {
    return '$completed daripada $total selesai · $percentage%';
  }

  @override
  String learnItemAddedMessage(String item) {
    return '$item telah ditambah.';
  }

  @override
  String learnItemRemovedMessage(String item) {
    return '$item telah dibuang.';
  }

  @override
  String get learnItemUpdateError =>
      'Tidak dapat mengemas kini item. Sila cuba lagi.';

  @override
  String get learnAdded => 'Ditambah';

  @override
  String get learnAdd => 'Tambah';

  @override
  String get learnWhyThisMatters => 'Mengapa ini penting';

  @override
  String learnAddedXp(int points) {
    return 'Ditambah · +$points XP';
  }

  @override
  String learnXp(int points) {
    return '+$points XP';
  }

  @override
  String learnEarnXpWhenAdded(int points) {
    return 'Dapatkan $points XP apabila ditambah.';
  }

  @override
  String get kitHazeMaskTitle => 'Pelitup N95';

  @override
  String get kitHazeMaskDescription => 'Simpan di rumah & dalam beg anda';

  @override
  String get kitHazeMaskExplanation =>
      'Pelitup N95 yang dipakai dengan betul boleh mengurangkan pendedahan kepada zarah halus jerebu apabila aktiviti luar tidak dapat dielakkan.';

  @override
  String get kitHazeMedsTitle => 'Ubat alahan';

  @override
  String get kitHazeMedsDescription => 'Simpan berdekatan jika diperlukan';

  @override
  String get kitHazeMedsExplanation =>
      'Sediakan alat sedut atau ubat alahan yang dipreskripsi jika kualiti udara yang buruk menjejaskan anda.';

  @override
  String get kitUvSunscreenTitle => 'Pelindung matahari SPF 30+';

  @override
  String get kitUvSunscreenDescription =>
      'Lindungi kulit yang terdedah di luar';

  @override
  String get kitUvSunscreenExplanation =>
      'Pelindung matahari spektrum luas SPF 30+ membantu melindungi kulit yang terdedah daripada sinaran ultraungu.';

  @override
  String get kitUvHatTitle => 'Topi & cermin mata hitam';

  @override
  String get kitUvHatDescription => 'Perlindungan tambahan daripada UV tinggi';

  @override
  String get kitUvHatExplanation =>
      'Topi dan cermin mata hitam memberikan perlindungan tambahan ketika pendedahan UV tinggi.';

  @override
  String get kitHeatWaterTitle => 'Air minuman';

  @override
  String get kitHeatWaterDescription => 'Kekal terhidrat dalam cuaca panas';

  @override
  String get kitHeatWaterExplanation =>
      'Membawa air tambahan membantu mengurangkan risiko dehidrasi dan penyakit berkaitan haba.';

  @override
  String get kitFloodBagTitle => 'Lampu suluh & bank kuasa';

  @override
  String get kitFloodBagDescription =>
      'Berguna semasa hujan lebat atau gangguan bekalan';

  @override
  String get kitFloodBagExplanation =>
      'Lampu suluh dan bank kuasa yang dicas berguna semasa gangguan bekalan elektrik dan hujan lebat.';

  @override
  String get kitFloodAlertsTitle => 'Amaran banjir';

  @override
  String get kitFloodAlertsDescription => 'Ikuti perkembangan kawasan terjejas';

  @override
  String get kitFloodAlertsExplanation =>
      'Saluran amaran rasmi menyediakan maklumat terkini mengenai hujan dan lokasi yang terjejas.';

  @override
  String get kitFloodRouteTitle => 'Laluan alternatif';

  @override
  String get kitFloodRouteDescription =>
      'Elakkan jalan yang mudah dilanda banjir';

  @override
  String get kitFloodRouteExplanation =>
      'Mengetahui laluan alternatif membantu anda mengelakkan jalan di kawasan rendah dan kawasan yang mudah dilanda banjir.';

  @override
  String get kitDefaultDescription => 'Keperluan kesiapsiagaan';

  @override
  String get kitDefaultExplanation =>
      'Item ini menyokong kesiapsiagaan persekitaran anda secara keseluruhan.';

  @override
  String get learnKnowledgeQuizzes => 'Kuiz Pengetahuan';

  @override
  String get learnKnowledgeQuizzesDescription =>
      'Uji pengetahuan anda dan pelajari cara bertindak balas terhadap bahaya alam sekitar.';

  @override
  String get learnQuizProgress => 'Kemajuan Kuiz';

  @override
  String get learnAllQuizQuestionsCompleted =>
      'Semua soalan kuiz telah selesai.';

  @override
  String learnQuizQuestionsRemaining(int count) {
    return '$count soalan berbaki.';
  }

  @override
  String learnQuizTopicTitle(String topic) {
    return 'Persediaan $topic';
  }

  @override
  String get learnCompleted => 'Selesai';

  @override
  String learnQuizQuestionsCompleted(int completed, int total) {
    return '$completed daripada $total soalan selesai';
  }

  @override
  String learnQuizTitle(String topic) {
    return 'Kuiz $topic';
  }

  @override
  String learnQuizQuestionProgress(int current, int total) {
    return 'Soalan $current daripada $total';
  }

  @override
  String get learnQuizCheckAnswer => 'Semak jawapan';

  @override
  String get learnQuizNextQuestion => 'Soalan seterusnya';

  @override
  String get learnQuizViewResults => 'Lihat keputusan';

  @override
  String get learnQuizComplete => 'Kuiz selesai';

  @override
  String learnQuizScore(int score, int total) {
    return 'Anda mendapat $score daripada $total.';
  }

  @override
  String get learnQuizPreviouslyCompleted =>
      'Kuiz ini telah diselesaikan sebelum ini. Tiada XP tambahan diberikan.';

  @override
  String learnQuizXpEarned(int points) {
    return '+$points XP diperoleh';
  }

  @override
  String get learnQuizContinue => 'Teruskan';

  @override
  String get learnQuizSaveError =>
      'Kemajuan kuiz tidak dapat disimpan. Sila cuba lagi.';

  @override
  String get learnQuizResultExcellent =>
      'Syabas! Anda telah menguasai topik ini.';

  @override
  String get learnQuizResultGood =>
      'Usaha yang baik. Semak penerangan untuk mengukuhkan pengetahuan anda.';

  @override
  String get learnQuizResultKeepLearning =>
      'Teruskan belajar. Anda boleh mengulangi kuiz untuk mengulang kaji topik ini.';

  @override
  String get learnQuizNoAdditionalXp => 'Tiada XP tambahan diberikan.';

  @override
  String get quizHaze1Question =>
      'Apabila PSI 24 jam memasuki julat Tidak Sihat, apakah yang patut dikurangkan oleh individu yang sihat?';

  @override
  String get quizHaze1Option1 => 'Minum air';

  @override
  String get quizHaze1Option2 => 'Aktiviti luar yang berpanjangan atau lasak';

  @override
  String get quizHaze1Option3 => 'Aktiviti dalam bangunan';

  @override
  String get quizHaze1Option4 => 'Tidur';

  @override
  String get quizHaze1Explanation =>
      'Apabila kualiti udara memasuki julat Tidak Sihat, aktiviti luar yang berpanjangan atau lasak patut dikurangkan.';

  @override
  String get quizHaze2Question =>
      'Topeng manakah yang direka untuk menapis zarah halus jerebu?';

  @override
  String get quizHaze2Option1 => 'Topeng pembedahan';

  @override
  String get quizHaze2Option2 => 'Respirator N95';

  @override
  String get quizHaze2Option3 => 'Topeng kain';

  @override
  String get quizHaze2Option4 => 'Topeng tidak diperlukan';

  @override
  String get quizHaze2Explanation =>
      'Respirator N95 yang dipakai dengan betul direka untuk menapis zarah halus dengan lebih berkesan berbanding topeng pembedahan atau kain.';

  @override
  String get quizHaze3Question =>
      'Mengapakah anda perlu memeriksa keadaan kualiti udara sebelum melakukan aktiviti luar yang berpanjangan semasa jerebu?';

  @override
  String get quizHaze3Option1 => 'Kualiti udara boleh berubah sepanjang hari';

  @override
  String get quizHaze3Option2 => 'PSI hanya mengukur suhu';

  @override
  String get quizHaze3Option3 => 'Jerebu hanya menjejaskan jarak penglihatan';

  @override
  String get quizHaze3Option4 => 'Aktiviti luar meningkatkan kualiti udara';

  @override
  String get quizHaze3Explanation =>
      'Kualiti udara boleh berubah, jadi memeriksa keadaan semasa membantu anda menentukan sama ada aktiviti luar yang berpanjangan perlu disesuaikan.';

  @override
  String get quizHaze4Question =>
      'Apakah cara yang munasabah untuk mengurangkan pendedahan kepada jerebu apabila kualiti udara merosot?';

  @override
  String get quizHaze4Option1 => 'Luangkan lebih banyak masa di luar';

  @override
  String get quizHaze4Option2 => 'Tingkatkan senaman luar yang lasak';

  @override
  String get quizHaze4Option3 =>
      'Kurangkan pendedahan luar yang berpanjangan dan tidak perlu';

  @override
  String get quizHaze4Option4 =>
      'Teruskan semua rancangan luar tanpa perubahan';

  @override
  String get quizHaze4Explanation =>
      'Mengurangkan pendedahan luar yang berpanjangan dan tidak perlu dapat membantu mengehadkan pendedahan apabila kualiti udara merosot.';

  @override
  String get quizHaze5Question =>
      'Jika anda masih perlu keluar semasa keadaan berjerebu, apakah yang patut anda terus lakukan?';

  @override
  String get quizHaze5Option1 => 'Abaikan kemas kini kualiti udara seterusnya';

  @override
  String get quizHaze5Option2 =>
      'Pantau maklumat kualiti udara semasa dan nasihat yang berkaitan';

  @override
  String get quizHaze5Option3 => 'Anggap keadaan akan kekal sama';

  @override
  String get quizHaze5Option4 =>
      'Berada di luar lebih lama untuk menyesuaikan diri dengan jerebu';

  @override
  String get quizHaze5Explanation =>
      'Terus pantau maklumat kualiti udara semasa kerana keadaan dan saranan berkaitan mungkin berubah.';

  @override
  String get quizUv1Question =>
      'Indeks UV 8–10 termasuk dalam kategori yang mana?';

  @override
  String get quizUv1Option1 => 'Rendah';

  @override
  String get quizUv1Option2 => 'Sederhana';

  @override
  String get quizUv1Option3 => 'Sangat Tinggi';

  @override
  String get quizUv1Option4 => 'Ekstrem';

  @override
  String get quizUv1Explanation =>
      'Indeks UV 8–10 dikategorikan sebagai Sangat Tinggi dan memerlukan perlindungan matahari yang kuat.';

  @override
  String get quizUv2Question =>
      'Bilakah pendedahan UV biasanya paling kuat di Singapura?';

  @override
  String get quizUv2Option1 => 'Awal pagi';

  @override
  String get quizUv2Option2 => 'Sekitar tengah hari';

  @override
  String get quizUv2Option3 => 'Petang';

  @override
  String get quizUv2Option4 => 'Malam';

  @override
  String get quizUv2Explanation =>
      'Sinaran UV biasanya paling kuat sekitar tengah hari, jadi perlindungan tambahan adalah penting dalam tempoh ini.';

  @override
  String get quizUv3Question =>
      'Apakah cara yang baik untuk mengurangkan pendedahan UV ketika berada di luar?';

  @override
  String get quizUv3Option1 => 'Berteduh apabila boleh';

  @override
  String get quizUv3Option2 =>
      'Berada lebih lama di bawah cahaya matahari langsung';

  @override
  String get quizUv3Option3 => 'Hanya melindungi diri apabila terasa panas';

  @override
  String get quizUv3Option4 => 'Elakkan minum air';

  @override
  String get quizUv3Explanation =>
      'Berteduh apabila boleh dapat membantu mengurangkan pendedahan langsung kepada sinaran ultraungu ketika berada di luar.';

  @override
  String get quizUv4Question =>
      'Gabungan manakah memberikan perlindungan yang lebih baik apabila tahap UV tinggi?';

  @override
  String get quizUv4Option1 =>
      'Pelindung matahari, pakaian yang sesuai dan tempat teduh';

  @override
  String get quizUv4Option2 => 'Minum air sahaja';

  @override
  String get quizUv4Option3 => 'Topeng pembedahan dan sarung tangan';

  @override
  String get quizUv4Option4 => 'Berada di bawah cahaya matahari langsung';

  @override
  String get quizUv4Explanation =>
      'Menggunakan beberapa bentuk perlindungan matahari, termasuk pelindung matahari, pakaian yang sesuai dan tempat teduh, membantu mengurangkan pendedahan UV.';

  @override
  String get quizUv5Question =>
      'Mengapakah anda masih perlu mempertimbangkan perlindungan UV pada hari yang mendung?';

  @override
  String get quizUv5Option1 =>
      'Sinaran UV masih boleh sampai kepada anda melalui litupan awan';

  @override
  String get quizUv5Option2 => 'Awan sentiasa meningkatkan Indeks UV';

  @override
  String get quizUv5Option3 => 'Sinaran UV hanya wujud apabila hujan';

  @override
  String get quizUv5Option4 =>
      'Perlindungan matahari hanya diperlukan pada hari yang cerah';

  @override
  String get quizUv5Explanation =>
      'Litupan awan tidak menghalang sinaran ultraungu sepenuhnya, jadi perlindungan UV mungkin masih diperlukan.';

  @override
  String get quizHeat1Question =>
      'Apakah salah satu cara paling penting untuk mengurangkan tekanan haba semasa aktiviti luar yang berpanjangan?';

  @override
  String get quizHeat1Option1 =>
      'Ambil rehat secara berkala untuk minum air dan menyejukkan badan';

  @override
  String get quizHeat1Option2 => 'Elakkan minum air sehingga berasa dahaga';

  @override
  String get quizHeat1Option3 => 'Pakai pakaian yang lebih tebal';

  @override
  String get quizHeat1Option4 =>
      'Kekal di bawah cahaya matahari langsung secara berterusan';

  @override
  String get quizHeat1Explanation =>
      'Minum air dan mengambil rehat untuk menyejukkan badan secara berkala dapat membantu mengurangkan tekanan haba semasa aktiviti luar yang berpanjangan.';

  @override
  String get quizHeat2Question =>
      'Jika anda mula berasa sangat panas semasa melakukan aktiviti luar, apakah tindakan yang lebih selamat?';

  @override
  String get quizHeat2Option1 => 'Teruskan tanpa berhenti';

  @override
  String get quizHeat2Option2 =>
      'Pergi ke kawasan yang teduh atau lebih sejuk dan berehat';

  @override
  String get quizHeat2Option3 =>
      'Bersenam dengan lebih kuat supaya selesai lebih cepat';

  @override
  String get quizHeat2Option4 => 'Elakkan minum air';

  @override
  String get quizHeat2Explanation =>
      'Berehat di kawasan yang teduh atau lebih sejuk membantu mengurangkan pendedahan berterusan kepada haba dan memberi peluang kepada badan untuk menyejuk.';

  @override
  String get quizHeat3Question =>
      'Mengapakah penghidratan penting semasa cuaca panas?';

  @override
  String get quizHeat3Option1 =>
      'Ia membantu menggantikan cecair yang hilang melalui peluh';

  @override
  String get quizHeat3Option2 => 'Ia meningkatkan pendedahan kepada haba';

  @override
  String get quizHeat3Option3 => 'Ia menghapuskan keperluan untuk berehat';

  @override
  String get quizHeat3Option4 => 'Ia mencegah semua penyakit berkaitan haba';

  @override
  String get quizHeat3Explanation =>
      'Minum air membantu menggantikan cecair yang hilang melalui peluh dan membantu mengekalkan penghidratan semasa keadaan panas.';

  @override
  String get quizHeat4Question =>
      'Apakah yang patut anda lakukan sebelum merancang aktiviti luar yang berpanjangan pada hari yang sangat panas?';

  @override
  String get quizHeat4Option1 =>
      'Periksa keadaan haba semasa dan rancang langkah berjaga-jaga yang sesuai';

  @override
  String get quizHeat4Option2 => 'Abaikan keadaan jika langit cerah';

  @override
  String get quizHeat4Option3 => 'Elakkan membawa air minuman';

  @override
  String get quizHeat4Option4 => 'Pakai lebih banyak lapisan pakaian tebal';

  @override
  String get quizHeat4Explanation =>
      'Memeriksa keadaan haba semasa membantu anda merancang penghidratan, rehat untuk menyejukkan badan dan langkah berjaga-jaga lain sebelum aktiviti luar yang berpanjangan.';

  @override
  String get quizHeat5Question =>
      'Jika keadaan panas berterusan sepanjang hari, apakah yang patut anda lakukan?';

  @override
  String get quizHeat5Option1 =>
      'Anggap keadaan akan bertambah baik secara automatik';

  @override
  String get quizHeat5Option2 =>
      'Teruskan semua rancangan luar tanpa perubahan';

  @override
  String get quizHeat5Option3 =>
      'Terus pantau keadaan dan sesuaikan rancangan apabila perlu';

  @override
  String get quizHeat5Option4 =>
      'Berhenti minum air supaya anda kurang perlu berehat';

  @override
  String get quizHeat5Explanation =>
      'Keadaan haba boleh berubah sepanjang hari, jadi terus pantau keadaan dan sesuaikan aktiviti luar yang berpanjangan apabila perlu.';

  @override
  String get quizFlood1Question =>
      'Apakah yang patut anda lakukan jika jalan di hadapan diliputi air banjir dan anda tidak dapat menentukan kedalamannya?';

  @override
  String get quizFlood1Option1 => 'Pandu perlahan-lahan melalui air banjir';

  @override
  String get quizFlood1Option2 => 'Berpatah balik dan gunakan laluan lain';

  @override
  String get quizFlood1Option3 => 'Berhenti di bahagian jalan yang dinaiki air';

  @override
  String get quizFlood1Option4 => 'Pandu dengan cepat sebelum air meningkat';

  @override
  String get quizFlood1Explanation =>
      'Elakkan memasuki air banjir apabila kedalaman dan keadaannya tidak dapat dipastikan. Berpatah balik dan menggunakan laluan alternatif yang lebih selamat dapat mengurangkan risiko.';

  @override
  String get quizFlood2Question =>
      'Apakah yang patut anda lakukan sebelum memilih laluan alternatif semasa banjir kilat?';

  @override
  String get quizFlood2Option1 =>
      'Semak maklumat banjir dan keadaan jalan semasa';

  @override
  String get quizFlood2Option2 =>
      'Pilih laluan terpendek tanpa membuat semakan';

  @override
  String get quizFlood2Option3 => 'Kembali ke jalan yang dinaiki air';

  @override
  String get quizFlood2Option4 =>
      'Terus memandu sehingga menemui jalan yang terbuka';

  @override
  String get quizFlood2Explanation =>
      'Menyemak maklumat banjir dan keadaan jalan semasa dapat membantu anda mengelakkan laluan yang terjejas oleh banjir.';

  @override
  String get quizFlood3Question =>
      'Apakah yang patut anda lakukan apabila jarak penglihatan menjadi terhad semasa memandu dalam hujan lebat?';

  @override
  String get quizFlood3Option1 =>
      'Pandu lebih laju supaya dapat keluar dari kawasan hujan dengan segera';

  @override
  String get quizFlood3Option2 =>
      'Perlahankan kenderaan dan pandu dengan berhati-hati';

  @override
  String get quizFlood3Option3 => 'Terus memandu pada kelajuan yang sama';

  @override
  String get quizFlood3Option4 =>
      'Gunakan telefon untuk menyemak kemas kini cuaca semasa memandu';

  @override
  String get quizFlood3Explanation =>
      'Memperlahankan kenderaan dan memandu dengan berhati-hati adalah lebih selamat apabila hujan lebat mengurangkan jarak penglihatan.';

  @override
  String get quizFlood4Question =>
      'Mengapakah anda perlu mengelakkan daripada memasuki air banjir?';

  @override
  String get quizFlood4Option1 => 'Air banjir sentiasa cetek';

  @override
  String get quizFlood4Option2 =>
      'Air banjir menjadikan kenderaan lebih bersih';

  @override
  String get quizFlood4Option3 =>
      'Air mungkin lebih dalam atau mengalir lebih deras daripada yang kelihatan';

  @override
  String get quizFlood4Option4 => 'Air banjir sentiasa surut dengan segera';

  @override
  String get quizFlood4Explanation =>
      'Air banjir mungkin lebih dalam atau mengalir lebih deras daripada yang kelihatan, menjadikannya berbahaya untuk dimasuki.';

  @override
  String get quizFlood5Question =>
      'Apakah yang patut anda lakukan selagi hujan lebat dan keadaan banjir berterusan?';

  @override
  String get quizFlood5Option1 =>
      'Terus pantau keadaan dan ikuti maklumat keselamatan yang berkaitan';

  @override
  String get quizFlood5Option2 => 'Abaikan kemas kini cuaca seterusnya';

  @override
  String get quizFlood5Option3 =>
      'Anggap semua jalan selamat selagi masih dibuka';

  @override
  String get quizFlood5Option4 =>
      'Masuki kawasan banjir untuk memeriksa kedalaman air';

  @override
  String get quizFlood5Explanation =>
      'Keadaan boleh berubah semasa hujan lebat, jadi terus pantau maklumat semasa dan sesuaikan rancangan anda apabila perlu.';

  @override
  String get scenarioChallenges => 'Cabaran Senario';

  @override
  String get scenarioChallengesDescription =>
      'Berlatih membuat keputusan yang selamat dalam situasi persekitaran yang realistik.';

  @override
  String get scenarioProgress => 'Kemajuan Senario';

  @override
  String get scenarioAllCompleted => 'Semua cabaran senario telah selesai.';

  @override
  String scenarioRemaining(int count) {
    return '$count senario masih berbaki.';
  }

  @override
  String get scenarioCompleted => 'Selesai';

  @override
  String get scenarioNotCompleted => 'Belum selesai';

  @override
  String get scenarioFlashFloodTitle => 'Banjir Kilat di Laluan Anda';

  @override
  String get scenarioFlashFloodDescription =>
      'Buat keputusan semasa dalam perjalanan ketika berlaku banjir secara tiba-tiba.';

  @override
  String get scenarioHazeTitle => 'Jerebu Semasa Aktiviti Luar';

  @override
  String get scenarioHazeDescription =>
      'Buat keputusan yang selamat apabila kualiti udara merosot semasa merancang aktiviti luar.';

  @override
  String get scenarioHeatUvTitle => 'Haba & UV Semasa Aktiviti Luar';

  @override
  String get scenarioHeatUvDescription =>
      'Buat keputusan yang selamat apabila pendedahan kepada haba dan UV adalah tinggi.';

  @override
  String get scenarioFloodStep1Situation =>
      'Anda sedang dalam perjalanan pulang ketika hujan lebat. Jalan di hadapan diliputi air banjir dan anda tidak dapat menentukan kedalamannya.';

  @override
  String get scenarioFloodStep1Question => 'Apakah yang patut anda lakukan?';

  @override
  String get scenarioFloodStep1Option1 =>
      'Pandu dengan cepat sebelum paras air meningkat lagi.';

  @override
  String get scenarioFloodStep1Option2 =>
      'Berpatah balik dan gunakan laluan lain.';

  @override
  String get scenarioFloodStep1Option3 =>
      'Berhenti di bahagian jalan yang dinaiki air dan tunggu.';

  @override
  String get scenarioFloodStep1Option4 =>
      'Buka tingkap dan terus memandu perlahan-lahan.';

  @override
  String get scenarioFloodStep1CorrectFeedback =>
      'Keputusan yang baik. Elakkan memasuki air banjir dan gunakan laluan alternatif yang lebih selamat.';

  @override
  String get scenarioFloodStep1IncorrectFeedback =>
      'Elakkan memasuki air banjir. Air mungkin lebih dalam atau mengalir lebih deras daripada yang kelihatan.';

  @override
  String get scenarioFloodStep2Situation =>
      'Anda telah berpatah balik dengan selamat, tetapi hujan semakin lebat. Anda perlu menentukan laluan yang patut diambil seterusnya.';

  @override
  String get scenarioFloodStep2Question =>
      'Apakah yang patut anda lakukan sebelum memilih laluan lain?';

  @override
  String get scenarioFloodStep2Option1 =>
      'Pilih jalan terpendek tanpa memeriksa keadaan.';

  @override
  String get scenarioFloodStep2Option2 =>
      'Semak maklumat banjir semasa dan rancang laluan yang lebih selamat.';

  @override
  String get scenarioFloodStep2Option3 =>
      'Kembali ke jalan yang dinaiki air untuk melihat sama ada keadaan telah bertambah baik.';

  @override
  String get scenarioFloodStep2Option4 =>
      'Terus memandu sehingga anda menemui jalan yang terbuka.';

  @override
  String get scenarioFloodStep2CorrectFeedback =>
      'Betul. Memeriksa keadaan semasa membantu anda mengelakkan jalan yang terjejas oleh banjir.';

  @override
  String get scenarioFloodStep2IncorrectFeedback =>
      'Pendekatan yang lebih selamat ialah memeriksa maklumat banjir semasa sebelum memilih laluan lain.';

  @override
  String get scenarioFloodStep3Situation =>
      'Laluan alternatif anda masih boleh dilalui, tetapi hujan lebat berterusan dan jarak penglihatan semakin terhad.';

  @override
  String get scenarioFloodStep3Question =>
      'Apakah tindakan seterusnya yang paling selamat?';

  @override
  String get scenarioFloodStep3Option1 =>
      'Pandu lebih laju supaya anda boleh sampai ke rumah dengan lebih cepat.';

  @override
  String get scenarioFloodStep3Option2 =>
      'Terus memandu seperti biasa dan abaikan jarak penglihatan yang terhad.';

  @override
  String get scenarioFloodStep3Option3 =>
      'Perlahankan kenderaan dan terus memandu dengan berhati-hati sambil memantau keadaan.';

  @override
  String get scenarioFloodStep3Option4 =>
      'Gunakan telefon semasa memandu untuk menyemak kemas kini.';

  @override
  String get scenarioFloodStep3CorrectFeedback =>
      'Betul. Memperlahankan kenderaan dan sentiasa berwaspada adalah lebih selamat apabila jarak penglihatan berkurangan.';

  @override
  String get scenarioFloodStep3IncorrectFeedback =>
      'Jarak penglihatan yang terhad meningkatkan risiko ketika memandu. Perlahankan kenderaan, sentiasa berwaspada dan pantau keadaan dengan selamat.';

  @override
  String get scenarioCompleteTitle => 'Senario selesai';

  @override
  String scenarioSafeDecisions(int safe, int total) {
    return '$safe daripada $total keputusan selamat';
  }

  @override
  String get scenarioPreviouslyCompleted =>
      'Senario ini telah diselesaikan sebelum ini. Tiada XP tambahan diberikan.';

  @override
  String scenarioXpEarned(int points) {
    return '+$points XP diperoleh';
  }

  @override
  String get scenarioContinue => 'Teruskan';

  @override
  String get scenarioSaveError =>
      'Tidak dapat menyimpan kemajuan senario. Sila cuba lagi.';

  @override
  String get scenarioHazeStep1Situation =>
      'Anda merancang untuk bersenam di luar rumah petang ini, tetapi anda mendapati keadaan kelihatan berjerebu.';

  @override
  String get scenarioHazeStep1Question =>
      'Apakah yang patut anda lakukan sebelum keluar?';

  @override
  String get scenarioHazeStep1Option1 =>
      'Teruskan rancangan anda tanpa memeriksa apa-apa.';

  @override
  String get scenarioHazeStep1Option2 =>
      'Semak PSI terkini dan keadaan kualiti udara.';

  @override
  String get scenarioHazeStep1Option3 =>
      'Bersenam dengan lebih kuat supaya anda boleh selesai lebih cepat.';

  @override
  String get scenarioHazeStep1Option4 =>
      'Anggap jerebu tidak berbahaya kerana jarak penglihatan masih boleh diterima.';

  @override
  String get scenarioHazeStep1CorrectFeedback =>
      'Keputusan yang baik. Memeriksa maklumat kualiti udara semasa membantu anda menentukan sama ada aktiviti luar sesuai dilakukan.';

  @override
  String get scenarioHazeStep1IncorrectFeedback =>
      'Semak maklumat kualiti udara semasa sebelum memutuskan sama ada untuk meneruskan aktiviti luar yang berpanjangan.';

  @override
  String get scenarioHazeStep2Situation =>
      'PSI menunjukkan kualiti udara yang lebih buruk daripada biasa. Anda masih mahu kekal aktif hari ini.';

  @override
  String get scenarioHazeStep2Question => 'Apakah pilihan yang lebih selamat?';

  @override
  String get scenarioHazeStep2Option1 =>
      'Teruskan senaman luar yang lama dan berat.';

  @override
  String get scenarioHazeStep2Option2 =>
      'Bersenam di dalam bangunan atau kurangkan aktiviti luar yang berpanjangan dan berat.';

  @override
  String get scenarioHazeStep2Option3 =>
      'Abaikan bacaan kerana anda telah merancang senaman tersebut.';

  @override
  String get scenarioHazeStep2Option4 =>
      'Luangkan lebih banyak masa di luar untuk menyesuaikan diri dengan jerebu.';

  @override
  String get scenarioHazeStep2CorrectFeedback =>
      'Betul. Menyesuaikan aktiviti anda dapat mengurangkan pendedahan yang tidak perlu apabila kualiti udara merosot.';

  @override
  String get scenarioHazeStep2IncorrectFeedback =>
      'Pertimbangkan untuk melakukan aktiviti berat di dalam bangunan atau mengurangkan aktiviti luar yang berpanjangan apabila keadaan bertambah buruk.';

  @override
  String get scenarioHazeStep3Situation =>
      'Kemudian, anda perlu keluar dan keadaan berjerebu masih berterusan.';

  @override
  String get scenarioHazeStep3Question => 'Apakah yang patut anda lakukan?';

  @override
  String get scenarioHazeStep3Option1 =>
      'Pantau keadaan semasa dan ikuti langkah berjaga-jaga yang disyorkan.';

  @override
  String get scenarioHazeStep3Option2 =>
      'Abaikan kemas kini kualiti udara seterusnya.';

  @override
  String get scenarioHazeStep3Option3 =>
      'Luangkan lebih banyak masa di luar kerana senaman anda telah dibatalkan.';

  @override
  String get scenarioHazeStep3Option4 =>
      'Anggap keadaan tidak akan berubah sepanjang hari.';

  @override
  String get scenarioHazeStep3CorrectFeedback =>
      'Betul. Kualiti udara boleh berubah, jadi terus pantau keadaan dan ikuti langkah berjaga-jaga yang sesuai.';

  @override
  String get scenarioHazeStep3IncorrectFeedback =>
      'Terus periksa keadaan semasa kerana kualiti udara boleh berubah sepanjang hari.';

  @override
  String get scenarioSituationLabel => 'Situasi';

  @override
  String get scenarioCheckDecision => 'Semak keputusan';

  @override
  String get scenarioNextSituation => 'Situasi seterusnya';

  @override
  String get scenarioFinishScenario => 'Selesaikan senario';

  @override
  String get scenarioHeatUvStep1Situation =>
      'Anda merancang untuk meluangkan beberapa jam di luar sekitar tengah hari. Cuaca panas dan Indeks UV adalah tinggi.';

  @override
  String get scenarioHeatUvStep1Question =>
      'Apakah yang patut anda lakukan sebelum keluar?';

  @override
  String get scenarioHeatUvStep1Option1 =>
      'Keluar dengan segera kerana cuaca cerah adalah selamat.';

  @override
  String get scenarioHeatUvStep1Option2 =>
      'Gunakan perlindungan matahari, bawa air dan rancang untuk berada di tempat teduh.';

  @override
  String get scenarioHeatUvStep1Option3 =>
      'Elakkan minum air supaya anda tidak perlu berehat.';

  @override
  String get scenarioHeatUvStep1Option4 =>
      'Pakai pakaian yang lebih tebal untuk membiasakan diri dengan cuaca panas.';

  @override
  String get scenarioHeatUvStep1CorrectFeedback =>
      'Keputusan yang baik. Perlindungan matahari, penghidratan dan akses kepada tempat teduh membantu mengurangkan pendedahan kepada haba dan UV.';

  @override
  String get scenarioHeatUvStep1IncorrectFeedback =>
      'Bersedia untuk menghadapi pendedahan haba dan UV sebelum berada di luar untuk tempoh yang lama.';

  @override
  String get scenarioHeatUvStep2Situation =>
      'Selepas berada di luar untuk beberapa ketika, anda mula berasa sangat panas dan telah terdedah kepada cahaya matahari secara langsung untuk suatu tempoh.';

  @override
  String get scenarioHeatUvStep2Question =>
      'Apakah tindakan seterusnya yang lebih selamat?';

  @override
  String get scenarioHeatUvStep2Option1 => 'Teruskan tanpa berhenti.';

  @override
  String get scenarioHeatUvStep2Option2 =>
      'Minum air dan berehat di kawasan yang teduh atau lebih sejuk.';

  @override
  String get scenarioHeatUvStep2Option3 =>
      'Bersenam dengan lebih kuat supaya anda boleh selesai lebih cepat.';

  @override
  String get scenarioHeatUvStep2Option4 =>
      'Kekal di bawah cahaya matahari secara langsung semasa berehat.';

  @override
  String get scenarioHeatUvStep2CorrectFeedback =>
      'Betul. Penghidratan dan rehat di tempat yang lebih sejuk dapat membantu mengurangkan tekanan haba semasa aktiviti luar yang berpanjangan.';

  @override
  String get scenarioHeatUvStep2IncorrectFeedback =>
      'Ambil rehat secara berkala untuk minum air dan menyejukkan badan daripada meneruskan aktiviti berpanjangan dalam cuaca panas.';

  @override
  String get scenarioHeatUvStep3Situation =>
      'Anda masih mempunyai lebih banyak aktiviti luar yang dirancang pada lewat hari.';

  @override
  String get scenarioHeatUvStep3Question =>
      'Bagaimanakah anda patut meneruskan aktiviti?';

  @override
  String get scenarioHeatUvStep3Option1 =>
      'Abaikan sebarang perubahan kerana anda telah memeriksa keadaan lebih awal.';

  @override
  String get scenarioHeatUvStep3Option2 =>
      'Elakkan minum air sehingga anda berasa sangat dahaga.';

  @override
  String get scenarioHeatUvStep3Option3 =>
      'Terus pantau keadaan dan sesuaikan rancangan anda jika perlu.';

  @override
  String get scenarioHeatUvStep3Option4 =>
      'Kekal di luar secara berterusan supaya badan anda dapat menyesuaikan diri.';

  @override
  String get scenarioHeatUvStep3CorrectFeedback =>
      'Betul. Keadaan boleh berubah, jadi terus pantau keadaan dan sesuaikan rancangan aktiviti luar jika perlu.';

  @override
  String get scenarioHeatUvStep3IncorrectFeedback =>
      'Terus pantau keadaan haba dan UV serta sesuaikan rancangan anda jika perlu.';

  @override
  String get cprAedTitle => 'CPR & AED';

  @override
  String get cprAedVideoTitle => 'Pelajari Prosedur CPR & AED';

  @override
  String get cprAedVideoSubtitle => 'Membuka video rasmi SCDF';

  @override
  String get cprAedDescription =>
      'Ketahui tindakan asas yang perlu diambil apabila disyaki berlaku henti jantung.';

  @override
  String get cprAedRememberActions => 'Ingat langkah-langkah ini';

  @override
  String get cprAedStep1Title => 'Periksa tindak balas';

  @override
  String get cprAedStep1Description =>
      'Tepuk bahu individu tersebut dan periksa sama ada mereka memberikan tindak balas.';

  @override
  String get cprAedStep2Title => 'Hubungi 995 & dapatkan AED';

  @override
  String get cprAedStep2Description =>
      'Minta seseorang menghubungi 995 dan seorang lagi mendapatkan AED yang terdekat.';

  @override
  String get cprAedStep3Title => 'Mulakan CPR';

  @override
  String get cprAedStep3Description =>
      'Jika individu tersebut tidak bernafas, mulakan CPR menggunakan tangan sahaja dan ikuti arahan pegawai 995.';

  @override
  String get cprAedStep4Title => 'Gunakan AED';

  @override
  String get cprAedStep4Description =>
      'Gunakan AED apabila tersedia dan ikuti arahan suara atau visual pada peranti.';

  @override
  String get cprAedWatchVideo => 'Tonton video rasmi SCDF';

  @override
  String get cprAedDisclaimer =>
      'Panduan ringkas ini adalah untuk pembelajaran kesiapsiagaan dan tidak menggantikan latihan CPR/AED yang diperakui. Semasa kecemasan, hubungi 995 dan ikuti arahan yang diberikan oleh pegawai SCDF.';

  @override
  String get cprAedVideoError => 'Tidak dapat membuka video SCDF.';

  @override
  String get floodSafetyTitle => 'Keselamatan Banjir Kilat';

  @override
  String get floodSafetyHeroTitle =>
      'Hujan lebat boleh menyebabkan banjir kilat';

  @override
  String get floodSafetyHeroDescription =>
      'Ketahui tindakan yang perlu diambil jika anda menghadapi banjir semasa dalam perjalanan di Singapura.';

  @override
  String get floodSafetyEncounterTitle => 'Jika anda menghadapi banjir';

  @override
  String get floodSafetyTurnBackTitle => 'Berpatah balik';

  @override
  String get floodSafetyTurnBackDescription =>
      'Jangan memasuki kawasan banjir. Gunakan laluan alternatif yang lebih selamat.';

  @override
  String get floodSafetyHigherGroundTitle =>
      'Pergi ke tempat yang lebih tinggi';

  @override
  String get floodSafetyHigherGroundDescription =>
      'Jika terdapat banjir di hadapan, jauhi kawasan tersebut kerana paras air boleh meningkat dengan cepat.';

  @override
  String get floodSafetyAvoidMovingWaterTitle =>
      'Elakkan air banjir yang mengalir';

  @override
  String get floodSafetyAvoidMovingWaterDescription =>
      'Keadaan air banjir sukar dinilai dan air yang mengalir boleh menyebabkan anda terjatuh.';

  @override
  String get floodSafetyAvoidDrivingTitle =>
      'Jangan memandu ke dalam air banjir yang dalam';

  @override
  String get floodSafetyAvoidDrivingDescription =>
      'Elakkan jalan yang dinaiki air apabila air melebihi paras bebendul jalan atau tanda jalan tidak lagi kelihatan.';

  @override
  String get floodSafetyBeforeTravellingTitle => 'Sebelum perjalanan';

  @override
  String get floodSafetyBeforeTravellingDescription =>
      'Semak keadaan cuaca semasa dan amaran banjir sebelum melakukan perjalanan ketika hujan lebat, dan rancang laluan alternatif jika perlu.';

  @override
  String get floodSafetySource =>
      'Panduan keselamatan diadaptasi daripada PUB, Agensi Air Negara Singapura.';

  @override
  String get floodSafetyDo => 'LAKUKAN';

  @override
  String get floodSafetyDont => 'JANGAN';

  @override
  String scenarioRewardXp(int points) {
    return '· +$points XP';
  }

  @override
  String get learnTryAgain => 'Cuba lagi';

  @override
  String get emergencyHelpTitle => 'Bantuan Kecemasan';

  @override
  String get emergencyInEmergency => 'Dalam kecemasan';

  @override
  String get emergencyImmediateDangerDescription =>
      'Jika seseorang berada dalam bahaya serta-merta, hubungi perkhidmatan kecemasan yang sesuai dengan segera.';

  @override
  String get emergencyServices => 'Perkhidmatan kecemasan';

  @override
  String get emergencyFireRescueTitle =>
      'Bomba, Penyelamat & Ambulans Kecemasan';

  @override
  String get emergencyFireRescueDescription =>
      'Kebakaran, penyelamatan atau kecemasan yang mengancam nyawa';

  @override
  String get emergencyPoliceTitle => 'Kecemasan Polis';

  @override
  String get emergencyPoliceDescription => 'Bantuan polis dengan segera';

  @override
  String get emergencySms => 'SMS Kecemasan';

  @override
  String get emergencyPoliceSmsTitle => 'SMS Kecemasan Polis';

  @override
  String get emergencyPoliceSmsDescription =>
      'SMS kecemasan apabila membuat panggilan tidak selamat';

  @override
  String get emergencyScdfSmsTitle => 'SMS Kecemasan SCDF';

  @override
  String get emergencyScdfSmsDescription =>
      'Perkhidmatan SMS kecemasan untuk individu yang pekak, kurang pendengaran atau mempunyai masalah pertuturan.';

  @override
  String get emergencyOtherUsefulContacts => 'Nombor lain yang berguna';

  @override
  String get emergencyNurseFirstDescription =>
      'Nasihat perubatan bukan kecemasan';

  @override
  String get emergencyNeaHotline => 'Talian Hotline NEA';

  @override
  String get emergencyNeaDescription =>
      'Maklum balas dan pertanyaan berkaitan alam sekitar';

  @override
  String get emergencyWhenToCall => 'Bilakah saya perlu menghubungi?';

  @override
  String get emergencyEmergencyLabel => 'Kecemasan';

  @override
  String get emergencyEmergencyGuide =>
      'Seseorang berada dalam bahaya serta-merta, cedera parah, mengalami keadaan perubatan yang mengancam nyawa, atau terdapat situasi kebakaran atau penyelamatan.';

  @override
  String get emergencyNonEmergencyLabel => 'Bukan kecemasan';

  @override
  String get emergencyNonEmergencyGuide =>
      'Situasi tersebut tidak menimbulkan ancaman serta-merta terhadap nyawa atau keselamatan. Gunakan perkhidmatan bukan kecemasan yang sesuai.';

  @override
  String get emergencyDisclaimer =>
      'Maklumat kecemasan disediakan untuk tujuan kesiapsiagaan. Sentiasa ikuti arahan daripada pihak berkuasa Singapura yang berkaitan.';

  @override
  String get profileLoadProgressError => 'Tidak dapat memuatkan kemajuan anda.';

  @override
  String get profileWeeklyActivity => 'Aktiviti Mingguan';

  @override
  String profileWeeklyDaysCompleted(int completed) {
    return '$completed / 7 hari';
  }

  @override
  String get profileWeeklyActivityDescription =>
      'Aktiviti pelan kesiapsiagaan anda sepanjang 7 hari yang lalu.';

  @override
  String profileCurrentStreak(int days) {
    return 'Rentetan semasa $days hari';
  }

  @override
  String get profileYourProgress => 'Kemajuan Anda';

  @override
  String get profileProgressDescription =>
      'Jejaki perjalanan kesiapsiagaan dan pencapaian anda.';

  @override
  String profileLevel(int level) {
    return 'Tahap $level';
  }

  @override
  String profileXpStreak(int xp, int days) {
    return '$xp XP · rentetan $days hari';
  }

  @override
  String profileProgressToLevel(int level) {
    return 'Kemajuan ke Tahap $level';
  }

  @override
  String profileXpProgress(int current) {
    return '$current / 100 XP';
  }

  @override
  String profileXpToLevel(int xp, int level) {
    return '$xp XP lagi untuk mencapai Tahap $level';
  }

  @override
  String get profileTodayPlanCompleted => 'Pelan hari ini selesai';

  @override
  String get profileTodayPlanNotCompleted => 'Pelan hari ini belum selesai';

  @override
  String get profileTodayPlanCompletedDescription =>
      'XP dan rentetan anda telah dikemas kini.';

  @override
  String get profileTodayPlanNotCompletedDescription =>
      'Lengkapkan pelan kesiapsiagaan hari ini untuk meneruskan rentetan anda.';

  @override
  String get profileNextBadge => 'Lencana seterusnya';

  @override
  String get profileBadges => 'Lencana';

  @override
  String get profileBadgeFirstCheckTitle => 'Semakan Pertama';

  @override
  String get profileBadgeFirstCheckDescription =>
      'Lengkapkan item senarai semak kesiapsiagaan pertama anda.';

  @override
  String get profileBadgeHazeHeroTitle => 'Wira Jerebu';

  @override
  String get profileBadgeHazeHeroDescription =>
      'Lengkapkan kedua-dua kuiz jerebu.';

  @override
  String get profileBadgeUvGuardianTitle => 'Penjaga UV';

  @override
  String get profileBadgeUvGuardianDescription =>
      'Lengkapkan kedua-dua kuiz UV.';

  @override
  String get profileBadgeFloodReadyTitle => 'Bersedia Menghadapi Banjir';

  @override
  String get profileBadgeFloodReadyDescription =>
      'Lengkapkan semua item senarai semak kesiapsiagaan banjir.';

  @override
  String get profileBadgeStreak7Title => 'Rentetan 7 Hari';

  @override
  String get profileBadgeStreak7Description =>
      'Kekalkan rentetan kesiapsiagaan anda selama 7 hari.';

  @override
  String get profileSettings => 'Tetapan';

  @override
  String get profilePreferences => 'Keutamaan';

  @override
  String get profilePreferencesDescription =>
      'Wilayah, aktiviti luar dan peringatan kesiapsiagaan.';

  @override
  String get profileAccount => 'Akaun';

  @override
  String get profileLogout => 'Log Keluar';

  @override
  String get profileLogoutDescription =>
      'Log keluar daripada akaun SGReady anda.';

  @override
  String get profileLogoutDialogTitle => 'Log keluar daripada SGReady?';

  @override
  String get profileLogoutDialogDescription =>
      'Anda boleh log masuk semula pada bila-bila masa menggunakan akaun anda.';

  @override
  String get profileCancel => 'Batal';

  @override
  String get profilePhotoSelectError =>
      'Tidak dapat memilih foto tersebut. Sila cuba lagi.';

  @override
  String get profileChangePhoto => 'Tukar foto profil';

  @override
  String get profileChoosePhoto => 'Pilih foto profil';

  @override
  String get profileRemovePhoto => 'Alih keluar foto profil';

  @override
  String get profileRewards => 'Ganjaran';

  @override
  String profileLifetimeXp(int xp) {
    return '$xp XP sepanjang masa';
  }

  @override
  String get profileAllRewardsUnlocked =>
      'Semua pencapaian ganjaran prototaip telah dibuka.';

  @override
  String profileXpUntilNextReward(int xp) {
    return '$xp XP lagi sehingga ganjaran anda yang seterusnya.';
  }

  @override
  String get profilePreparednessScore => 'Skor Kesiapsiagaan';

  @override
  String get profileScoreChecklist => 'Senarai semak';

  @override
  String get profileScoreQuizzes => 'Kuiz';

  @override
  String get profileScoreEngagement => 'Penglibatan';

  @override
  String get profileScoreBadges => 'Lencana';

  @override
  String get rewardsScreenTitle => 'Ganjaran';

  @override
  String get rewardsMilestones => 'Pencapaian ganjaran';

  @override
  String get rewardsMilestonesDescription =>
      'Tingkatkan pengetahuan kesiapsiagaan anda dan buka ganjaran apabila jumlah XP anda meningkat.';

  @override
  String get rewardTreatVoucherTitle => 'Baucar Sajian \$5';

  @override
  String get rewardTreatVoucherDescription =>
      'Ganjaran kecil untuk membina tabiat kesiapsiagaan yang baik.';

  @override
  String get rewardLifestyleVoucherTitle => 'Baucar Gaya Hidup \$10';

  @override
  String get rewardLifestyleVoucherDescription =>
      'Ganjaran kerana kekal aktif dan bersedia.';

  @override
  String get rewardPreparednessPackTitle => 'Pek Kesiapsiagaan SGReady';

  @override
  String get rewardPreparednessPackDescription =>
      'Keperluan berguna untuk membantu anda kekal bersedia menghadapi kecemasan.';

  @override
  String get rewardsLifetimeXpTitle => 'Jumlah XP anda';

  @override
  String rewardsXpValue(int xp) {
    return '$xp XP';
  }

  @override
  String rewardsTier(String tier) {
    return 'Tahap $tier';
  }

  @override
  String get rewardsHighestTierReached =>
      'Tahap ganjaran tertinggi telah dicapai';

  @override
  String rewardsXpToTier(int xp, String tier) {
    return '$xp XP lagi untuk mencapai $tier';
  }

  @override
  String get rewardsEarnXpDescription =>
      'Dapatkan XP daripada tindakan kesiapsiagaan harian, kuiz, senario dan kit kecemasan anda.';

  @override
  String get rewardsTierStarter => 'Permulaan';

  @override
  String get rewardsTierPrepared => 'Bersedia';

  @override
  String get rewardsTierReady => 'Sedia';

  @override
  String get rewardsTierResilient => 'Berdaya Tahan';

  @override
  String get rewardUnlocked => 'Ganjaran telah dibuka';

  @override
  String rewardXpMoreToUnlock(int xp) {
    return '$xp XP lagi untuk membuka ganjaran';
  }

  @override
  String get rewardView => 'Lihat ganjaran';

  @override
  String get rewardPrototypeDialogDescription =>
      'Ganjaran ini adalah sebahagian daripada prototaip SGReady dan tidak boleh ditebus pada masa ini. Dalam pelaksanaan akan datang, pengguna yang layak boleh menebus ganjaran melalui organisasi rakan kerjasama yang mengambil bahagian.';

  @override
  String get rewardGotIt => 'Faham';

  @override
  String get prototypeRewardsTitle => 'Ganjaran prototaip';

  @override
  String get prototypeRewardsDescription =>
      'Ganjaran yang dipaparkan dalam SGReady adalah simulasi untuk tujuan demonstrasi dan tidak boleh ditebus pada masa ini. Pelaksanaan sebenar memerlukan kerjasama dengan organisasi yang mengambil bahagian serta proses pemberian ganjaran yang selamat.';

  @override
  String get youSpendMoreTimeOutdoors =>
      'Anda menghabiskan lebih banyak masa di luar';

  @override
  String get usuallyOutdoorsAtMidday =>
      'Biasanya berada di luar pada waktu tengah hari';

  @override
  String get todayFocusAirQuality => 'Kualiti udara';

  @override
  String get todayFocusHeatSafety => 'Keselamatan cuaca panas';

  @override
  String get todayFocusUvProtection => 'Perlindungan UV';
}
