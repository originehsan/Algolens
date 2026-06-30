abstract class AppStrings {
  AppStrings._();

  // ── App ───────────────────────────────────────────
  static const String appName        = 'Magnus';

  // ── Greetings ─────────────────────────────────────
  static const String greetMorning   = 'Good morning';
  static const String greetAfternoon = 'Good afternoon';
  static const String greetEvening   = 'Good evening';
  static const String greetNight     = 'Hey';

  // ── Home sections ─────────────────────────────────
  static const String upcomingContests = 'Upcoming contests';
  static const String friendsPulse     = 'Friends pulse';
  static const String todayFocus       = "Today's focus";
  static const String seeAll           = 'See all';

  // ── Contest status labels ─────────────────────────
  static const String live     = 'LIVE';
  static const String upcoming = 'UPCOMING';
  static const String finished = 'FINISHED';
  static const String liveNow  = 'LIVE NOW';

  // ── Contest type labels ───────────────────────────
  static const String div1Plus2 = 'DIV 1+2';
  static const String div1      = 'DIV 1';
  static const String div2      = 'DIV 2';
  static const String div3      = 'DIV 3';
  static const String div4      = 'DIV 4';
  static const String edu       = 'EDU';
  static const String icpc      = 'ICPC';
  static const String cf        = 'CF';

  // ── Reminder sheet ────────────────────────────────
  static const String setReminder             = 'Set reminder';
  static const String notifyMeVia             = 'Notify me via';
  static const String howEarly                = 'How early?';
  static const String pushNotification        = 'Push notification';
  static const String pushNotificationSub     = 'Silent alert on your device';
  static const String ttsVoiceAlert           = 'TTS voice alert';
  static const String ttsVoiceAlertSub        = 'Speaks contest name aloud';
  static const String widgetCountdown         = 'Widget countdown';
  static const String widgetCountdownSub      = 'Live timer on home screen';
  static const String agentCall               = 'Agent call reminder';
  static const String agentCallSub            = 'Automated voice call before contest';
  static const String premium                 = 'PREMIUM';
  static const String reminderSaved           = 'Reminder set';

  // ── Stats labels ──────────────────────────────────
  static const String solved   = 'SOLVED';
  static const String contests = 'CONTESTS';
  static const String streak   = 'STREAK';

  // ── Rating card ───────────────────────────────────
  static const String cfRating = 'CODEFORCES RATING';
  static const String peak     = 'Peak';

  // ── Today focus ───────────────────────────────────
  static const String practice       = 'Practice →';
  static const String weakTopicLabel = 'WEAK TOPIC';

  // ── Empty / error states ──────────────────────────
  static const String noUpcomingContests    = 'No upcoming contests';
  static const String noUpcomingContestsSub = 'Check back later';
  static const String noFriends             = 'No friends yet';
  static const String noFriendsSub          = 'Add friends to see pulse';
  static const String somethingWentWrong    = 'Something went wrong.';
  static const String retry                 = 'Retry';
  static const String handleNotSet          = 'Handle not set. Set up your CF handle.';

  // ── Pull to refresh ───────────────────────────────
  static const String retrieving = 'RETRIEVING_DATA_STREAM...';

  // ── Navigation labels ─────────────────────────────
  static const String home     = 'Home';
  static const String contestsTab = 'Contests';
  static const String friends  = 'Friends';
  static const String insights = 'Insights';



  static const String updateReminder  = 'Update reminder';
  static const String removeReminder  = 'Remove reminder';
  static const String reminderUpdated = 'Reminder updated';
  static const String reminderRemoved = 'Reminder removed';


  static const String reminderLimitReached = 'Maximum 3 reminders per contest';
}