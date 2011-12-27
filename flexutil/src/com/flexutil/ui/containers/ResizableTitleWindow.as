package com.flexutil.ui.containers
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import mx.containers.TitleWindow;
	import mx.controls.Button;
	import mx.managers.CursorManager;
	
	public class ResizableTitleWindow extends TitleWindow
	{
		
		[Embed(source="assets/icons/resizeCursor.gif")]
		private static var CURSOR_CLASS:Class;
		
		private static var CURSOR_X_OFFSET:Number = -10;
		
		private static var CURSOR_Y_OFFSET:Number = -10;
		
		public function ResizableTitleWindow()
		{
		}
		
		public var resizeHandleSize:int = 10;
		
		private var m_dragStartMouseX:Number;
		
		private var m_dragStartMouseY:Number;
		
		private var m_resizeHandle:Button;
		
		private var m_startHeight:Number;
		
		private var m_startWidth:Number;
		
		override protected function createChildren():void
		{
			super.createChildren();
			
			m_resizeHandle = new Button();
			m_resizeHandle.width = resizeHandleSize;
			m_resizeHandle.height = resizeHandleSize;
			m_resizeHandle.alpha = 0.0;
			m_resizeHandle.focusEnabled = false;
			
			m_resizeHandle.addEventListener(MouseEvent.ROLL_OVER, rollOverHandler, false, 0, true);
			m_resizeHandle.addEventListener(MouseEvent.ROLL_OUT, rollOutHandler, false, 0, true);
			m_resizeHandle.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			
			rawChildren.addChild(m_resizeHandle);
		}
		
		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			
			m_resizeHandle.x = this.width - resizeHandleSize * .5;
			m_resizeHandle.y = this.height - resizeHandleSize * .5;
			m_resizeHandle.width = m_resizeHandle.height = resizeHandleSize;
		}
		
		private function enterFrameHandler(event:Event):void
		{
			const dragAmountX:Number = parent.mouseX - m_dragStartMouseX;
			const dragAmountY:Number = parent.mouseY - m_dragStartMouseY;
			
			if (parent.mouseX < parent.width && parent.mouseY < parent.height)
			{
				this.width = Math.max(m_startWidth + dragAmountX, minWidth);
				this.height = Math.max(m_startHeight + dragAmountY, minHeight);
			}
		}
		
		/**
		 * Mouse down on any resize handle.
		 */
		private function mouseDownHandler(event:MouseEvent):void
		{
			setCursor();
			
			m_dragStartMouseX = parent.mouseX;
			m_dragStartMouseY = parent.mouseY;
			
			m_startWidth = this.width;
			m_startHeight = this.height;
			
			systemManager.addEventListener(Event.ENTER_FRAME, enterFrameHandler, false, 0, true);
			systemManager.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			systemManager.stage.addEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler, false, 0, true);
		}
		
		private function mouseLeaveHandler(event:Event):void
		{
			mouseUpHandler();
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
		}
		
		private function mouseUpHandler(event:MouseEvent = null):void
		{
			systemManager.removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
			systemManager.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			systemManager.stage.removeEventListener(Event.MOUSE_LEAVE, mouseLeaveHandler);
			
			CursorManager.removeCursor(CursorManager.currentCursorID);
		}
		
		private function rollOutHandler(event:MouseEvent):void
		{
			if (!event.buttonDown)
			{
				CursorManager.removeCursor(CursorManager.currentCursorID);
			}
		}
		
		private function rollOverHandler(event:MouseEvent):void
		{
			if (!event.buttonDown)
			{
				setCursor();
			}
		}
		
		private function setCursor():void
		{
			CursorManager.removeCursor(CursorManager.currentCursorID);
			CursorManager.setCursor(CURSOR_CLASS, 2, CURSOR_X_OFFSET, CURSOR_Y_OFFSET);
		}
	}
}
