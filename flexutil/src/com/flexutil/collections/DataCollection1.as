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
	 * 
	 * Keeps track of the data elements that are modified in the ArrayCollection.
	 * modified property of this class gives the dictionary of the changes that are 
	 * updated/added/deleted
	 * 
	 */	
	public class DataCollection1 extends ArrayCollection{
		
		public function DataCollection1(source:Array=null){
			super(source);
			list.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionEvent,false,100,true);
		}
		
		override public function set source(s:Array):void{
			super.source = s;
			list.addEventListener(CollectionEvent.COLLECTION_CHANGE,onCollectionEvent,false,100,true);
		}
		
		//------------------------------
		//  childrenModified
		//------------------------------
		
		/**
		 *  @private
		 *  Dictionary of hierarchical items, containing at least one child collectoin in a "commitRequired" state
		 */
		public var childrenModified:Dictionary = new Dictionary();
		
		
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
		
		
		private function onCollectionEvent(event:CollectionEvent):void{
			if (!trackChanges) return;
			var item:Object = null;
			switch(event.kind){
				case "remove": 
					for(var i:int = 0; i < event.items.length; i++){
						item = event.items[i];
						if(modified[item].state == ChangeObject.CREATE)
						{
							delete modified[item];
							modifiedCount--;
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
				
				case "add": 
					for(var j:int = 0; j < event.items.length; j++){
						item = event.items[j];
						modified[item] = new ChangeObject(ChangeObject.CREATE, item, null);
						modifiedCount++;
					}
					
					break;
			}	
			
		}
		
		private function updateCollectionItems(event:CollectionEvent):Boolean
		{
			var ignore:Boolean = false;
			for (var i:int = 0; i < event.items.length; i++)
			{
				var item:Object = null;
				var pce:PropertyChangeEvent = event.items[i] as PropertyChangeEvent;
				if (pce != null)
				{		    				
					if (pce.oldValue != pce.newValue)
					{		    				
						item = pce.currentTarget; //as DTO;
						if(item == null)
							item = pce.source;
						var evt:DynamicEvent = new DynamicEvent("itemTracking");
						evt.item = item;
						dispatchEvent(evt);
						if (evt.isDefaultPrevented())
						{
							ignore = true;
							break;
						}
					}
					else
					{
						// In particular, we can get here as a result of the collection.itemUpdated().
						// Some of them are caused by the bug in dg.onItemEditorEditEnd() that relies on describeType()
						// and ignores accessor favoring onlyvariables
						ignore = true;
						break;
					}
				}
				if (item != null)
				{
					if (item is IUID && pce.property == "uid") return true; 
					if (pce.property == "childCommitRequired")
					{
						if (pce.newValue)
						{
							childrenModified[item] = true;
							// Increase the count only if item by itself is not known as being modified
							if (!modified[item])
							{ 	    							
								modifiedCount++;
							}
						}
						else
						{
							delete childrenModified[item];
							// Decrease the count only if item by itself is not known as being modified
							if (!modified[item])
							{
								modifiedCount--;
							}
						}
					}
					else
					{				    			
						if(modified[item] == null)
						{
							if (item.hasOwnProperty("properties"))
							{
								var oldProperties:Dictionary = item["properties"];
								oldProperties[pce.property] = pce.oldValue;
								var previousVersion:Object = cloneItem(item, oldProperties)
							}
							else
							{
								// Explicit cloning of items with circular references
								// will result in exception. Preferrably, items have
								// set/get properties methods
								previousVersion=ObjectUtil.copy(item);
								if (previousVersion.hasOwnProperty(pce.property))
								{
									previousVersion[pce.property]=pce.oldValue;
								}
							}
							modified[item] = new ChangeObject(ChangeObject.UPDATE,
								item, previousVersion);
							if (!childrenModified[item])
							{
								modifiedCount++;
							}
						}
						var co:ChangeObject = ChangeObject(modified[item]);
						if (co.changedPropertyNames == null)
						{
							co.changedPropertyNames = [];
						}
						for (i = 0; i < co.changedPropertyNames.length; i++)
							if (co.changedPropertyNames[i] == pce.property)
								break;
						if (i >= co.changedPropertyNames.length)
							co.changedPropertyNames.push(pce.property);
					}			
				}
			}
			return ignore;
		}
		
		//------------------------------
		//  Private Methods
		//------------------------------
		/**
		 *  Old comment:
		 Marshalling (remoting) of items with circular references
		 will result in indefinite loop. So we clone items, prior to sending.
		 TODO: investigate the need for cloning
		 TODO: investigate correct cloning of the child collections
		 */ 
		private function cloneItem(item:Object, properties:Dictionary=null):Object
		{
			var clone:Object;
			if (item.hasOwnProperty("properties"))
			{
				clone = item["newInstance"]();
				if (properties==null) properties=item["properties"];
				clone["properties"] = properties;
				clone.uid = item.uid;
			}
			else
			{
				clone=ObjectUtil.copy(item);
				if (item.hasOwnProperty("uid"))
				{
					clone.uid=item.uid;
				}
			}
			return clone;
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
		private function updateCollectionItem1(event:CollectionEvent):void
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
						//				Comparing the previous version and new version to see if there are any property values
						//				updated. If both object property values are same, then delete the object from modified 
						//				dictionary and decrement the modifiedCount		
						var prevVersion:* = modified[item].previousVersion;
						var sameItem:Boolean=true;
						var xml:XML = describeType(item); 
						if(prevVersion != null)
						{
							for each(var accessor in xml..accessor) 
							{  
								var property:String = accessor.@name;  
								var type:String = accessor.@type;
								//							ignoring types if arracollection or data collection
								if(!(item[property] is ArrayCollection) || (item[property] is DataCollection))
								{
									//								if type is Number and the property value is NaN
									//								we cannot compare NaN with a number value
									if(type == 'Number')
									{
										var oldNumber:Number = prevVersion[property]; 
										var newNumber:Number = item[property]; 
										if(isNaN(newNumber) && isNaN(oldNumber))
											continue;
									}
									
									if(prevVersion.hasOwnProperty(property))
									{
										if(item[property] != prevVersion[property])
										{
											sameItem = false;
											break;
										}
										
									}
								}
								trace(item[property]);
							}
						}
					} 
					
					if(sameItem)
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