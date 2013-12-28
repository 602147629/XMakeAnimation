package com.utils
{
	import flash.utils.Dictionary;

	public class HashMap
	{
		private var dic:Dictionary;
		private var _keyArr:Array;
		public function HashMap()
		{
			dic = new Dictionary();
			_keyArr = [];
		}
		
		public static function getDic(value:Dictionary):HashMap
		{
			var map:HashMap = new HashMap();
			for(var key:String in value)
			{
				map.add(key, value[key]);
			}
			return map;
		}
		
		public function add(key:Object,value:Object):void
		{
			if(_keyArr.indexOf(key) == -1)
			{
				_keyArr.push(key);
			}
			dic[key] = value;
			
		}
		
		public function remove(key:Object):Object
		{
			var result:Object = dic[key];
			var index:int = _keyArr.indexOf(key);
			if(index != -1)
			{
				_keyArr.splice(index,1);
				delete dic[key];
			}
			return result;
		}
		
		public function get(key:Object):Object
		{
			return dic[key];
		}
		
		public function hasKey(key:Object):Boolean
		{
			return dic[key] != null;
		}
		
		public function hasValue(value:Object):Boolean
		{
			for each(var v:Object in dic)
			{
				if(v == value) return true;
			}
			return false;
		}
		
		public function isEmpty():Boolean
		{
			for each(var o:Object in dic)
			{
				return false;
			}
			return true;
		}
		
		public function get keys():Array
		{
			var key:Array = [];
			for(var i:int = 0;i<_keyArr.length;i++)
			{
				key.push(_keyArr[i]);
			}
			return key;
		}
		/**
		 *获得关键字数组的引用 
		 * @return 
		 * 
		 */		
		public function getSourceKeys():Array
		{
			return _keyArr;
		}
		
		/**
		 *  
		 * @param asc 升序吗？
		 * @return 
		 * 
		 */		
		public function getKeys(asc:Boolean):Array
		{
			var rs:Array = this.keys;
			if(asc == false)
			{
				rs.sort(Array.NUMERIC);
				rs.reverse();
			}
			else
			{
				rs.sort(Array.NUMERIC);
			}
			return rs;
		}
		
		public function get values():Array
		{
			var value:Array = [];
			for(var i:int = 0;i<_keyArr.length;i++)
			{
				value.push(get(_keyArr[i]));
			}
			return value;
		}
		
		public function getDic():Dictionary
		{
			return this.dic
		}
		
		public function clear():void
		{
			dic = new Dictionary();
			_keyArr = [];
		}
		
		
		public function get length():int
		{
			return _keyArr.length;
		}
		
		public function dispose():void
		{
			for(var i:int = 0;i<_keyArr.length;i++)
			{
				delete this.dic[_keyArr[i]];
			}

			dic = null;
			_keyArr = null;
		}
	}
}