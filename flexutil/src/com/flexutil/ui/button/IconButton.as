package com.flexutil.ui.button {
	import com.flexutil.skins.IconButtonSkin;
	
	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import spark.components.Button;

	[Style(name="icon", type="Class")]
	[Style(name="paddingLeft", type="Number")]
	[Style(name="paddingRight", type="Number")]
	[Style(name="paddingTop", type="Number")]
	[Style(name="paddingBottom", type="Number")]
	[Style(name="labelPlacement", type="String", enumeration="left,right,top,bottom")]

	/**
	 * Adds the "icon" style, and some padding for the horizontal layout.
	 */
	public class IconButton extends Button {

		private static const classConstructed:Boolean = classConstruct();

		private static function classConstruct():Boolean {
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			if (!styleManager.getStyleDeclaration("com.flexutil.ui.button.IconButton")) {
				var css:CSSStyleDeclaration = new CSSStyleDeclaration(null, styleManager);
				css.defaultFactory = function():void {
					this.skinClass = IconButtonSkin;
					this.paddingLeft = 0;
					this.paddingTop = 0;
					this.paddingRight = 0;
					this.paddingBottom = 0;
					this.labelPlacement = "right";
				}
				styleManager.setStyleDeclaration("com.flexutil.ui.button.IconButton", css, true);
			}
			return true;
		}

		public function IconButton() {
			super();
		}


	}
}