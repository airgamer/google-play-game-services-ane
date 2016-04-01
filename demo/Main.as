package
{
	import com.airgamer.playgameservices.PlayGamesServices;
	
	import example.AdmobDemo;
	import example.BasicDemo;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	
	public class Main extends Sprite
	{
		var ads:AdmobDemo;
		var bb:BasicDemo;
		public function Main()
		{
			super();
			initUI();
			ads=new AdmobDemo();
			bb=new BasicDemo();
			bb.stage=this.stage;
		}
		private function initUI():void
		{
			stage.align=StageAlign.TOP_LEFT;
			stage.scaleMode=StageScaleMode.NO_SCALE;
			var buttons:Buttons=new Buttons(onClick);
			addChild(buttons);
			buttons.addButton("banner", 20, 40);
			buttons.addButton("interstitial" ,200, 40);
			buttons.addButton("login", 200, 120);
			buttons.addButton("achievement", 20, 120);
		}
		private function onClick(label:String):void
		{
			if(label=="banner"){
				ads.showBannerAd();
			}
			if(label=="interstitial"){
				ads.showInterstitialAd();
			}
			if(label=="login"){
				bb.signIn();
			}
			if(label=="achievement"){
				bb.showAchievementsUI();
			}
		}
	}
}