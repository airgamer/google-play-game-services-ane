package example
{
	import com.airgamer.playgameservices.PlayGamesServices;
	import com.airgamer.playgameservices.PlayGamesServicesEvent;
	import com.airgamer.playgameservices.savedgames.SavedGames;
	import com.airgamer.playgameservices.savedgames.SavedGame;
	import com.airgamer.playgameservices.savedgames.SavedGameEvent;

	// https://developers.google.com/games/services/android/savedgames
	public class SavedGameDemo
	{

		public var playGamesServices:PlayGamesServices;
		private var savedGames:Vector.<SavedGame>;
		private var currentGame:SavedGame;

		public function SavedGameDemo()
		{
			init();
		}

		private function init():void
		{
			playGamesServices=PlayGamesServices.getInstance();
			playGamesServices.addEventListener(PlayGamesServicesEvent.GOOGLE_PLAY_GAMES_EVENT, onGooglePlayGames);
			playGamesServices.addEventListener(SavedGameEvent.SAVEDGAMES_EVENT, onSavedGames);
			playGamesServices.initAPI(true);
		}

		private function onGooglePlayGames(event:PlayGamesServicesEvent):void
		{
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

		}

		private function onSavedGames(event:SavedGameEvent):void
		{
			if (event.responseCode == SavedGameEvent.ON_LOAD_SAVEDGAMES_SUCCESS)
			{
				trace("Load Saved games Success");
				savedGames=event.savedGameList;
				if (savedGames.length > 0)
				{
					currentGame=savedGames[0];
					trace("currentGame uniqueName : ", currentGame.uniqueName);
					trace("currentGame description : ", currentGame.description);
					trace("currentGame lastModifiedTimestamp : ", currentGame.lastModifiedTimestamp);
					trace("currentGame playedTime : ", currentGame.playedTime);
					trace("currentGame progressValue : ", currentGame.progressValue);
				}
			}
			else if (event.responseCode == SavedGameEvent.ON_OPEN_SUCCESS)
			{
				trace("Open Saved games Success");
				trace("Json String Data : ", event.savedgameData);
			}
			else if (event.responseCode == SavedGameEvent.ON_WRITE_SUCCESS)
			{
				trace("Write Saved games Success");
			}
			else if (event.responseCode == SavedGameEvent.ON_UI_CANCEL)
			{
				trace("Saved games UI Cancel");
			}
			else if (event.responseCode == SavedGameEvent.ON_UI_LOAD_GAME)
			{
				trace("On UI Load Selected Game");
				currentGame=event.savedGame;
				trace("currentGame uniqueName : ", currentGame.uniqueName);
				trace("currentGame description : ", currentGame.description);
				trace("currentGame lastModifiedTimestamp : ", currentGame.lastModifiedTimestamp);
				trace("currentGame playedTime : ", currentGame.playedTime);
				trace("currentGame progressValue : ", currentGame.progressValue);
				openGame();
			}
			else if (event.responseCode == SavedGameEvent.ON_UI_CREATE_GAME)
			{
				trace("On UI Create New Saveg Game");
				createNewGame();
			}
			else
			{
				trace("SavedGames ERROR ");
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

		public function createNewGame():void
		{
			currentGame=new SavedGame("myNewGame", "This is and example saved game.");
			playGamesServices.savedGames.openGame(currentGame);
		}

		public function openSavedGames_UI():void
		{
			playGamesServices.savedGames.showSavedGames_UI();
		}

		public function getAllSavedGames():void
		{
			playGamesServices.savedGames.getSavedGamesList();
		}

		public function openGame():void
		{
			playGamesServices.savedGames.openGame(currentGame, SavedGames.RESOLUTION_POLICY_LAST_KNOWN_GOOD);
		}

		public function writeDataToOpenedGame(JsonData:String):void
		{
			currentGame.setData(JsonData);
			playGamesServices.savedGames.writeGame(currentGame);
		}

		public function deleteSavedGame():void
		{
			playGamesServices.savedGames.deleteGame(currentGame);
		}
	}
}
