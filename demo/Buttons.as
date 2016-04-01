package
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Buttons extends Sprite
	{
		private var format:TextFormat=new TextFormat(null,28);
		private var click:Function;
		public function Buttons(clickHandler:Function)
		{
			super();
			click=clickHandler;
		}
		public function addButton(label:String,x:int,y:int):TextField{
			var check:TextField=new TextField();
			check.defaultTextFormat=format;
			check.text=label;
			check.x=x;
			check.y=y;
			check.width=100;
			check.height=32;
			check.border=true;
			check.addEventListener(MouseEvent.CLICK,onClick);
			addChild(check);
			return check;
		}
		protected function onClick(event:MouseEvent):void
		{
			if(click!=null){
				var label:TextField=event.currentTarget as  TextField;
				click(label.text);
			}
		}
	}
}