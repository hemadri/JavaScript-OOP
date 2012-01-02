package com.flexutil.shell.events
{
	
	import com.flexutil.shell.vo.LogonUser;
	
	import flash.events.Event;

	public class LoginEvent extends Event
	{
		public static const LOG_IN:String = "login";
		public static const LOG_OUT:String = "logout";
		
		public static const LOGIN_SUCCESS:String = "loginSuccess";
		public static const LOGIN_FAILED:String = "loginFailed";
		
		public var user:LogonUser;
		public var errorMessage:String;
		
		
		public function LoginEvent( type:String )
		{
			super( type, true );
		}
	}
}