package example
{

	import com.airgamer.playgameservices.PlayGamesServices;
	import com.airgamer.playgameservices.ads.AdmobBanner;
	import com.airgamer.playgameservices.ads.AdmobEvent;
	import com.airgamer.playgameservices.ads.AdmobInterstitial;

	public class AdmobDemo
	{
		var playGamesServices:PlayGamesServices;

		public function AdmobDemo()
		{
			init();
		}

		private function init():void
		{
			playGamesServices=PlayGamesServices.getInstance();
			playGamesServices.addEventListener(AdmobEvent.ADMOB_EVENT, onAdmobEvent);

			playGamesServices.admobInterstitial.init("ca-app-pub-xxxxxxxxxxxxx/xxxxxxxxxx");
			playGamesServices.admobInterstitial.load();

			playGamesServices.admobBanner.init("ca-app-pub-xxxxxxxxxxxxxxxxxx/xxxxxxxxxx", AdmobBanner.ADSIZE_SMART_BANNER, AdmobBanner.POSITION_BOTTOM_CENTER);
			playGamesServices.admobBanner.load();
		}

		private function onAdmobEvent(event:AdmobEvent):void
		{
			if (event.responseCode == AdmobEvent.ON_INTERSTITIAL_LOADED)
			{
				trace("Interstitial Ad was loaded");
				showInterstitialAd();
			}
			if (event.responseCode == AdmobEvent.ON_INTERSTITIAL_FAILED_TO_LOAD)
			{
				trace("Interstitial Ad was loaded fail");
				playGamesServices.admobInterstitial.load();
			}
			else if (event.responseCode == AdmobEvent.ON_BANNER_LOADED)
			{
				trace("banner Ad was loaded");
			}
		}

		public function showInterstitialAd():void
		{
			if (playGamesServices.admobInterstitial.isLoaded())
			{
				playGamesServices.admobInterstitial.show();
			}
			else
			{
				playGamesServices.admobInterstitial.load();
			}
		}

		public function showBannerAd():void
		{
			if (playGamesServices.admobBanner.isShown())
			{
				playGamesServices.admobBanner.hide();
			}
			else
			{
				playGamesServices.admobBanner.load();
				playGamesServices.admobBanner.show();
			}
		}
	}
}
