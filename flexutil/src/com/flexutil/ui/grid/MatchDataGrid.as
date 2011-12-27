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

import mx.controls.DataGrid;
import mx.core.ClassFactory;
import mx.events.ListEvent;
import mx.logging.ILogger;

public class MatchDataGrid extends DataGrid {
	
	public static const MATCH_LINK:String = "matchLink";
	
	[Bindable] protected var _matchFactory:ClassFactory = new ClassFactory(MatchDataGridItemRenderer);
	[Bindable] protected var _matchDateFactory:ClassFactory = new ClassFactory(MatchDataGridDateItemRenderer);
	

	[Bindable] public var matchFilter:MatchFilter;

	// decorator function
	protected var _decoratorFunction:Function = null;
	
	private var _log:ILogger = LogUtils.getLogger(this);

	public function MatchDataGrid() {
		super();
		
		matchFilter = new MatchFilter(this);
		
		// a link event, e.g.: "<a href=\"event:" + email + "\">" + email + "</a>"
		addEventListener(MATCH_LINK, linkHandler);
		addEventListener(ListEvent.ITEM_DOUBLE_CLICK, doubleClickHandler);
	}
		
	protected function linkHandler(event:ListEvent):void {
		_log.debug("linkHandler: link event={0}, link={1}", event, event.reason);
	}
	
	protected function doubleClickHandler(event:ListEvent):void {
		_log.debug("dblClickHandler: dbl click event={0}, column={1}", event, event.columnIndex);
	}
	
	public function set decoratorFunction(decorator:Function):void {
		_decoratorFunction = decorator;
	}
	
	public function get decoratorFunction():Function {
		return _decoratorFunction;
	}
	
/* 	override public function set dataProvider(value:Object):void {
		//_log.debug("set dataProvider");
		if (value != null) {
			if (value is XMLList) {
   				value = new XMLListCollection(value as XMLList).toArray();
			} else if (value is Array == false && value is ArrayCollection == false) {
				throw new Error("dataProvider must be an Array or an ArrayCollection");
			}
		}
		super.dataProvider = value;
		matchFilter.updateData();
	} */
	
	//
	// MatchFilter wrapper methods
	//
	
	public function match(textFields:Object = null, dataFields:Object = null):void  {		
		matchFilter.match(textFields, dataFields);			
	}
	public function useFilter(value:Boolean):void {				matchFilter.useFilter =value;			}	
	public function useWholeWord(value:Boolean):void {			matchFilter.useWholeWord = value;		}	
	public function useRegEx(value:Boolean):void {				matchFilter.useRegEx = value;			}	
	public function useStartPos(value:Boolean):void {			matchFilter.useStartPos = value;		}	
	public function useCaseSensitive(value:Boolean):void {		matchFilter.useCaseSensitive = value;	}	
	public function selectNext():void {							matchFilter.selectNext();				}	
	public function selectPrevious():void {						matchFilter.selectPrevious();			}	
		
}
}