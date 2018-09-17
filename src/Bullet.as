package 
{
import laya.display.Sprite;
/**
 * ...子弹类
 * @author Kanon
 */
public class Bullet 
{
	//子弹类型
	public var type:int;
	//碰撞组
	public var collisionGroup:int;
	//速度
	public var vx:Number = 0;
	public var vy:Number = 0;
	//加速度
	public var ax:Number = 0;
	public var ay:Number = 0;
	//x坐标
	public var x:Number = 0;
	//y坐标
	public var y:Number = 0;
	//角速度
	public var av:Number = 0;
	//角度
	public var rotation:Number = 0;
	//标记
	public var tag:int;
	//生命周期
	public var life:int;
	//显示对象
	public var image:Sprite;
	public function Bullet() 
	{
		
	}
	
	/**
	 * 更新
	 */
	public function update():void
	{
		this.x += this.vx;
		this.y += this.vy;
		this.vx += this.ax;
		this.vy += this.ay;
		this.rotation += this.av;
		if (this.image)
		{
			this.image.x = this.x;
			this.image.y = this.y;
			this.image.rotation = this.rotation;
		}
	}
	
	
	/**
	 * 销毁
	 */
	public function destroy():void
	{
		if (this.image)
		{
			this.image.removeSelf();
			this.image.destroy();
			this.image = null;
		}
	}
}
}