package example
{

	import com.airgamer.playgameservices.PlayGamesServices;
	import com.airgamer.playgameservices.PlayGamesServicesEvent;
	import com.airgamer.playgameservices.Player;
	import com.airgamer.playgameservices.PlayerStats;
	import com.airgamer.playgameservices.achievements.Achievement;
	import com.airgamer.playgameservices.leaderboards.Leaderboard;
	import com.airgamer.playgameservices.leaderboards.LeaderboardScore;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Stage;

	//---------------------------------------------------------		
	// https://developers.google.com/games/services/android/achievements
	// https://developers.google.com/games/services/android/leaderboards
	//---------------------------------------------------------		
	public class BasicDemo
	{
		public var stage:Stage;
		public var playGamesServices:PlayGamesServices;
		private var LEADERBOARD_ID:String="xxxxxx_xxxxxxxx";
		private var ACHIEVEMENT_ID:String="xxxxxx_xxxxxxxx";
		private var player:Player;

		public function BasicDemo()
		{
			init();
		}

		private function init():void
		{
			playGamesServices=PlayGamesServices.getInstance();
			playGamesServices.addEventListener(PlayGamesServicesEvent.GOOGLE_PLAY_GAMES_EVENT, onGooglePlayGames);
			playGamesServices.initAPI(false, false, true, 3, true);
		}

		private function onGooglePlayGames(event:PlayGamesServicesEvent):void
		{
			trace("onGooglePlayGames", event.responseCode);
			if (event.responseCode == PlayGamesServicesEvent.ON_SIGN_IN_SUCCESS)
			{
				trace("Sign In Success");
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_SIGN_OUT_SUCCESS)
			{
				trace("Sign Out Success");
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_SIGN_IN_FAIL)
			{
				trace("Sign In Failed");
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_URI_IMAGE_LOADED)
			{
				var bitmapData:BitmapData=playGamesServices.utils.getCurrentLoadedUriImage();
				var bitmap:Bitmap=new Bitmap(bitmapData);
				stage.addChild(bitmap);
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_PLAYERSTATS_LOADED)
			{
				trace("Player Stats Loaded Success");
				var playerStats:PlayerStats=event.playerStats;
				trace("averageSessionLength : ", playerStats.averageSessionLength);
				trace("daysSinceLastPlayed : ", playerStats.daysSinceLastPlayed);
				trace("numberOfPurchases : ", playerStats.numberOfPurchases);
				trace("numberOfSessions : ", playerStats.numberOfSessions);
				trace("sessionPercentile : ", playerStats.sessionPercentile);
				trace("spendPercentile : ", playerStats.spendPercentile);

			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_ACHIEVEMENTS_LOADED)
			{
				var achivArray:Vector.<Achievement>=event.achievements;
				trace("Achievements Loaded, found : ", achivArray.length);
				if (achivArray.length > 0)
				{
					var achi:Achievement=achivArray[0];
					trace("name : ", achi.name);
					trace("description : ", achi.description);
					trace("state : ", achi.state);
					trace("totalSteps : ", achi.totalSteps);
					playGamesServices.utils.loadUriImage(achi.revealedImageUri);
				}
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_PLAYER_SCORE_LOADED)
			{
				trace("Player Score Loaded :");
				var leaderboardScore:LeaderboardScore=event.leaderboardScore;
				trace("leaderboardScore ", leaderboardScore.displayRank);
				trace("leaderboardScore ", leaderboardScore.displayScore);
				trace("leaderboardScore ", leaderboardScore.rank);
				trace("leaderboardScore ", leaderboardScore.rawScore);
			}
			else if (event.responseCode == PlayGamesServicesEvent.ON_LEADERBOARD_LOADED)
			{
				trace("Leaderboard loaded :");
				var leaderboard:Leaderboard=event.leaderboard;
				if (leaderboard != null)
				{
					trace("leaderboard displayName ", leaderboard.displayName);
					trace("leaderboard iconImageUri ", leaderboard.iconImageUri);
					trace("leaderboard leaderboardId ", leaderboard.leaderboardId);
					var leaderboardScores:Vector.<LeaderboardScore>=leaderboard.leaderboardScores;
					trace("Number of scores loaded : ", leaderboardScores.length);
					if (leaderboardScores.length > 0)
					{
						var firstLeaderboardScore:LeaderboardScore=leaderboardScores[0];
						trace("firstLeaderboardScore displayRank ", firstLeaderboardScore.displayRank);
						trace("firstLeaderboardScore displayScore ", firstLeaderboardScore.displayScore);
						trace("firstLeaderboardScore rank ", firstLeaderboardScore.rank);
						trace("firstLeaderboardScore rawScore ", firstLeaderboardScore.rawScore);
						trace("firstLeaderboardScore displayName", firstLeaderboardScore.player.displayName);
					}
				}
			}
		}

		public function signIn():void
		{
			playGamesServices.signIn();
		}

		public function signOut():void
		{
			playGamesServices.signOut();
		}

		public function getActivePlayerInfo():void
		{
			var player:Player=playGamesServices.getActivePlayer();
			trace("displayName ", player.id);
			trace("displayName ", player.displayName);
			trace("iconImageUri ", player.iconImageUri);
			trace("iconImageUrl ", player.iconImageUrl);
		}

		public function getPlayerStats():void
		{
			playGamesServices.getPlayerStats();
		}
		
		public function showAchievementsUI():void
		{
			playGamesServices.achievements.showAchievements();
		}

		public function getAchievementsList():void
		{
			playGamesServices.achievements.loadAchievements();
		}

		public function unlockAchievement():void
		{
			playGamesServices.achievements.unlockAchievement(ACHIEVEMENT_ID);
		}

		public function incrementAchievement(numSteps:int):void
		{
			playGamesServices.achievements.incrementAchievement(ACHIEVEMENT_ID, numSteps);
		}

		public function setStepsAchivement(numSteps:int):void
		{
			playGamesServices.achievements.setStepsAchivement(ACHIEVEMENT_ID, numSteps);
		}

		public function showAllLeaderboards():void
		{
			playGamesServices.leaderboards.showLeaderboards();
		}

		public function showLeaderboard():void
		{
			playGamesServices.leaderboards.showLeaderboard(LEADERBOARD_ID);
		}

		public function getCurrentPlayerLeaderboardScore():void
		{
			playGamesServices.leaderboards.getCurrentPlayerLeaderboardScore(LEADERBOARD_ID, Leaderboard.TIME_SPAN_ALL_TIME, Leaderboard.COLLECTION_SOCIAL);
		}

		public function getPlayerCenteredLeaderboard():void
		{
			playGamesServices.leaderboards.getPlayerCenteredLeaderboard(LEADERBOARD_ID, 5, Leaderboard.TIME_SPAN_ALL_TIME, Leaderboard.COLLECTION_PUBLIC);
		}

		public function getTopLeaderboard():void
		{
			playGamesServices.leaderboards.getTopLeaderboard(LEADERBOARD_ID, 10, Leaderboard.TIME_SPAN_ALL_TIME, Leaderboard.COLLECTION_PUBLIC);
		}
	}
}
