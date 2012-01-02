package com.aramco.rcd.pm
{
	import com.aramco.rcd.model.ApplicationViewModel;
	import com.aramco.rcd.modules.paramselection.model.IParamMenu;
	import com.aramco.rcd.vo.LogonUser;

	public class AppNavigationPM
	{
		
		[Bindable] public var logonUser:LogonUser;

		/**
		 * Holds the ViewStack index (prespud, drilling, goc, rcd, administration) 
		 */
		[Bindable] public var viewStackIndex:int = 0;
		[Bindable] public var headerVisible:Boolean;

		/**
		 * Holds the main view instance 
		 */		
		private var indexView:index;
		
		[ViewAdded]
		public function uiLoaded(view:index):void
		{
			indexView = view;
		}
		
		[EventHandler(event="LoginEvent.LOGIN_SUCCESS")]
		public function loadMainUI():void
		{
			indexView.mainUI.visible = true;
			indexView.removeElement(indexView.loginView);
			indexView.removeElement(indexView.errorMessage);
			
			//Allow the loginview to destroy and remove from the memory
			indexView.loginView = null;
			indexView.errorMessage = null;
		}
		
		[EventHandler(event="LoginEvent.LOGIN_FAILED", properties="errorMessage")]
		public function loginFailed(errorMessage:String):void
		{
			indexView.errorMessage.text = errorMessage;
		}
		
		[EventHandler(event="ViewStackEvent.VIEW_CHANGED", properties="menuOperation")]
		public function changeViewStackIndex(menuOperation:String):void
		{
			switch(menuOperation)
			{
				case IParamMenu.HOME_SCREEN:
					viewStackIndex = ApplicationViewModel.HOME_VIEW_INDEX;
					headerVisible  = false;
					break;
				
				case IParamMenu.REPORTS:
					viewStackIndex = ApplicationViewModel.REPORTS_INDEX;
					headerVisible  = false;
					break;
				default:
					headerVisible  = false;
					break;
			}
		}
		
	}
}