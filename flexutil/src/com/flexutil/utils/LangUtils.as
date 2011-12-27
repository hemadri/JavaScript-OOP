/*
 * Copyright (c) 2008  Stefan Bistram
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
package com.flexutil.utils {

import mx.logging.ILogger;
	
public class LangUtils {
	
	private static var _log:ILogger = LogUtils.getLogger(LangUtils);
	
	public function LangUtils() {
	}
	
	/**
	 * Merge the properties of source object to the destination object
	 * 
	 * @param destination
	 * @param source 
	 */
	public static function merge(destination:Object, source:Object):void {
		if (destination == null || source == null) {
			return;
		}
		for (var prop:String in source) {
			destination[prop] = source[prop];
			//_log.debug("merge: property={0}", source[prop]);
		}
	}
		
}
}