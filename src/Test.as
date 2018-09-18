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
		this.barrage.move(Laya.stage.mouseX, Laya.stage.mouseY);
		this.barrage.update();
	}
	
	private function clickHandler(event:Event):void 
	{
		this.b = !this.b;

		//this.barrage.createCircle(this.bullet2Texture, Laya.stage.mouseX, Laya.stage.mouseY, 30, 10, 0, 0, 5);
		//this.barrage.roundWaveBarrage(this.bulletTexture, 20, 30, 5, 0, 0, 80);
		
		//this.barrage.createSector(this.bullet2Texture, event.stageX, event.stageY, 5, 60, 120, 4, 0, 10, 2);

		//this.barrage.createLine(this.bullet2Texture, 120, 90, 6, 0, 0, 100, 0, 5);
		
		//this.barrage.createScatter(this.bullet2Texture, 10, 60, 120, 10, 0, 0, 80, 0, 5);
		
		/*this.barrage.threeCrossBarrage(this.bulletTexture, 
								-30, 90, 210, 45, 8, 50, 0, 0, 80);
								
		this.barrage.threeCrossBarrage(this.bulletTexture, 
								-90, 30, 120, 45, 8, 50, 0, 0, 80);*/
								
		/*if (this.b)
			this.barrage.circleWaveBarrage(this.bulletTexture, 20, 30, 5, 0, 0, 80);
		else
			this.barrage.rotateScatterBarrage(this.bulletTexture, 2, 50, 5, 0, 0, 80);*/
			
		//this.barrage.sectorWaveBarrage(this.bullet2Texture, 30, 3, 75, 45, 4, 0, 10, 220, 10);
		//this.barrage.twoSectorWaveBarrage(this.bullet2Texture, 30, 3, 75, 115, 45, 4, 0, 10, 220, 10, 110, 0);
	}
}
}