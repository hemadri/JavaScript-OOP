package com.aramco.rcd.modules.paramselection.controller
{
	import com.aramco.rcd.modules.paramselection.model.IParamMenu;
	import com.aramco.rcd.modules.paramselection.pm.ParamSelectionPM;
	import com.aramco.rcd.modules.paramselection.vo.ParamSelectionPackage;
	import com.aramco.rcd.modules.paramselection.events.ParamSelectionEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import org.swizframework.controller.AbstractController;
	
	public class ParamSelectionController extends AbstractController
	{
		
		[Inject("paramSelectionService")]
		public var paramSelectionService:RemoteObject;
		
		[Inject("paramSelectionPM")]
		public var paramSelectionPM:ParamSelectionPM;
		
		
		public function ParamSelectionController()
		{
			super();
		}
		
		
		[EventHandler( event="ParamSelectionEvent.HEADER", properties="menuOperation" )]
		public function getHeaderValues(menuOperation:String):void {
			executeServiceCall(paramSelectionService.getHeaderData(menuOperation), selectionHeader_Success);
		}
		
		private function selectionHeader_Success(event:ResultEvent):void
		{
			paramSelectionPM.initPM(event.result as ParamSelectionPackage);
		}
		
	}
}