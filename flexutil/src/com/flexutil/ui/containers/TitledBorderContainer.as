package com.flexutil.ui.containers {
	import com.flexutil.skins.TitledBorderContainerSkin;
	
	import flash.events.Event;
	
	import mx.core.FlexGlobals;
	import mx.graphics.IFill;
	import mx.graphics.IStroke;
	import mx.skins.halo.TitleBackground;
	import mx.styles.CSSStyleDeclaration;
	import mx.styles.IStyleManager2;
	
	import spark.components.Label;
	import spark.components.SkinnableContainer;
	import spark.layouts.BasicLayout;
	import spark.layouts.HorizontalLayout;
	import spark.layouts.TileLayout;
	import spark.layouts.VerticalLayout;
	
	/**
	 *  Alpha level of the color defined by the <code>backgroundrColor</code> style.
	 *  Valid values range from 0.0 to 1.0.
	 *  @default 1.0
	 */
	[Style(name="backgroundAlpha", type="Number", inherit="no")]
	
	/**
	 *  Background color.
	 *  @default 0xFFFFFF
	 */
	[Style(name="backgroundColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  Determines if the background is visible or not.
	 *  If <code>false</code>, then no background is visible
	 *  @default true
	 */
	[Style(name="backgroundVisible", type="Boolean", inherit="no")]
	
	/**
	 *  Alpha level of the color defined by the <code>borderColor</code> style.
	 *  Valid values range from 0.0 to 1.0.
	 *  @default 1.0
	 */
	[Style(name="borderAlpha", type="Number", inherit="no")]
	
	/**
	 *  Color of the border.
	 *  @default 0x000000
	 */
	[Style(name="borderColor", type="uint", format="Color", inherit="no")]
	
	/**
	 *  Determines if the border is visible or not.
	 *  If <code>false</code>, then no border is visible
	 *  except a border set by using the <code>borderStroke</code> property.
	 *  @default true
	 */
	[Style(name="borderVisible", type="Boolean", inherit="no")]
	
	/**
	 *  The stroke weight for the border.
	 *  @default 1
	 */
	[Style(name="borderWeight", type="Number", format="Length", inherit="no")]
	
	/**
	 *  Radius of the curved corners of the border.
	 *  @default 0
	 */
	[Style(name="cornerRadius", type="Number", format="Length", inherit="no")]
	
	/**
	 *  If <code>true</code>, the container has a visible drop shadow.
	 *  @default false
	 */
	[Style(name="dropShadowVisible", type="Boolean", inherit="no")]
	
	// Layout styles:
	/** Left side padding */
	[Style(name="paddingLeft", type="Number")]
	/** Right side padding */
	[Style(name="paddingRight", type="Number")]
	/** Padding at the top */
	[Style(name="paddingTop", type="Number")]
	/** Padding at the bottom */
	[Style(name="paddingBottom", type="Number")]
	
	/** Horizontal or vertical gap (VerticalLayout and HorizontalLayout only) */
	[Style(name="gap", type="Number")]
	/** Horizontal gap between columns (TileLayout and HorizontalLayout only) */
	[Style(name="horizontalGap", type="Number")]
	/** Vertical gap between rows (TileLayout and VerticalLayout only) */
	[Style(name="verticalGap", type="Number")]
	/** Layout horizontal alignment (TileLayout, HorizontalLayout and VerticalLayout only) */
	[Style(name="horizontalAlign", type="String", enumeration="left,center,right,justify")]
	/** Layout vertical alignment (TileLayout, HorizontalLayout and VerticalLayout only) */
	[Style(name="verticalAlign", type="String", enumeration="top,middle,bottom,justify")]
	/** Width of the columns (TileLayout only) */
	[Style(name="columnWidth", type="Number")]
	/** Height of the rows (TileLayout only) */
	[Style(name="rowHeight", type="Number")]
	
	/**
	 *  Style declaration name for the text in the title border.
	 *  The default value is <code>"windowStyles"</code>,
	 *  which causes the title to have boldface text.
	 *  @default "windowStyles"
	 */
	[Style(name="titleStyleName", type="String", inherit="no")]
	
	
	/**
	 * The TitledBorderContainer class is similar to the BorderContainer class.
	 * It renders a border and a background, both which can customized.
	 * But it also has a title Label that appears in the top left corner of the box.
	 * It also supports rounded corners and exposes many of the layout styles as all.
	 * The titleLabel can be styled by setting the <b>titleStyleName</b> style.
	 *
	 */
	public class TitledBorderContainer extends SkinnableContainer {
		
		
		override public function stylesInitialized():void {
			super.stylesInitialized();
			this.setStyle("skinClass",Class(TitledBorderContainerSkin));
			var styleManager:IStyleManager2 = FlexGlobals.topLevelApplication.styleManager;
			var style:CSSStyleDeclaration = styleManager.getStyleDeclaration("com.flexutil.ui.containers.TitledBorderContainer");
			if (!style) {
				style = new CSSStyleDeclaration();
			}
			style.defaultFactory = function():void {
				this.backgroundAlpha = 1;
				this.backgroundColor = 0xffffff;
				this.backgroundVisible = true;
				this.borderAlpha = 1;
				this.borderColor = 0x0;
				this.borderWeight = 1;
				this.borderVisible = true;
				this.cornerRadius = 5;
				this.dropShadowVisible = true;
				this.titleStyleName = "windowStyles";
				this.paddingLeft = 10;
				this.paddingRight = 10;
				this.paddingBottom = 10;
				this.paddingTop = 8;
				this.skinClass = TitledBorderContainerSkin;
			};
			styleManager.setStyleDeclaration("com.flexutil.ui.containers.TitledBorderContainer", style, true);
		}
		
		
		[SkinPart(required="true")]
		[Inspectable(environment="none")]
		public var titleLabel:Label;
		
		private var _title:String;
		
		private var titleChanged:Boolean = false;
		
		/**
		 *  Constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function TitledBorderContainer() {
			super();
			layoutMode = 'vertical';
		}
		
		private var _layoutMode:String;
		
		
		[Inspectable(category="General", enumeration="vertical,horizontal,tile,basic", defaultValue="vertical")]
		public function get layoutMode():String
		{
			return _layoutMode;
		}
		
		public function set layoutMode(value:String):void
		{
			_layoutMode = value;
			
			setLayout(_layoutMode);
		}
		
		private function setLayout(layoutType:String):void
		{
			switch (layoutType)
			{
				case 'horizontal':
					this.layout = new HorizontalLayout();
					break;
				case 'vertical':
					this.layout = new VerticalLayout();
					break;
				case 'tile':
					var tile:TileLayout =new TileLayout();
					tile.orientation = 'rows';
					this.layout = tile; 
					break;
				case 'basic':
					this.layout = new BasicLayout();
					break;
			}
		}
		
		
		[Bindable("titleChanged")]
		[Inspectable(category="General")]
		public function get title():String {
			return _title;
		}
		
		public function set title(value:String):void {
			if (_title != value) {
				_title = value;
				titleChanged = true;
				invalidateProperties();
				dispatchEvent(new Event("titleChanged"));
			}
		}
		
		override protected function partAdded(partName:String, instance:Object):void {
			super.partAdded(partName, instance);
			if (instance == titleLabel) {
				titleLabel.text = title;
			}
		}
		
		override protected function commitProperties():void {
			super.commitProperties();
			
			if (titleChanged) {
				titleChanged = false;
				if (titleLabel) {
					titleLabel.text = title;
				}
			}
		}
		
	}
}
