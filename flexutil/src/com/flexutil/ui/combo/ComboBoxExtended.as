package com.flexutil.ui.combo
{
	import spark.components.ComboBox;
//	import clear.resources.ResourceBase;
	
	import flash.events.Event;
	
	import mx.core.IMXMLObject;
	
	import spark.components.ComboBox;
	import spark.components.DataRenderer;
	public class ComboBoxExtended extends ComboBox
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		public function ComboBoxExtended()
		{
			super();
		}
				//
				//  Variables
				//
				//----------------------------------------------------------------------
				
				//----------------------------------
				//  hasComplexFieldName
				//----------------------------------
				
				/**
				 *  @private
				 * 
				 *  ComboBox has complex data field name.
				 */
				protected var hasComplexFieldName:Boolean = false;
				
				//----------------------------------
				//  complexFieldNameComponents
				//----------------------------------
				
				/**
				 *  @private
				 * 
				 *  Array of split complex field name derived when set
				 *  so that it is not derived each time.
				 */
				protected var complexFieldNameComponents:Array;
				
				//----------------------------------------------------------------------
				//
				//  Properties
				//
				//----------------------------------------------------------------------
				
				//----------------------------------
				//  allowPendingSelection
				//----------------------------------
				
				[Inspectable(category="General")]
				
				/**
				 *  TODO: write a comment.
				 *  
				 * 
				 *  @default false
				 */
				public var allowPendingSelection:Boolean;
				
				//---------------------------------
				//  resource
				//---------------------------------
				
				private var _resource:Object;
				
				[Bindable("resourceChange")]
				[Inspectable(category="General")]
				
				/**
				 *  TODO : Write a comment ...
				 *
				 *  @default null
				 *  
				 *  @langversion 3.0
				 *  @playerversion Flash 10
				 *  @playerversion AIR 1.5
				 *  @productversion Flex 4
				 */
				public function get resource():Object
				{
					return _resource;
				}
				
				public function set resource(value:Object):void
				{
					if (_resource == value) return;
					
					_resource = value;
					
//					var resourceInstance:ResourceBase = ResourceBase.getResourceInstance(value);
					
//					if (resourceInstance != null)
//						resourceInstance.apply(this);
					
					if (hasEventListener("resourceChange"))
						dispatchEvent(new Event("resourceChange"));
				}
				
				//----------------------------------
				//  dataField
				//----------------------------------
				
				/**
				 *  @private
				 *  Storage for the dataField property.
				 */
				private var _dataField:String;
				private var dataFieldChanged:Boolean;
				
				[Bindable("dataFieldChange")]
				[Inspectable(category="Data")]
				
				/**
				 *
				 *  <p>This property is Bindable; it dispatches 
				 *  "dataFieldChange" events</p>
				 * 
				 *  @default null
				 *  @eventType dataFieldChange 
				 *  @see clear.containers.DataForm
				 */
				public function get dataField():String
				{
					return _dataField;
				}
				
				/**
				 *  @private
				 */
				public function set dataField(value:String):void
				{
					if (_dataField == value) return;
					
					_dataField = value;
					
					if (value && value.indexOf( "." ) != -1 ) 
					{
						hasComplexFieldName = true;
						complexFieldNameComponents = value.split( "." );
					}
					else
					{
						hasComplexFieldName = false;
						complexFieldNameComponents = null;
					}
					invalidateProperties();
					
					if (hasEventListener("dataFieldChange"))
						dispatchEvent(new Event("dataFieldChange"));
				}
				
				//----------------------------------
				//  valueFunction
				//----------------------------------
				
				/**
				 *  @private
				 *  Storage for the valueFunction property.
				 */
				private var _valueFunction:Function;
				private var valueFunctionChanged:Boolean;
				
				[Bindable("valueFunctionChange")]
				[Inspectable(category="Data")]
				
				/**
				 *  A function that determines the value to distribute in this ComboBox. By default
				 *  the FormItem distributes the value for the field in the data that matches the
				 *  <code>dataField</code> property. However, sometimes you want to distribute value based on
				 *  more than one field in the data, or distribute something that does not
				 *  have the value that you want.
				 *  In such a case you specify a callback function using <code>valueFunction</code>.
				 *
				 *  <p>The method signature has the following form:</p>
				 *
				 *  <pre>valueFunction(item:Object):Object</pre>
				 *
				 *  <p>Where <code>item</code> contains one row from the ComboBox's dataProvider list, and
				 *  <code>comboBox</code> specifies the ComboBox control.</p>
				 *
				 *  <p>A callback function might concatenate the firstName and
				 *  lastName fields in the data, or do some calculation of numbers.</p>
				 *  
				 *  @default null
				 *  @eventType valueFunctionChange
				 * 
				 */
				public function get valueFunction():Function
				{
					return _valueFunction;
				}
				
				/**
				 *  @private
				 */
				public function set valueFunction(value:Function):void
				{
					if (_valueFunction == value) return;
					
					_valueFunction = value;
					
					valueFunctionChanged = true;
					invalidateProperties();		
					
					if (hasEventListener("valueFunctionChange"))
						dispatchEvent(new Event("valueFunctionChange"));
				}
				
				//----------------------------------
				//  value
				//----------------------------------
				
				/**
				 *  @private
				 *  Storage for the value property.
				 */
				private var _changedValue:Object;
				private var valueChanged:Boolean;
				
				[Bindable("change")]
				[Bindable("valueCommit")]
				[Inspectable(category="Data")]
				
				/**
				 *  Write some comment ...
				 *  
				 *  <p>This property is Bindable; it dispatches 
				 *  "change" or "valueCommit" events</p>
				 *
				 *  @default null
				 *  @eventType change, valueChange 
				 *  
				 */
				public function get value():Object
				{
					return (valueChanged) ? _changedValue : itemToValue(selectedItem);
				}
				
				/**
				 *  @private
				 */
				public function set value(newValue:Object):void
				{
					if (value == newValue) return;
					
					_changedValue = newValue;
					
					valueChanged = true;
					invalidateProperties();
				}
				
				//----------------------------------------------------------------------
				//
				//  Overriden Methods
				//
				//----------------------------------------------------------------------
				
				override protected function commitProperties():void
				{
					if (dataFieldChanged || valueFunctionChanged || valueChanged)
					{
						// Select item by value.
						if (value != null && dataProvider != null && dataProvider.length > 0)
						{
							// Match value with one of the dataProvider's items.
							var index:int = findValueLoop(_changedValue);
							selectedIndex = index;
							if (index == -1)
							{
								_changedValue = null;	
							}
						}
						else
						{
							//			if (!allowPendingSelection)
							//			{
							selectedIndex = -1;
							_changedValue = null;	
							//			}
						}
						
						dataFieldChanged = false;
						valueFunctionChanged = false;
						valueChanged = false;
					}
					
					super.commitProperties();
				}
				
				//----------------------------------------------------------------------
				//
				//  Methods
				//
				//----------------------------------------------------------------------
				
				/**
				 *  Returns the Object that the FormItem container distributes for the given data object.
				 *  If the FormItem container has a non-null <code>valueFunction</code> 
				 *  property, it applies the function to the data object. 
				 *  Otherwise, the method extracts the contents of the field specified by the 
				 *  <code>dataField</code> property, or distributes the data object itself.
				 *  If the method cannot get any value, it returns <code>null</code>.
				 *
				 *  @param data Object to be analysed for the distribution.
				 * 
				 *  @return Distributable Object based on the data.
				 *  
				 */
				public function itemToValue(item:Object):Object
				{
					if (!item)
						return null;
					
					if (valueFunction != null)
						return valueFunction(item);
					
					if (!dataField || dataField == "")
						return item;
					
					if (typeof(item) == "object" || typeof(item) == "xml")
					{
						try
						{
							if (!hasComplexFieldName)
								item = item[dataField];
							else
								item = deriveComplexItemData(item);
						}
						catch(e:Error)
						{
							item = null;
						}
					}
					
					return item;
				}
				
				/**
				 *  @private
				 * 
				 */
				protected function deriveComplexItemData(item:Object):Object 
				{
					var currentRef:Object = item;
					if (complexFieldNameComponents) 
					{
						var n:int = complexFieldNameComponents.length;
						for (var i:int = 0; i < n; i++)
							currentRef = currentRef[ complexFieldNameComponents[i] ];
					}
					
					return currentRef;
				}
				
				/**
				 *  @private
				 */
				protected function findValueLoop(keyValue:Object):int
				{
					var num:int = dataProvider != null ? dataProvider.length : 0;
					
					// Try to find the item based on the start and stop indices. 
					for (var i:int = 0; i < num; i++)
					{
						var itemValue:Object = itemToValue(dataProvider.getItemAt(i));
						
						if (keyValue == itemValue)
						{
							return i;
						}
					}
					return -1;
				}
				
				//----------------------------------------------------------------------
				//
				//  Overriden Handlers
				//
				//----------------------------------------------------------------------
				
				
				
				//----------------------------------------------------------------------
				//
				//  Handlers
				//
				//----------------------------------------------------------------------
				
				
				
	}
}