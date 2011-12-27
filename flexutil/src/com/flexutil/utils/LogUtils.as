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

import flash.utils.*;

import mx.logging.ILogger;
import mx.logging.Log;

public class LogUtils {

	//--------------------------------------------
	// Flex API logging support
 	//--------------------------------------------
	
	/**
	 * Get an instance of an <code>ILogger</code>
	 * 
	 * @param	value can be a class or an instance
	 * @return	mx.logging.ILogger
	 */
	public static function getLogger(value:*):ILogger {
		return Log.getLogger(getCategory(value));
	}
	
	/**
	 * Using the full qualified class name as the category
	 * name for the logger.
	 * 
	 * <p>
	 * Unfortunately the method getQualifiedClassName is 
	 * returning e.g. de.sbistram.Utils::SbUtils for this class, 
	 * but Log.getLogger doesn't allow ':' chars in the category
	 * name, so "::" will be replaced by "."
	 * 
	 * Internal classes don't include the package, e.g.:
	 * MatchComboBox.as$0::MatchComboBoxRenderer
	 * </p>
	 * 
	 * @param	value of an instance object or class
	 * @return	the full qualified class name without "::"
	 * @see http://livedocs.adobe.com/flex/3/langref/mx/logging/Log.html#getLogger()
	 */
	public static function getCategory(value:*):String {
		var qcn:String = getQualifiedClassName(value);
		qcn = qcn.replace("$", ".");	// maybe an internal class using '$'
		return qcn.replace("::", ".");	// public class in a package using '::'
	}
	
	/**
	 * Convert an array of classes or instances to an array of valid 
	 * category names. 
	 * 
	 * - [...] means to include the complete package of the class
	 * - String filter items left untouched
	 * - For internal classes of a public class Foo -> "Foo.*"
	 * 
	 * @param	values
	 * @return	array of String categories
	 */
	public static function getFilter(values:Array):Array {
		var categories:Array = [];
		for (var value:* in values) {
			value = values[value];
			// an array indicates that we want to include the package of the class
			if (value is Array) {
				var qcn:String = getQualifiedClassName(value[0]);
				value = qcn.slice(0, qcn.indexOf("::")).concat(".*");
			} 
			categories.push((value is String) ? value : getCategory(value));
		}
		return categories;
	}
	
}
}