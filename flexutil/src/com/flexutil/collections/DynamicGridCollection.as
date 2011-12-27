package com.flexutil.collections
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class DynamicGridCollection extends ArrayCollection
	{
		public function DynamicGridCollection(source:Array=null)
		{
			super(source);
		}
		

		private var _displayColumns:ArrayCollection;
	
		public function set displayColumns(value:ArrayCollection):void {
			this._displayColumns = value;
		}
		public function get displayColumns():ArrayCollection {
			return this._displayColumns;
		}
		
	}
}