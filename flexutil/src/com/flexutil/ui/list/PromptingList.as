package com.flexutil.ui.list {
	import com.flexutil.skins.PromptingListSkin;
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import spark.components.Label;
	import spark.components.List;

	/**
	 * The styleName to use for the prompt label.
	 */
	[Style(name="promptStyleName", type="String")]

	public class PromptingList extends List {

		private static const classConstructed:Boolean = classConstruct();

		private static function classConstruct():Boolean {
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			if (!styleManager.getStyleDeclaration("com.flexutil.ui.list.PromptingList")) {
				var css:CSSStyleDeclaration = new CSSStyleDeclaration(null, styleManager);
				css.defaultFactory = function():void {
					this.skinClass = PromptingListSkin;
				}
				styleManager.setStyleDeclaration("com.flexutil.ui.list.PromptingList", css, true);
			}
			return true;
		}

		[SkinPart(required="false")]
		[Inspectable(environment="none")]
		public var promptLabel:Label;

		private var _prompt:String = "";

		public function PromptingList() {
			super();
		}

		[Inspectable(category="Common", defaultValue="")]
		[Bindable("promptChanged")]
		public function set prompt(value:String):void {
			if (value != _prompt) {
				_prompt = value;
				if (promptLabel) {
					promptLabel.text = value;
				}
				dispatchEvent(new Event("promptChanged"));
			}
		}

		public function get prompt():String {
			return _prompt;
		}

		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == promptLabel) {
				promptLabel.text = prompt;
			}
		}

	}
}