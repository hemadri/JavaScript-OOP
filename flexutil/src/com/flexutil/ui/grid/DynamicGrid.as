package com.flexutil.ui.grid
{
	
	
	import com.flexutil.collections.DynamicGridCollection;
	import com.flexutil.utils.LogUtils;
	
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.events.ListEvent;
	import mx.logging.ILogger;
		
	
	public class DynamicGrid extends MatchDataGrid {
		
		private var _log:ILogger = LogUtils.getLogger(this);
		private var _displayColumns:ArrayCollection;
	
		/* [Bindable]
		
		
		public function set displayColumns(value:ArrayCollection):void {
			this._displayColumns = value;
		}
		public function get displayColumns():ArrayCollection {
			return this._displayColumns;
		} */

	
		/**
		 * Constructor
		 */
		public function DynamicGrid() {
			super();
	/* 		_displayColumns = (DynamicGridCollection(this.dataProvider)).displayColumns;
			columns = createColumns();		
			labelFunction = getLabelCommon;
			decoratorFunction = decorator;
			doubleClickEnabled = true; */
	//		addEventListener(FlexEvent.CREATION_COMPLETE,onComponentComplete);
	
		}
		
		override public function set dataProvider(value:Object):void {
			super.dataProvider = value;
			
			var dgc:ArrayCollection = value as ArrayCollection;
			_displayColumns = (value as DynamicGridCollection).displayColumns;
			columns = createColumns();		
			labelFunction = getLabelCommon;
			decoratorFunction = decorator;
			doubleClickEnabled = true;
			matchFilter.updateData();
			columnSelectProvider();
		}
	
	/*  	public function onComponentComplete():void {
			columns = createColumns();		
			labelFunction = getLabelCommon;
			decoratorFunction = decorator;
			doubleClickEnabled = true;
		}	  */
		/**
		 * Create data for a combobox selection of one or all columns
		 * Add the 'All' entry for selecting all columns
		 * 
		 * @return Array of all columns headerText and dataField 
		 */	
		[Bindable] 
		public var provider:Array;
		private function columnSelectProvider():Array {
			provider = [{ label:"All", dataField:null }];
			for (var i:int = 0; i < columns.length; i++) {
				provider.push({ label:columns[i].headerText, dataField:columns[i].dataField });
			}
			return provider;
		}
					
		/**
		 * Can also be handled by listening to the event 
		 * 
		 * @see		de.sbistram.controls.MatchDataGrid 
		 * @param	event
		 */
		override protected function linkHandler(event:ListEvent):void {
			//_log.debug("linkHandler: link={0}, event={1}", event.reason, event);		
			Alert.show("IK-Nr.:" + event.reason);	// just for the demo
		}
	
	/* 	override protected function doubleClickHandler(event:ListEvent):void {
			var item:Object = event.currentTarget.selectedItem;
			var df:String = columns[event.columnIndex].dataField;
			Alert.show("Double click: row:" + event.rowIndex + ", column:" + event.columnIndex + ", value:" + item[df]); // just for the demo
		}	 */
		
		/** 
		 * @see DataGridColumn#itemToLabel
		 * @return Array of DataGridColumn
		 */
		private function createColumns():Array {
			var columns:Array = [];
			var column:DataGridColumn;
			var df:String;
			
			var columnProp:DynamicGridColumn;
			
			if (_displayColumns != null) {
				// create all columns
				for (var index:int = 0; index < _displayColumns.length; index++) {
					column = new DataGridColumn();
					
					columnProp 			 = _displayColumns.getItemAt(index) as DynamicGridColumn;
					column.dataField     = columnProp.name;	
					column.headerText    = columnProp.headerText;
					
					if (columnProp.dateField)
						column.itemRenderer  = _matchDateFactory;
					else
						column.itemRenderer  = _matchFactory;
					column.labelFunction = getLabelCommon;
					column.width 		 = columnProp.width;
			
					columns.push(column);
		
				}
			}
			
			return columns;
		}
		
		/**
		 * Common label function for all columns, can be replaced by column.labelFunction
		 * 
		 * @param	item
		 * @param	column
		 * @return 	label as String
		 * 
		 * @see mx.controls.dataGridClasses.DataGridColumn#itemToLabel
		 */
		private function getLabelCommon(item:Object, column:DataGridColumn):String {
			//_log.debug("getLabelCommon: item={0}, column={1}", item, column);
			if (item[column.dataField] == null) {
				item[column.dataField] =" ";
				// maybe not for all
				//throw new Error("Property of item can't be null, dataField = " + column.dataField);
			}
			return item[column.dataField];
		}
		
	/* 	private function getLabelIk(item:Object, column:DataGridColumn):String {
				if (item == null || item[DF_USERNAME] == undefined || item[DF_USERNAME] == null) return " ";
			return "<a href=\"event:" + item[DF_USERNAME] + "\">" + item[DF_USERNAME] + "</a>";
		} */
		
		/**
		 * Remove all HTML tags before doing the compare.
		 * 
		 * @todo The HTML stuff should be done in a more general way - maybe Gumbo ?!
		 *       Method removeHTMLTags not finished, @see LangUtils#removeHTMLTags
		 */
	/* 	private function sortCompareIk(item1:Object, item2:Object):int {
			var s1:String = HTMLUtils.stripTags(item1[DF_USERNAME]);
			var s2:String = HTMLUtils.stripTags(item2[DF_USERNAME]);
			//_log.debug("compareItemsIk: item1={0}, item2={1}", s1, s2);
			if 		(s1 > s2) return 1;
			else if (s1 < s2) return -1;
			else 			  return 0;
		} */
			
		/**
		 * Decorator method to do some DataGrid decorator stuff:
		 * 
		 *  	- font: color, size, bold, italic, underline.
		 * 
		 * Note: Because the renderer is reused we have to set/reset the values!
		 * 		 And don't use the column index if dragging columns is enabled! Instead 
		 *       use the column like it's done here.
		 * 
		 * @param	r renderer for the current cell
		 * @param	w width of the current cell
		 * @param	h heigth of the current cell
		 */
		private function decorator(r:Object, w:Number, h:Number):void {
			// Note: r.data is the original value object for the hole row
			var column:DataGridColumn = columns[r.listData.columnIndex];
			var columnProp:DynamicGridColumn;
			if (_displayColumns != null) {
				for (var index:int = 0; index < _displayColumns.length; index++) {			
					columnProp = _displayColumns.getItemAt(index) as DynamicGridColumn;
					if (columnProp.name == column.dataField) {
						if (columnProp.highlight) 
							r.setStyle("fontWeight", "bold");
						else
							r.setStyle("fontWeight", "normal");
						
						if(r.data.hasOwnProperty("status") && r.data.status == 'N')
							r.setStyle("color",getStyle("disabledColor"));
						else
							r.setStyle("color",getStyle("color"));
					}
				}	
			}
			
		}
	}
}