package 
{
import laya.d3.math.Vector2;
import laya.display.Sprite;
import laya.maths.Rectangle;
import laya.resource.Texture;
import laya.ui.Image;
import utils.MathUtil;
import utils.Random;
/**
 * ...弹幕类
 * @author Kanon
 */
public class Barrage 
{
	//子弹列表
	private var bulletList:Array;
	//弹幕场景
	private var scene:Sprite;
	//子弹可视范围
	private var rage:Rectangle;
	public function Barrage(scene:Sprite, rage:Rectangle)
	{
		this.rage = rage;
		this.scene = scene;
		this.bulletList = [];
	}
	
	/**
	 * 创建圆形弹幕
	 * @param	texture		纹理
	 * @param	x			起始坐标x
	 * @param	y			起始坐标y
	 * @param	count		数量
	 * @param	speed		速度
	 * @param	accel		加速度
	 * @param	angular		角速度
	 * @param	interval	间隔 (0 为一起发出)
	 * @param	delay		延迟执行
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createCircle(texture:Texture, x:Number, y:Number, 
								count:uint, speed:Number, 
								accel:Number = 0, angular:Number = 0, 
								interval:uint = 0, delay:uint = 0, 
								angleRand:Number = 0):void
	{
		var angle:Number = 0;
		var angleInterval:Number = 360 / count;
		var callback:Function = function()
		{
			angle += Random.randnum(-angleRand, angleRand);
			var b:Bullet = new Bullet();
			b.x = x;
			b.y = y;
			var rad:Number = MathUtil.dgs2rds(angle);
			b.vx = Math.cos(rad) * speed;
			b.vy = Math.sin(rad) * speed;
			b.ax = Math.cos(rad) * accel;
			b.ay = Math.sin(rad) * accel;
			b.av = angular;
			b.rotation = angle;
			angle += angleInterval;
			this.bulletList.push(b);
			if (texture && this.scene)
			{
				var sp:Image = new Image();
				sp.source = texture;
				sp.x = x;
				sp.y = y;
				sp.rotation = angle;
				sp.anchorX = .5;
				sp.anchorY = .5;
				b.image = sp;
				this.scene.addChild(sp);
			}
		}
		
		for (var i:int = 0; i < count; ++i) 
		{
			if (delay > 0 || interval > 0)
				Laya.timer.once(interval * i + delay, this, callback, null, false);
			else
				callback.call(this);
		}
	}
	
	/**
	 * 创建扇形弹幕
	 * @param	texture		纹理
	 * @param	x			起始坐标x
	 * @param	y			起始坐标y
	 * @param	count		数量
	 * @param	startRot	起始角度
	 * @param	endRot		结束角度
	 * @param	speed		速度
	 * @param	accel		加速度
	 * @param	angular		角速度
	 * @param	interval	间隔  (0 为一起发出)
	 * @param	delay		延迟执行
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createSector(texture:Texture, x:Number, y:Number, 
								count:uint, startRot:Number, endRot:Number, 
								speed:Number, accel:Number = 0, 
								angular:Number = 0, interval:uint = 0, 
								delay:uint = 0, angleRand:Number = 0):void
	{
		var angle:Number = startRot + Random.randnum(-angleRand, angleRand);
		var angleInterval:Number = (endRot - startRot) / (count - 1);
		var callback:Function = function()
		{
			var b:Bullet = new Bullet();
			b.x = x;
			b.y = y;
			var rad:Number = MathUtil.dgs2rds(angle);
			b.vx = Math.cos(rad) * speed;
			b.vy = Math.sin(rad) * speed;
			b.ax = Math.cos(rad) * accel;
			b.ay = Math.sin(rad) * accel;
			b.av = angular;
			b.rotation = angle;
			angle += angleInterval + Random.randnum(-angleRand, angleRand);
			this.bulletList.push(b);
			if (texture && this.scene)
			{
				var sp:Image = new Image();
				sp.source = texture;
				sp.x = x;
				sp.y = y;
				sp.anchorX = .5;
				sp.anchorY = .5;
				b.image = sp;
				this.scene.addChild(sp);
			}
		}
		for (var i:int = 0; i < count; ++i) 
		{
			if (delay > 0 || interval > 0)
				Laya.timer.once(interval * i + delay, this, callback, null, false);
			else
				callback.call(this);
		}
	}
	
	/**
	 * 创建线性弹幕
	 * @param	texture		纹理
	 * @param	x			x坐标
	 * @param	y			y坐标
	 * @param	count		数量
	 * @param	angle		角度
	 * @param	speed		速度
	 * @param	accel		加速度
	 * @param	angular		角速度
	 * @param	interval	间隔  (0 为一起发出)
	 * @param	delay		延迟执行
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createLine(texture:Texture, x:Number, y:Number, 
								count:Number, angle:Number, speed:Number, 
								accel:Number = 0, angular:Number = 0, interval:uint = 0, 
								delay:uint = 0, angleRand:Number = 0):void
	{
		var callback:Function = function()
		{
			var b:Bullet = new Bullet();
			b.x = x;
			b.y = y;
			angle += Random.randnum(-angleRand, angleRand);
			var rad:Number = MathUtil.dgs2rds(angle);
			b.vx = Math.cos(rad) * speed;
			b.vy = Math.sin(rad) * speed;
			b.ax = Math.cos(rad) * accel;
			b.ay = Math.sin(rad) * accel;
			b.av = angular;
			b.rotation = angle;
			this.bulletList.push(b);
			if (texture && this.scene)
			{
				var sp:Image = new Image();
				sp.source = texture;
				sp.x = x;
				sp.y = y;
				sp.rotation = angle;
				sp.anchorX = .5;
				sp.anchorY = .5;
				b.image = sp;
				this.scene.addChild(sp);
			}
		}
		for (var i:int = 0; i < count; ++i) 
		{
			if (delay > 0 || interval > 0)
				Laya.timer.once(interval * i + delay, this, callback, null, false);
			else
				callback.call(this);
		}
	}
	
	/**
	 * 交叉弹幕
	 * @param	texture		纹理
	 * @param	posX		坐标x
	 * @param	posY		坐标y
	 * @param	angle		起始角度
	 * @param	angleRange	角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	count		子弹数量
	 * @param	interval	间隔  (0 为一起发出)
	 */
	public function crossBarrage(texture:Texture, posX:Number, posY:Number, 
								angle:Number, angleRange:Number, 
								speed:Number, accel:Number, 
								angular:Number, count:uint, 
								interval:uint):void
	{
		
		this.createSector(texture, posX, posY, count, angle - angleRange / 2, angle + angleRange / 2, 
									speed, accel, angular, interval, 0, 1);
		this.createSector(texture, posX, posY, count, angle + angleRange / 2, angle - angleRange / 2, 
									speed, accel, angular, interval, count * interval, 1);
											
		this.createSector(texture, posX, posY, count, angle + angleRange / 2, angle - angleRange / 2, 
									speed, accel, angular, interval, 0, 1);
		this.createSector(texture, posX, posY, count, angle - angleRange / 2, angle + angleRange / 2, 
									speed, accel, angular, interval, count * interval, 1);
	}
	
	/**
	 * 环形旋转弹幕
	 * @param	texture		纹理
	 * @param	posX		坐标x
	 * @param	posY		坐标y
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	interval	间隔  (0 为一起发出)	
	 */
	public function rotateWaveBarrage(texture:Texture, posX:Number, posY:Number, 
									 wave:uint, count:uint,
									 speed:Number, accel:Number = 0, 
									 angular:Number = 0, interval:Number = 0):void
	{
		for (var i:int = 0; i < wave; i++) 
		{
			for (var j:int = 0; j < 360; j += 60) 
			{
				this.createSector(texture, posX, posY, count, j, j + 360, 
										speed, accel, angular, interval, 0, 2);
			}
		}
	}
	
	/**
	 * 环形弹幕
	 * @param	texture		纹理
	 * @param	posX		坐标x
	 * @param	posY		坐标y
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	delay		波数之间延迟时间  (0 为一起发出)	
	 */
	public function roundWaveBarrage(texture:Texture, posX:Number, posY:Number, wave:uint, count:uint,
									speed:Number, accel:Number=0, angular:Number=0, delay:Number=0):void
	{
		for (var i:int = 0; i < wave; i++) 
		{
			this.createCircle(texture, posX, posY, count, speed, accel, angular, 0, i * delay, 5);
		}
	}
	
	/**
	 * 三叉弹幕
	 * @param	texture		纹理
	 * @param	pos1		起始位置1
	 * @param	pos2		起始位置2
	 * @param	pos3		起始位置3
	 * @param	angle1		起始角度1
	 * @param	angle2		起始角度2
	 * @param	angle3		起始角度3
	 * @param	angleRange	角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed		子弹速度
	 * @param	count		子弹数量
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	interval	间隔  (0 为一起发出)	
	 */
	public function threeCrossBarrage(texture:Texture, 
									pos1:Vector2, pos2:Vector2, pos3:Vector2, 
									angle1:Number, angle2:Number, angle3:Number, 
									angleRange:Number, speed:Number, count:uint, 
									accel:Number = 0, angular:Number = 0, interval:uint = 0):void
	{
		this.crossBarrage(texture, pos1.x, pos1.y, angle1, angleRange, speed, accel, angular, count, interval);
		this.crossBarrage(texture, pos2.x, pos2.y, angle2, angleRange, speed, accel, angular, count, interval);
		this.crossBarrage(texture, pos3.x, pos3.y, angle3, angleRange, speed, accel, angular, count, interval);
	}
	
	/**
	 * 扇形波数弹幕
	 * @param	texture		纹理
	 * @param	posX		坐标x
	 * @param	posY		坐标y
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	angle		起始角度
	 * @param	angleRange	角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed		子弹速度
	 * @param	count		子弹数量
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function sectorWaveBarrage(texture:Texture, 
									posX:Number, posY:Number, 
									wave:uint, count:uint,
									angle:Number, angleRange:Number,
									speed:Number, accel:Number = 0, 
									angular:Number = 0, delay:Number = 0,
									angleRand:Number = 0) :void
	{
		for (var i:int = 0; i < wave; i++) 
		{
			this.createSector(texture, posX, posY, count, 
							angle + angleRange / 2, angle - angleRange / 2, 
							speed, accel, angular, 0, i * delay, 5, angleRand);
		}
	}
	
	/**
	 * 更新
	 */
	public function update():void
	{
		var length:int = this.bulletList.length;
		var b:Bullet;
		for (var i:int = 0; i < length; i++) 
		{
			b = this.bulletList[i];
			b.update();
		}
		for (var i:int = 0; i < this.bulletList.length; i++) 
		{
			b = this.bulletList[i];
			if (this.rage)
			{
				if (b.x < this.rage.x || 
					b.x > this.rage.x + this.rage.width ||
					b.y < this.rage.y ||
					b.y > this.rage.y + this.rage.height)
				{
					b.destroy();
					this.bulletList.splice(i, 1);
				}
			}
		}
	}
	
	/**
	 * 清除所有弹幕
	 */
	public function clearAll():void
	{
		for (var i:int = this.bulletList.length - 1; i >= 0; i--) 
		{
			var b:Bullet = this.bulletList[i];
			b.destroy();
			this.bulletList.splice(i, 1);
		}
	}
	
	/**
	 * 销毁
	 */
	public function destroy():void
	{
		this.clearAll();
		this.bulletList = null;
	}
}
}