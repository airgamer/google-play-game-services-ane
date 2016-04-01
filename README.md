Google Play Games Services ANE
==================================================

Play Games Services for Android ANE,A lib for flash air developer.Enable user to log in with Google+ to upload high score and achievements.
With this Adobe Air Native Extension of gps,as3 developer can add game center in air app such as  Achievements,Leaderboards,Sign ,Multiplayer, Admob and so on.

Features :

-  Sign in/out
- Achievements
- Leaderboards
- Saved Games
- Turn-based Multiplayer
- Events and Quests
- Player Stats
- Admob (Banner and Interstitial)


Reqirement:
air sdk 17 or later
[Google Play Services Lib ANE](https://github.com/airgamer/google-play-service-ane)

### Start Up

Show admob banner ads
```
var playGamesServices:PlayGamesServices;
playGamesServices=PlayGamesServices.getInstance();
playGamesServices.admobBanner.init("ca-app-pub-xxxxxxxxxxxxxxxxxxxxxx/xxxxxxxxxxx", AdmobBanner.ADSIZE_SMART_BANNER, AdmobBanner.POSITION_BOTTOM_CENTER);
playGamesServices.admobBanner.load();
playGamesServices.admobBanner.show();
```

Login with google+ and get player infomation 
```
var playGamesServices:PlayGamesServices;
playGamesServices=PlayGamesServices.getInstance();
playGamesServices.addEventListener(PlayGamesServicesEvent.GOOGLE_PLAY_GAMES_EVENT, onGooglePlayGames);
playGamesServices.initAPI(false, false, true, 3, true);
playGamesServices.signIn();
private function onGooglePlayGames(event:PlayGamesServicesEvent):void
{
	trace("onGooglePlayGames", event.responseCode);
	if (event.responseCode == PlayGamesServicesEvent.ON_SIGN_IN_SUCCESS)
	{
		trace("Sign In Success");
		var player:Player=playGamesServices.getActivePlayer();
		trace("displayName ", player.id);
		trace("displayName ", player.displayName);
		trace("iconImageUri ", player.iconImageUri);
		trace("iconImageUrl ", player.iconImageUrl);
	}
}
```


For more fun Check out the example folder to see how to use.

###for air android app  you need add in xxx-app.xml
```
		<!-- GooglePlay Games Services -->
		<meta-data android:name="com.google.android.gms.games.APP_ID" android:value="\ MY_APP_ID" />
		<meta-data android:name="com.google.android.gms.version" android:value="@integer/google_play_services_version" />

		<!-- Only if you use Admob -->
		  <activity android:name="com.google.android.gms.ads.AdActivity" android:configChanges="keyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize" android:theme="@android:style/Theme.Translucent" />
```

### extensionID
```
<extensionID>com.grumpycarrot.ane.playgameservices</extensionID>
```
------------------------------------------------
[Google Play game services ane](https://github.com/airgamer)
