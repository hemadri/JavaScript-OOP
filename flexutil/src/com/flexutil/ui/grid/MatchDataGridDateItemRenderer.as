package com.flexutil.ui.grid
{
	import mx.collections.ArrayCollection;
	import mx.controls.DateField;
	import mx.controls.Label;
	import mx.formatters.DateFormatter;
	
	public class MatchDataGridDateItemRenderer extends Label
	{
		public function MatchDataGridDateItemRenderer()
		{
			super();
		}

		[Bindable]
			private var _dataProvider:ArrayCollection;
			public function set dataProvider(value:ArrayCollection):void {
				this._dataProvider = value;
			}
			public function get dataProvider():ArrayCollection {
				return this._dataProvider;
			} 
			
			
		override public function set text(value:String):void {
			var dtFormat:String="MM/DD/YYYY";
			

 			if(value != null){
				super.text = DateField.dateToString(DateFormatter.parseDateString(value),dtFormat);  
	  	    } 
	  	    

        }
	}
}

