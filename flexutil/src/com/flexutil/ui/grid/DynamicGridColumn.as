package com.flexutil.ui.grid
{
	[Bindable]
	public class DynamicGridColumn
	{
		/**
		 * 
		 * @param name - should match the vo property names
		 * @param headerText - header display text
		 * @param width - width of the column
		 * @param highlight - used to bold the text
		 * 
		 */		
		public function DynamicGridColumn(name:String,headerText:String,width:int,highlight:Boolean)
		{
			this._name = name;
			this._headerText = headerText;
			this._width = width;
			this._highlight=highlight;
		}
		
		
		private var _width:int = 60;
		private var _highlight:Boolean;
		private var _name:String;
		private var _headerText:String;
		private var _dateField:Boolean = false;
		
		public function set dateField(value:Boolean):void {
			this._dateField = value;
		}
		public function get dateField():Boolean {
			return this._dateField;
		}
		
		public function set width(value:int):void {
			this._width = value;
		}
		public function get width():int {
			return this._width;
		}
		
		public function set highlight(value:Boolean):void {
			this._highlight = value;
		}
		public function get highlight():Boolean {
			return this._highlight;
		}
		public function set name(value:String):void {
			this._name = value;
		}
		public function get name():String {
			return this._name;
		}
		public function set headerText(value:String):void {
			this._headerText = value;
		}
		public function get headerText():String {
			return this._headerText;
		}
	}
}