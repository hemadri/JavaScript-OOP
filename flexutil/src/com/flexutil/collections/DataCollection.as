package com.flexutil.collections{
	
	import flash.utils.Dictionary;
	import flash.utils.describeType;
	
	import mx.collections.ArrayCollection;
	import mx.core.IUID;
	import mx.events.CollectionEvent;
	import mx.events.DynamicEvent;
	import mx.events.PropertyChangeEvent;
	import mx.utils.ObjectUtil;
	
	[Bindable(event="propertyChange")]
	/**
	 * Keeps track of the data elements that are modified in the ArrayCollection.
	 * modified property of this class gives the dictionary of the changes that are 
	 * updated/added/deleted
	 */	
	public class DataCollection extends ArrayCollection{
		/**
		 * creates a DataCollection instance for a given arrayCollection and returns
		 * @param arrayColl
		 * @return 
		 */		
		public static function create(arrayColl:ArrayCollection):DataCollection {
			var dc:DataCollection;
			if(arrayColl)
				dc = new DataCollection(arrayColl.source)
			else
				dc = new DataCollection();
			return dc;
		}
		
		public function DataCollection(source:Array=null){
			super(source);
			list.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionEvent,false,100,true);
		}
		
		override public function set source(s:Array):void{
			super.source = s;
			list.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionEvent,false,100,true);
		}
		
		private var _modified:Dictionary = new Dictionary();
		public function get modified():Dictionary {
			return _modified;
		}
		public function set modified(value:Dictionary):void{
			this._modified = value;
		}
		
		private var _trackChanges:Boolean = true;
		public function get trackChanges():Boolean {
			return _trackChanges;
		}
		public function set trackChanges(value:Boolean):void{
			this._trackChanges = value;
		}
		
		
		private var _commitRequired:Boolean = false;
		public function set commitRequired(val :Boolean) :void {
			if (val!==_commitRequired){
				_commitRequired = val;
				dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this,"commitRequired", !_commitRequired, _commitRequired));
			}
		}
		public function get commitRequired() :Boolean {
			return _commitRequired;
		}
		
		
		private var _modifiedCount:int = 0;
		public function get modifiedCount():int{
			return this._modifiedCount;
		}
		public function set modifiedCount(value:int):void{
			var oldValue:uint = this._modifiedCount;
			this._modifiedCount = value;
			commitRequired = (modifiedCount>0);
			dispatchEvent(mx.events.PropertyChangeEvent.createUpdateEvent(this,"modifiedCount", oldValue, this._modifiedCount));
		}
		
		public function isItemModified(item:Object):Boolean{
			var co:ChangeObject = modified[item] as ChangeObject;
			return (co != null && !co.isCreate());
		}
		
		public function isItemNew(item:Object):Boolean{
			var co:ChangeObject = modified[item] as ChangeObject;
			return (co!=null && co.isCreate());
		}
		
		public function resetState():void{
			modified = new Dictionary();
			modifiedCount = 0;
		}
		
		public function get changes():Array {
			var args:Array = [];
			for (var obj:Object in _modified) {
				args.push(modified[obj]);
			}
			
			return args;
		}
		/**
		 * returns the newVersion changed VO's 
		 * @return 
		 */		
		public function get updatedChanges():Array {
			var args:Array = [];
			for (var obj:Object in _modified) {
				args.push(modified[obj].newVersion);
			}
			
			return args;
		}
		
		/**
		 * Returns the last element of Datacollection
		 * @return Object 
		 */		
		public function lastItem():*
		{
			return length>0?getItemAt(length-1):null;
		}
		
		/**
		 * returns complete object of a matching property value in the collection 
		 * @param property - property name in the collection for the which the value is passedS
		 * @param value - value of the property in the collection
		 * @return Object (object of matching value), null if not matching 
		 */		
		public function getItemByProperty(property:String, value:*):Object
		{
			for each(var obj:Object in this)
			if(value == obj[property])
				return obj;
			
			return null;
		}
		
		/**
		 * returns index of a matching property value in the collection 
		 * @param property - property name in the collection for the which the value is passedS
		 * @param value - value of the property in the collection
		 * @return int (index of matching value), -1 if not matching
		 */		
		public function getIndexByProperty(property:String, value:*):int
		{
			for(var i:int=0; i<length; i++)
			{
				if(value == this.getItemAt(i)[property])
					return i;
			}
			
			return -1;
		}
		
		private function onCollectionEvent(event:CollectionEvent):void{
			if (!trackChanges) return;
			var item:Object = null;
			switch(event.kind){
				case "remove": 
					for(var i:int = 0; i < event.items.length; i++){
						item = event.items[i];
						if(modified[item])
						{
							if(modified[item].state == ChangeObject.CREATE)
							{
								delete modified[item];
								modifiedCount--;
							}
							else if(modified[item].state == ChangeObject.UPDATE)
							{
								modified[item] = new ChangeObject(ChangeObject.DELETE, item, modified[item].previousVersion);
								modifiedCount++;
							}
						}
						else {
							modified[item] = new ChangeObject(ChangeObject.DELETE, item, null);
							modifiedCount++;
						}
					} 
					break;
				
				case "update": 
					updateCollectionItem(event)   
					break;
				case "replace": 
					//					In complete
					//					replaceCollectionItem(event)   
					break;
				
				case "add": 
					for(var j:int = 0; j < event.items.length; j++){
						item = event.items[j];
						modified[item] = new ChangeObject(ChangeObject.CREATE, item, null);
						modifiedCount++;
					}
					
					break;
			}	
			
		}
		
		public function checkNull(property:String = 'code'):Boolean
		{
			for each(var record:Object in this)
			{
				if (record[property] == null || record[property] == '')
					return true;
			}
			return false;
		}
		public function checkDuplicate(property:String = 'code'):Boolean
		{
			var valueExists:Boolean;
			for each(var outerRecord:Object in this)
			{
			 	valueExists = false;
				for each(var innerRecord:Object in this)
				{
					if(outerRecord[property] == innerRecord[property])
					{
						if(!valueExists)
							valueExists = true;
						else
//							duplicate exists
							return true;
					}
				}
			}
				return false;
		}
		
		private function replaceCollectionItem(event:CollectionEvent):void
		{
			//						event.location
			for(var i:int = 0; i<event.items.length; i++){
				var pce:PropertyChangeEvent = event.items[i] as PropertyChangeEvent;
				
				var item:Object = null;
				
				item = event.items[i].newValue;
				
				if(modified[item] == null)
				{
					modified[item] = new ChangeObject(ChangeObject.DELETE, item, null);
					modifiedCount++;
					
					modified[item] = new ChangeObject(ChangeObject.CREATE, item, null);
					modifiedCount++;
				}
				else
				{
					var prevVersion:* = modified[item].previousVersion;
					if(prevVersion)
						if(prevVersion.hasOwnProperty('compare'))
							if(prevVersion.compare(item))
							{
								delete modified[item];
								modifiedCount--;
								return;
							}
				}
			}
			
		}
		private function updateCollectionItem(event:CollectionEvent):void
		{
			for(var i:int = 0; i<event.items.length; i++){
				
				var item:Object = null;
				var pce:PropertyChangeEvent = event.items[i] as PropertyChangeEvent;
				
				if(pce != null){
					item = pce.currentTarget;
				}
				
				var previousVersion:Object;
				if(item != null){
					
					if(modified[item] == null){
						previousVersion = ObjectUtil.copy(item);
						previousVersion[pce.property] = pce.oldValue;
						modified[item] = new ChangeObject(ChangeObject.UPDATE,item,previousVersion);
						modifiedCount++; 
					}
					else
					{
						var prevVersion:* = modified[item].previousVersion;
						if(prevVersion)
							if(prevVersion.hasOwnProperty('compare'))
								if(prevVersion.compare(item))
								{
									delete modified[item];
									modifiedCount--;
									return;
								}
					}
					var co:ChangeObject = ChangeObject(modified[item]);
					if(co.changedPropertyNames == null){
						co.changedPropertyNames = [];
					}
					
					co.changedPropertyNames.push(pce.property); 
				}
			}
		}	
	}
}