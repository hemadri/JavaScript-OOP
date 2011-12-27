package com.flexutil.ui.containers
{
	import mx.containers.FormItem;
	import mx.controls.Text;
	import mx.core.FlexGlobals;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	import mx.styles.StyleManager;

/**
 * EPFormItem allows to use
 *  - Multiline labels
 *  - Selectable labels
 *  - Max width labels
 */			
	public class EPFormItem extends FormItem 
	{
		public var maxLabelWidth:Number = 200;
		public var text:Text;
		public var selectable:Boolean = false;
		public var multiline:Boolean = true;
		
		public function EPFormItem() {
			super();
		}
			
		override protected function createChildren():void 
		{
				super.createChildren();
				itemLabel.maxWidth = maxLabelWidth;
				if (multiline) {
					itemLabel.visible = false;
					text = new Text();
					
					text.setStyle("textAlign", "center");
					text.selectable = selectable;
					
					var labelStyleName:String = getStyle("labelStyleName");
					if (labelStyleName) {
						
						var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
						var styleDecl:CSSStyleDeclaration = styleManager.getStyleDeclaration("." + labelStyleName);
						if (styleDecl) text.styleDeclaration = styleDecl;
					}
					text.verticalCenter = 0;
					rawChildren.addChild(text);
				} else {
					itemLabel.selectable = selectable;
				}
			}
		
			override protected function commitProperties():void 
			{
				super.commitProperties();
				if (multiline) {
					text.text = itemLabel.text;
				}
			}
			
			override protected function measure():void 
			{
				super.measure();
				if (multiline) {
					measuredMinHeight = Math.max(measuredMinHeight, text.measuredMinHeight);
					measuredHeight = Math.max(measuredHeight, text.measuredHeight);
				}
			}
			
			override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void 
			{
				super.updateDisplayList(unscaledWidth, unscaledHeight);
				if (multiline) {
					text.explicitWidth = itemLabel.width;
					text.validateNow();
					text.setActualSize(itemLabel.width, text.measuredHeight + 3);
					text.validateSize();
				}
			}
	}
}