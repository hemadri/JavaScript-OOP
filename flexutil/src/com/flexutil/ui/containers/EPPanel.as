package com.flexutil.ui.containers
{
	import com.flexutil.skins.EPPanelSkin;
	
	import flash.events.MouseEvent;
	
	import mx.controls.Image;
	import mx.controls.LinkButton;
	import mx.core.UIComponent;
	
	import spark.components.HGroup;
	import spark.components.Label;
	import spark.components.Panel;
	import spark.effects.Scale3D;
	import spark.effects.easing.Bounce;
	
	/**
	 * 
	 *  Adds status text to the spark panel, uses EPPanelSkin
	 * @author Hemadri (hemadri@hemadri.com)
	 */	
	[Event (name="statusIconClick", type="flash.events.Event")]
//	[Event (name="aboutLblClick", type="flash.events.Event")]
	public class EPPanel extends Panel
	{
		public function EPPanel()
		{
			super();
			//			TODO: Need to write the below in external CSS file
			this.setStyle('skinClass',com.flexutil.skins.EPPanelSkin);
		}
		
		//----------------------------------
		//  statusField
		//---------------------------------- 
		
		[SkinPart(required="false")]
		public var statusDisplay:Label;
		
		[SkinPart(required="false")]
		public var statusIcon:Image;
		
		[SkinPart(required="false")]
		public var titleGroup:HGroup;
		
		[SkinPart(required="false")]
		public var aboutLink:LinkButton;
		
		public var aboutNotes:String;
		//----------------------------------
		//  status
		//----------------------------------
		
		/**
		 *  @private
		 */
		private var _status:String = "";
		
		private var _statusIconSrc:Object;
		
		private var _titleChildren:UIComponent;
		
		/**
		 *  @private
		 */
		private var statusChanged:Boolean;
		
		public function get titleChildren():UIComponent
		{
			return _titleChildren;
		}

		public function set titleChildren(value:UIComponent):void
		{
			_titleChildren = value;
			
			if(titleGroup)
			{
				if(titleGroup.numElements > 0)
					titleGroup.removeAllElements();
			
				titleGroup.addElement(titleChildren)
			}
		}

		public function get statusIconSrc():Object
		{
			return _statusIconSrc;
		}
		
		public function set statusIconSrc(value:Object):void
		{
			_statusIconSrc = value;
			statusIcon.source = _statusIconSrc;
		}
		
		[Bindable]
		
		/**
		 *  status displayed in the status bar. 
		 *
		 *  @default ""
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10
		 *  @playerversion AIR 1.5
		 *  @productversion Flex 4
		 */
		public function get status():String 
		{
			return _status;
		}
		
		/**
		 *  @private
		 */
		public function set status(value:String):void 
		{
			_status = value;
			
			if (statusDisplay)
			{
				statusDisplay.text = status;
				applyStatusEffect();
			}
		}
		
		private function applyStatusEffect():void
		{
			var scale:Scale3D = new Scale3D(statusDisplay);
			scale.scaleXFrom = 0;
			scale.scaleXTo = 1;
			scale.scaleYFrom = 0;
			scale.scaleYTo = 1; 
			scale.duration = 1000;
			scale.easer = new Bounce();
			scale.play();
			
		}
		
		/**
		 *  @private
		 */
		override protected function partAdded(partName:String, instance:Object):void
		{
			super.partAdded(partName, instance);
			
			if (instance == statusDisplay)
			{
				statusDisplay.text = status;
			}
			else
			if(instance == statusIcon)
			{
				statusIcon.source = statusIconSrc;
				statusIcon.addEventListener(MouseEvent.CLICK, statusIconClick);
			}
			if(instance == titleGroup)
			{
				if(titleGroup && titleChildren)
				{ 
					if(titleGroup.numElements > 0)
						titleGroup.removeAllElements();
					
					titleGroup.addElement(titleChildren)
				}
			}
			if(instance == aboutLink)
			{
				if(aboutNotes && aboutNotes.length >0)
				{
					aboutLink.visible =true;
					aboutLink.toolTip = 'About '+title;
					aboutLink.addEventListener(MouseEvent.CLICK, aboutlblClick);
				}
				else
					aboutLink.visible =false;
			}
		}
		
		private function aboutlblClick(event:MouseEvent):void
		{
//			dispatchEvent(new Event('aboutLblClick'));
			if(aboutNotes.length >300)
				EPPopup.show(aboutNotes, 'About '+title,500,400);
			else
				EPPopup.show(aboutNotes, 'About '+title,350,250);
		}
		private function statusIconClick(event:MouseEvent):void
		{
			dispatchEvent(new Event('statusIconClick'));
		}
		
		override public function set title(value:String):void
		{
			super.title = value;
			if(aboutLink)
				aboutLink.toolTip = 'About '+title;
		}
	}
}