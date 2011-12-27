package com.flexutil.ui.combo
{
	import flash.events.Event;
	
	import mx.controls.ComboBox;
	import mx.core.ClassFactory;
	import mx.core.IFactory;
	import mx.core.mx_internal;
	import mx.events.FlexEvent;
	
	use namespace mx_internal;
	[Event(name="cbChangeEvent", type="flash.events.Event")]
	public class ValueComboBox extends ComboBox
	{
		public function ValueComboBox()
		{
			super();
			this.addEventListener(Event.CHANGE,changeEvt);
			itemRenderer = new ClassFactory(ActiveLabel);
			dropdownFactory = new ClassFactory(ActiveList);
			rowCount = 15;
		}
		
		private function changeEvt(event:Event):void {
			var obj:Object = event.currentTarget.selectedItem;
			_selectedValue = obj[dataProperty]; 
			
			this.dispatchEvent(new Event("cbChangeEvent"));
		}
		
		
		//---------------------------------------------------------------------
		//
		//  Variables
		//
		//---------------------------------------------------------------------
		
		//Indicator that the dataProvider has changed.
		private var dataProviderChanged:Boolean=false;
		
		//Indicator that the selectedValue has changed.
		private var selectedValueChanged:Boolean=false;
		
		
		//---------------------------------------------------------------------
		//
		//  Overridden properties
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  dataProvider
		//----------------------------------
		/**
		 * @private
		 * This override executes the superclass, and then sets the indicator
		 * that the dataProvider has changed.
		 **/
		override public function set dataProvider(value:Object):void
		{
			dataProviderChanged=true;
			super.dataProvider=value;
			isDataProviderChanged = true;
		}
		
		//---------------------------------------------------------------------
		//
		//  Properties
		//
		//---------------------------------------------------------------------
		
		//----------------------------------
		//  dataProperty
		//----------------------------------
		/**
		 * dataProperty identifies the property that contains the selectedValue
		 * in the dataProvider objects.
		 */
		private var _dataProperty:String="code";
		public function get dataProperty():*
		{
			return _dataProperty;
		}
		
		public function set dataProperty(val:String):void
		{
			_dataProperty=val;
		}
		
		//----------------------------------
		//  selectedValue
		//----------------------------------
		private var _selectedValue:*;
		
		/**
		 * selectedValue is the value that will be searched within the
		 * dataProperty property of the objects in the dataProvider.
		 */
		[Bindable(event="cbChangeEvent")]
		public function get selectedValue():*
		{
			return _selectedValue;
		}
		
		/**
		 * @private
		 **/
		public function set selectedValue(val:*):void
		{
			_selectedValue=val;
			selectedValueChanged=true;
			//invalidateProperties to force commitProperties to be executed.
			invalidateProperties();
		}
		
		
		//---------------------------------------------------------------------
		//
		//  Overridden methods
		//
		//---------------------------------------------------------------------
		/**
		 * @private
		 * This override executes the superclass, and sets the selectedIndex
		 * of the selectedValue if it can be found in the dataProvider.
		 **/
		override protected function commitProperties():void
		{
			super.commitProperties();
			
			//If the selectedValue and dataProvider are set, find the selectedIndex of the value.
			if ((selectedValueChanged == true && dataProvider != null) ||
				(dataProviderChanged == true && selectedValue != undefined)
			)
			{
				dataProviderChanged=false;
				selectedValueChanged=false;
				
				var idx:int=-1;
				
				//Loop through data provider until a record with the value is found.
				for (var i:int=0; i < dataProvider.length; i++)
				{
					if (this.dataProvider[i] != null &&
						this.dataProvider[i].hasOwnProperty(dataProperty) &&
						this.dataProvider[i][dataProperty] == selectedValue)
					{
						idx=i;
						break;
					}
				}
				trace('idx = '+idx);
				//Set the selectedIndex with the index found or -1 if not found.
				this.selectedIndex=idx;
			}
			/*			else
			this.selectedIndex=-1;*/
			
				trace('selectedIndex = '+selectedIndex);
			
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth,unscaledHeight);
			
			var ddWidth:int = calculatePreferredSizeFromData(dataProvider.length).width;
			if (dropdown && dropdown.maxVerticalScrollPosition > 0)
			{					
				ddWidth += ActiveList(dropdown).getScrollbarWidth();					
			}	
			
			if(width > 0 && ddWidth > width)
				dropdownWidth = ddWidth+50;
		}
		
		/**
		 * @private
		 * This override executes the superclass, and calls invalidateProperties to
		 * force the commitProperties since there were changes in the dataProvider.
		 */
		override protected function collectionChangeHandler(event:Event):void
		{
			super.collectionChangeHandler(event);
			dataProviderChanged=true;
			invalidateProperties();
		}
		
		private var isDataProviderChanged:Boolean;
		

		override mx_internal function hasDropdown():Boolean
		{
			if(isDataProviderChanged)
			{
				isDataProviderChanged = false;
				return false; 
			}
			return super.hasDropdown();
		}

		
	}
}