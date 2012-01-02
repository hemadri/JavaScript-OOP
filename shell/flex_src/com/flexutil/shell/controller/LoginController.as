package com.flexutil.shell.controller
{
	import com.flexutil.shell.events.LoginEvent;
	import com.flexutil.shell.pm.AppNavigationPM;
	import com.flexutil.shell.vo.LogonUser;
	
	import flash.external.ExternalInterface;
	
	import mx.controls.Alert;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.mxml.RemoteObject;
	
	import org.swizframework.controller.AbstractController;

	public class LoginController extends AbstractController {
		
		
		
		private var userName:String;
		private var orclPassword:String;
		private var docPassword:String;
		
		
		[Inject("loginService")]
		public var loginService:RemoteObject;
		
		[Inject("logoutService")]
		public var logoutService:RemoteObject;
		
		[Inject("appNavigationPM")]
		public var appNavigationPM:AppNavigationPM;
		
		[EventHandler( event="LoginEvent.LOG_IN", properties="user" )]
		public function validateLogin(user:LogonUser):void {
			this.userName = user.userName;
			this.orclPassword=user.orclPassword;
			this.docPassword = user.docPassword;
			executeServiceCall(loginService.validateLogin(userName,orclPassword,this.docPassword),validateLogin_success,validateLogin_failure);
		}

		[EventHandler( event="LoginEvent.LOG_OUT")]
		public function logoutUser():void {
			executeServiceCall(loginService.logoutUser(),logout_success);
		}

		private function logout_success(event:ResultEvent):void
		{
			ExternalInterface.call('window.location.reload()');
		}
									   

		private function validateLogin_success(event:ResultEvent):void {
			appNavigationPM.logonUser = event.result as LogonUser;
			appNavigationPM.logonUser.userName = userName;
			appNavigationPM.logonUser.orclPassword = orclPassword;
				
				dispatcher.dispatchEvent(new LoginEvent(LoginEvent.LOGIN_SUCCESS));
		}
		
		//LoginEvent.LOG_OUT Event is required.....
		
		private function validateLogin_failure(event:FaultEvent):void {
			var loginEvent:LoginEvent = new LoginEvent(LoginEvent.LOGIN_FAILED);
			loginEvent.errorMessage = event.fault.faultString;
			dispatcher.dispatchEvent(loginEvent);
		}
	}
}