package example
{
	import com.airgamer.playgameservices.PlayGamesServices;
	import com.airgamer.playgameservices.PlayGamesServicesEvent;
	import com.airgamer.playgameservices.multiplayer.TurnBasedEvent;
	import com.airgamer.playgameservices.multiplayer.TurnBasedMatch
	import com.airgamer.playgameservices.multiplayer.Participant
	import com.airgamer.playgameservices.multiplayer.Invitation;

	// https://developers.google.com/games/services/android/turnbasedMultiplayer
	public class TurnBaseMultiDemo
	{

		public var playGamesServices:PlayGamesServices;
		private var _matchId:String;
		private var _turnBasedMatch:TurnBasedMatch;
		private var _turnBasedMatches:Vector.<TurnBasedMatch>;
		private var _invitations:Vector.<Invitation>;
		private var _invitationId:String;
		private var _invitation:Invitation;

		public function TurnBaseMultiDemo()
		{
			init();
		}

		private function init():void
		{
			playGamesServices=PlayGamesServices.getInstance();
			playGamesServices.addEventListener(PlayGamesServicesEvent.GOOGLE_PLAY_GAMES_EVENT, onGooglePlayGames);
			playGamesServices.addEventListener(TurnBasedEvent.MULTIPLAYER_TBM_EVENT, onTurnBaseMultiplayer);
			playGamesServices.initAPI(false, true);
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

		private function onTurnBaseMultiplayer(event:TurnBasedEvent):void
		{
			if (event.responseCode == TurnBasedEvent.ON_LOAD_INVITATIONS_SUCCESS)
			{
				_invitations=event.invitations;
				trace("Number of invitations loaded : ", _invitations.length);

				if (_invitations.length > 0)
				{

					_invitation=_invitations[0];
					trace("Invitation ID ", _invitation.invitationId);
					trace("Invitation Inviter", _invitation.inviter.displayName);
				}
			}
			else if (event.responseCode == TurnBasedEvent.ON_LOAD_MATCHES_SUCCESS)
			{
				_turnBasedMatches=event.turnBasedMatches;
				trace("Number of Matches loaded : ", _turnBasedMatches.length);
				if (_turnBasedMatches.length > 0)
					onMatchLoaded(_turnBasedMatches[0]);
			}
			else if (event.responseCode == TurnBasedEvent.ON_INITIATE_MATCH_SUCCESS)
			{

				trace("Match Ini Success !");
				onMatchLoaded(event.turnBasedMatch);

			}
			else if (event.responseCode == TurnBasedEvent.ON_LOAD_MATCH_SUCCESS)
			{
				trace("Match load Success !");
				onMatchLoaded(event.turnBasedMatch);
			}
			else if (event.responseCode == TurnBasedEvent.ON_UPDATE_MATCH_SUCCESS)
			{
				trace("Match Update Success !");

				onMatchLoaded(event.turnBasedMatch);
			}
			else if (event.responseCode == TurnBasedEvent.ON_CANCEL_MATCH_SUCCESS)
			{
				trace("Match Cancel Success !");

				_matchId=event.matchId;
				trace("_matchId ", _matchId);
			}
			else if (event.responseCode == TurnBasedEvent.ON_LEAVE_MATCH_SUCCESS)
			{
				trace("Match Leave Success !");

				onMatchLoaded(event.turnBasedMatch);
			}
			else if (event.responseCode == TurnBasedEvent.ON_CREATE_MATCH_UI_CANCELED)
			{
				trace("Create Match was canceled by user");
			}
			else if (event.responseCode == TurnBasedEvent.ON_LOOK_AT_MATCH_UI_CANCELED)
			{
				trace("Look at Matches was canceled by user");
			}
			else if (event.responseCode == TurnBasedEvent.ON_NOTIFICATION_TBM_RECEIVED)
			{

				trace("Notification : Match received");
				onMatchLoaded(event.turnBasedMatch);
			}
			else if (event.responseCode == TurnBasedEvent.ON_NOTIFICATION_TBM_REMOVED)
			{
				trace("Notification : Match removed");
				_matchId=event.matchId;
				trace("_matchId : ", _matchId);
			}
			else if (event.responseCode == TurnBasedEvent.ON_NOTIFICATION_INVITATION_RECEIVED)
			{
				trace("Notification : Invitation received");

				_invitation=event.invitation;
				trace("Invitation ID ", _invitation.invitationId);
				trace("Invitation Inviter", _invitation.inviter.displayName);
			}
			else if (event.responseCode == TurnBasedEvent.ON_NOTIFICATION_INVITATION_REMOVED)
			{
				trace("Notification : Invitation Removed");
				_invitationId=event.invitationId;
				trace("_invitationId ", _invitationId);
			}
			else
			{
				trace("TurnBaseMatch ERROR ");
			}

		}

		private function onMatchLoaded(turnBasedMatch:TurnBasedMatch):void
		{
			_turnBasedMatch=turnBasedMatch;
			trace("Turn Match JSON String Data : ", _turnBasedMatch.data);
			if (turnBasedMatch.status == TurnBasedMatch.MATCH_STATUS_ACTIVE)
			{
				trace("OK, it's active. Check on turn status.");

				switch (turnBasedMatch.turnStatus)
				{
					case TurnBasedMatch.MATCH_TURN_STATUS_MY_TURN:
						trace("Your turn to play");
						break;
					case TurnBasedMatch.MATCH_TURN_STATUS_THEIR_TURN:
						trace("It's not your turn.");
						break;
				}
			}
			else
			{

				switch (turnBasedMatch.status)
				{
					case TurnBasedMatch.MATCH_STATUS_CANCELED:
						trace("This game was canceled");
						return;
					case TurnBasedMatch.MATCH_STATUS_EXPIRED:
						trace("This game is expired.");
						return;
					case TurnBasedMatch.MATCH_STATUS_AUTO_MATCHING:
						trace("We're still waiting for an automatch partner.");
						return;
					case TurnBasedMatch.MATCH_STATUS_COMPLETE:

						if (turnBasedMatch.turnStatus == TurnBasedMatch.MATCH_TURN_STATUS_COMPLETE)
						{
							trace("This game is over; someone finished it, and so did you!  There is nothing to be done.");
						}
						else
						{
							trace("This game is over; someone finished it!  You can only finish it now.");
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

		public function getCompletedMatchesList():void
		{
			playGamesServices.turnBasedMultiplayer.loadMatches([TurnBasedMatch.MATCH_TURN_STATUS_COMPLETE]);
		}

		public function getMyTurnMatchesList():void
		{
			playGamesServices.turnBasedMultiplayer.loadMatches([TurnBasedMatch.MATCH_TURN_STATUS_MY_TURN]);
		}

		public function getTheirTurnMatchesList():void
		{
			playGamesServices.turnBasedMultiplayer.loadMatches([TurnBasedMatch.MATCH_TURN_STATUS_THEIR_TURN]);
		}

		public function checkForInvitations():void
		{
			playGamesServices.turnBasedMultiplayer.getInvitations();
		}

		public function openSeeAllMatches_UI():void
		{
			playGamesServices.turnBasedMultiplayer.lookAtMatches_UI();
		}

		public function openFindPlayers_UI():void
		{
			playGamesServices.turnBasedMultiplayer.createNewGame_UI();
		}

		public function StartAutoMatch():void
		{
			playGamesServices.turnBasedMultiplayer.createAutoMatch(1, 1);
		}

		public function acceptInvitation():void
		{
			playGamesServices.turnBasedMultiplayer.acceptInvitation(_invitation.invitationId);
		}

		public function dismissInvitation():void
		{
			playGamesServices.turnBasedMultiplayer.dismissInvitation(_invitation.invitationId);
		}

		public function declineInvitation():void
		{
			playGamesServices.turnBasedMultiplayer.declineInvitation(_invitation.invitationId);
		}

		public function dismissMatch():void
		{
			playGamesServices.turnBasedMultiplayer.dismissMatch(_turnBasedMatch.matchId);
		}

		public function cancelMatch():void
		{
			playGamesServices.turnBasedMultiplayer.cancelMatch(_turnBasedMatch.matchId);
		}

		public function leaveMatch():void
		{
			playGamesServices.turnBasedMultiplayer.leaveMatch(_turnBasedMatch.matchId);
		}

		public function playTurn(jsonData:String):void
		{
			var nextParticipantId:String=_turnBasedMatch.getNextParticipantId();
			trace("NextParticipantId : ", nextParticipantId);
			playGamesServices.turnBasedMultiplayer.takeTurn(_turnBasedMatch.matchId, nextParticipantId, jsonData);
		}

		public function leaveMatchDuringTurn():void
		{
			playGamesServices.turnBasedMultiplayer.leaveMatchDuringTurn(_turnBasedMatch.matchId, _turnBasedMatch.getNextParticipantId());
		}

		public function FinishMatch(jsonData:String=null):void
		{
			playGamesServices.turnBasedMultiplayer.finishMatch(_turnBasedMatch.matchId, jsonData);
		}

		public function RematchButton():void
		{
			playGamesServices.turnBasedMultiplayer.rematch(_turnBasedMatch.matchId);
		}
	}
}
