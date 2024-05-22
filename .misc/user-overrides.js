/* Section 0100 */
// 0102: I like it resume sessions
user_pref("browser.startup.page", 3);
// 0103: Firefox home as homepage (home+new window)
user_pref("browser.startup.homepage", "about:home");
// 0104: Firefox home as newtab page
user_pref("browser.newtabpage.enabled", true);


/* Section 0800 */
// 0803: Enable live search suggestions, make sure to use a privacy respecting
// search engine if using this pref.
user_pref("browser.search.suggest.enabled", true);
user_pref("browser.urlbar.suggest.searches", false); // Default: FALSE

/* Section 2800 */
// 2810: Enable clearing data when Firefox shuts down
user_pref("privacy.sanitize.sanitizeOnShutdown", true); // Default: TRUE
// 2811: Control what exactly is cleared on shutdown
user_pref("privacy.clearOnShutdown.cache", true);     // DEFAULT: TRUE
user_pref("privacy.clearOnShutdown.formdata", true);  // DEFAULT: TRUE
user_pref("privacy.clearOnShutdown.downloads", false); // DEFAULT: TRUE
user_pref("privacy.clearOnShutdown.history", false);   // DEFAULT: TRUE
user_pref("privacy.clearOnShutdown.sessions", true);  // DEFAULT: TRUE
// 2815: Clear cookie and site data on shutdown
user_pref("privacy.clearOnShutdown.cookies", true); // We exclude sites manually
user_pref("privacy.clearOnShutdown.offlineApps", true); // Site Data

/* Section 4501: enable RFP (Resist FingerPrinting)
 * may break sites since it always returns Color scheme light */
user_pref("privacy.resistFingerprinting", true);
// 4504: Letterboxing
user_pref("privacy.resistFingerprinting.letterboxing", false);  // Annoying
// 4520: Disable WebGL
user_pref("webgl.disabled", false);  // Needed for webapps like Figma

/* Section 5000: Optional OPSEC */
// 5003: Disable saving passwords
user_pref("signon.rememberSignons", false);
// 5017: Disable Form Autofill
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);

/* 9999: Not included in Arkenfox */
// Enable custom stylesheets
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
// Enable ffmpeg VA-API by default
user_pref("media.ffmpeg.vaapi.enabled", true);
// Disable firefox accounts and sync
  // user_pref("identity.fxaccounts.enabled", false);
