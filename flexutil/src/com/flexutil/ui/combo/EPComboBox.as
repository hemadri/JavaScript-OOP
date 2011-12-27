package com.flexutil.ui.combo
{
	import com.flexutil.skins.EPComboBoxSkin;
	
	import flash.events.Event;
	
	import mx.collections.IList;
	import mx.controls.List;
	import mx.events.FlexEvent;
	
	import spark.components.ComboBox;
	import spark.components.supportClasses.ListBase;
	
	public class EPComboBox extends ComboBox
	{
		public function EPComboBox()
		{
			super();
			this.setStyle('skinClass',com.flexutil.skins.EPComboBoxSkin);
			this.addEventListener(Event.CHANGE,changeEvt);
		}
		
		private function changeEvt(event:Event):void {
			var obj:Object = event.currentTarget.selectedItem;
			if (selectedIndex == NO_SELECTION || selectedIndex == CUSTOM_SELECTED_ITEM)
				_selectedValue = null;
			else
				_selectedValue = event.currentTarget.selectedItem[dataProperty];
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
		override public function set dataProvider(value:IList):void
		{
			dataProviderChanged=true;
			super.dataProvider=value;
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
			
			//If the selectedValue and dataProvider are set, find the selectedIndex of the value.
			if ((selectedValueChanged == true && dataProvider != null) ||
				(dataProviderChanged == true && selectedValue != undefined))
			{
				dataProviderChanged=false;
				selectedValueChanged=false;
				
				var idx:int=-1;
				
			    if (dataProvider != null) {
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
				}
				//Set the selectedIndex with the index found or -1 if not found.
				this.selectedIndex=idx;
			}
			super.commitProperties();
		}
		/**
		 * @private
		 * This override executes the superclass, and calls invalidateProperties to
		 * force the commitProperties since there were changes in the dataProvider.
		 */
		override protected function dataProvider_collectionChangeHandler(event:Event):void
		{
			super.dataProvider_collectionChangeHandler(event);
			this.addEventListener(FlexEvent.VALUE_COMMIT,adjustDropDownWidth);
			dataProviderChanged=true;
			invalidateProperties();
		}
		
		/*private var _ddFactory:IFactory = new ClassFactory(ExtendedList);
		
		
		override public function get dropdownFactory():IFactory
		{
			return _ddFactory;
		}        
		
		override public function set dropdownFactory(factory:IFactory):void
		{
			_ddFactory = factory;
		}*/
		
		public function adjustDropDownWidth(event:Event=null):void
		{    
			this.removeEventListener(FlexEvent.VALUE_COMMIT,adjustDropDownWidth);
			
			if (this.dropDown == null)
			{
				callLater(adjustDropDownWidth);
			}
			else
			{              
//				List(dropDown).mea
				/*var ddWidth:int = this.dropDown.measureWidthOfItems(-1,this.dataProvider.length);
				if (this.dropDown.maxVerticalScrollPosition > 0)
				{                    
					ddWidth += 15//hardcoded the scrollbar width;                    
//					ddWidth += ExtendedList(dropdown).getScrollbarWidth();                    
				}                
				this.dropdownWidth = Math.max(ddWidth,this.width);     */           
			}
		}
		
	}
}