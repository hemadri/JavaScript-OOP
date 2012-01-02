package com.aramco.rcd.modules.paramselection.pm
{
//	import com.aramco.ep.utils.DateUtil;
	import com.aramco.rcd.events.ViewStackEvent;
	
	import com.aramco.rcd.modules.paramselection.views.SelectionHeader;
	import com.aramco.rcd.modules.paramselection.vo.ParamSelectionPackage;
	
	import flash.events.IEventDispatcher;
	
	import mx.controls.Alert;

	public class ParamSelectionPM extends ParamSelectionPMHelper
	{ 
		[Bindable] public var paramsData:ParamSelectionPackage;
		
		[Bindable] public var paramHeader:SelectionHeader;
		
		[Dispatcher] 
		public var dispatcher:IEventDispatcher;
		
		
		[ViewAdded]
		public function config(view:SelectionHeader):void
		{
			this.paramHeader = view;
		}
		
		public function initPM(result:ParamSelectionPackage):void
		{
			paramsData = result;
			dispatcher.dispatchEvent(new ViewStackEvent(ViewStackEvent.VIEW_CHANGED,paramsData.menuOperation));
			
//			TODO: initial settings or dispatch retrieve directly
			switch(paramsData.menuOperation)
			{
//				case IParamMenu.PROFILE_ADMINISTRATION :
//					dispatcher.dispatchEvent(new ProfileEvent(ProfileEvent.RETRIEVE));
//					break;
			}
		}
		public function retrieve():void
		{
			switch(paramsData.menuOperation)
			{
//				case IParamMenu.PREWAP_WELL :
//					if(paramHeader.wellNameCombo.selectedValue != null)
//					{
//						var preWapEvent:PreWapEvent = new PreWapEvent(PreWapEvent.RETRIEVE);
//						preWapEvent.preWapSeq = paramHeader.wellNameCombo.selectedValue;
//						dispatcher.dispatchEvent(preWapEvent);
//					}
//					else
//						Alert.show('Well Name is not available','Error');
//					break;
			}
		}
		
	}
}