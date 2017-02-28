﻿package com.ixiyou.effects 
{
	
	/**
	位图置换飘忽
	erikhallander@gmail.com
	http://www.erikhallander.com/blog
	init()
	function init():void{
		var targetClip:MovieClip = new clip();
		addChild(targetClip);
		targetClip.x = 70;
		targetClip.y = 155;
		targetClip.buttonMode = true;
		pDist = new PerlinDistort(targetClip,20,20);
	
		addEventListener(MouseEvent.MOUSE_UP,doTransition);
		pDist.addEventListener("NOISE_ON_COMPLETE",transitionComplete);
		pDist.addEventListener("NOISE_OFF_COMPLETE",restartTransition);
	}
	
	private function doTransition(e:MouseEvent):void {
		removeEventListener(MouseEvent.MOUSE_UP,doTransition);
		pDist.start_noise();
	};
	private function transitionComplete(e:Event):void {
		pDist.end_noise();
	};
	
	private function restartTransition(e:Event):void {
		addEventListener(MouseEvent.MOUSE_UP,doTransition);
		pDist.noise_reset();
	};
	*/

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.filters.DisplacementMapFilter;
	import flash.filters.BlurFilter;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.display.Bitmap;
	import flash.events.*;
	
	public class PerlinDistort extends EventDispatcher {
	
		private var baseX:Number = 100;
		private var baseY:Number = 100;	
		private const _zeroPoint:Point = new Point(0,0);
		private const _rndCount:Number = Math.random() * 25;
		private var _nx:int;
		private var _ny:int;
		private var p1:Point = new Point(55, 34);
		private var p2:Point = new Point(20, 33);
		private var perlinOffset:Array = new Array(p1, p2);
		private var bF:BlurFilter = new BlurFilter(2,2,3);
		private var blurMod:Number = 0.55;
		private var nXScale:int;
		private var nYScale:int;
		private var bmp:BitmapData
		private var _theTarget:DisplayObject;
		private var _initialized:Boolean = false;
		private var dmf:DisplacementMapFilter;
		/**
		 * 位图置换飘忽
		 * @param	_target
		 * @param	xscale
		 * @param	yscale
		 */
		public function PerlinDistort(_target:DisplayObject,xscale:int=20,yscale:int=20) {
			_theTarget = _target;
			nXScale = _nx = xscale;
			nYScale = _ny = yscale;
			init();
		};
		
		public function init():void {
			bmp = new BitmapData(_theTarget.width+100,_theTarget.height+100,false);
			bmp.draw(_theTarget);
			dmf = new DisplacementMapFilter(bmp,_zeroPoint, 1, 1, nXScale, nYScale, "color", 0xFFFFFF, 0);
			_initialized = true;
		};
		/**
		 * 消失
		 */
		public function hit():void {
			_theTarget.addEventListener(Event.ENTER_FRAME,noiseOn);
		};
		/**
		 * 结束
		 */
		public function show():void {
			_theTarget.addEventListener(Event.ENTER_FRAME,noiseOff);
		};
		/**
		 * 设置开始消状态
		 */
		public function setHitStart():void {
			_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOn);
			_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOff);
			blurMod=.25
			nXScale = _nx;
			nYScale = _ny;
			perlinOffset[0].x=55;
			perlinOffset[0].y=34;
			perlinOffset[1].x=20;
			perlinOffset[1].y=33;
			bF.blurX = 2;
			bF.blurY = 2;	
			dmf = new DisplacementMapFilter(bmp, _zeroPoint, 1, 1, nXScale, nYScale, "color", 0xFFFFFF, 0);
			_theTarget.filters= [dmf,bF];
			_theTarget.alpha = 1
			hit()
		};
		/**
		 * 设置开始出现状态
		 */
		public function setShowStart():void {
			_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOn);
			_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOff);
			nXScale = _nx;
			nYScale = _ny;
			perlinOffset[0].x=55-20*8;
			perlinOffset[0].y=34-20*5;
			perlinOffset[1].x=20+20*8;
			perlinOffset[1].y=33+20*5;
			bF.blurX = 2;
			bF.blurY = 2;	
			dmf = new DisplacementMapFilter(bmp, _zeroPoint, 1, 1, nXScale, nYScale, "color", 0xFFFFFF, 0);
			_theTarget.filters= [dmf,bF];
			_theTarget.alpha = 0
			show()
		};
		
		private function noiseOn(e:Event):void {
			bF.blurX += blurMod;
			bF.blurY += blurMod;
			perlinOffset[0].y-=8;
			perlinOffset[0].x-=5;
			perlinOffset[1].x+=8;
			perlinOffset[1].y+=5;
			bmp.perlinNoise(baseX, baseY, 3, _rndCount, false, true, 1, true, perlinOffset);
			e.target.filters = [dmf,bF];
			e.target.alpha -= 0.05;
			if (e.target.alpha <= 0) {
				_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOn);
				dispatchEvent(new Event("NOISE_ON_COMPLETE",false));
				dispatchEvent(new Event("hit",false));
			}
		};
		
		private function noiseOff(e:Event):void {
			bF.blurX -= blurMod*1.2;
			bF.blurY -= blurMod*1.2;
			perlinOffset[0].y-=8;
			perlinOffset[0].x-=5;
			perlinOffset[1].x+=8;
			perlinOffset[1].y+=5;
			bmp.perlinNoise(baseX, baseY,3,_rndCount, false, true, 1, true, perlinOffset);
			e.target.filters = [dmf,bF];
			e.target.alpha += 0.1;
			nXScale -= 0.25;
			nYScale -= 0.25;
			dmf = new DisplacementMapFilter(bmp,_zeroPoint, 1, 1, nXScale, nYScale, "color", 0xFFFFFF, 0);
			if (e.target.alpha >= 1) {
				_theTarget.removeEventListener(Event.ENTER_FRAME,noiseOff);
				dispatchEvent(new Event("NOISE_OFF_COMPLETE", false));
				dispatchEvent(new Event("show",false));
				e.target.filters = null;
			}
			
		};
	};
};