package com.flexutil.ui.textinput {
	import com.flexutil.skins.ClearTextInputSkin;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import spark.components.Button;
	import spark.components.TextInput;

	public class ClearTextInput extends PromptingTextInput {

		private static const classConstructed:Boolean = classConstruct();

		private static function classConstruct():Boolean {
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			if (!styleManager.getStyleDeclaration("com.flexutil.ui.textinput.PromptingTextInput.ClearTextInput")) {
				var css:CSSStyleDeclaration = new CSSStyleDeclaration(null, styleManager);
				css.defaultFactory = function():void {
					this.skinClass = ClearTextInputSkin;
				}
				styleManager.setStyleDeclaration("com.flexutil.ui.textinput.ClearTextInput", css, true);
			}
			return true;
		}

		[SkinPart(required="false")]
		public var clearButton:Button;

		public function ClearTextInput() {
			super();
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == clearButton) {
				clearButton.addEventListener(MouseEvent.CLICK, clearButtonClicked);
			}
		}

		override protected function partRemoved(partName:String, instance:Object):void {
			super.partRemoved(partName, instance);
			if (instance == clearButton) {
				clearButton.removeEventListener(MouseEvent.CLICK, clearButtonClicked);
			}
		}

		private function clearButtonClicked(event:MouseEvent):void {
			if (text.length > 0) {
				text = "";
			}
		}

	}
}