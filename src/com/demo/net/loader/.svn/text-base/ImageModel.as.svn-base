package com.demo.net.loader{
	
	import com.demo.core.animation.BitmapFrameData;
	import com.demo.core.animation.WrapperedAnimation;
	import com.demo.core.data.RenderData;
	import com.demo.define.Config;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.geom.Rectangle;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	
	/**
	 * @author Sampson
	 */
	public class ImageModel  {
		private static var _instance : ImageModel ;
		private var animManager : ResManager;
		private var sceneResManager : ResManager;
		public var animCache : Dictionary;
		public static const RESTYPE_ANIM : uint = 0;
		public static const RESTYPE_BITMAP_DATA : uint = 1;
		public static const RESTYPE_RENDER_DATA : uint = 2;
		
		public function ImageModel() {
			animManager = new ResManager();
			sceneResManager = new ResManager();
			animCache = new Dictionary();
		}
		
		public function getAnimRes(type : String, id : int, acttionType : int, fun : Function, args : Array = null, resType : uint = 0) : ResResult {
			return getRes(animManager, type, id, acttionType, fun, args, resType);
		}
		
		public function getImage(type : String, imageId : int, acttionType : int, fun : Function, ...args) : ResResult {
			var manager : ResManager = sceneResManager;
			return getRes(manager, type, imageId, acttionType, fun, args, RESTYPE_BITMAP_DATA);
		}
		
		public function getRes(manager : ResManager, type : String, id : int, acttionType : int,
							   fun : Function, args : Array, 
							   resType : uint = 0/*oder : Boolean = true, 
		depth : uint = 0, sortFun : Function = null*/) : ResResult {
			if (args == null) args = [];
			// if (Login.isTengxun) packId = getTxPackId(packId, groupId, imageId);
			var key : String = type + id + String(acttionType);
			
			var renderData : RenderData = animCache[key];
			var url : String;
			if(acttionType == 0)
				url = Config.swfPath + type + "/" + id + ".swf";
			else
				url = Config.swfPath + type + "/" + id + "/" + acttionType + ".swf";
			
			if (renderData != null) {
				execGetResWithArgs(fun, args, resType, renderData, key);
				return new ResResult(true, url);
			} else {
				var callBack : Function = function() : void {
					renderData = animCache[key];
					if (renderData == null) {
						var frames : Vector.<BitmapFrameData> = new Vector.<BitmapFrameData>();
						var frameLength : uint = 100;
//						frameLength = Math.max(frameLength, StaticDataModel.instance.getAnimOffsetLength(type, id, acttionType));
						renderData = new RenderData(400, 400, 124, frames);
						
						var className : String;
						var bmdClass : Class;
						var bmdFrameData : BitmapFrameData;
						className = type + "_" + id + "_" + acttionType;
						if (frameLength == 1) {
							if (ApplicationDomain.currentDomain.hasDefinition(className)) {
								bmdClass = getDefinitionByName(className) as Class;
							} else {
								bmdClass = getDefinitionByName(className + "_" + 0) as Class;
							}
							bmdFrameData = new BitmapFrameData();
							bmdFrameData.targetBitmapClass = bmdClass;
							// if (detailed)
							// bmdFrameData.rectangle = detailed.frames[i].rectangle;
							frames.push(bmdFrameData);
						} else {
							for (var i : int = 0; i < frameLength; i++) {
								if (!ApplicationDomain.currentDomain.hasDefinition(className + "_" + i))
									continue;
								bmdClass = getDefinitionByName(className + "_" + i) as Class;
								bmdFrameData = new BitmapFrameData();
								bmdFrameData.targetBitmapClass = bmdClass;
								frames.push(bmdFrameData);
							}
						}
//						StaticDataModel.instance.setOffset(type, id, acttionType, frames);
						animCache[key] = renderData;
					}
					execGetResWithArgs(fun, args, resType, renderData, key);
				};
				return manager.getRes(url, callBack, null, Class);
			}
		}
		
		private function execGetResWithArgs(fun : Function, args : Array, resType : uint, 
											renderData : RenderData, key : String) : void {
			if (fun == null) return;
			var target : *;
			switch(resType) {
				case RESTYPE_ANIM:
					target = createAnim(renderData, key);
					break;
				case RESTYPE_BITMAP_DATA:
					target = renderData.frames[0].bitmapData;
					break;
				case RESTYPE_RENDER_DATA:
					target = renderData;
					break;
			}
			
			args.unshift(target);
			fun.apply(fun, args);
			args.shift();
		}
		
		public function createAnim(renderData : RenderData, name : String) : WrapperedAnimation {
			var anim : WrapperedAnimation = new WrapperedAnimation();
			//			anim.renderBySelf = renderBySelf;
			anim.renderSpeed = renderData.renderSpeed;
			anim.setFrames(renderData.frames);
			anim.name = name;
			// anim.wrapperWidth = imageVO.wrapperWidth;
			// anim.wrapperHeight = imageVO.wrapperHeight;
			return anim;
		}
		
		public function createFrameDatas(fac : Class) : Vector.<BitmapFrameData> {
			var frames : Vector.<BitmapFrameData> = new Vector.<BitmapFrameData>();
			var mc : * = new fac();
			var totalFrames : int;
			if (mc is MovieClip) {
				totalFrames = mc.totalFrames;
				for (var i : int = 1; i <= totalFrames; i++) {
					mc.gotoAndStop(i);
					frames.push(getBitmapData(mc, "idle" + i));
				}
			}
			return frames;
		}
		
		public function getBitmapData(obj : DisplayObjectContainer, className : String) : BitmapFrameData {
			var bmd : BitmapFrameData;
			var bounds : Rectangle = obj.getRect(obj);
			bounds.x = Math.round(bounds.x);
			bounds.y = Math.round(bounds.y);
			bmd = new BitmapFrameData();
			if (ApplicationDomain.currentDomain.hasDefinition(className)) {
				bmd.targetBitmapClass = getDefinitionByName(className) as Class;
			}
			// bmd.bitmapData = new BitmapData(bounds.width, bounds.height, true, 0x00);
			// bmd.bitmapData.draw(obj, new Matrix(1, 0, 0, 1, -bounds.x, -bounds.y));
			bmd.rectangle = bounds;
			return bmd;
		}
		
		public static function get instance():ImageModel
		{
			return _instance ||= new ImageModel();
		}
//		public function getImageByUrl(swfId:int, url : String, fun : Function, args : Array = null, index : uint = 0) : ResResult {
//			if (args == null) args = [];
//			var manager : ResManager = sceneResManager;
//			// if (Login.isTengxun) packId = getTxPackId(packId, groupId, imageId);
//			var key : String = url + swfId;
//			
//			var renderData : RenderData = animCache[key];
//			var url : String = url + swfId + ".swf";
//			if (renderData != null) {
//				execGetResWithArgs(fun, args, RESTYPE_BITMAP_DATA, renderData, key);
//				return new ResResult(true, url);
//			} else {
//				var callBack : Function = function() : void {
//					renderData = animCache[key];
//					if (renderData == null) {
//						var frames : Vector.<BitmapFrameData> = new Vector.<BitmapFrameData>();
//						var frameLength : uint = 1;
//						//frameLength = Math.max(frameLength, StaticDataModel.instance.getAnimOffsetLength(type, id, acttionType));
//						renderData = new RenderData(400, 400, 125, frames);
//						
//						var className : String;
//						var bmdClass : Class;
//						var bmdFrameData : BitmapFrameData;
//						className = ResType.IMAGE + "_" + swfId;
//						if (frameLength == 1) {
//							if (ApplicationDomain.currentDomain.hasDefinition(className)) {
//								bmdClass = getDefinitionByName(className) as Class;
//							} else {
//								bmdClass = getDefinitionByName(className + "_" + index) as Class;
//							}
//							bmdFrameData = new BitmapFrameData();
//							bmdFrameData.targetBitmapClass = bmdClass;
//							frames.push(bmdFrameData);
//						} /*else {
//						for (var i : int = 0; i < frameLength; i++) {
//						if (!ApplicationDomain.currentDomain.hasDefinition(className + "_" + i))
//						continue;
//						bmdClass = getDefinitionByName(className + "_" + i) as Class;
//						bmdFrameData = new BitmapFrameData();
//						bmdFrameData.targetBitmapClass = bmdClass;
//						frames.push(bmdFrameData);
//						}
//						}*/
//						//						StaticDataModel.instance.setOffset(type, id, acttionType, frames);
//						animCache[key] = renderData;
//					}
//					execGetResWithArgs(fun, args, RESTYPE_BITMAP_DATA, renderData, key);
//				};
//				return manager.getRes(url, callBack, null, Class);
//			}
//		}
	}
}
