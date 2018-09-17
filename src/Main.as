package 
{
//import laya.debug.DebugPanel;
import laya.display.Stage;
import laya.utils.Stat;
import laya.webgl.WebGL;
/**
 * ...入口
 * @author ...Kanon
 */
public class Main 
{
	public function Main() 
	{
		Laya.init(800, 500, WebGL);
		Laya.stage.scaleMode = Stage.SCALE_SHOWALL;
		Laya.stage.screenMode = Stage.SCREEN_HORIZONTAL;
		Laya.stage.bgColor = "#283331";
		Stat.show();
		
		var test:Test = new Test();
		Laya.stage.addChild(test);
	}
}
}