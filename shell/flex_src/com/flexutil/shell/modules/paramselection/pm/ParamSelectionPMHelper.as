package com.flexutil.shell.modules.paramselection.pm
{
	public class ParamSelectionPMHelper
	{
		protected function getCurrentShift():String
		{
			var date:Date = new Date();
			var hours:Number = date.getHours();
			if(hours >= 6 && hours < 14)
				return "2";
			else if(hours >= 14 && hours < 22)
				return "3";
			else  if(hours >= 22 && hours < 6)
				return "1";
			return "0";
		}
	}
}