package example
{
	import com.airgamer.playgameservices.PlayGamesServices;
	import com.airgamer.playgameservices.PlayGamesServicesEvent;
	import com.airgamer.playgameservices.eventsquests.EventsQuestsEvent;
	import com.airgamer.playgameservices.eventsquests.GameEvent;
	import com.airgamer.playgameservices.eventsquests.Quest;
	import com.airgamer.playgameservices.eventsquests.EventsQuests;
	import com.airgamer.playgameservices.eventsquests.Milestone;
	// https://developers.google.com/games/services/android/quests
	public class QuestDemo
	{
		public var playGamesServices:PlayGamesServices;
		private var gameEventList:Vector.<GameEvent>;
		private var currentGameEvent:GameEvent;
		private var questsList:Vector.<Quest>;
		private var currentQuest:Quest;
		public function QuestDemo()
		{
			init();
		}
		private function init():void
		{
			playGamesServices=PlayGamesServices.getInstance();
			playGamesServices.addEventListener(PlayGamesServicesEvent.GOOGLE_PLAY_GAMES_EVENT, onGooglePlayGames);
			playGamesServices.addEventListener(EventsQuestsEvent.EVENTS_AND_QUESTS_EVENT, onEventsQuests);
			playGamesServices.initAPI();
		}
		private function onGooglePlayGames(event:PlayGamesServicesEvent):void
		{
			if (event.responseCode == PlayGamesServicesEvent.ON_SIGN_IN_SUCCESS)
			{
				trace("Sign In Success");
				playGamesServices.eventsQuests.registerQuestUpdateListener();
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
		private function onEventsQuests(event:EventsQuestsEvent):void
		{
			if (event.responseCode == EventsQuestsEvent.ON_RETRIEVE_EVENT_SUCCESS)
			{
				trace("Get Events List Success");
				gameEventList=event.gameEventsList;
				if (gameEventList.length > 0)
				{
					currentGameEvent=gameEventList[0];
					trace("currentGameEvent eventId : ", currentGameEvent.eventId);
					trace("currentGameEvent name : ", currentGameEvent.name);
					trace("currentGameEvent description : ", currentGameEvent.description);
					trace("currentGameEvent isVisible : ", currentGameEvent.isVisible);
				}
				else
				{
					trace("Nothing retrived.");
				}
			}
			else if (event.responseCode == EventsQuestsEvent.ON_QUESTS_UI_CANCEL)
			{
				trace("Open Quest UI Cancel");
			}
			else if (event.responseCode == EventsQuestsEvent.ON_QUESTS_UI_ACCEPTED)
			{
				trace("Quest UI Accepted");
				currentQuest=event.quest;
				trace("currentQuest questId : ", currentQuest.questId);
				trace("currentQuest name : ", currentQuest.name);
				trace("currentQuest state : ", currentQuest.state);
				trace("QuestMilestone eventId : ", currentQuest.milestone.eventId);
				trace("QuestMilestone currentProgress : ", currentQuest.milestone.currentProgress);
				trace("QuestMilestone targetProgress : ", currentQuest.milestone.targetProgress);
				trace("QuestMilestone state : ", currentQuest.milestone.state);
			}
			else if (event.responseCode == EventsQuestsEvent.ON_LOAD_QUESTS_SUCCESS)
			{
				trace("Load Quest List Success");
				questsList=event.questsList;
				trace("Total found : ", questsList.length);
				if (questsList.length > 0)
				{
					currentQuest=questsList[0];
					trace("currentQuest questId : ", currentQuest.questId);
					trace("currentQuest name : ", currentQuest.name);
					trace("currentQuest state : ", currentQuest.state);
					trace("QuestMilestone eventId : ", currentQuest.milestone.eventId);
					trace("QuestMilestone currentProgress : ", currentQuest.milestone.currentProgress);
					trace("QuestMilestone targetProgress : ", currentQuest.milestone.targetProgress);
					trace("QuestMilestone state : ", currentQuest.milestone.state);
				}
			}
			else if (event.responseCode == EventsQuestsEvent.ON_QUEST_ACCEPT_SUCCESS)
			{
				trace("Quest was accepted");
			}
			else if (event.responseCode == EventsQuestsEvent.ON_QUESTS_UI_CLAIM_REWARD)
			{
				trace("Quest UI manual claim reward");
				currentQuest=event.quest;
				playGamesServices.eventsQuests.claimReward(currentQuest.questId, currentQuest.milestone.milestoneId);
			}
			else if (event.responseCode == EventsQuestsEvent.ON_CLAIM_REWARD_SUCCESS)
			{
				trace("Claim Reward Success");
				trace("Reward Json String Data Received : ", event.rewardData);
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
		public function openQuestList_UI():void
		{
			playGamesServices.eventsQuests.showQuestsUI([EventsQuests.SELECT_OPEN, EventsQuests.SELECT_ACCEPTED, EventsQuests.SELECT_COMPLETED_UNCLAIMED]);
		}
		public function getQuestToAcceptList():void
		{
			playGamesServices.eventsQuests.loadQuests([EventsQuests.SELECT_OPEN]);
		}
		public function acceptQuest():void
		{
			playGamesServices.eventsQuests.acceptQuest(currentQuest.questId);
		}
		public function getAlreadyAcceptedQuestList():void
		{
			playGamesServices.eventsQuests.loadQuests([EventsQuests.SELECT_ACCEPTED]);
		}
		public function submitEventProgress(incrementAmount:int):void
		{
			playGamesServices.eventsQuests.submitEvent(currentGameEvent.eventId, (incrementAmount));
		}
		public function getAvailableEventsList():void
		{
			playGamesServices.eventsQuests.retrieveEvent();
		}
	}
}
