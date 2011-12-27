package com.flexutil.ui.combo
{
	
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	import mx.controls.ComboBox;
	import mx.controls.List;
	import mx.controls.listClasses.IListItemRenderer;
	import mx.controls.listClasses.ListItemRenderer;
	import mx.core.ClassFactory;
	
	/**
	 * Removes the mouse selection for the disabled items
	 * @author Hemadri (hemadri@hemadri.com)
	 */	
	public class ActiveList extends List
	{
		/**
		 *  Constructor.
		 */
		public function ActiveList()
		{
			super();
			this.itemRenderer = new ClassFactory(ActiveLabel);
		}
		
		
		/**
		 * remove mouse over handler when item is disabled.
		 */
		override protected function mouseOverHandler(event:MouseEvent):void
		{
			var item:IListItemRenderer = mouseEventToItemRenderer(event);
			if (itemDisable(event)) {
				// Disable selection.
			} else 
				super.mouseOverHandler(event);
		}
		
		
		/**
		 * remove mouse down handler when item is disabled.
		 */         
		override protected function mouseDownHandler(event:MouseEvent):void {
			if (itemDisable(event)) {
				// Disable click.
				return;
			} else 
				super.mouseDownHandler(event);
		}
		
		
		/**
		 * remove mouse up handler when item is disabled.
		 */         
		override protected function mouseUpHandler(event:MouseEvent):void {
			if (itemDisable(event)) {
				// Disable click.
				return;
			} else 
				super.mouseUpHandler(event);
		}
		
		
		/**
		 * remove mouse click handler when item is disabled.
		 */         
		override protected function mouseClickHandler(event:MouseEvent):void {
			if (itemDisable(event)) {
				// Disable click.
				return;
			} else 
				super.mouseClickHandler(event);
		}
		
		/**
		 * remove mouse double click handler when item is disabled.
		 */         
		override protected function mouseDoubleClickHandler(event:MouseEvent):void {
			if (itemDisable(event)) {
				// Disable double click.
				event.preventDefault();
			} else 
				super.mouseDoubleClickHandler(event);
		}
		
		private var beforeKeyDownIndex:int=-1;
		private var startKeyDownIndex:int=-1;
		
		/**
		 * adjusts keydown handler when item is disabled.
		 */        
		override protected function keyDownHandler(event:KeyboardEvent):void {
			
			if(this.owner is ComboBox)
				beforeKeyDownIndex = ComboBox(this.owner).selectedIndex;
			else
				beforeKeyDownIndex = selectedIndex;
			
			super.keyDownHandler(event);
			
			if(this.owner is ComboBox)
				startKeyDownIndex = ComboBox(this.owner).selectedIndex;
			else
				startKeyDownIndex = selectedIndex;
			
			if(selectedIndex > -1)
				checkItemDisable(event);
		}
		
		private function checkItemDisable(event:KeyboardEvent):void
		{
			var prevIndex:int;
			
			if(this.owner is ComboBox)
				prevIndex = ComboBox(this.owner).selectedIndex;
			else
				prevIndex = selectedIndex;
			
			if(selectedItem.hasOwnProperty('status') && selectedItem.status == 'N')
			{
				if(event.keyCode == Keyboard.UP || event.keyCode == Keyboard.DOWN)
				{
					if(selectedIndex == ComboBox(this.owner).dataProvider.length-1 || selectedIndex ==0)
					{
						if(this.owner is ComboBox)
							ComboBox(this.owner).selectedIndex = beforeKeyDownIndex;
						else
							selectedIndex = beforeKeyDownIndex;
					}
					else
					{
						moveSelectionVertically(event.keyCode, event.shiftKey, event.ctrlKey);
						checkItemDisable(event);
					}
				}
				else if(event.charCode >= 33 && event.charCode <= 126)
				{
					//					if selectedItem is disabled find next item
					super.keyDownHandler(event);
					if(selectedIndex != startKeyDownIndex)
						checkItemDisable(event);
					else
					{
						if(this.owner is ComboBox)
							ComboBox(this.owner).selectedIndex = beforeKeyDownIndex;
						else
							selectedIndex = beforeKeyDownIndex;
						
						scrollToIndex(selectedIndex);
					}
				}
			}
			event.stopPropagation();
		}                 
		
		
		private function itemDisable(event:MouseEvent):Boolean 
		{
			var item:IListItemRenderer = mouseEventToItemRenderer(event);
			if (item && item.data != null && item.data.hasOwnProperty('status') && item.data.status =='N') 
			{
				//				toolTip = item.data[labelField]+ '(InActive)';
				return true;
			}
			else 
			{
				//				toolTip = item.data[labelField];
				return false;
			}
		}     
		
		public function getScrollbarWidth():int
		{
			var scrollbarWidth:int = 0;
			if (this.verticalScrollBar != null)
				scrollbarWidth = this.verticalScrollBar.width;
			
			return scrollbarWidth;
		}
		
	}
}