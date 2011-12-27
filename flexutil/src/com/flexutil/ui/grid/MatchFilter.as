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

import flash.events.Event;

import mx.collections.ArrayCollection;
import mx.controls.dataGridClasses.DataGridColumn;
import mx.events.CollectionEvent;
import mx.logging.ILogger;

/**
 * <code>MatchFilter</code> is used by <code>MatchDataGrid</code> to do filtering
 * on the <code>ArrayCollectioin</code> of the grid and some properties
 */
internal class MatchFilter {
	
	//
	// public
	//
	
	public var useFilter:Boolean = true;
	public var useCaseSensitive:Boolean = false;		// @todo	not implemented now
	public var useStartPos:Boolean = false;				// @todo		-""-	
	public var useWholeWord:Boolean = false;			// @todo		-""-
	public var useRegEx:Boolean = false;				// @todo		-""-
	
	// for en/disable NEXT/PREVIOUS selection
    [Bindable] public var enableSelectNext:Boolean = false;
    [Bindable] public var enableSelectPrev:Boolean = false;
	
	// for showing the number of matches
	[Bindable] public var matchCount:int = 0;

	//
	// private
	//

	// reference to the DataGrid	
	private var _grid:MatchDataGrid;
	
	// 
	private var _textField:String = null;
	
	// the dataFields to search for
	private var _dataFields:Array = [];

	//  one search text per dataField
	private var _textFields:Array = [];
    
    // data for for grid
    private var _data:ArrayCollection;
    	
    // count the number of matches
	private var _matchCounter:int;
	
	// first, last and the actual match index
	private var _firstMatchIndex:int;
	private var _actualMatchIndex:int;
	private var _lastMatchIndex:int;

    // flag for internal usage
	private var _isMatch:Boolean = false;
	
	private var _log:ILogger = LogUtils.getLogger(this);

	/**
	 * Constructor
	 * @param	grid
	 */
	public function MatchFilter(grid:MatchDataGrid) {
		_grid = grid;
	}
	
	public function get dataFields():Array {
		return _dataFields;
	}
	
	public function get textFields():Array {
		return _textFields;
	}
		
	/**
	 * Called when the dataProvider of the MatchDataGrid changed.
	 */
	public function updateData():void {
		_data = _grid.dataProvider as ArrayCollection;
		_data.filterFunction = filterFunc;
		_data.addEventListener(CollectionEvent.COLLECTION_CHANGE, onCollectionChanged);
		_matchCounter = _data.length;
		updateMatchCount();
	}
	
	/**
	 * Do the match according to the given properties (see above)
	 * and the actual properties (merge). 
	 * 
	 * @param properties
	 */	
	public function match(textFields:Object = null, dataFields:Object = null):void {
		try {
			//_log.debug("match: textFields={0}, dataFields={1}", textFields, dataFields);
			_isMatch = true;	// we do a match and no sorting
			
			validateSearch(textFields, dataFields);
						
			// trigger new filtering
			_matchCounter = 0;
			_data.refresh();		
        	updateMatchCount();
        
        	// grid must be valid before we can do scrolling
			_grid.validateNow();
		
			// get the index of to first item and en/disable the UP/DOWN
			_firstMatchIndex = _actualMatchIndex = findNext();
			_lastMatchIndex = findPrevious();
			updateEnableNextPrev();
		
			// scroll grid so the first item is visible  
			if (_firstMatchIndex != -1 && useFilter == false) {
				_grid.scrollToIndex(_firstMatchIndex);
				_grid.selectedIndex = _firstMatchIndex;
			}
		} finally {
			_isMatch = false;
		}
    } 
	
	/**
	 * Method also used by the MatchDataGridRenderer
	 * 
	 * @param value
	 * @param searchText
	 * @return index if match or -1
	 * 
	 */	
	public function matchText(value:String, searchText:String):int {
		return value.toLowerCase().indexOf(searchText);
	}
	
	/**
	 * Select next match (filter off)
	 */
	public function selectNext():void {
		selectNextOrPrev(true/*next*/);
	}

	/**
	 * Select previous match (filter off)
	 */
	public function selectPrevious():void {
		selectNextOrPrev(false/*previous*/);
	}
	
	private function selectNextOrPrev(next:Boolean):void {
		if (next && !enableSelectNext || !next && !enableSelectPrev) {
			_log.warn("selectNextOrPrev: Please use flags to disable NEXT/PREVIOUS");
			return;
		}
		_actualMatchIndex = next == true ? findNext(_actualMatchIndex) : findPrevious(_actualMatchIndex);
        _grid.selectedIndex = _actualMatchIndex;
		_grid.scrollToIndex(_actualMatchIndex);
		updateEnableNextPrev();
	}

	/**
	 * If the user is doing sorting by click'n on the header
	 * we want to show the first search match (filter = off)
	 */
	private function onCollectionChanged(event:Event):void {
		//_log.debug("onCollectionChanged: _isMatch={0}, event={1}", _isMatch, event);
		if (_isMatch == false) {
			match();
		}
	}
	
	private function filterFunc(item:Object):Boolean {
		if (matchItem(item) == true) {
			_matchCounter++;
    		return true;
		} else {
			// no filtering -> always true, just counting
	    	return !useFilter;
		}
	}

	private function findNext(index:int=-1):int {
		var length:int = _data.length; 
		var item:Object;		
		index = index == -1 ? 0 : index + 1;
		for (var i:int = index; i < length; i++) {
			item = _data.getItemAt(i);
			if (matchItem(item) == true) {
				//_log.debug("findNext: index={0}", i);
				return i;
			}
		}
		//_log.debug("findNext: index=-1");
		return -1;
	}
	
	private function findPrevious(index:int=-1):int {
		var length:int = _data.length; 
		var item:Object;
		index = index == -1 ? length - 1 : index - 1;
		for (var i:int = index; i >= 0; i--) {
			item = _data.getItemAt(i);
			if (matchItem(item) == true) {
				//_log.debug("findPrevious: index={0}", i);
				return i;
			}
		}
		//_log.debug("findPreviouns: index=-1");
		return -1;
	}
	
	private function matchItem(item:Object):Boolean {
		var value:String;
		var index:int;
		// search with one textField in one or all dataFields, success when one match
		if (_textField != null) {
			if (_textField.length == 0)	return true;	// match always, even null	
			for (index = 0; index < dataFields.length; ++index) {
				value = item[_dataFields[index]];
				if (value != null && matchText(value, _textField) != -1) {
					//_log.debug("matchItem: return true");
					return true;
				}
			}
			//_log.debug("matchItem: return false");
			return false;
		} else {
			// search with more than one textField, success when all match
			var textField:String;
			for (index = 0; index < dataFields.length; ++index) {
				textField = _textFields[index];
				if (textField.length == 0) continue;	// match always, even null
				value = item[_dataFields[index]];
				if (value != null && matchText(value, textField) == -1) {
					//_log.debug("matchItem: return false");
					return false;
				}
			}
			//_log.debug("matchItem: return true");
			return true;			
		}
	}
	
	/**
	 * Validate the search properties.
	 * @param	props
	 */
	private function validateSearch(search:Object = null, dataFields:Object = null):void {
		if (search == null) {				// filter with existing parameters
			return;	
		} else if (search is Array) {		// array of String or {textField:xxx, dataField:xxx} items
			_textField = null;
			if (dataFields is Array) {		// two arrays of String
				if (search.length != dataFields.length) {
					throw new Error("textFields array and dataFields array must have same size");
				}	
				_textFields = search as Array;
				_dataFields = dataFields as Array;
			} else {						// an array of objects { dataField:xxx, textField:xxx }
				var textFields:Array = [];
				var dfFields:Array = [];
				for (var x:int = 0; x < search.length; x++) {
					var item:Object = search[x];
					textFields.push(item.textField);
					dfFields.push(item.dataField);
				} 
				_dataFields = dfFields;
				_textFields = textFields;
			}
		} else if (search is String) {		// one filter String for one or all dataFields
			_textField = search as String;	
			_textFields = null; 
			_dataFields = dataFields is String ? [dataFields] : null;
		} else {							// search is Object of { dataField:xxx, textField:xxx }
			if (search.textField == undefined || search.textField == null) {
				throw new Error("search object must have a textField");
			}
			_textFields = search.textField;
			if (search.dataField == undefined) {
				throw new Error("search object must have a dataField");
			}
			_dataFields = search.dataField;
		}

		if (_textFields == null) {			// create an array of _textField for MatchDataGridItemRenderer
			_textFields = [];
			for each(var column:DataGridColumn in _grid.columns) {
				_textFields.push(_textField);
			}
		}
		
		if (_dataFields == null) {
			_dataFields = [];			
			for each(column in _grid.columns) {
				_dataFields.push(column.dataField);
			}
		}
		
		if (useRegEx == false && useCaseSensitive == false) {
			if (_textField != null) {
				_textField = _textField.toLowerCase();
			}
			for (var i:int = 0; i < _textFields.length; i++) {
				if (_textFields[i] != null) {
					_textFields[i] = _textFields[i].toLowerCase();
				}
			}
		}
		//dumpProperties();
	}
	
	private function updateEnableNextPrev():void {
		//_log.debug("updateEnableNextPrev: actual={0}, first={1}, last={2}", _actualMatchIndex, _firstMatchIndex, _lastMatchIndex);
		if (_actualMatchIndex == -1 || useFilter == true) {
			enableSelectNext = enableSelectPrev = false;
		} else {
			enableSelectPrev = _actualMatchIndex > _firstMatchIndex;  
			enableSelectNext = _actualMatchIndex < _lastMatchIndex;  
		}
	}
	
	/**
	 * Update the number of matches for showing in the GUI via <code>matchCount</code>
	 */
    private function updateMatchCount():void {
    	//_log.debug("updateMatchCount: _matchCounter={0}", _matchCounter);
		matchCount = _matchCounter;
    }
    
    private function dumpProperties():void {
    	if (textFields.length == 0) {
    		_log.debug("dumpProperties: text.length=0");
    		return;
    	}
    	for (var i:int=0; i < textFields.length; i++) {
    		_log.debug("dumpProperties: dataField={0}, textField={1}", dataFields[i], textFields[i]);    		
    	} 
    	//_log.debug("dumpProperties:");
    }
    
}
}