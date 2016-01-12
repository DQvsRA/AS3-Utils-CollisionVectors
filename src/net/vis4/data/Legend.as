package net.vis4.data 
{
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextFormat;
	import net.vis4.layout.HBox;
	import net.vis4.layout.IBox;
	import net.vis4.layout.VBox;
	import net.vis4.text.Label;
	import net.vis4.text.Label_HelveticaNeue;
	
	/**
	 * ...
	 * @author gka
	 */
	public class Legend extends Sprite
	{
		private var _title:Label;
		
		public function Legend(title:String, colors:Array, labels:Array, vertical:Boolean = true) 
		{
			_title = new Label(title, new TextFormat('Arial', 12, 0), true);
			var vbox:VBox = new VBox();
			addChild(vbox);
			var box:Sprite = vertical ? new VBox(5) : new HBox(5);
			
			vbox.addChild(_title);
			vbox.addChild(box);
			for (var i:uint = 0; i < colors.length; i++) {
				var shape:Shape = new Shape();
				shape.graphics.beginFill(0xffffff, 0);
				shape.graphics.drawRect(0, 0, 10, 10);
				shape.graphics.beginFill(colors[i]);
				shape.graphics.drawRect(5, 0, 15, 15);
				var hbox:HBox = new HBox();
				hbox.addChild(shape);
				hbox.addChild(new Label(labels[i], new TextFormat('Arial', 10, 0), true));
				
				box.addChild(hbox);
			}
		}
		
	}
	
}