package 
{
import laya.d3.math.Vector2;
import laya.display.Sprite;
import laya.display.Text;
import laya.events.Event;
import laya.maths.Rectangle;
import laya.net.Loader;
import laya.resource.Texture;
import laya.ui.Image;
import laya.ui.Label;
import laya.utils.Handler;
/**
 * ...测试
 * @author Kanon
 */
public class Test extends Sprite 
{
	private var barrage:Barrage;
	private var b:Boolean;
	private var sp:Sprite;
	private var bulletTexture:Texture;
	private var bullet2Texture:Texture;
	public function Test() 
	{
		var arr:Array = [];
		arr.push( { url:"res/bullet.png", type:Loader.IMAGE } );
		arr.push( { url:"res/bullet2.png", type:Loader.IMAGE } );
		Laya.loader.load(arr, Handler.create(this, loadImgComplete), null, Loader.IMAGE);
		
		var label:Label = new Label("0.0.6");
		label.font = 20;
		label.color = "#FFFFFF";
		label.x = stage.width / 2;
		this.addChild(label);
		
		
	}
	
	private function loadImgComplete(event:Event):void
	{
		this.bulletTexture = Laya.loader.getRes("res/bullet.png");
		this.bullet2Texture = Laya.loader.getRes("res/bullet2.png");
		this.barrage = new Barrage(this, new Rectangle(0, 0, stage.width, stage.height));
		this.frameLoop(1, this, loopHandler);
		Laya.stage.on(Event.CLICK, this, clickHandler);
	}
	
	private function loopHandler():void 
	{
		this.barrage.update();
	}
	
	private function clickHandler(event:Event):void 
	{
		this.b = !this.b;
		/*this.barrage.createLine(this.bulletTexture, event.stageX, event.stageY, 20, 30, 20, 0, 0, 100, 0, 5);
		this.barrage.threeCrossBarrage(this.bulletTexture, new Vector2(event.stageX, event.stageY), 
								new Vector2(event.stageX, event.stageY), 
								new Vector2(event.stageX, event.stageY), 
								-30, 90, 210, 45, 8, 50, 0, 0, 80);
								
		this.barrage.threeCrossBarrage(this.bulletTexture, new Vector2(event.stageX, event.stageY), 
								new Vector2(event.stageX, event.stageY), 
								new Vector2(event.stageX, event.stageY), 
								-90, 30, 120, 45, 8, 50, 0, 0, 80);
		if (this.b)
			this.barrage.roundWaveBarrage(this.bulletTexture, event.stageX, event.stageY, 20, 30, 5, 0, 0, 80);
		else
			this.barrage.rotateWaveBarrage(this.bulletTexture, event.stageX, event.stageY, 2, 50, 5, 0, 0, 80, 80);*/
			
		this.barrage.sectorWaveBarrage(this.bullet2Texture, event.stageX - 110, event.stageY, 30, 3, 75, 45, 4, 0, 10, 220, 10);
		this.barrage.sectorWaveBarrage(this.bullet2Texture, event.stageX + 110, event.stageY, 30, 3, 115, 45, 4, 0, 10, 220, 10);
	}
	
	
	
	
	
	
}
}