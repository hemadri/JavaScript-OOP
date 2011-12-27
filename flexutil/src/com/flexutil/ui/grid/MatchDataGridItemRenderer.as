/*
 * Copyright (c) 2009  Stefan Bistram
 * All rights reserved.
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is 
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in 
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN 
 * THE SOFTWARE.
 */
package com.flexutil.ui.grid {
	
import com.flexutil.utils.LogUtils;

import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.StyleSheet;

import mx.controls.Label;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.ListEvent;
import mx.logging.ILogger;

internal class MatchDataGridItemRenderer extends Label {
	
	private static const MARK_TAG:String   = "<font color='#0000ff'><b>";
	private static const MARK_UNTAG:String = "</b></font>";	
	
	private var hoverStyles:String = "a:hover { color: #ff00ff; text-decoration: underline; } a { color: #00ffff; text-decoration: underline; }";

	private var _log:ILogger = LogUtils.getLogger(this);
		
	public function MatchDataGridItemRenderer() {
		super();
		selectable = false;	// must be true for links!
		addEventListener(TextEvent.LINK, linkHandler);
		
		//experimental stuff for rollOver
		//addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
		//addEventListener(MouseEvent.MOUSE_OUT,  onMouseOut);
		
		/*
		http://livedocs.adobe.com/flex/3/html/help.html?content=textcontrols_04.html
		*/
		setupLinkStyle();

	}
			
	private function linkHandler(e:TextEvent):void {
		var event:ListEvent = new ListEvent(MatchDataGrid.MATCH_LINK);
		event.itemRenderer = this;
		event.columnIndex = listData.columnIndex;
		event.rowIndex = listData.rowIndex;
		event.reason = e.text;	// reused...
		// dispatch it as an event for the MatchDataGrid
		//_log.debug("linkHandler: dispatch, event={0}", event);
		owner.dispatchEvent(event);
	}	
	
	/**
	 *	For link tags if its not alway underlined (see below)
	 *  TODO show underline only if mouse hovers over text, not cell
	 */
	private function onMouseOver(event:MouseEvent):void {
		if (htmlText.toLowerCase().indexOf("<a href") != -1) {
			setStyle("textDecoration", "underline");
		}
	} 

	private function onMouseOut(event:MouseEvent):void {
		setStyle("textDecoration", "none");
	} 
	
	/**
	 * @see http://livedocs.adobe.com/flex/3/html/help.html?content=textcontrols_04.html
	 */
	private function setupLinkStyle ():void {
		var ss:StyleSheet = new StyleSheet();
		ss.parseCSS(hoverStyles);
		//styleSheet = ss;	// doesn't work
	}	
	
	/** 
	 * Make sure that HTML text will be set as HTML text!
	 * A '<' sign has to be shown via ....todo.. 
	 */
	override public function set text(value:String):void {
		//_log.debug("set text: value={0}", value);
		var isHTML:Boolean = false;	// true if its a link or a search match
		var isLink:Boolean = false;	// we don't use HTML except for links
		
		// check if it is a link
		if (value.indexOf("</a>") != -1) {
			isLink = isHTML = true;
			var startLink:String = value.substring(0, value.indexOf(">") + 1);
			// extract the text in a fast and simple way
			value = value.substring(value.indexOf(">") + 1);
			value = value.substring(0, value.indexOf("<"));
		}
		
		// mark the search match with HTML tag if column part of the search
		if (listData.owner is MatchDataGrid) {
			var grid:MatchDataGrid = listData.owner as MatchDataGrid;
			var textFields:Array = grid.matchFilter.textFields;
			if (textFields.length > 0) {	// "" match all, but no text mark
				var dataField:String = (grid.columns[listData.columnIndex] as DataGridColumn).dataField;
				var dataFields:Array = grid.matchFilter.dataFields;
				//_log.debug("set text: dataField={0}, dataFields={1}", dataField, dataFields);
				var index:int = dataFields.indexOf(dataField);
				if (index != -1) {
					var searchText:String = textFields[index];
					if (searchText.length > 0) {
						var matchIndex:int = grid.matchFilter.matchText(value, searchText);
						if (matchIndex != -1) {
							value = htmlMatch(value, searchText.length, matchIndex);
							isHTML = true;
						}
					}
				}
			}
		}
		
		// is it an <anchor> text?
		if (isLink == true) {
        	setStyle("textDecoration", "underline");
        	setStyle("color", "#0000FF");				// all links in blue
        	selectable = true;							// must be true to follow the link!
			isHTML = true;
			value = startLink + value + "</a>";
		} else {
        	setStyle("textDecoration", "none");
        	setStyle("color", "#000000");				// ...otherwise black
			selectable = false;
		}
		
		if (isHTML == true) {
			super.htmlText = value;
		} else {
			super.text = value;
		}
				
	}
	
	override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
    	super.updateDisplayList(unscaledWidth, unscaledHeight);
        var grid:MatchDataGrid = listData.owner as MatchDataGrid; 
    	if (grid.decoratorFunction != null) {
    		grid.decoratorFunction(this, unscaledWidth, unscaledHeight);
    	}
    }
    
	/**
	 * Helper method to decorate the match in the original string.
	 */        
	private function htmlMatch(value:String, len:int, index:int):String {
       	return value.substr(0, index).concat(MARK_TAG, value.substr(index, len), MARK_UNTAG, value.substr(index + len));
	}
    	
}
}
