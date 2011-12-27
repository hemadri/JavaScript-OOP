package com.flexutil.collections
{

     // This line gets required only in UpdatableCollection
    [RemoteClass(alias="com.flexutil.collections.ChangeObjectImpl")]	
	public class ChangeObject{
		
		public var state:int;
        public var newVersion:Object = null;
        public var previousVersion:Object = null;
        public var changedPropertyNames:Array= null;
        public static const UPDATE:int=2;
        public static const DELETE:int=3;
        public static const CREATE:int=1;
        
        public var error:String;
		
		public function ChangeObject(state:int=0,newVersion:Object=null,previousVersion:Object = null){
		   this.state = state;
           this.newVersion = newVersion;
           this.previousVersion = previousVersion;
		}
		
		public function isCreate():Boolean {
		   return state==ChangeObject.CREATE;
        }
        
        public function isUpdate():Boolean {
           return state==ChangeObject.UPDATE;
        }
        
        public function isDelete():Boolean {
           return state==ChangeObject.DELETE;
        }

	}
}