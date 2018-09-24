package 
{
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
	private var viewport:Rectangle;
	//弹幕位置坐标
	public var x:Number = 0;
	public var y:Number = 0;
	public function Barrage(scene:Sprite, viewport:Rectangle)
	{
		this.viewport = viewport;
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
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createCircle(texture:Texture, x:Number, y:Number,
								count:uint, speed:Number, accel:Number = 0, 
								angular:Number = 0,	angleRand:Number = 5):void
	{
		var angle:Number = 0;
		var angleInterval:Number = 360 / count;
		for (var i:int = 0; i < count; ++i) 
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
				sp.x = b.x;
				sp.y = b.y;
				sp.rotation = b.rotation;
				sp.anchorX = .5;
				sp.anchorY = .5;
				b.image = sp;
				this.scene.addChild(sp);
			}
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
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createSector(texture:Texture, 
								x:Number, y:Number,
								count:uint, 
								startRot:Number, endRot:Number, 
								speed:Number, accel:Number = 0, 
								angular:Number = 0, angleRand:Number = 0):void
	{
		var angle:Number = startRot + Random.randnum(-angleRand, angleRand);
		var angleInterval:Number = (endRot - startRot) / (count - 1);
		for (var i:int = 0; i < count; ++i) 
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
				sp.x = b.x;
				sp.y = b.y;
				sp.rotation = b.rotation;
				sp.anchorX = .5;
				sp.anchorY = .5;
				b.image = sp;
				this.scene.addChild(sp);
			}
		}
	}
	
	/**
	 * 创建散射弹幕
	 * @param	texture		纹理
	 * @param	count		数量
	 * @param	startRot	起始角度
	 * @param	endRot		结束角度
	 * @param	speed		速度
	 * @param	accel		加速度
	 * @param	angular		角速度
	 * @param	interval	间隔 (0 为一起发出效果和扇形一样)	
	 * @param	delay		延迟执行 (毫秒数)
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 */
	public function createScatter(texture:Texture, count:uint, 
									startRot:Number, endRot:Number, 
									speed:Number, accel:Number = 0, 
									angular:Number = 0, interval:uint = 0, 
									delay:uint = 0, angleRand:Number = 0):void
	{
		var angle:Number = startRot + Random.randnum(-angleRand, angleRand);
		var angleInterval:Number = (endRot - startRot) / (count - 1);
		var callback:Function = function():void
		{
			var b:Bullet = new Bullet();
			b.x = this.x;
			b.y = this.y;
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
				sp.x = b.x;
				sp.y = b.y;
				sp.rotation = b.rotation;
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
	 * @param	count		数量
	 * @param	angle		角度
	 * @param	speed		速度
	 * @param	accel		加速度
	 * @param	angular		角速度
	 * @param	interval	间隔 (0 为一起发出)
	 * @param	delay		延迟执行 (毫秒数) 
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 * @param	offsetX		起始位置x坐标偏移量
	 * @param	offsetY		起始位置y坐标偏移量
	 */
	public function createLine(texture:Texture, count:Number, 
								angle:Number, speed:Number, 
								accel:Number = 0, angular:Number = 0, 
								interval:uint = 0, delay:uint = 0, 
								angleRand:Number = 0, offsetX:Number = 0, offsetY:Number = 0):void
	{
		var callback:Function = function():void
		{
			var b:Bullet = new Bullet();
			b.x = this.x + offsetX;
			b.y = this.y + offsetY;
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
				sp.x = b.x;
				sp.y = b.y;
				sp.rotation = b.rotation;
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
	 * 交叉散射弹幕
	 * @param	texture		纹理
	 * @param	angle		起始角度
	 * @param	angleRange	角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	count		子弹数量
	 * @param	interval	间隔 (0 为一起发出)
	 */
	public function crossBarrage(texture:Texture, angle:Number, 
								angleRange:Number, speed:Number, 
								accel:Number, angular:Number, 
								count:uint, interval:uint):void
	{
		this.createScatter(texture, count, angle - angleRange / 2, angle + angleRange / 2, 
									speed, accel, angular, interval, 0, 1);
		this.createScatter(texture, count, angle + angleRange / 2, angle - angleRange / 2, 
									speed, accel, angular, interval, count * interval, 1);
											
		this.createScatter(texture, count, angle + angleRange / 2, angle - angleRange / 2, 
									speed, accel, angular, interval, 0, 1);
		this.createScatter(texture, count, angle - angleRange / 2, angle + angleRange / 2, 
									speed, accel, angular, interval, count * interval, 1);
	}
	
	/**
	 * 旋转散射弹幕
	 * @param	texture		纹理
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	interval	间隔  (0 为一起发出)	
	 */
	public function rotateScatterBarrage(texture:Texture, wave:uint, count:uint,
										 speed:Number, accel:Number = 0, 
										 angular:Number = 0, interval:Number = 0):void
	{
		for (var i:int = 0; i < wave; i++) 
		{
			for (var j:int = 0; j < 360; j += 60) 
			{
				this.createScatter(texture, count, j, j + 360, 
								   speed, accel, angular, interval, 0, 2);
			}
		}
	}
	
	/**
	 * 环形弹幕
	 * @param	texture		纹理
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	delay		波数之间延迟时间  (0 为所有波数一起发出)	
	 */
	public function circleWaveBarrage(texture:Texture, wave:uint, count:uint,
									  speed:Number, accel:Number = 0, 
									  angular:Number = 0, delay:Number = 0):void
	{
		var callback:Function = function ():void
		{
			this.createCircle(texture, this.x, this.y, count, speed, accel, angular);
		}
		for (var i:int = 0; i < wave; i++) 
		{
			if (delay > 0)
				Laya.timer.once(i * delay, this, callback, null, false);
			else
				callback.call(this)
		}
	}
	
	/**
	 * 固定位置的环形弹幕
	 * @param	texture		纹理
	 * @param	x			初始位置x
	 * @param	y			初始位置y
	 * @param	wave		弹幕波数
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	speed		子弹速度
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	delay		波数之间延迟时间  (0 为所有波数一起发出)	
	 */
	public function circleWaveBarrageFixed(texture:Texture, 
										  x:Number, y:Number, 
										  wave:uint, count:uint,
										  speed:Number, accel:Number = 0, 
										  angular:Number = 0, delay:Number = 0):void
	{
		var callback:Function = function ():void
		{
			this.createCircle(texture, x, y, count, speed, accel, angular);
		}
		for (var i:int = 0; i < wave; i++) 
		{
			if (delay > 0)
				Laya.timer.once(i * delay, this, callback, null, false);
			else
				callback.call(this)
		}
	}
	
	/**
	 * 三叉弹幕
	 * @param	texture		纹理
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
									angle1:Number, angle2:Number, angle3:Number, 
									angleRange:Number, speed:Number, count:uint, 
									accel:Number = 0, angular:Number = 0, interval:uint = 0):void
	{
		this.crossBarrage(texture, angle1, angleRange, speed, accel, angular, count, interval);
		this.crossBarrage(texture, angle2, angleRange, speed, accel, angular, count, interval);
		this.crossBarrage(texture, angle3, angleRange, speed, accel, angular, count, interval);
	}
	
	/**
	 * 扇形波数弹幕
	 * @param	texture		纹理
	 * @param	wave		弹幕波数
	 * @param	count		一波数量
	 * @param	angle		起始角度
	 * @param	angleRange	角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed		子弹速度
	 * @param	count		子弹数量
	 * @param	accel		子弹加速度
	 * @param	angular		子弹角速度
	 * @param	delay		波数之间延迟时间  (0 为所有波数一起发出)	
	 * @param	angleRand	角度随机范围 (-angleRand, angleRand)
	 * @param	offsetX		起始位置x坐标偏移量
	 * @param	offsetY		起始位置y坐标偏移量
	 */
	public function sectorWaveBarrage(texture:Texture, 
										wave:uint, 
										count:uint,
										angle:Number, 
										angleRange:Number,
										speed:Number, 
										accel:Number = 0, 
										angular:Number = 0, 
										delay:Number = 0,
										angleRand:Number = 0, 
										offsetX:Number = 0, 
										offsetY:Number = 0) :void
	{
		var callback:Function = function ():void
		{
			this.createSector(texture, this.x + offsetX, this.y + offsetY, 
								count, angle + angleRange / 2, angle - angleRange / 2, 
								speed, accel, angular, angleRand);
		}
		for (var i:int = 0; i < wave; i++) 
		{
			if (delay > 0)
				Laya.timer.once(i * delay, this, callback, null, false);
			else
				callback.call(this)
		}
	}
	
	/**
	 * 两个扇形波数弹幕
	 * @param	texture			纹理
	 * @param	wave			弹幕波数
	 * @param	count			一波数量
	 * @param	angle			起始角度
	 * @param	angleRange		角度散射范围（-angleRange / 2, angleRange / 2）
	 * @param	speed			子弹速度
	 * @param	accel			子弹加速度
	 * @param	angular			子弹角速度
	 * @param	delay			波数之间延迟时间  (0 为所有波数一起发出)	
	 * @param	angleRand		角度随机范围 (-angleRand, angleRand)
	 * @param	offsetRangeX	起始位置x坐标偏移量 (-offsetRangeX, offsetRangeX)
	 * @param	offsetRangeY	起始位置y坐标偏移量 (-offsetRangeY, offsetRangeY)
	 */
	public function twoSectorWaveBarrage(texture:Texture, 
										wave:uint, 
										count:uint,
										angle1:Number, 
										angle2:Number,
										angleRange:Number, 
										speed:Number, 
										accel:Number = 0, 
										angular:Number = 0, 
										delay:Number = 0, 
										angleRand:Number = 0, 
										offsetRangeX:Number = 0, 
										offsetRangeY:Number = 0):void
	{
		this.sectorWaveBarrage(texture, wave, count, angle1, 
							angleRange, speed, accel, angular, 
							delay, angleRand, -offsetRangeX, -offsetRangeY);
		this.sectorWaveBarrage(texture, wave, count, angle2, 
							angleRange, speed, accel, angular, 
							delay, angleRand, offsetRangeX, offsetRangeY);
	}
	
	/**
	 * 烟火弹幕
	 * @param	texture1	纹理1
	 * @param	texture2	纹理2
	 * @param	delay		延迟
	 * @param	wave		波数
	 * @param	count		数量
	 * @param	angle		角度
	 * @param	speed1		发射速度
	 * @param	speed2		散射速度
	 */
	public function fireworksBarrage(texture1:Texture, 
									texture2:Texture, 
									delay:uint,
									wave:uint, 
									count:uint,
									angle:Number, 
									speed1:Number,
									speed2:Number):void
	{
		var b:Bullet = new Bullet();
		b.x = this.x;
		b.y = this.y;
		var rad:Number = MathUtil.dgs2rds(angle);
		b.vx = Math.cos(rad) * speed1;
		b.vy = Math.sin(rad) * speed1;
		b.rotation = angle;
		this.bulletList.push(b);
		if (texture1 && this.scene)
		{
			var sp:Image = new Image();
			sp.source = texture1;
			sp.x = b.x;
			sp.y = b.y;
			sp.rotation = b.rotation;
			sp.anchorX = .5;
			sp.anchorY = .5;
			b.image = sp;
			this.scene.addChild(sp);
		}
		var callback:Function = function ():void
		{
			this.circleWaveBarrageFixed(texture2, b.x, b.y, wave, count, speed2, 0, 0, 100);
			b.canDestroy = true;
		}
		Laya.timer.once(delay, this, callback, null, false);
	}
	
	/**
	 * 更新
	 */
	public function update():void
	{
		if (!this.bulletList) return;
		var length:int = this.bulletList.length;
		var b:Bullet;
		for (var i:int = 0; i < length; i++) 
		{
			b = this.bulletList[i];
			b.update();
		}
		for (i = 0; i < this.bulletList.length; i++) 
		{
			b = this.bulletList[i];
			if (this.viewport)
			{
				if (b.canDestroy ||
					b.x < this.viewport.x || 
					b.x > this.viewport.x + this.viewport.width ||
					b.y < this.viewport.y ||
					b.y > this.viewport.y + this.viewport.height)
				{
					b.destroy();
					this.bulletList.splice(i, 1);
				}
			}
		}
	}
	
	/**
	 * 移动发射点
	 * @param	x	发射点坐标x
	 * @param	y	发射点坐标y
	 */
	public function move(x:Number, y:Number):void
	{
		this.x = x;
		this.y = y;
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
		Laya.timer.clearAll(this);
		this.scene = null;
		this.bulletList = null;
	}
}
}