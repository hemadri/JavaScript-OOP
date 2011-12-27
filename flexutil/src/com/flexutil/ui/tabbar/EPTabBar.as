package com.flexutil.ui.tabbar {
	import com.flexutil.events.EPTabBarEvent;
	import com.flexutil.skins.EPTabBarSkin;
	
	import flash.utils.setTimeout;
	
	import mx.collections.IList;
	
	import spark.components.TabBar;
	
	[Event (name="closeTab", type="com.flexutil.events.EPTabBarEvent")]
	/**
	 * @author Hemadri (hemadri@hemadri.com)
	 * spark TabBar with close button and color
	 */
	public class EPTabBar extends TabBar {
		public function EPTabBar() {
			super();
			//			TODO: Need to set styles in an external style sheet;
			this.setStyle('skinClass',com.flexutil.skins.EPTabBarSkin);
		}
		
		public var closeButtonVisible:Boolean = true;
		
		public function setTabColor(index:int, value:uint):void {
			if (index >= 0 && index < dataGroup.numElements) 
				setTimeout(updateColor,50,index,value);
		}
		private function updateColor(index:int, value:uint):void
		{
			var btn:EPTabBarButton = dataGroup.getElementAt(index) as EPTabBarButton;
			btn.setStyle('chromeColor',value);
		}
		
		public function setCloseableTab(index:int, value:Boolean):void {
			if (index >= 0 && index < dataGroup.numElements) 
				setTimeout(updateTab, 50,index,value);
		}
		
		public function setEditableTab(index:int, value:Boolean):void {
			if (index >= 0 && index < dataGroup.numElements)  {
				setTimeout(updateEditableIcon, 50,index,value);
			}
		}
		
		public function setOneEditableTab(index:int):void {
			for(var i:int=0; i< this.dataGroup.numElements; i++)
			{
				if( i == index)
					updateEditableIcon(i, true);
				else
					updateEditableIcon(i, false);
			}
		}
		
		private function updateEditableIcon(index:int, editBtnVal:Boolean):void
		{
			if (dataGroup.getElementAt(index)) {
				var btn:EPTabBarButton = dataGroup.getElementAt(index) as EPTabBarButton;
				btn.editable  = editBtnVal;
			}
		}
		
		private function updateTab(index:int, closeBtnVal:Boolean):void
		{
			var btn:EPTabBarButton = dataGroup.getElementAt(index) as EPTabBarButton;
			btn.closeable = closeBtnVal;
		}
		public function getCloseableTab(index:int):Boolean {
			if (index >= 0 && index < dataGroup.numElements) {
				var btn:EPTabBarButton = dataGroup.getElementAt(index) as EPTabBarButton;
				return btn.closeable;
			}
			return false;
		}
		
		private function closeHandler(e:EPTabBarEvent):void {
			//			Notes: CloseTab method can be closed by the Object, which allows to handle alerts before closing.
			//			closeTab(e.index, selectedIndex);
		}
		/**
		 * adjusts the selectedIndex. Use this method if you have ysed
		 * @param closedTab
		 * 
		 */
		public function closeTabWithoutData(closedTab:int):void {
			var selectedTab:int = selectedIndex;
			
			if (dataProvider.length == 0) 
				selectedIndex = -1;
			else if (closedTab < selectedTab) 
				selectedIndex = selectedTab - 1;
			else if (closedTab == selectedTab) 
				selectedIndex = (selectedTab == 0 ? 0 : selectedTab - 1);
			else 
				selectedIndex = selectedTab;
		}
		
		/**
		 * Removes the tab and its corresponding dataprovider element, and adjusts the selectedIndex
		 * @param closedTab
		 */		
		public function closeTab(closedTab:int):void {
			var selectedTab:int = selectedIndex;
			if (dataProvider.length == 0) return;
			
			if (dataProvider is IList) 
				dataProvider.removeItemAt(closedTab);
			
			//adjust selectedIndex appropriately
			if (dataProvider.length == 0) {
				selectedIndex = -1;
			} else if (closedTab < selectedTab) {
				selectedIndex = selectedTab - 1;
			} else if (closedTab == selectedTab) {
				selectedIndex = (selectedTab == 0 ? 0 : selectedTab - 1);
			} else {
				selectedIndex = selectedTab;
			}
		}
		
		protected override function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == dataGroup) {
				dataGroup.addEventListener(EPTabBarEvent.CLOSE_TAB, closeHandler);
			}
		}
		
		protected override function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == dataGroup) {
				dataGroup.removeEventListener(EPTabBarEvent.CLOSE_TAB, closeHandler);
			}
		}
	}
}