package com.flexutil.ui.tabbar {
	
	import com.flexutil.events.EPTabBarEvent;
	import com.flexutil.skins.EPTabBarButtonSkin;
	
	import flash.events.MouseEvent;
	
	import mx.graphics.SolidColor;
	
	import spark.components.Button;
	import spark.components.ButtonBarButton;
	
	[Event(name='closeTab',type='events.EPTabBarEvent')]
	
	public class EPTabBarButton extends ButtonBarButton {
		
		[SkinPart(required="false")]
		public var closeButton:Button;
		
		[SkinPart(required="false")]
		public var editButton:Button;
		
		[SkinPart(required="false")]
		public var bgColor:SolidColor;

		private var _closeable:Boolean = true;
		private var _editable:Boolean  = false;

		public function EPTabBarButton() {
			super();

			//NOTE: this enables the button's children (aka the close button) to receive mouse events
			this.mouseChildren = true;
			this.setStyle('skinClass',com.flexutil.skins.EPTabBarButtonSkin2);
		}

		[Bindable]
		public function get closeable():Boolean {
			return _closeable;
		}
		public function set closeable(val:Boolean):void {
			if (_closeable != val) {
				_closeable = val;
				closeButton.visible = val;
//				labelDisplay.right = (val ? 30 : 14);
			}
		}
		
		[Bindable]
		public function get editable():Boolean {
			return _editable;
		}
		public function set editable(val:Boolean):void {
			if (_editable != val) {
				_editable = val;
				editButton.visible = val;
				//				labelDisplay.right = (val ? 30 : 14);
			}
		}
		
		private var _buttonState:String;
		

		private function closeHandler(e:MouseEvent):void {
			dispatchEvent(new EPTabBarEvent(EPTabBarEvent.CLOSE_TAB, itemIndex, true));
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			
			if (instance == closeButton) {
				closeButton.addEventListener(MouseEvent.CLICK, closeHandler);
				closeButton.visible = closeButton.includeInLayout = closeable;
				
			} 
			else if (instance == editButton) {
				editButton.visible = editButton.includeInLayout = editable;
				
			} 
			else if (instance == labelDisplay) {
//				labelDisplay.right = (closeable ? 30 : 14);
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			
			if (instance == closeButton) {
				closeButton.removeEventListener(MouseEvent.CLICK, closeHandler);
			}
		}
	}
}